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

package com.huawei.hms.flutter.account.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.util.Constant;
import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.support.hwid.tools.NetworkTool;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class NetworkToolMethodHandler implements MethodChannel.MethodCallHandler {
    private Activity activity;
    private MethodChannel.Result mResult;

    public NetworkToolMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "buildNetworkCookie":
                buildNetworkCookie(call);
                break;
            case "buildNetworkUrl":
                buildNetworkUrl(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Constructs a cookie by combining entered values.
     *
     * @param call customizable request data
     */
    private void buildNetworkCookie(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("buildNetworkCookie");
        Map<String, Object> cookieMap = call.arguments();
        String cookieName = (String) cookieMap.get("cookieName");
        String cookieValue = (String) cookieMap.get("cookieValue");
        String domain = (String) cookieMap.get("domain");
        String path = (String) cookieMap.get("path");
        boolean isHttpOnly = (boolean) cookieMap.get("isHttpOnly");
        boolean isSecure = (boolean) cookieMap.get("isSecure");
        Double maxAge = (Double) cookieMap.get("maxAge");

        if (cookieName == null || cookieValue == null || domain == null || path == null || maxAge == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("buildNetworkCookie", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.BUILD_NETWORK_COOKIE_FAILURE, Constant.ILLEGAL_PARAMETER, null);
            return;
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("buildNetworkCookie");
        mResult.success(NetworkTool.buildNetworkCookie(
                cookieName,
                cookieValue,
                domain,
                path,
                isHttpOnly,
                isSecure,
                maxAge.longValue()
        ));
    }

    /**
     * Obtains a cookie URL based on the domain name and isUseHttps.
     *
     * @param call customizable request data
     */
    private void buildNetworkUrl(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("buildNetworkUrl");
        Map<String, Object> urlMap = call.arguments();
        String domainName = (String) urlMap.get("domainName");
        boolean isHttps = (boolean) urlMap.get("isHttps");

        if (domainName == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("buildNetworkUrl", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.BUILD_NETWORK_URL_FAILURE, Constant.ILLEGAL_PARAMETER, null);
            return;
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("buildNetworkUrl");
        mResult.success(NetworkTool.buildNetworkUrl(domainName, isHttps));
    }
}
