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

package com.huawei.hms.flutter.ml.asr;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.mlsdk.asr.MLAsrConstants;
import com.huawei.hms.mlsdk.asr.MLAsrListener;
import com.huawei.hms.mlsdk.asr.MLAsrRecognizer;
import com.huawei.hms.mlsdk.common.MLApplication;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AsrMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = AsrMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLAsrRecognizer mSpeechRecognizer;

    public AsrMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        if (call.method.equals("analyzeVoice")) {
            analyzeVoice(call);
        } else if (call.method.equals("stopRecognition")) {
            stopRecognizing();
        } else {
            result.notImplemented();
        }
    }

    private void analyzeVoice(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                int feature = object.getInt("feature");
                String language = object.getString("language");

                mSpeechRecognizer = MLAsrRecognizer.createAsrRecognizer(activity);
                mSpeechRecognizer.setAsrListener(new SpeechRecognitionListener());
                Intent mSpeechRecognizerIntent = new Intent(MLAsrConstants.ACTION_HMS_ASR_SPEECH);
                mSpeechRecognizerIntent
                        .putExtra(MLAsrConstants.LANGUAGE, language)
                        .putExtra(MLAsrConstants.FEATURE, feature);
                mSpeechRecognizer.startRecognizing(mSpeechRecognizerIntent);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private class SpeechRecognitionListener implements MLAsrListener {
        @Override
        public void onResults(Bundle bundle) {
            mResult.success(bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZED));
        }

        @Override
        public void onRecognizingResults(Bundle bundle) {
            Log.i(TAG, Objects.requireNonNull(bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZING)));
        }

        @Override
        public void onError(int i, String s) {
            mResult.error(String.valueOf(i), s, "");
        }

        @Override
        public void onStartListening() {
            Log.i(TAG, "Started listening");
        }

        @Override
        public void onStartingOfSpeech() {
            Log.i(TAG, "Speech started");
        }

        @Override
        public void onVoiceDataReceived(byte[] bytes, float v, Bundle bundle) {
            Log.i(TAG, "Voice data is received");
        }

        @Override
        public void onState(int i, Bundle bundle) {
            Log.i(TAG, String.valueOf(i));
        }
    }

    private void stopRecognizing() {
        if (mSpeechRecognizer != null) {
            mSpeechRecognizer.destroy();
            String success = "Recognizing closed";
            mResult.success(success);
        } else {
            mResult.error(TAG, "Recognition is not initialized", "");
        }
    }
}