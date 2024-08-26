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
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.listeners.TtsListenerImpl;
import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadListener;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadStrategy;
import com.huawei.hms.mlsdk.tts.MLTtsConfig;
import com.huawei.hms.mlsdk.tts.MLTtsConstants;
import com.huawei.hms.mlsdk.tts.MLTtsEngine;
import com.huawei.hms.mlsdk.tts.MLTtsLocalModel;
import com.huawei.hms.mlsdk.tts.MLTtsSpeaker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TtsHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "TtsHandler";

    private final Handler h = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel mChannel;
    private final ResponseHandler handler;

    private MLTtsEngine mlTtsEngine;
    private MLTtsConfig mlTtsConfig;

    public TtsHandler(Activity activity, MethodChannel mChannel) {
        this.activity = activity;
        this.mChannel = mChannel;
        this.handler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "isModelExist":
                isModelExist(call);
                break;
            case "downloadModel":
                downloadModel(call);
                break;
            case "getLanguages":
                getLanguages();
                break;
            case "getSpeaker":
                getSpeaker(call);
                break;
            case "getSpeakers":
                getSpeakers();
                break;
            case "isLanguageAvailable":
                isLangAvailable(call, result);
                break;
            case "setPlayerVolume":
                setVolume(call);
                break;
            case "speak":
                speak(call);
                break;
            case "pause":
                pause();
                break;
            case "resume":
                resume();
                break;
            case "stop":
                stop();
                break;
            case "shutdown":
                shutdown();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void pause() {
        if (mlTtsEngine == null) {
            handler.noService();
            return;
        }

        mlTtsEngine.pause();
        handler.success(true);
    }

    private void resume() {
        if (mlTtsEngine == null) {
            handler.noService();
            return;
        }

        mlTtsEngine.resume();
        handler.success(true);
    }

    private void stop() {
        if (mlTtsEngine == null) {
            handler.noService();
            return;
        }

        mlTtsEngine.stop();
        handler.success(true);
    }

    private void shutdown() {
        if (mlTtsEngine == null) {
            handler.noService();
            return;
        }

        mlTtsEngine.shutdown();
        handler.success(true);
    }

    private void setVolume(MethodCall call) {
        Integer volume = FromMap.toInteger("volume", call.argument("volume"));

        if (mlTtsEngine == null) {
            handler.noService();
            return;
        }

        if (volume == null) {
            handler.exception(new Exception("Volume must not be null!"));
            return;
        }

        mlTtsEngine.setPlayerVolume(volume);
        mlTtsEngine.updateConfig(mlTtsConfig);
        handler.success(null);
    }

    private void getLanguages() {
        mlTtsEngine = new MLTtsEngine(new MLTtsConfig());
        handler.success(mlTtsEngine.getLanguages());
    }

    private void getSpeaker(MethodCall call) {
        String lang = FromMap.toString("language", call.argument("language"), false);

        mlTtsEngine = new MLTtsEngine(new MLTtsConfig());
        List<MLTtsSpeaker> speakers = mlTtsEngine.getSpeaker(lang);
        speakersToMap(speakers);
    }

    private void getSpeakers() {
        mlTtsEngine = new MLTtsEngine(new MLTtsConfig());
        List<MLTtsSpeaker> speakers = mlTtsEngine.getSpeakers();
        speakersToMap(speakers);
    }

    private void isLangAvailable(@NonNull MethodCall call, MethodChannel.Result result) {
        String language = FromMap.toString("lang", call.argument("lang"), false);

        mlTtsEngine = new MLTtsEngine(new MLTtsConfig());
        result.success(mlTtsEngine.isLanguageAvailable(language));
    }

    private void speak(MethodCall call) {
        String text = FromMap.toString("text", call.argument("text"), false);
        Integer queuingMode = FromMap.toInteger("queuingMode", call.argument("queuingMode"));

        if (text == null || text.isEmpty()) {
            handler.exception(new Exception("Text must not be null or empty!"));
            return;
        }

        if (queuingMode == null) {
            queuingMode = MLTtsEngine.QUEUE_APPEND;
        }

        mlTtsConfig = RequestBuilder.createTtsConfig(call);
        mlTtsEngine = new MLTtsEngine(mlTtsConfig);
        mlTtsEngine.setTtsCallback(new TtsListenerImpl(activity, mChannel));

        mlTtsEngine.updateConfig(mlTtsConfig);
        handler.success(mlTtsEngine.speak(text, queuingMode));
    }

    private void speakersToMap(List<MLTtsSpeaker> speakers) {
        ArrayList<Map<String, Object>> spList = new ArrayList<>();
        for (int i = 0; i < speakers.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLTtsSpeaker speaker = speakers.get(i);
            map.put("language", speaker.getLanguage());
            map.put("modelSize", speaker.getModelSize());
            map.put("name", speaker.getName());
            map.put("speakerDesc", speaker.getSpeakerDesc());
            spList.add(map);
        }
        handler.success(spList);
    }

    private void isModelExist(MethodCall call) {
        String model = FromMap.toString("model", call.argument("model"), false);

        if (model == null || model.isEmpty()) {
            handler.exception(new Exception("Model must not be null or empty!"));
            return;
        }

        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();
        MLTtsLocalModel localModel = new MLTtsLocalModel.Factory(model).create();

        localModelManager.isModelExist(localModel)
                .addOnSuccessListener(handler::success)
                .addOnFailureListener(handler::exception);
    }

    private void downloadModel(MethodCall call) {
        String model = FromMap.toString("model", call.argument("model"), false);

        if (model == null || model.isEmpty()) {
            handler.exception(new Exception("Model must not be null or empty!"));
            return;
        }
        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();
        MLTtsLocalModel localModel = new MLTtsLocalModel.Factory(MLTtsConstants.TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BEE).create();

        MLModelDownloadStrategy strategy = new MLModelDownloadStrategy.Factory().create();

        localModelManager.downloadModel(localModel, strategy, listener)
                .addOnSuccessListener(aVoid -> handler.success(true))
                .addOnFailureListener(handler::exception);
    }

    MLModelDownloadListener listener = new MLModelDownloadListener() {
        @Override
        public void onProcess(long l, long l1) {
            Map<String, Object> map = new HashMap<>();
            map.put("downloaded", l);
            map.put("all", l1);
            h.post(() -> mChannel.invokeMethod("modelDownload", map));
        }
    };
}
