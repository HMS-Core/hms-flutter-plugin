/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.modeling3d.modeling3dcapture;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.modeling3dcapturesdk.Modeling3dCaptureImageEngine;
import com.huawei.hms.modeling3dcapturesdk.Modeling3dCaptureImageListener;
import com.huawei.hms.modeling3dcapturesdk.Modeling3dCaptureSetting;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class Modeling3dCaptureImageEngineHandler implements MethodChannel.MethodCallHandler {
    private final Activity activity;
    private final Modeling3dCaptureImageListener captureImageListener;

    public Modeling3dCaptureImageEngineHandler(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.captureImageListener = new Modeling3dCaptureImageListener() {
            @Override
            public void onResult() {
                HMSLogger.getInstance(activity).sendPeriodicEvent("#capture-image");
                new Handler(Looper.getMainLooper()).post(() -> methodChannel.invokeMethod("onResult", null));
            }

            @Override
            public void onProgress(int i) {
                HMSLogger.getInstance(activity).sendPeriodicEvent("#capture-image");
                final Map<String, Object> map = new HashMap<>();
                map.put("progress", i);
                new Handler(Looper.getMainLooper()).post(() -> methodChannel.invokeMethod("onProgress", map));
            }

            @Override
            public void onError(int i, String s) {
                HMSLogger.getInstance(activity).sendPeriodicEvent("#capture-image", String.valueOf(i));
                final Map<String, Object> map = new HashMap<>();
                map.put("errorCode", i);
                map.put("message", s);
                new Handler(Looper.getMainLooper()).post(() -> methodChannel.invokeMethod("onError", map));
            }
        };
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer("#capture-image-" + call.method);
        switch (call.method) {
            case "captureImage":
                captureImage(call, result);
                HMSLogger.getInstance(activity).sendSingleEvent("#capture-image-" + call.method);
                break;
            case "setCaptureConfig":
                setCaptureConfig(call, result);
                HMSLogger.getInstance(activity).sendSingleEvent("#capture-image-" + call.method);
                break;
            default:
                result.notImplemented();
        }
    }

    private void captureImage(MethodCall call, MethodChannel.Result result) {
        final String fileSavePath = Objects.requireNonNull(call.argument("fileSavePath"));

        Modeling3dCaptureImageEngine.getInstance().captureImage(fileSavePath, activity, captureImageListener);
        result.success(true);
    }

    private void setCaptureConfig(MethodCall call, MethodChannel.Result result) {
        final int azimuthNum = Objects.requireNonNull(call.argument("azimuthNum"));
        final int latitudeNum = Objects.requireNonNull(call.argument("latitudeNum"));
        final double radius = Objects.requireNonNull(call.argument("radius"));

        final Modeling3dCaptureSetting setting = new Modeling3dCaptureSetting.Factory()
                .setAzimuthNum(azimuthNum)
                .setLatitudeNum(latitudeNum)
                .setRadius(radius)
                .create();

        Modeling3dCaptureImageEngine.getInstance().setCaptureConfig(setting);
        result.success(true);
    }
}
