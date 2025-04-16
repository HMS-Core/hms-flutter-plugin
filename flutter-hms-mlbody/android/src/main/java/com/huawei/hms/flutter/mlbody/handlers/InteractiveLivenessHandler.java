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
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCapture;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCaptureConfig;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCaptureResult;
import com.huawei.hms.mlsdk.interactiveliveness.action.MLInteractiveLivenessConfig;

import java.util.Objects;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InteractiveLivenessHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = InteractiveLivenessHandler.class.getSimpleName();

    private final Activity activity;
    private final BinaryMessenger binaryMessenger;
    private final BodyResponseHandler handler;

    public InteractiveLivenessHandler(Activity activity, BinaryMessenger binaryMessenger) {
        this.activity = activity;
        this.binaryMessenger = binaryMessenger;
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        if (call.method.equals("interactiveLiveness#startDetect")) {
            detect(call);
        } else {
            result.notImplemented();
        }
    }

    private void detect(MethodCall call) {
        final String eventChannelName = FromMap.toString("eventChannelName", call.argument("eventChannelName"), false);
        final EventChannel eventChannel = new EventChannel(binaryMessenger, eventChannelName);
        final EventChannel.EventSink[] eventSinkArray = new EventChannel.EventSink[1];
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                eventSinkArray[0] = events;
            }

            @Override
            public void onCancel(Object arguments) {
                eventSinkArray[0] = null;
            }
        });

        final MLInteractiveLivenessCaptureConfig.Builder builder = new MLInteractiveLivenessCaptureConfig.Builder();
        final MLInteractiveLivenessConfig actionConfig = new MLInteractiveLivenessConfig.Builder().build();
        builder.setActionConfig(actionConfig);
        final Long detectionTimeOut = FromMap.toLong("detectionTimeOut", call.argument("detectionTimeOut"));
        builder.setDetectionTimeOut(Objects.requireNonNull(detectionTimeOut));
        final Boolean detectMask = FromMap.toBoolean("detectMask", call.argument("detectMask"));
        builder.setOptions(detectMask ? 1 : 0);
        final MLInteractiveLivenessCapture capture = MLInteractiveLivenessCapture.getInstance();
        capture.setConfig(builder.build());

        handler.success(true);
        capture.startDetect(activity, new MLInteractiveLivenessCapture.Callback() {
            @Override
            public void onSuccess(MLInteractiveLivenessCaptureResult mlInteractiveLivenessCaptureResult) {
                final EventChannel.EventSink eventSink = eventSinkArray[0];
                if (eventSink != null) {
                    eventSink.success(ToMap.InteractiveLivenessToMap.getResult(mlInteractiveLivenessCaptureResult));
                }
            }

            @Override
            public void onFailure(int i) {
                final EventChannel.EventSink eventSink = eventSinkArray[0];
                if (eventSink != null) {
                    eventSink.error("" + i, null, null);
                }
            }
        });
    }
}
