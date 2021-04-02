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
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscription;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionConstants;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionListener;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RealTimeTranscriptionMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private final static String TAG = RealTimeTranscriptionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLSpeechRealTimeTranscription mSpeechRecognizer;
    private Map<String, Object> mEventMap = new HashMap<>();

    public RealTimeTranscriptionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "startRecognizing":
                startTranscription(call);
                break;
            case "destroy":
                destroyTranscription();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void startTranscription(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("startRealTimeTranscription");
        mSpeechRecognizer = MLSpeechRealTimeTranscription.getInstance();
        mSpeechRecognizer.setRealTimeTranscriptionListener(new SpeechRecognitionListener());
        mSpeechRecognizer.startRecognizing(SettingUtils.createRttConfig(call));
    }

    private void destroyTranscription() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopRealTimeTranscription");

        if (mSpeechRecognizer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("stopRealTimeTranscription", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Recognizer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        mSpeechRecognizer.setRealTimeTranscriptionListener(null);
        mSpeechRecognizer.destroy();
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("stopRealTimeTranscription");
        mResult.success(true);
    }

    private Map<String, Object> getSegment(ArrayList<MLSpeechRealTimeTranscriptionResult> segments) {
        Map<String, Object> segmentMap = new HashMap<>();
        for (MLSpeechRealTimeTranscriptionResult segment : segments) {
            segmentMap.put("endTime", segment.endTime);
            segmentMap.put("startTime", segment.startTime);
            segmentMap.put("text", segment.text);
        }
        return segmentMap;
    }

    protected class SpeechRecognitionListener implements MLSpeechRealTimeTranscriptionListener {
        @Override
        public void onStartListening() {
            mEventMap.clear();
            mEventMap.put("onStartListening", "Started Listening..");
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onStartListening");
            sendEvent(mEventMap);
        }

        @Override
        public void onStartingOfSpeech() {
            mEventMap.clear();
            mEventMap.put("onStartingOfSpeech", "Speech is started");
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onStartingOfSpeech");
            sendEvent(mEventMap);
        }

        @Override
        public void onVoiceDataReceived(byte[] data, float energy, Bundle bundle) {
            mEventMap.clear();
            HashMap<String, Object> voiceDataMap = new HashMap<>();
            voiceDataMap.put("length", data.length);
            voiceDataMap.put("energy", energy);
            mEventMap.put("onVoiceDataReceived", voiceDataMap);
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onVoiceDataReceived");
            sendEvent(mEventMap);
        }

        @Override
        public void onRecognizingResults(Bundle partialResults) {
            mEventMap.clear();
            Map<String, Object> finalResultMap = new HashMap<>();
            if (partialResults != null) {
                boolean isFinal = partialResults.getBoolean(MLSpeechRealTimeTranscriptionConstants.RESULTS_PARTIALFINAL);
                if (isFinal) {
                    ArrayList<MLSpeechRealTimeTranscriptionResult> wordOffset = partialResults.getParcelableArrayList(
                            MLSpeechRealTimeTranscriptionConstants.RESULTS_WORD_OFFSET);
                    ArrayList<MLSpeechRealTimeTranscriptionResult> sentenceOffset = partialResults.getParcelableArrayList(
                            MLSpeechRealTimeTranscriptionConstants.RESULTS_SENTENCE_OFFSET);

                    if (wordOffset != null)
                        finalResultMap.put("wordOffset", getSegment(wordOffset));

                    if (sentenceOffset != null)
                        finalResultMap.put("sentenceOffset", getSegment(sentenceOffset));

                }
                finalResultMap.put("result", partialResults.getString(MLSpeechRealTimeTranscriptionConstants.RESULTS_RECOGNIZING));
                mEventMap.put("onRecognizingResults", finalResultMap);
                HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onRecognizingResults");
                sendEvent(mEventMap);
            }
        }

        @Override
        public void onError(int error, String errorMessage) {
            mResult.error(TAG, errorMessage, error);
        }

        @Override
        public void onState(int state, Bundle params) {
            mEventMap.clear();
            HashMap<String, Object> stateMap = new HashMap<>();
            stateMap.put("state", state);
            mEventMap.put("onState", stateMap);
            HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onState");
            sendEvent(mEventMap);
        }
    }

    private void sendEvent(final Map<String, Object> event) {
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }

    @Override
    public void onListen(Object r, EventChannel.EventSink t) {
        EventHandler.getInstance().setEventSink(t);
    }

    @Override
    public void onCancel(Object s) {
        EventHandler.getInstance().setEventSink(null);
    }
}
