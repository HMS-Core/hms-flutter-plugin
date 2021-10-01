/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.materialgen.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.FromMap;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.materialgeneratesdk.MaterialGenApplication;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MaterialGenAppHandler implements MethodChannel.MethodCallHandler {
    private final String TAG = MaterialGenAppHandler.class.getSimpleName();
    private final Activity activity;

    public MaterialGenAppHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer("#materialApp-"+call.method);
        if (call.method.equals("setAccessToken")) {
            setAccessToken(call, result);
        } else if (call.method.equals("setApiKey")) {
            setApiKey(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void setAccessToken(MethodCall call, MethodChannel.Result result) {
        String token = FromMap.toString("accessToken", call.argument("accessToken"), false);

        if (token == null) {
            HMSLogger.getInstance(activity).sendSingleEvent("#materialApp-setAccessToken", "-1");
            result.error(TAG, "Access token must not be null", "");
            return;
        }

        MaterialGenApplication.getInstance().setAccessToken(token);
        HMSLogger.getInstance(activity).sendSingleEvent("#materialApp-setAccessToken");
        result.success(true);
    }

    private void setApiKey(MethodCall call, MethodChannel.Result result) {
        String key = FromMap.toString("apiKey", call.argument("apiKey"), false);

        if (key == null) {
            HMSLogger.getInstance(activity).sendSingleEvent("#materialApp-setApiKey", "-1");
            result.error(TAG, "Api key must not be null", "");
            return;
        }

        MaterialGenApplication.getInstance().setApiKey(key);
        HMSLogger.getInstance(activity).sendSingleEvent("#materialApp-setApiKey");
        result.success(true);
    }
}
