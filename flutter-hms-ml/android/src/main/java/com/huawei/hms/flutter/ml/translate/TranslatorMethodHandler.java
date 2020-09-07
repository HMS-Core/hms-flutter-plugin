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

package com.huawei.hms.flutter.ml.translate;

import android.app.Activity;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.translate.MLTranslatorFactory;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslateSetting;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslator;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;

public class TranslatorMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = TranslatorMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLRemoteTranslator translator;

    public TranslatorMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "translate":
                translate(call);
                break;
            case "stopTranslator":
                stopTranslator();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void translate(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                String targetLangCode = object.getString("targetLangCode");
                String sourceLangCode = object.getString("sourceLangCode");
                String sourceText = object.getString("sourceText");
                String apiKey = AGConnectServicesConfig.fromContext(
                        activity.getApplicationContext()).getString("client/api_key");
                MLApplication.getInstance().setApiKey(apiKey);

                MLRemoteTranslateSetting setting = new MLRemoteTranslateSetting.Factory()
                        .setTargetLangCode(targetLangCode)
                        .setSourceLangCode(sourceLangCode)
                        .create();

                translator = MLTranslatorFactory.getInstance().getRemoteTranslator(setting);
                Task<String> task = translator.asyncTranslate(sourceText);

                task.addOnSuccessListener(new OnSuccessListener<String>() {
                    @Override
                    public void onSuccess(String s) {
                        onTranslateSuccess(s);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception translateError) {
                        mResult.error(TAG, translateError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException translateError) {
            mResult.error(TAG, translateError.getMessage(), "");
        }
    }

    private void onTranslateSuccess(String s) {
        mResult.success(s);
    }

    private void stopTranslator() {
        if (translator != null) {
            translator.stop();
            translator = null;
            String success = "Translator is stopped";
            mResult.success(success);
        } else {
            mResult.error(TAG, "Translator is null", "");
        }
    }
}