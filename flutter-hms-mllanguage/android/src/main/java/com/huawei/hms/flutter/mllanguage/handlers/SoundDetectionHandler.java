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
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.sounddect.MLSoundDetectListener;
import com.huawei.hms.mlsdk.sounddect.MLSoundDetector;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SoundDetectionHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "SoundDetect";

    private final Activity activity;
    private final MethodChannel mChannel;
    private final ResponseHandler handler;

    private MLSoundDetector soundDetector;

    public SoundDetectionHandler(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.mChannel = channel;
        this.handler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "startSoundDetector":
                startSoundDetector();
                break;
            case "stopSoundDetector":
                stopSoundDetector();
                break;
            case "destroySoundDetector":
                destroySoundDetector();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void startSoundDetector() {
        soundDetector = MLSoundDetector.createSoundDetector();
        soundDetector.setSoundDetectListener(listener);
        soundDetector.start(activity.getApplicationContext());
        handler.success(true);
    }

    private void stopSoundDetector() {
        if (soundDetector == null) {
            handler.noService();
            return;
        }
        soundDetector.stop();
        handler.success(true);
    }

    private void destroySoundDetector() {
        if (soundDetector == null) {
            handler.noService();
            return;
        }
        soundDetector.destroy();
        handler.success(true);
    }

    private final MLSoundDetectListener listener = new MLSoundDetectListener() {
        @Override
        public void onSoundSuccessResult(Bundle result) {
            final Map<String, Object> map = new HashMap<>();
            map.put("result", result.getInt(MLSoundDetector.RESULTS_RECOGNIZED));
            mChannel.invokeMethod("success", map);
        }

        @Override
        public void onSoundFailResult(int errCode) {
            final Map<String, Object> map = new HashMap<>();
            map.put("errCode", errCode);
            mChannel.invokeMethod("fail", map);
        }
    };
}
