/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.aft;

import android.app.Activity;
import android.net.Uri;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftEngine;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftListener;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftResult;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftSetting;
import com.huawei.hms.mlsdk.common.MLApplication;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AftMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = AftMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    public AftMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        if (call.method.equals("start")) {
            startAft(call);
        }
    }

    private void startAft(MethodCall call) {
        try {
            String aftJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                aftJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (aftJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject aftJsonObject = new JSONObject(aftJsonString);
                String path = aftJsonObject.getString("path");
                String language = aftJsonObject.getString("language");
                MLRemoteAftEngine engine = MLRemoteAftEngine.getInstance();
                engine.init(activity);
                MLRemoteAftSetting setting = new MLRemoteAftSetting.Factory()
                        .setLanguageCode(language)
                        .create();
                engine.setAftListener(aftListener);
                Uri uri = Uri.fromFile(new File(path));
                engine.shortRecognize(uri, setting);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private MLRemoteAftListener aftListener = new MLRemoteAftListener() {
        @Override
        public void onInitComplete(String s, Object o) {
            Log.i(TAG, s + " " + o.toString());
        }

        @Override
        public void onUploadProgress(String s, double v, Object o) {
            Log.i(TAG, s + " " + v);
        }

        @Override
        public void onEvent(String s, int i, Object o) {
            Log.i(TAG, s);
        }

        @Override
        public void onResult(String s, MLRemoteAftResult mlRemoteAftResult, Object o) {
            mResult.success(mlRemoteAftResult.getText());
        }

        @Override
        public void onError(String s, int i, String s1) {
            mResult.error(TAG, s, s1);
        }
    };
}