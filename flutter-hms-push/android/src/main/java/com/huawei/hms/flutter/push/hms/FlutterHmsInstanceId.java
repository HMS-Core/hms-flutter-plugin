/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

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
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.aaid.entity.AAIDResult;
import com.huawei.hms.aaid.HmsInstanceId;

import io.flutter.plugin.common.MethodChannel.Result;

import com.huawei.hms.flutter.push.PushPlugin;
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

    public static void getId(final Result result) {
        String instanceId = HmsInstanceId.getInstance(PushPlugin.getContext()).getId();
        Log.d("FlutterHmsInstanceId", "id");
        result.success(instanceId);
    }

    public static void getAAID(final Result result) {
        Task<AAIDResult> aaidResultTask = HmsInstanceId.getInstance(PushPlugin.getContext()).getAAID();
        aaidResultTask.addOnSuccessListener(aaidResult -> {
            String aaid = aaidResult.getId();
            Log.d("FlutterHmsInstanceId", "aaid");
            result.success(aaid);
        }).addOnFailureListener(e -> Log.d("FlutterHmsInstanceId", "getAAID failed"));
    }

    public static void getAppId(final Result result) {
        String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/app_id");
        if (Utils.isEmpty(appId)) appId = "";
        result.success(appId);
    }

    public static void getToken() {
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/app_id");
            if (Utils.isEmpty(appId)) appId = "";
            String token = "";
            try {
                token = HmsInstanceId.getInstance(PushPlugin.getContext()).getToken(appId, "HCM");
            } catch (ApiException e) {
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, e.getLocalizedMessage());
            } catch (Exception e) {
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, e.getLocalizedMessage());
            }
            Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
        }).start();
    }

    public static void getCreationTime(final Result result) {
        String createTime = String.valueOf(HmsInstanceId.getInstance(PushPlugin.getContext()).getCreationTime());
        Log.d("FlutterHmsInstanceId", "createTime");
        result.success(createTime);
    }

    public static void deleteAAID(final Result result) {
        try {
            HmsInstanceId.getInstance(PushPlugin.getContext()).deleteAAID();
        } catch (ApiException e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
        result.success(Code.RESULT_SUCCESS.code());
    }

    public static void deleteToken() {
        new Thread(() -> {
            String appId = AGConnectServicesConfig.fromContext(PushPlugin.getContext()).getString("client/app_id");
            if (Utils.isEmpty(appId)) appId = "";
            try {
                HmsInstanceId.getInstance(PushPlugin.getContext()).deleteToken(appId, "HCM");
            } catch (ApiException e) {
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, e.getLocalizedMessage());
            } catch (Exception e) {
                Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, e.getLocalizedMessage());
            }
            Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, Code.RESULT_SUCCESS.code());
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
