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

package com.huawei.hms.flutter.account.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.FromMap;
import com.huawei.hms.flutter.account.util.ResultSender;
import com.huawei.hms.support.hwid.tools.NetworkTool;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HwNetworkTool implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public HwNetworkTool(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "buildNetworkCookie":
                buildNetworkCookie(call, result);
                break;
            case "buildNetworkUrl":
                buildNetworkUrl(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
    
    private void buildNetworkCookie(@NonNull MethodCall call, MethodChannel.Result result) {
        String cookieName = FromMap.toString("cookieName", call.argument("cookieName"), false);
        String cookieValue = FromMap.toString("cookieValue", call.argument("cookieValue"), true);
        String domain = FromMap.toString("domain", call.argument("domain"), true);
        String path = FromMap.toString("path", call.argument("path"), true);
        Boolean isHttpOnly = FromMap.toBoolean("isHttpOnly", call.argument("isHttpOnly"));
        Boolean isSecure = FromMap.toBoolean("isSecure", call.argument("isSecure"));
        Long maxAge = FromMap.toLong("maxAge", call.argument("maxAge"));
        
        if (cookieName == null) {
            ResultSender.illegal(activity, "HwNetworkTool", call.method, result);
            return;
        }

        String res = NetworkTool.buildNetworkCookie(cookieName, cookieValue, domain, path, isHttpOnly, isSecure, maxAge);
        ResultSender.success(activity, call.method, result, res);
    }

    private void buildNetworkUrl(@NonNull MethodCall call, MethodChannel.Result result) {
        String domainName = FromMap.toString("domainName", call.argument("domainName"), false);
        Boolean isHttps = FromMap.toBoolean("isHttps", call.argument("isHttps"));

        String res = NetworkTool.buildNetworkUrl(domainName, isHttps);
        ResultSender.success(activity, call.method, result, res);
    }
}
