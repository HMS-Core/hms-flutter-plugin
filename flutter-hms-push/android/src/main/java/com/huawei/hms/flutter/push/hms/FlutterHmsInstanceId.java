/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.push.hms;

import android.util.Log;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.aaid.entity.AAIDResult;
import com.huawei.hms.aaid.HmsInstanceId;

import io.flutter.plugin.common.MethodChannel.Result;

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.common.ApiException;

import java.util.HashMap;
import java.util.Map;

/**
 * class FlutterHmsInstanceId
 *
 * @since 4.0.4
 */
public class FlutterHmsInstanceId {
    private static String TAG = FlutterHmsInstanceId.class.getSimpleName();

    private static HMSLogger hmsLogger = HMSLogger.getInstance(PushPlugin.getContext());

    public static void getId(final Result result) {
        hmsLogger.startMethodExecutionTimer("getId");
        String instanceId = HmsInstanceId.getInstance(PushPlugin.getContext()).getId();
        hmsLogger.sendSingleEvent("getId");
        Log.d(TAG, "id");
        result.success(instanceId);
    }

    public static void getAAID(final Result result) {
        hmsLogger.startMethodExecutionTimer("getAAID");
        Task<AAIDResult> aaidResultTask = HmsInstanceId.getInstance(PushPlugin.getContext()).getAAID();
        aaidResultTask.addOnSuccessListener(aaidResult -> {
            String aaid = aaidResult.getId();
            hmsLogger.sendSingleEvent("getAAID");
            Log.d(TAG, "aaid");
            result.success(aaid);
        }).addOnFailureListener(e -> {
            if (e instanceof ApiException) {
                ApiException ex = ((ApiException) e);
                hmsLogger.sendSingleEvent("getAAID", String.valueOf(ex.getStatusCode()));
            } else {
                hmsLogger.sendSingleEvent("getAAID", Code.RESULT_UNKNOWN.code());
            }
            Log.d("FlutterHmsInstanceId", "getAAID failed");
        });
    }

    public static void getAppId(final Result result) {
        String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString(Core.CLIENT_APP_ID);
        if (Utils.isEmpty(appId)) appId = "";
        result.success(appId);
    }

    public static void getToken(final String scope) {
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString(Core.CLIENT_APP_ID);
            if (Utils.isEmpty(appId)) appId = "";
            String token = "";
            hmsLogger.startMethodExecutionTimer("getToken");
            try {
                String defaultScope = scope == null ? Core.DEFAULT_TOKEN_SCOPE : scope;
                if (defaultScope.trim().isEmpty()) {
                    defaultScope = Core.DEFAULT_TOKEN_SCOPE;
                }
                token = HmsInstanceId.getInstance(PushPlugin.getContext()).getToken(appId, defaultScope);
                hmsLogger.sendSingleEvent("getToken");
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent("getToken", String.valueOf(e.getStatusCode()));
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, e.getLocalizedMessage());
            } catch (Exception e) {
                hmsLogger.sendSingleEvent("getToken", Code.RESULT_UNKNOWN.code());
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, e.getLocalizedMessage());
            }
        }).start();
    }

    public static void getCreationTime(final Result result) {
        hmsLogger.startMethodExecutionTimer("getCreationTime");
        String createTime = String.valueOf(HmsInstanceId.getInstance(PushPlugin.getContext()).getCreationTime());
        Log.d(TAG, "createTime");
        hmsLogger.sendSingleEvent("getCreationTime");
        result.success(createTime);
    }

    public static void deleteAAID(final Result result) {
        hmsLogger.startMethodExecutionTimer("deleteAAID");
        try {
            HmsInstanceId.getInstance(PushPlugin.getContext()).deleteAAID();
            hmsLogger.sendSingleEvent("deleteAAID");
        } catch (ApiException e) {
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
            hmsLogger.sendSingleEvent("deleteAAID", String.valueOf(e.getStatusCode()));
        }
        result.success(Code.RESULT_SUCCESS.code());
    }

    public static void deleteToken(final String scope) {
        // Since operation on main thread is prohibited for this method, results will be returned on
        // token event channel's onError callback
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString(Core.CLIENT_APP_ID);
            if (Utils.isEmpty(appId)) appId = "";
            hmsLogger.startMethodExecutionTimer("deleteToken");
            try {
                String defaultScope = scope == null ? Core.DEFAULT_TOKEN_SCOPE : scope;
                if (defaultScope.trim().isEmpty()) {
                    defaultScope = Core.DEFAULT_TOKEN_SCOPE;
                }
                HmsInstanceId.getInstance(PushPlugin.getContext()).deleteToken(appId, defaultScope);
                hmsLogger.sendSingleEvent("deleteToken");
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, Code.RESULT_SUCCESS.code());
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent("deleteToken", String.valueOf(e.getStatusCode()));
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, e.getLocalizedMessage());
            } catch (Exception e) {
                hmsLogger.sendSingleEvent("deleteToken", Code.RESULT_UNKNOWN.code());
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, e.getLocalizedMessage());
            }
        }).start();
    }

    public static void getAgConnectValues(final Result result) {
        HashMap<String, String> agconnect = new HashMap<>();
        agconnect.put("app_id", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/app_id"));
        agconnect.put("cp_id", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/cp_id"));
        agconnect.put("client_id", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/client_id"));
        agconnect.put("product_id", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/product_id"));
        agconnect.put("package_name", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/package_name"));
        agconnect.put("api_key", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/api_key"));
        agconnect.put("client_secret", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/client_secret"));
        agconnect.put("agcw_url", AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("agcgw/url"));

        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> entry : agconnect.entrySet()) {
            sb.append(entry.getKey()).append(" : ").append(entry.getValue()).append("\n");
        }
        result.success(sb.toString());
    }

}
