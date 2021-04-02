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

package com.huawei.hms.flutter.ml.language;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlplugin.asr.MLAsrCaptureActivity;
import com.huawei.hms.mlplugin.asr.MLAsrCaptureConstants;
import com.huawei.hms.mlsdk.asr.MLAsrConstants;
import com.huawei.hms.mlsdk.asr.MLAsrListener;
import com.huawei.hms.mlsdk.asr.MLAsrRecognizer;

import java.util.HashMap;

import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrMethodHandler implements MethodChannel.MethodCallHandler, StreamHandler, PluginRegistry.ActivityResultListener {
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
        switch (call.method) {
            case "startRecognizing":
                recognize(call);
                break;
            case "recognizeWithUi":
                recognizeWithUi(call);
                break;
            case "stopRecognition":
                stopAsr();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void recognize(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeVoice");
        String language = call.argument("language");
        String scene = call.argument("scene");
        Integer feature = call.argument("feature");

        mSpeechRecognizer = MLAsrRecognizer.createAsrRecognizer(activity);
        mSpeechRecognizer.setAsrListener(new SpeechRecognitionListener());

        Intent mSpeechRecognizerIntent = new Intent(MLAsrConstants.ACTION_HMS_ASR_SPEECH);
        mSpeechRecognizerIntent
                .putExtra(MLAsrConstants.LANGUAGE, language != null ? language : "en-US")
                .putExtra(MLAsrConstants.FEATURE, feature != null ? feature : 11);

        if (language != null && language.contains("z")) {
            mSpeechRecognizerIntent.putExtra(MLAsrConstants.SCENES, scene);
        }

        mSpeechRecognizer.startRecognizing(mSpeechRecognizerIntent);
    }

    private void recognizeWithUi(MethodCall call) {
        String language = call.argument("language");
        Integer feature = call.argument("feature");

        Intent intent = new Intent(activity, MLAsrCaptureActivity.class)
                .putExtra(MLAsrCaptureConstants.LANGUAGE, language != null ? language : "en-US")
                .putExtra(MLAsrCaptureConstants.FEATURE, feature != null ? feature : 11);

        activity.startActivityForResult(intent, 100);
    }

    private class SpeechRecognitionListener implements MLAsrListener {
        @Override
        public void onResults(Bundle bundle) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeVoice");
            mResult.success(bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZED));
        }

        @Override
        public void onRecognizingResults(Bundle bundle) {
            HashMap<String, Object> recMap = new HashMap<>();
            recMap.put("event", "onRecognizingResults");
            recMap.put("result", bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZING));
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onRecognizingResults");
            sendAsrEvents(recMap);
        }

        @Override
        public void onError(int i, String s) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeVoice", String.valueOf(i));
            mResult.error(String.valueOf(i), s, "");
        }

        @Override
        public void onStartListening() {
            HashMap<String, Object> onStartListeningMap = new HashMap<>();
            onStartListeningMap.put("event", "onStartListening");
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onStartListening");
            sendAsrEvents(onStartListeningMap);
        }

        @Override
        public void onStartingOfSpeech() {
            HashMap<String, Object> onStartSpeechMap = new HashMap<>();
            onStartSpeechMap.put("event", "onStartingOfSpeech");
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onStartingOfSpeech");
            sendAsrEvents(onStartSpeechMap);
        }

        @Override
        public void onVoiceDataReceived(byte[] data, float energy, Bundle bundle) {
            HashMap<String, Object> onVoiceReceivedMap = new HashMap<>();
            onVoiceReceivedMap.put("event", "onVoiceDataReceived");
            onVoiceReceivedMap.put("energy", energy);
            onVoiceReceivedMap.put("data", data);
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onVoiceDataReceived");
            sendAsrEvents(onVoiceReceivedMap);
        }

        @Override
        public void onState(int state, Bundle bundle) {
            HashMap<String, Object> onStateMap = new HashMap<>();
            onStateMap.put("event", "onState");
            onStateMap.put("state", state);
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onState");
            sendAsrEvents(onStateMap);
        }
    }

    private void stopAsr() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopAsrRecognition");
        if (mSpeechRecognizer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopAsrRecognition", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Recognition is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        mSpeechRecognizer.destroy();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopAsrRecognition");
        mResult.success(true);
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        EventHandler.getInstance().setEventSink(events);
    }

    @Override
    public void onCancel(Object arguments) {
        EventHandler.getInstance().setEventSink(null);
    }

    private void sendAsrEvents(final HashMap<String, Object> event) {
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        String text;
        String errMsg = null;
        int errCode = 0;
        int subErrCode = 0;
        if (requestCode == 100) {
            switch (resultCode) {
                case MLAsrCaptureConstants.ASR_SUCCESS:
                    if (data != null) {
                        Bundle bundle = data.getExtras();
                        if (bundle != null && bundle.containsKey(MLAsrCaptureConstants.ASR_RESULT)) {
                            text = bundle.getString(MLAsrCaptureConstants.ASR_RESULT);
                            mResult.success(text);
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
                    mResult.error(TAG, errMsg, String.valueOf(errCode) + subErrCode);
                    break;
                default:
                    break;
            }
        }
        return true;
    }
}