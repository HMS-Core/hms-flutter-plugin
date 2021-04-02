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
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.sounddect.MLSoundDectListener;
import com.huawei.hms.mlsdk.sounddect.MLSoundDector;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SoundDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = SoundDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLSoundDector soundDetector;

    public SoundDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
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
                mResult.notImplemented();
                break;
        }
    }

    private void startSoundDetector() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("startSoundDetector");
        soundDetector = MLSoundDector.createSoundDector();
        soundDetector.setSoundDectListener(listener);
        soundDetector.start(activity.getApplicationContext());
    }

    private void stopSoundDetector() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopSoundDetector");
        if (soundDetector == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSoundDetector", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Sound detector is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        soundDetector.stop();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSoundDetector");
        mResult.success(true);
    }

    private void destroySoundDetector() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("destroySoundDetector");
        if (soundDetector == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("destroySoundDetector", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Sound detector is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        soundDetector.destroy();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("destroySoundDetector");
        mResult.success(true);
    }

    private MLSoundDectListener listener = new MLSoundDectListener() {
        @Override
        public void onSoundSuccessResult(Bundle result) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startSoundDetector");
            mResult.success(result.getInt(MLSoundDector.RESULTS_RECOGNIZED));
        }

        @Override
        public void onSoundFailResult(int errCode) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startSoundDetector", String.valueOf(errCode));
            mResult.error(TAG, String.valueOf(errCode), "");
        }
    };
}
