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
import android.net.Uri;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.listeners.AftListenerImpl;
import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftEngine;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftSetting;

import java.io.File;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AftHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "AftHandler";

    private final Activity activity;
    private final MethodChannel mChannel;
    private final ResponseHandler rspHandler;

    private MLRemoteAftEngine engine;

    public AftHandler(Activity activity, MethodChannel mChannel) {
        this.activity = activity;
        this.mChannel = mChannel;
        this.rspHandler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        rspHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "shortAftLang":
                shortAftLgs();
                break;
            case "longAftLang":
                longAftLgs();
                break;
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
            case "close":
                closeEngine();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void shortAftLgs() {
        MLRemoteAftEngine.getInstance().getShortAftLanguages(new MLRemoteAftEngine.LanguageCallback() {
            @Override
            public void onResult(List<String> l) {
                rspHandler.success(l);
            }

            @Override
            public void onError(int i, String s) {
                rspHandler.callbackError(String.valueOf(i), s);
            }
        });
    }

    private void longAftLgs() {
        MLRemoteAftEngine.getInstance().getLongAftLanguages(new MLRemoteAftEngine.LanguageCallback() {
            @Override
            public void onResult(List<String> list) {
                rspHandler.success(list);
            }

            @Override
            public void onError(int i1, String s1) {
                rspHandler.callbackError(String.valueOf(i1), s1);
            }
        });
    }

    private void shortRecognize(@NonNull MethodCall call) {
        final String shortVoicePath = FromMap.toString("path", call.argument("path"), false);
        if (shortVoicePath == null || shortVoicePath.isEmpty()) {
            rspHandler.exception(new Exception("Audio path must not be null or empty"));
            return;
        }
        final MLRemoteAftSetting setting = RequestBuilder.createAftSetting(call);
        engine = MLRemoteAftEngine.getInstance();
        engine.init(activity);
        engine.setAftListener(new AftListenerImpl(activity, mChannel));

        final Uri shortUri = Uri.fromFile(new File(shortVoicePath));
        engine.shortRecognize(shortUri, setting);
    }

    private void longRecognize(@NonNull MethodCall call) {
        final String longVoicePath = FromMap.toString("path", call.argument("path"), false);
        if (longVoicePath == null || longVoicePath.isEmpty()) {
            rspHandler.exception(new Exception("Audio path must not be null or empty!"));
            return;
        }
        final MLRemoteAftSetting setting1 = RequestBuilder.createAftSetting(call);
        engine = MLRemoteAftEngine.getInstance();
        engine.init(activity);
        engine.setAftListener(new AftListenerImpl(activity, mChannel));

        final Uri longUri = Uri.fromFile(new File(longVoicePath));
        engine.longRecognize(longUri, setting1);
    }

    private void startTask(@NonNull MethodCall call) {
        String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        if (engine == null) {
            rspHandler.noService();
            return;
        }

        engine.startTask(taskId);
        rspHandler.success(true);
    }

    private void pauseTask(@NonNull MethodCall call) {
        String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        if (engine == null) {
            rspHandler.noService();
            return;
        }

        engine.pauseTask(taskId);
        rspHandler.success(true);
    }

    private void destroyTask(@NonNull MethodCall call) {
        String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        if (engine == null) {
            rspHandler.noService();
            return;
        }

        engine.destroyTask(taskId);
        rspHandler.success(true);
    }

    private void getLongAftResult(@NonNull MethodCall call) {
        String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        if (engine == null) {
            rspHandler.noService();
            return;
        }

        engine.getLongAftResult(taskId);
        rspHandler.success(true);
    }

    private void closeEngine() {
        if (engine == null) {
            rspHandler.noService();
            return;
        }

        engine.close();
        rspHandler.success(true);
    }
}
