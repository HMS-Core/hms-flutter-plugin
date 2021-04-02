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
import android.net.Uri;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftEngine;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftListener;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftResult;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AftMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = AftMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLRemoteAftEngine engine;

    public AftMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "shortRecognize":
                shortRecognize(call);
                break;
            case "longRecognize":
                longRecognize(call);
                break;
            case "startTask":
                startTask(call);
                break;
            case "pauseTask":
                pauseTask(call);
                break;
            case "destroyTask":
                destroyTask(call);
                break;
            case "getLongAftResult":
                getLongAftResult(call);
                break;
            case "closeAftEngine":
                closeAftEngine();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void shortRecognize(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("shortRecognize");
        String voicePath = call.argument("path");

        if (voicePath == null || voicePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("shortRecognize", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Voice path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        engine = MLRemoteAftEngine.getInstance();
        engine.init(activity);
        engine.setAftListener(aftListener);

        Uri uri = Uri.fromFile(new File(voicePath));
        engine.shortRecognize(uri, SettingUtils.createAftSetting(call));
    }

    private void longRecognize(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("longRecognize");
        String voicePath1 = call.argument("path");

        if (voicePath1 == null || voicePath1.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("shortRecognize", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Voice path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        engine = MLRemoteAftEngine.getInstance();
        engine.init(activity);
        engine.setAftListener(aftListener);

        Uri uri = Uri.fromFile(new File(voicePath1));
        engine.longRecognize(uri, SettingUtils.createAftSetting(call));
    }

    private void startTask(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("startAftTask");
        String taskId = call.argument("taskId");

        if (engine == null) {
            mResult.error(TAG, "Aft engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        engine.startTask(taskId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startAftTask");
        mResult.success(true);
    }

    private void pauseTask(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("pauseAftTask");
        String taskId = call.argument("taskId");

        if (engine == null) {
            mResult.error(TAG, "Aft engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        engine.pauseTask(taskId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("pauseAftTask");
        mResult.success(true);
    }

    private void destroyTask(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("destroyAftTask");
        String taskId = call.argument("taskId");

        if (engine == null) {
            mResult.error(TAG, "Aft engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        engine.destroyTask(taskId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("destroyAftTask");
        mResult.success(true);
    }

    private void getLongAftResult(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLongAftResult");
        String taskId = call.argument("taskId");

        if (engine == null) {
            mResult.error(TAG, "Aft engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        engine.getLongAftResult(taskId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLongAftResult");
        mResult.success(true);
    }

    private void closeAftEngine() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("closeAftRecognition");
        if (engine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("closeAftRecognition", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Aft engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        engine.close();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("closeAftRecognition");
        mResult.success(true);
    }

    private String obtainAftJsonObject(@NonNull MLRemoteAftResult result) {
        Map<String, Object> aftMap = new HashMap<>();
        aftMap.put("segments", result.getSegments());
        aftMap.put("sentences", result.getSentences());
        aftMap.put("words", result.getWords());
        aftMap.put("text", result.getText());
        aftMap.put("taskId", result.getTaskId());
        aftMap.put("isComplete", result.isComplete());
        Gson gson = new Gson();
        return gson.toJson(aftMap);
    }


    private MLRemoteAftListener aftListener = new MLRemoteAftListener() {
        public void onResult(String taskId, MLRemoteAftResult result, Object ext) {
            if (result.isComplete()) {
                Map<String, Object> map = new HashMap<>();
                map.put("event", "onResult");
                map.put("taskId", taskId);
                map.put("result", obtainAftJsonObject(result));
                sendEvent(map);
            }
        }

        @Override
        public void onError(String taskId, int errorCode, String message) {
            Map<String, Object> map = new HashMap<>();
            map.put("event", "onError");
            map.put("taskId", taskId);
            map.put("errorCode", errorCode);
            map.put("message", message);
            sendEvent(map);
        }

        @Override
        public void onInitComplete(String taskId, Object ext) {
            Map<String, Object> map = new HashMap<>();
            map.put("event", "onInitComplete");
            map.put("taskId", taskId);
            sendEvent(map);
        }

        @Override
        public void onUploadProgress(String taskId, double progress, Object ext) {
            Map<String, Object> map = new HashMap<>();
            map.put("event", "onUploadProgress");
            map.put("taskId", taskId);
            map.put("progress", progress);
            sendEvent(map);
        }

        @Override
        public void onEvent(String taskId, int eventId, Object ext) {
            Map<String, Object> map = new HashMap<>();
            map.put("event", "onEvent");
            map.put("taskId", taskId);
            map.put("eventId", eventId);
            sendEvent(map);
        }
    };

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        EventHandler.getInstance().setEventSink(events);
    }

    @Override
    public void onCancel(Object arguments) {
        EventHandler.getInstance().setEventSink(null);
    }

    private void sendEvent(final Map<String, Object> event) {
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }
}