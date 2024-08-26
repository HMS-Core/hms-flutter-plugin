/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mlbody.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCapture;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCaptureConfig;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCaptureResult;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LivenessHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = LivenessHandler.class.getSimpleName();

    private final Activity activity;
    private final BodyResponseHandler handler;

    public LivenessHandler(Activity activity) {
        this.activity = activity;
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        if (call.method.equals("liveness#startDetect")) {
            detect(call);
        } else {
            result.notImplemented();
        }
    }

    private void detect(MethodCall call) {
        final Boolean detectMask = FromMap.toBoolean("detectMask", call.argument("detectMask"));

        final MLLivenessCaptureConfig.Builder builder = new MLLivenessCaptureConfig.Builder();
        builder.setOptions(detectMask ? 1 : 0);

        final MLLivenessCapture capture = MLLivenessCapture.getInstance();
        capture.setConfig(builder.build());
        capture.startDetect(activity, callback);
    }

    private final MLLivenessCapture.Callback callback = new MLLivenessCapture.Callback() {
        @Override
        public void onSuccess(MLLivenessCaptureResult mlLivenessCaptureResult) {
            handler.success(ToMap.LivenessToMap.getResult(mlLivenessCaptureResult));
        }

        @Override
        public void onFailure(int i) {
            handler.callbackError(i, null);
        }
    };
}
