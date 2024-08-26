/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.push.hms;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.aaid.HmsInstanceId;
import com.huawei.hms.aaid.entity.AAIDResult;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.common.ResolvableApiException;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.utils.Utils;

import io.flutter.plugin.common.MethodChannel.Result;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * class FlutterHmsInstanceId
 *
 * @since 4.0.4
 */
public class FlutterHmsInstanceId {
    private static final String TAG = FlutterHmsInstanceId.class.getSimpleName();

    private final HMSLogger hmsLogger;

    private final Context context;

    public FlutterHmsInstanceId(Context context) {
        this.context = context;
        hmsLogger = HMSLogger.getInstance(context);
    }

    public void getId(final Result result) {
        hmsLogger.startMethodExecutionTimer("getId");
        String instanceId = HmsInstanceId.getInstance(context).getId();
        hmsLogger.sendSingleEvent("getId");
        result.success(instanceId);
    }

    public void getAAID(final Result result) {
        hmsLogger.startMethodExecutionTimer("getAAID");
        Task<AAIDResult> aaidResultTask = HmsInstanceId.getInstance(context).getAAID();
        aaidResultTask.addOnSuccessListener(aaidResult -> {
            String aaid = aaidResult.getId();
            hmsLogger.sendSingleEvent("getAAID");
            result.success(aaid);
        }).addOnFailureListener(e -> {
            if (e instanceof ApiException) {
                ApiException ex = ((ApiException) e);
                result.error(String.valueOf(ex.getStatusCode()), ex.getMessage(), null);
                hmsLogger.sendSingleEvent("getAAID", String.valueOf(ex.getStatusCode()));
            } else {
                result.error("-1", e.getMessage(), null);
                hmsLogger.sendSingleEvent("getAAID", Code.RESULT_UNKNOWN.code());
            }
            Log.d("FlutterHmsInstanceId", "getAAID failed");
        });
    }

    public void getAppId(final Result result) {
        String appId = AGConnectServicesConfig.fromContext(context).getString(Core.CLIENT_APP_ID);
        if (Utils.isEmpty(appId)) {
            appId = "";
        }
        result.success(appId);
    }

    public void getToken(final String scope) {
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(context).getString(Core.CLIENT_APP_ID);
            if (Utils.isEmpty(appId)) {
                appId = "";
            }
            String token = "";
            hmsLogger.startMethodExecutionTimer("getToken");
            try {
                String defaultScope = scope == null ? Core.DEFAULT_TOKEN_SCOPE : scope;
                if (defaultScope.trim().isEmpty()) {
                    defaultScope = Core.DEFAULT_TOKEN_SCOPE;
                }
                token = HmsInstanceId.getInstance(context).getToken(appId, defaultScope);
                hmsLogger.sendSingleEvent("getToken");
                Utils.sendIntent(context, PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
            } catch (ResolvableApiException e) {
                hmsLogger.sendSingleEvent("getToken", String.valueOf(e.getStatusCode()));
                PendingIntent resolution = e.getResolution();
                if (resolution != null) {
                    try {
                        hmsLogger.sendSingleEvent("getToken");
                        resolution.send();
                    } catch (PendingIntent.CanceledException ex) {
                        HMSLogger.getInstance(PluginContext.getContext())
                            .sendSingleEvent("onTokenError", ex.getMessage());
                    }
                }
                Intent resolutionIntent = e.getResolutionIntent();
                if (resolutionIntent != null) {
                    hmsLogger.sendSingleEvent("getToken");
                    resolutionIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    PluginContext.getContext().startActivity(resolutionIntent);
                }
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent("getToken", String.valueOf(e.getStatusCode()));
                Utils.sendIntent(context, PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR,
                    e.getLocalizedMessage());
            } catch (Exception e) {
                hmsLogger.sendSingleEvent("getToken", Code.RESULT_UNKNOWN.code());
                Utils.sendIntent(context, PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR,
                    e.getLocalizedMessage());
            }
        }).start();
    }

    public void getMultiSenderToken(final String subjectId) {
        new Thread(() -> {
            String token = "";
            hmsLogger.startMethodExecutionTimer("getMultiSenderToken");
            try {
                token = HmsInstanceId.getInstance(context).getToken(subjectId);
                hmsLogger.sendSingleEvent("getMultiSenderToken");
                JSONObject result = new JSONObject();
                result.putOpt("multiSenderToken", token);
                Utils.sendIntent(context, PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION, PushIntent.MULTI_SENDER_TOKEN,
                    result.toString());
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent("getMultiSenderToken", String.valueOf(e.getStatusCode()));
                Utils.sendIntent(context, PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION,
                    PushIntent.MULTI_SENDER_TOKEN_ERROR, e.getLocalizedMessage());
            } catch (Exception e) {
                hmsLogger.sendSingleEvent("getMultiSenderToken", Code.RESULT_UNKNOWN.code());
                Utils.sendIntent(context, PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION,
                    PushIntent.MULTI_SENDER_TOKEN_ERROR, e.getLocalizedMessage());
            }
        }).start();
    }

    public void getCreationTime(final Result result) {
        hmsLogger.startMethodExecutionTimer("getCreationTime");
        String createTime = String.valueOf(HmsInstanceId.getInstance(context).getCreationTime());
        hmsLogger.sendSingleEvent("getCreationTime");
        result.success(createTime);
    }

    public void deleteAAID(final Result result) {
        new Thread(() -> {
            hmsLogger.startMethodExecutionTimer("deleteAAID");
            try {
                HmsInstanceId.getInstance(context).deleteAAID();
                Utils.handleSuccessOnUIThread(result);
                hmsLogger.sendSingleEvent("deleteAAID");
            } catch (ApiException e) {
                Utils.handleErrorOnUIThread(result, String.valueOf(e.getStatusCode()), e.getMessage(), "");
                hmsLogger.sendSingleEvent("deleteAAID", String.valueOf(e.getStatusCode()));
            }
        }).start();

    }

    public void deleteToken(final String scope, final Result result) {
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(context).getString(Core.CLIENT_APP_ID);
            if (Utils.isEmpty(appId)) {
                appId = "";
            }
            hmsLogger.startMethodExecutionTimer("deleteToken");
            try {
                String defaultScope = scope == null ? Core.DEFAULT_TOKEN_SCOPE : scope;
                if (defaultScope.trim().isEmpty()) {
                    defaultScope = Core.DEFAULT_TOKEN_SCOPE;
                }
                HmsInstanceId.getInstance(context).deleteToken(appId, defaultScope);
                hmsLogger.sendSingleEvent("deleteToken");
                Utils.handleSuccessOnUIThread(result);
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent("deleteToken", String.valueOf(e.getStatusCode()));
                Utils.handleErrorOnUIThread(result, String.valueOf(e.getStatusCode()), e.getMessage(), "");
            }
        }).start();
    }

    public void deleteMultiSenderToken(final String subjectId, final Result result) {
        final String methodName = "deleteMultiSenderToken";
        new Thread(() -> {
            hmsLogger.startMethodExecutionTimer(methodName);
            try {
                HmsInstanceId.getInstance(context).deleteToken(subjectId);
                hmsLogger.sendSingleEvent(methodName);
                Utils.handleSuccessOnUIThread(result);
            } catch (ApiException e) {
                hmsLogger.sendSingleEvent(methodName, String.valueOf(e.getStatusCode()));
                Utils.handleErrorOnUIThread(result, String.valueOf(e.getStatusCode()), e.getMessage(), "");
            }
        }).start();
    }

    public void getAgConnectValues(final Result result) {
        HashMap<String, String> agconnect = new HashMap<>();
        agconnect.put("app_id", AGConnectServicesConfig.fromContext(context).getString("client/app_id"));
        agconnect.put("cp_id", AGConnectServicesConfig.fromContext(context).getString("client/cp_id"));
        agconnect.put("client_id", AGConnectServicesConfig.fromContext(context).getString("client/client_id"));
        agconnect.put("product_id", AGConnectServicesConfig.fromContext(context).getString("client/product_id"));
        agconnect.put("package_name", AGConnectServicesConfig.fromContext(context).getString("client/package_name"));
        agconnect.put("api_key", AGConnectServicesConfig.fromContext(context).getString("client/api_key"));
        agconnect.put("client_secret", AGConnectServicesConfig.fromContext(context).getString("client/client_secret"));
        agconnect.put("agcw_url", AGConnectServicesConfig.fromContext(context).getString("agcgw/url"));

        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> entry : agconnect.entrySet()) {
            sb.append(entry.getKey()).append(" : ").append(entry.getValue()).append("\n");
        }
        result.success(sb.toString());
    }
}
