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
import android.graphics.Bitmap;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.constant.IAnalyzer;
import com.huawei.hms.flutter.mlbody.data.Commons;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.gesture.MLGesture;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzer;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzerFactory;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzerSetting;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GestureHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = GestureHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private MLGestureAnalyzer gestureAnalyzer;

    public GestureHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "gesture#stop":
                stop();
                break;
            case "gesture#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            case "gesture#destroy":
                destroy();
                break;
            case "gesture#isAvailable":
                isAvailable();
                break;
            case "gesture#analyseFrame":
                aFrame(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void aFrame(MethodCall mCall1) {
        String gesturePath = FromMap.toString("path", mCall1.argument("path"), false);

        MLGestureAnalyzerSetting setting = new MLGestureAnalyzerSetting.Factory().create();
        gestureAnalyzer = MLGestureAnalyzerFactory.getInstance().getGestureAnalyzer(setting);

        MLFrame frame = Commons.frameFromBitmap(gesturePath);

        SparseArray<MLGesture> mlGestureSparseArray = gestureAnalyzer.analyseFrame(frame);
        List<MLGesture> arrayList = new ArrayList<>(mlGestureSparseArray.size());

        for (int i = 0; i < mlGestureSparseArray.size(); i++) {
            arrayList.add(mlGestureSparseArray.valueAt(i));
        }

        handler.success(ToMap.GestureToMap.onGestureAnalyzeSuccess(arrayList));
    }

    @Override
    public void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        MLGestureAnalyzerSetting setting = new MLGestureAnalyzerSetting.Factory().create();
        gestureAnalyzer = MLGestureAnalyzerFactory.getInstance().getGestureAnalyzer(setting);

        Bitmap bt = Commons.bitmapFromPath(path);
        MLFrame frame = new MLFrame.Creator().setBitmap(bt).create();

        gestureAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(list -> handler.success(ToMap.GestureToMap.onGestureAnalyzeSuccess(list)))
                .addOnFailureListener(handler::exception);
    }

    @Override
    public void isAvailable() {
        if (gestureAnalyzer == null) {
            handler.noService();
            return;
        }
        handler.success(gestureAnalyzer.isAvailable());
    }

    @Override
    public void destroy() {
        if (gestureAnalyzer == null) {
            handler.noService();
            return;
        }

        gestureAnalyzer.destroy();
        handler.success(true);
    }

    @Override
    public void stop() {
        if (gestureAnalyzer == null) {
            handler.noService();
            return;
        }

        gestureAnalyzer.stop();
        handler.success(true);
    }
}
