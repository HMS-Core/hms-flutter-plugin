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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.listeners.TtsListenerImp;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadStrategy;
import com.huawei.hms.mlsdk.tts.MLTtsConfig;
import com.huawei.hms.mlsdk.tts.MLTtsEngine;
import com.huawei.hms.mlsdk.tts.MLTtsLocalModel;
import com.huawei.hms.mlsdk.tts.MLTtsSpeaker;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextToSpeechMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = TextToSpeechMethodHandler.class.getSimpleName();

    private MethodChannel.Result mResult;
    private Activity activity;

    private MLTtsEngine mlTtsEngine;
    String localText;

    public TextToSpeechMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "initEngine":
                initEngine(call);
                break;
            case "getLanguages":
                getLang();
                break;
            case "getSpeaker":
                getPerson(call);
                break;
            case "getSpeakers":
                getPersons();
                break;
            case "isLangAvailable":
                isLangAvailable(call);
                break;
            case "getSpeechWithCloud":
                getSpeechWithCloud(call);
                break;
            case "getSpeechOnDevice":
                getSpeechOnDevice(call);
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
            case "shutdownTextToSpeech":
                shutdown();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void initEngine(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("initTtsEngine");
        mlTtsEngine = new MLTtsEngine(SettingUtils.createTtsConfig(call));
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("initTtsEngine");
        mResult.success(true);
    }

    private void getLang() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getTtsLanguages");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsLanguages", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        List<String> languages = mlTtsEngine.getLanguages();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsLanguages");
        mResult.success(languages);
    }

    private void getPerson(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getTtsSpeaker");
        Map<String, Object> mainMap = new HashMap<>();
        String lang = call.argument("language");

        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsSpeaker", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        List<MLTtsSpeaker> speakers = mlTtsEngine.getSpeaker(lang);
        for (int i = 0; i < speakers.size(); i++) {
            Map<String, Object> innerMap = new HashMap<>();
            MLTtsSpeaker speaker = speakers.get(i);
            innerMap.put("language", speaker.getLanguage());
            innerMap.put("modelSize", speaker.getModelSize());
            innerMap.put("name", speaker.getName());
            innerMap.put("speakerDesc", speaker.getSpeakerDesc());
            mainMap.put(String.valueOf(i), innerMap);
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsSpeaker");
        mResult.success(mainMap);
    }

    private void getPersons() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getTtsSpeakers");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsSpeakers", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        Map<String, Object> mainMap = new HashMap<>();
        List<MLTtsSpeaker> speakers = mlTtsEngine.getSpeakers();
        for (int i = 0; i < speakers.size(); i++) {
            Map<String, Object> innerMap = new HashMap<>();
            MLTtsSpeaker speaker = speakers.get(i);
            innerMap.put("language", speaker.getLanguage());
            innerMap.put("modelSize", speaker.getModelSize());
            innerMap.put("name", speaker.getName());
            innerMap.put("speakerDesc", speaker.getSpeakerDesc());
            mainMap.put(String.valueOf(i), innerMap);
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTtsSpeakers");
        mResult.success(mainMap);
    }

    private void isLangAvailable(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("isLanguageAvailable");
        String language = call.argument("lang");

        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isLanguageAvailable", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isLanguageAvailable");
        mResult.success(mlTtsEngine.isLanguageAvailable(language));
    }

    private void pauseSpeech() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("pauseSpeech");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("pauseSpeech", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        mlTtsEngine.pause();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("pauseSpeech");
        mResult.success(true);
    }

    private void resumeSpeech() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("resumeSpeech");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("resumeSpeech", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            mlTtsEngine.resume();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("resumeSpeech");
            mResult.success(true);
        }
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopTextToSpeech");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextToSpeech", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            mlTtsEngine.stop();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextToSpeech");
            mResult.success(true);
        }
    }

    private void shutdown() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("shutdownTextToSpeech");
        if (mlTtsEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("shutdownTextToSpeech", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            mlTtsEngine.setTtsCallback(null);
            mlTtsEngine.shutdown();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("shutdownTextToSpeech");
            mResult.success(true);
        }
    }

    private void getSpeechWithCloud(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getSpeechWithCloud");
        String text = call.argument("text");
        Integer queuingMode = call.argument("queuingMode");


        if (text == null || text.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSpeechWithCloud", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Source text is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        if (queuingMode == null) {
            queuingMode = 0;
        }

        mlTtsEngine = new MLTtsEngine(SettingUtils.createTtsConfig(call));
        mlTtsEngine.updateConfig(SettingUtils.createTtsConfig(call));
        mlTtsEngine.setTtsCallback(new TtsListenerImp(activity));
        mlTtsEngine.speak(text, queuingMode);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSpeechWithCloud");
    }

    private void getSpeechOnDevice(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getSpeechOnDevice");
        localText = call.argument("text");
        String speaker = call.argument("person");
        Integer queuingMode = call.argument("queuingMode");

        mlTtsEngine = new MLTtsEngine(SettingUtils.createTtsConfig(call));
        mlTtsEngine.setTtsCallback(new TtsListenerImp(activity));

        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();
        MLTtsLocalModel model = new MLTtsLocalModel.Factory(speaker).create();

        localModelManager.isModelExist(model).addOnSuccessListener(aBoolean -> {
            if (aBoolean) {
                mlTtsEngine.speak(localText, queuingMode != null ? queuingMode : 0);
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSpeechOnDevice");
            } else {
                downloadModel(SettingUtils.createTtsConfig(call), queuingMode != null ? queuingMode : 0);
            }
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getSpeechOnDevice", mResult));
    }

    private void downloadModel(@NonNull MLTtsConfig mlConfigs, Integer queueingMode) {
        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();
        final MLTtsLocalModel model = new MLTtsLocalModel.Factory(mlConfigs.getPerson()).create();

        MLModelDownloadStrategy request = new MLModelDownloadStrategy.Factory().needWifi().create();

        localModelManager.downloadModel(model, request, SettingUtils.MODEL_DOWNLOAD_LISTENER).addOnSuccessListener(aVoid -> {
            mlTtsEngine.updateConfig(mlConfigs);
            mlTtsEngine.speak(localText, queueingMode);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getSpeechOnDevice", mResult));
    }

    @Override
    public void onListen(Object arguments, final EventChannel.EventSink events) {
        EventHandler.getInstance().setEventSink(events);
    }

    @Override
    public void onCancel(Object arguments) {
        EventHandler.getInstance().setEventSink(null);
    }
}
