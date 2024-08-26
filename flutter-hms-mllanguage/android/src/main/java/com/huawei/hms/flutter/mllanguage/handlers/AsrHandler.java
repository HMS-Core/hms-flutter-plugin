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
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.listeners.AsrListenerImpl;
import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.mlplugin.asr.MLAsrCaptureActivity;
import com.huawei.hms.mlplugin.asr.MLAsrCaptureConstants;
import com.huawei.hms.mlsdk.asr.MLAsrConstants;
import com.huawei.hms.mlsdk.asr.MLAsrRecognizer;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static final String TAG = "AsrHandler";

    private final Activity activity;
    private final MethodChannel channel;
    private final ResponseHandler rsHandler;

    private MLAsrRecognizer mSpeechRecognizer;

    public AsrHandler(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
        this.rsHandler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        rsHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "getSupportedLanguages":
                getLanguages();
                break;
            case "startRecognizing":
                start(call);
                break;
            case "startRecognizingWithUi":
                startWithUi(call);
                break;
            case "destroy":
                destroy();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getLanguages() {
        MLAsrRecognizer.createAsrRecognizer(activity).getLanguages(new MLAsrRecognizer.LanguageCallback() {
            @Override
            public void onResult(List<String> list) {
                rsHandler.success(list);
            }

            @Override
            public void onError(int i, String s) {
                rsHandler.callbackError(String.valueOf(i), s);
            }
        });
    }

    private void start(MethodCall call) {
        String language = FromMap.toString("language", call.argument("language"), false);
        String scene = FromMap.toString("scene", call.argument("scene"), false);
        Integer feature = FromMap.toInteger("feature", call.argument("feature"));

        Intent mSpeechRecognizerIntent = new Intent(MLAsrConstants.ACTION_HMS_ASR_SPEECH);

        if (language == null) {
            language = MLAsrConstants.LAN_EN_US;
        }

        if (feature == null) {
            feature = MLAsrConstants.FEATURE_WORDFLUX;
        }

        mSpeechRecognizerIntent
                .putExtra(MLAsrConstants.LANGUAGE, language)
                .putExtra(MLAsrConstants.FEATURE, feature);

        if (scene != null && scene.equals(MLAsrConstants.SCENES_SHOPPING) && language.equals(MLAsrConstants.LAN_ZH_CN)) {
            mSpeechRecognizerIntent.putExtra(MLAsrConstants.SCENES, scene);
        }

        mSpeechRecognizer = MLAsrRecognizer.createAsrRecognizer(activity);
        mSpeechRecognizer.setAsrListener(new AsrListenerImpl(activity, channel));

        mSpeechRecognizer.startRecognizing(mSpeechRecognizerIntent);
        rsHandler.success(null);
    }

    private void startWithUi(MethodCall call) {
        String language = FromMap.toString("language", call.argument("language"), false);
        Integer feature = FromMap.toInteger("feature", call.argument("feature"));

        Intent intent = new Intent(activity, MLAsrCaptureActivity.class)
                .putExtra(MLAsrCaptureConstants.LANGUAGE, language != null ? language : "en-US")
                .putExtra(MLAsrCaptureConstants.FEATURE, feature != null ? feature : 11);

        activity.startActivityForResult(intent, 8888);
    }

    private void destroy() {
        if (mSpeechRecognizer == null) {
            rsHandler.noService();
            return;
        }

        mSpeechRecognizer.destroy();
        rsHandler.success(null);
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        String text;
        String errMsg = null;
        int errCode = 0;
        int subErrCode = 0;
        if (requestCode == 8888) {
            switch (resultCode) {
                case MLAsrCaptureConstants.ASR_SUCCESS:
                    if (data != null) {
                        Bundle bundle = data.getExtras();
                        if (bundle != null && bundle.containsKey(MLAsrCaptureConstants.ASR_RESULT)) {
                            text = bundle.getString(MLAsrCaptureConstants.ASR_RESULT);
                            rsHandler.success(text);
                        } else {
                            rsHandler.success(null);
                        }
                    }
                    break;
                case MLAsrCaptureConstants.ASR_FAILURE:
                    if (data != null) {
                        Bundle bundle = data.getExtras();
                        if (bundle != null && bundle.containsKey(MLAsrCaptureConstants.ASR_ERROR_CODE)) {
                            errCode = bundle.getInt(MLAsrCaptureConstants.ASR_ERROR_CODE);
                        }
                        if (bundle != null && bundle.containsKey(MLAsrCaptureConstants.ASR_ERROR_MESSAGE)) {
                            errMsg = bundle.getString(MLAsrCaptureConstants.ASR_ERROR_MESSAGE);
                        }
                        if (bundle != null && bundle.containsKey(MLAsrCaptureConstants.ASR_SUB_ERROR_CODE)) {
                            subErrCode = bundle.getInt(MLAsrCaptureConstants.ASR_SUB_ERROR_CODE);
                        }
                    }
                    final String errors = "Err: " + errCode + " Sub: " + subErrCode;
                    rsHandler.callbackError(errors, errMsg);
                    break;
                default:
                    break;
            }
        }
        return true;
    }
}
