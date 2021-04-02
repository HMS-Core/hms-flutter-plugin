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

package com.huawei.hms.flutter.ml.body;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCapture;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCaptureConfig;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCaptureResult;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LivenessDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = LivenessDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    public LivenessDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (call.method.equals("getLivenessDetectionResult")) {
            startCapturing(call);
        } else {
            mResult.notImplemented();
        }
    }

    private void startCapturing(MethodCall call) {
        Boolean detectMask = call.argument("detectMask");
        if (detectMask == null) detectMask = true;
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLivenessDetectionResult");
        MLLivenessCapture capture = MLLivenessCapture.getInstance();
        MLLivenessCaptureConfig captureConfig = new MLLivenessCaptureConfig.Builder().setOptions(detectMask ? 1 : 0).build();
        capture.setConfig(captureConfig);
        capture.startDetect(activity, callback);
    }

    private MLLivenessCapture.Callback callback = new MLLivenessCapture.Callback() {
        @Override
        public void onSuccess(MLLivenessCaptureResult result) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLivenessDetectionResult");
            sendLivenessDetectionResult(result);
        }

        @Override
        public void onFailure(int errorCode) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLivenessDetectionResult", String.valueOf(errorCode));
            mResult.error(TAG, String.valueOf(errorCode), String.valueOf(errorCode));
        }
    };

    private void sendLivenessDetectionResult(MLLivenessCaptureResult result) {
        Map<String, Object> liveMap = new HashMap<>();
        liveMap.put("score", result.getScore());
        liveMap.put("pitch", result.getPitch());
        liveMap.put("roll", result.getRoll());
        liveMap.put("yaw", result.getYaw());
        liveMap.put("bitmap", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), result.getBitmap()));
        liveMap.put("isLive", result.isLive());

        mResult.success(liveMap);
    }
}
