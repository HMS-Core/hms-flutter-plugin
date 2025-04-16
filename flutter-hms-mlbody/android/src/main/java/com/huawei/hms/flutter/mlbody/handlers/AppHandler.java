/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mlbody.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.HMSLogger;
import com.huawei.hms.mlsdk.common.MLApplication;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AppHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = AppHandler.class.getSimpleName();

    private final Activity activity;
    private final BodyResponseHandler handler;

    public AppHandler(Activity activity) {
        this.activity = activity;
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "bodyApp#enableLogger":
                enableLogger();
                break;
            case "bodyApp#disableLogger":
                disableLogger();
                break;
            case "bodyApp#setApiKey":
                setApiKey(call);
                break;
            case "bodyApp#setAccessToken":
                setAccessToken(call);
                break;
            case "bodyApp#setUserRegion":
                setUserRegion(call);
                break;
            case "bodyApp#getCountryCode":
                getCountryCode();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void enableLogger() {
        HMSLogger.getInstance(activity).enableLogger();
        handler.success(null);
    }

    private void disableLogger() {
        HMSLogger.getInstance(activity).disableLogger();
        handler.success(null);
    }

    private void setApiKey(MethodCall call) {
        String apiKey = FromMap.toString("apiKey", call.argument("apiKey"), false);
        MLApplication.getInstance().setApiKey(apiKey);
        handler.success(true);
    }

    private void setAccessToken(MethodCall call) {
        String token = FromMap.toString("token", call.argument("token"), false);
        MLApplication.getInstance().setAccessToken(token);
        handler.success(true);
    }

    private void setUserRegion(@NonNull MethodCall call) {
        final Integer region = FromMap.toInteger("region", call.argument("region"));
        MLApplication.getInstance().setUserRegion(Objects.requireNonNull(region));
        handler.success(true);
    }

    private void getCountryCode() {
        final String countryCode = MLApplication.getInstance().getCountryCode();
        handler.success(countryCode);
    }
}
