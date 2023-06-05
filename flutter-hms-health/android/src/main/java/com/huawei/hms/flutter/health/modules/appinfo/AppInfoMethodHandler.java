/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.modules.appinfo;

import androidx.annotation.NonNull;

import com.huawei.hms.hihealth.data.AppInfo;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AppInfoMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "AppInfoHandler";

    private AppInfo appInfo;

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "create":
                createApp(call, result);
                break;
            case "getDetailsUrl":
                getDetailsUrl(result);
                break;
            case "getDomainName":
                getDomainName(result);
                break;
            case "getPackageName":
                getPackageName(result);
                break;
            case "getVersion":
                getVersion(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void createApp(MethodCall call, MethodChannel.Result result) {
        final String packageName = call.argument("packageName");
        final String domainName = call.argument("domainName");
        final String version = call.argument("version");
        final String detailsUrl = call.argument("detailsUrl");

        appInfo = new AppInfo(packageName, domainName, version, detailsUrl);
        result.success(true);
    }

    private void getDetailsUrl(MethodChannel.Result result) {
        if (appInfo == null) {
            result.error(TAG, "Create an AppInfo instance first", null);
            return;
        }
        result.success(appInfo.getDetailsUrl());
    }

    private void getDomainName(MethodChannel.Result result) {
        if (appInfo == null) {
            result.error(TAG, "Create an AppInfo instance first", null);
            return;
        }
        result.success(appInfo.getDomainName());
    }

    private void getPackageName(MethodChannel.Result result) {
        if (appInfo == null) {
            result.error(TAG, "Create an AppInfo instance first", null);
            return;
        }
        result.success(appInfo.getPackageName());
    }

    private void getVersion(MethodChannel.Result result) {
        if (appInfo == null) {
            result.error(TAG, "Create an AppInfo instance first", null);
            return;
        }
        result.success(appInfo.getVersion());
    }
}
