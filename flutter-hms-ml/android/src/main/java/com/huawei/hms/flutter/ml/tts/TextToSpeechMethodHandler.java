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

package com.huawei.hms.flutter.ml.tts;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.tts.MLTtsAudioFragment;
import com.huawei.hms.mlsdk.tts.MLTtsCallback;
import com.huawei.hms.mlsdk.tts.MLTtsConfig;
import com.huawei.hms.mlsdk.tts.MLTtsEngine;
import com.huawei.hms.mlsdk.tts.MLTtsError;
import com.huawei.hms.mlsdk.tts.MLTtsWarn;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextToSpeechMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = TextToSpeechMethodHandler.class.getSimpleName();

    private Activity activity;
    private MLTtsEngine mlTtsEngine;
    private MethodChannel.Result mResult;

    public TextToSpeechMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        mResult = result;
        switch (call.method) {
            case "getSpeechFromText":
                getSpeechFromText(call);
                break;
            case "pauseSpeech":
                pauseSpeech();
                break;
            case "resumeSpeech":
                resumeSpeech();
                break;
            case "stopTextToSpeech":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void pauseSpeech() {
        if (mlTtsEngine == null)
            mResult.error(TAG, "Analyser is not initializer", "");
        else {
            mlTtsEngine.pause();
            mResult.success(true);
        }
    }

    private void resumeSpeech() {
        if (mlTtsEngine == null) {
            mResult.error(TAG, "Analyser is not initializer", "");
        } else {
            mlTtsEngine.resume();
            mResult.success(true);
        }
    }

    private void stopAnalyzer() {
        if (mlTtsEngine == null) {
            mResult.error(TAG, "Analyser is not initialized", "");
        } else {
            mlTtsEngine.stop();
            String success = "Analyzer is stopped";
            mResult.success(success);
        }
    }

    private void getSpeechFromText(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                String text = object.getString("text");
                int queuingMode = object.getInt("queuingMode");
                MLTtsConfig mlConfigs = new MLTtsConfig()
                        .setLanguage(object.getString("language"))
                        .setPerson(object.getString("person"))
                        .setSpeed((float) object.getDouble("speed"))
                        .setVolume((float) object.getDouble("volume"));
                mlTtsEngine = new MLTtsEngine(mlConfigs);
                mlTtsEngine.setTtsCallback(callback);
                mlTtsEngine.speak(text, queuingMode);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private static MLTtsCallback callback = new MLTtsCallback() {
        @Override
        public void onError(String s, MLTtsError mlTtsError) {
            Log.i(TAG, s);
        }

        @Override
        public void onWarn(String s, MLTtsWarn mlTtsWarn) {
            Log.i(TAG, s);
        }

        @Override
        public void onRangeStart(String s, int i, int i1) {
            Log.i(TAG, s);
        }

        @Override
        public void onAudioAvailable(String s, MLTtsAudioFragment mlTtsAudioFragment,
            int i, Pair<Integer, Integer> pair, Bundle bundle) {
            Log.i(TAG, s);
        }

        @Override
        public void onEvent(String s, int i, Bundle bundle) {
            Log.i(TAG, s);
        }

    };
}
