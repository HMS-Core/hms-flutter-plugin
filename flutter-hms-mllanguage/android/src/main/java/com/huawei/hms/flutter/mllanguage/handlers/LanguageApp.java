/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mllanguage.handlers;

import android.app.Activity;
import android.os.Environment;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.HMSLogger;
import com.huawei.hms.mlsdk.common.MLApplication;

import java.io.File;
import java.io.IOException;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LanguageApp implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public LanguageApp(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "enableLogger":
                enableLogger(result);
                break;
            case "disableLogger":
                disableLogger(result);
                break;
            case "setApiKey":
                setApiKey(call, result);
                break;
            case "setAccessToken":
                setAccessToken(call, result);
                break;
            case "getAppDirectory":
                getAppDir(result);
                break;
            case "setUserRegion":
                setUserRegion(call, result);
                break;
            case "getCountryCode":
                getCountryCode(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getAppDir(MethodChannel.Result result) {
        File dir = Environment.getExternalStorageDirectory();
        try {
            String path = dir.getCanonicalPath();
            HMSLogger.getInstance(activity).sendSingleEvent("getAppDirectory");
            result.success(path);
        } catch (IOException e) {
            HMSLogger.getInstance(activity).sendSingleEvent("getAppDirectory", "-1");
            result.error("MLLanguageApp", e.getMessage(), null);
        }
    }

    private void enableLogger(MethodChannel.Result result) {
        HMSLogger.getInstance(activity).enableLogger();
        result.success(null);
    }

    private void disableLogger(MethodChannel.Result result) {
        HMSLogger.getInstance(activity).disableLogger();
        result.success(null);
    }

    private void setApiKey(MethodCall call, MethodChannel.Result result) {
        final String apiKey = FromMap.toString("apiKey", call.argument("apiKey"), false);
        MLApplication.getInstance().setApiKey(apiKey);
        HMSLogger.getInstance(activity).sendSingleEvent("setApiKey");
        result.success(true);
    }

    private void setAccessToken(MethodCall call, MethodChannel.Result result) {
        final String token = FromMap.toString("accessToken", call.argument("accessToken"), false);
        MLApplication.getInstance().setAccessToken(token);
        HMSLogger.getInstance(activity).sendSingleEvent("setAccessToken");
        result.success(true);
    }

    private void setUserRegion(MethodCall call, MethodChannel.Result result) {
        final Integer region = FromMap.toInteger("region", call.argument("region"));
        MLApplication.getInstance().setUserRegion(Objects.requireNonNull(region));
        result.success(true);
    }

    private void getCountryCode(MethodChannel.Result result) {
        final String countryCode = MLApplication.getInstance().getCountryCode();
        result.success(countryCode);
    }
}
