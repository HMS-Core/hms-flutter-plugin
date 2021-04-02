/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.mlapplication;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLApplicationSetting;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MlApplicationMethodHandler implements MethodChannel.MethodCallHandler {
    private Activity activity;
    private MethodChannel.Result mResult;

    public MlApplicationMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "setApiKey":
                setApiKey(call);
                break;
            case "setAccessToken":
                setAccessToken(call);
                break;
            case "createSetting":
                createSetting(call);
                break;
            case "enableLogger":
                enableLogger();
                break;
            case "disableLogger":
                disableLogger();
                break;
            default:
                mResult.notImplemented();
        }
    }

    private void createSetting(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("createMLAppSetting");
        String apiKey = call.argument("apiKey");
        String appId = call.argument("appId");
        String certFingerprint = call.argument("certFingerprint");

        MLApplicationSetting setting = new MLApplicationSetting.Factory().setApiKey(apiKey).setApplicationId(appId).setCertFingerprint(certFingerprint).create();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("createMLAppSetting");
        mResult.success(setting.getApiKey() != null);
    }

    private void setApiKey(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("setApiKey");

        String key = call.argument("key");
        MLApplication.getInstance().setApiKey(key);

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("setApiKey");
        mResult.success(true);
    }

    private void setAccessToken(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("setAccessToken");

        String key = call.argument("token");
        MLApplication.getInstance().setAccessToken(key);

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("setAccessToken");
        mResult.success(true);
    }

    private void enableLogger() {
        HMSLogger.getInstance(activity.getApplicationContext()).enableLogger();
        mResult.success(true);
    }

    private void disableLogger() {
        HMSLogger.getInstance(activity.getApplicationContext()).disableLogger();
        mResult.success(true);
    }
}
