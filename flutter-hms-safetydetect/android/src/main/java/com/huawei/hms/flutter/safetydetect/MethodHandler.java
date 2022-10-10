/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.safetydetect;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.safetydetect.constants.Constants;
import com.huawei.hms.flutter.safetydetect.constants.Constants.APIMethod;
import com.huawei.hms.flutter.safetydetect.logger.HMSLogger;
import com.huawei.hms.flutter.safetydetect.util.CommonFailureListener;
import com.huawei.hms.flutter.safetydetect.util.PlatformUtil;
import com.huawei.hms.flutter.safetydetect.util.SerializerUtil;
import com.huawei.hms.support.api.entity.core.CommonCode;
import com.huawei.hms.support.api.entity.safetydetect.MaliciousAppsData;
import com.huawei.hms.support.api.entity.safetydetect.SysIntegrityRequest;
import com.huawei.hms.support.api.entity.safetydetect.UrlCheckThreat;
import com.huawei.hms.support.api.entity.safetydetect.VerifyAppsCheckEnabledResp;
import com.huawei.hms.support.api.safetydetect.SafetyDetect;
import com.huawei.hms.support.api.safetydetect.SafetyDetectClient;
import com.huawei.hms.support.api.safetydetect.SafetyDetectStatusCodes;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MethodHandler implements MethodCallHandler {
    private SafetyDetectClient mClient;
    private Activity activity;
    private HMSLogger hmsLogger;

    MethodHandler(Activity act) {
        this.activity = act;
        this.mClient = SafetyDetect.getClient(activity);
        this.hmsLogger = HMSLogger.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        hmsLogger.startMethodExecutionTimer(call.method);
        try {
            Method m = this.getClass().getDeclaredMethod(call.method, Result.class, MethodCall.class);
            m.invoke(this, result, call);
        } catch (NoSuchMethodException e) {
            result.notImplemented();
        } catch (InvocationTargetException | IllegalAccessException e) {
            result.error(Constants.ERROR, e.getMessage(), "");
        }
    }

    private void sysIntegrity(final Result result, final MethodCall call) {
        byte[] nonce = PlatformUtil.getByteArrayArg(call, "nonce");
        String appId = PlatformUtil.getStringArg(call, Constants.APP_ID);
        String alg = PlatformUtil.getStringArg(call, "alg");
        SysIntegrityRequest sir = new SysIntegrityRequest();
        sir.setNonce(nonce);
        sir.setAppId(appId);
        sir.setAlg(alg);
        (alg == null ? mClient.sysIntegrity(nonce, appId) : mClient.sysIntegrity(sir)).addOnSuccessListener(sysIntegrityResp -> {
            if (sysIntegrityResp.getRtnCode() == CommonCode.OK) {
                hmsLogger.sendSingleEvent(call.method);
                result.success(sysIntegrityResp.getResult());
            } else {
                hmsLogger.sendSingleEvent(call.method, Constants.ERROR);
                result.error(String.valueOf(sysIntegrityResp.getRtnCode()),
                    "SysIntegrityCheck failed! Message: " + sysIntegrityResp.getErrorReason(), "");
            }
        }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.SYS_INTEGRITY));
    }

    private void getAppId(final Result result, final MethodCall call) {
        String appId = AGConnectServicesConfig.fromContext(activity.getApplicationContext()).getString("client/app_id");
        if (appId == null) {
            appId = "";
        }
        result.success(appId);
    }

    private void isVerifyAppsCheck(final Result result, final MethodCall call) {
        mClient.isVerifyAppsCheck()
            .addOnSuccessListener(
                appsCheckEnabledResp -> handleAppsCheckEnabledResponse(appsCheckEnabledResp, result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.IS_VERIFY_APPS_CHECK));
    }

    private void enableAppsCheck(final Result result, final MethodCall call) {
        mClient.enableAppsCheck()
            .addOnSuccessListener(
                appsCheckEnabledResp -> handleAppsCheckEnabledResponse(appsCheckEnabledResp, result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.ENABLE_APPS_CHECK));
    }

    private void getMaliciousAppsList(final Result result, final MethodCall call) {
        mClient.getMaliciousAppsList().addOnSuccessListener(maliciousAppsListResp -> {
            final List<MaliciousAppsData> maliciousAppsDataList = maliciousAppsListResp.getMaliciousAppsList();
            List<HashMap<String, Object>> serializedList = new ArrayList<>();
            for (MaliciousAppsData maliciousAppsData : maliciousAppsDataList) {
                serializedList.add(new HashMap<>(SerializerUtil.serializeMaliciousAppData(maliciousAppsData)));
            }
            hmsLogger.sendSingleEvent(call.method);
            result.success(serializedList);
        }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.GET_MALICIOUS_APPS_LIST));
    }

    private void initUrlCheck(final Result result, final MethodCall call) {
        mClient.initUrlCheck()
            .addOnSuccessListener(aVoid -> handleVoidTaskResponse("Successfully initialized Url Check", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.INIT_URL_CHECK));
    }

    private void urlCheck(final Result result, final MethodCall call) {
        final String url = call.argument("url");
        final String appId = call.argument(Constants.APP_ID);
        int[] threatTypes = PlatformUtil.getThreatTypes(call);
        if (threatTypes.length > 0) {
            mClient.urlCheck(url, appId, threatTypes).addOnSuccessListener(urlCheckResponse -> {
                final List<UrlCheckThreat> urlCheckThreats = urlCheckResponse.getUrlCheckResponse();
                ArrayList<Integer> threatValueList = new ArrayList<>();
                for (UrlCheckThreat threat : urlCheckThreats) {
                    threatValueList.add(threat.getUrlCheckResult());
                }
                hmsLogger.sendSingleEvent(call.method);
                result.success(threatValueList);
            }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.URL_CHECK));
        } else {
            hmsLogger.sendSingleEvent(APIMethod.URL_CHECK,
                String.valueOf(SafetyDetectStatusCodes.URL_CHECK_REQUEST_PARAM_INVALID));
            result.error(Constants.ERROR, "Threat Types can't be null or empty", "");
        }
    }

    private void shutdownUrlCheck(final Result result, final MethodCall call) {
        mClient.shutdownUrlCheck()
            .addOnSuccessListener(v -> handleVoidTaskResponse("Successfully shutdown urlCheck", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.SHUTDOWN_URL_CHECK));
    }

    private void initUserDetect(final Result result, final MethodCall call) {
        mClient.initUserDetect()
            .addOnSuccessListener(v -> handleVoidTaskResponse("Successfully initialized user detection", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.INIT_USER_DETECT));
    }

    private void userDetection(final Result result, final MethodCall call) {
        final String appId = PlatformUtil.getStringArg(call, Constants.APP_ID);
        mClient.userDetection(appId).addOnSuccessListener(userDetectResponse -> {
            hmsLogger.sendSingleEvent(call.method);
            result.success(userDetectResponse.getResponseToken());
        }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.USER_DETECTION));
    }

    private void shutdownUserDetect(final Result result, final MethodCall call) {
        mClient.shutdownUserDetect()
            .addOnSuccessListener(v -> handleVoidTaskResponse("Successfully shutdown UserDetect", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.SHUTDOWN_USER_DETECT));
    }

    private void getWifiDetectStatus(final Result result, final MethodCall call) {
        mClient.getWifiDetectStatus().addOnSuccessListener(wifiDetectResponse -> {
            hmsLogger.sendSingleEvent(call.method);
            result.success(wifiDetectResponse.getWifiDetectStatus());
        }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.GET_WIFI_DETECT_STATUS));
    }

    private void initAntiFraud(final Result result, final MethodCall call) {
        final String appId = PlatformUtil.getStringArg(call, Constants.APP_ID);
        mClient.initAntiFraud(appId)
            .addOnSuccessListener(v -> handleVoidTaskResponse("Successfully initialized anti fraud", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.INIT_ANTI_FRAUD));
    }

    private void getRiskToken(final Result result, final MethodCall call) {
        mClient.getRiskToken().addOnSuccessListener(riskTokenResponse -> {
            hmsLogger.sendSingleEvent(call.method);
            result.success(riskTokenResponse.getRiskToken());
        }).addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.GET_RISK_TOKEN));
    }

    private void releaseAntiFraud(final Result result, final MethodCall call) {
        mClient.releaseAntiFraud()
            .addOnSuccessListener(v -> handleVoidTaskResponse("Successfully released anti fraud", result, call))
            .addOnFailureListener(new CommonFailureListener(result, hmsLogger, APIMethod.RELEASE_ANTI_FRAUD));
    }

    private void enableLogger(final Result result, final MethodCall call) {
        hmsLogger.enableLogger();
        result.success(Constants.SUCCESS);
    }

    private void disableLogger(final Result result, final MethodCall call) {
        hmsLogger.disableLogger();
        result.success(Constants.SUCCESS);
    }

    /**
     * Common handler method for Task<VerifyAppsCheckEnableResp>
     *
     * @param appsCheckEnabledResp : VerifyAppsCheckEnabledResp result from Task<VerifyAppsCheckEnableResp> OnSuccess
     * @param result               : Flutter Result
     * @param call                 : Flutter MethodCall
     */
    private void handleAppsCheckEnabledResponse(VerifyAppsCheckEnabledResp appsCheckEnabledResp, final Result result,
        final MethodCall call) {
        if (appsCheckEnabledResp.getRtnCode() == CommonCode.OK) {
            hmsLogger.sendSingleEvent(call.method);
            result.success(appsCheckEnabledResp.getResult());
        } else {
            hmsLogger.sendSingleEvent(call.method, Constants.ERROR);
            result.error(String.valueOf(appsCheckEnabledResp.getRtnCode()),
                "Get malicious apps list failed! Message: " + appsCheckEnabledResp.getErrorReason(), "");
        }
    }

    /**
     * Common handler method for Void and Null type Task Responses
     *
     * @param successMessage : Success message to be logged.
     * @param result         : Flutter Result
     * @param call           : Flutter MethodCall
     */
    private void handleVoidTaskResponse(String successMessage, final Result result, final MethodCall call) {
        hmsLogger.sendSingleEvent(call.method);
        Log.i(call.method, successMessage);
        result.success(Constants.SUCCESS);
    }
}
