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
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.constant.IAnalyzer;
import com.huawei.hms.flutter.mlbody.data.Commons;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.RequestBuilder;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FaceMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = FaceMethodHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private MLFaceAnalyzer mlFaceAnalyzer;

    public FaceMethodHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "face#analyseFrame":
                aFrame(call);
                break;
            case "face#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            case "face#stop":
                stop();
                break;
            case "face#destroy":
                destroy();
                break;
            case "face#isAvailable":
                isAvailable();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void aFrame(MethodCall methodCall) {
        String facePath = FromMap.toString("path", methodCall.argument("path"), false);

        mlFaceAnalyzer = MLAnalyzerFactory.getInstance()
                .getFaceAnalyzer(RequestBuilder.createFaceAnalyzerSetting(methodCall));

        MLFrame frame = Commons.frameFromBitmap(facePath);
        SparseArray<MLFace> analyseFrame = mlFaceAnalyzer.analyseFrame(frame);

        List<MLFace> arrayList = new ArrayList<>(analyseFrame.size());
        for (int i = 0; i < analyseFrame.size(); i++) {
            arrayList.add(analyseFrame.valueAt(i));
        }

        onSuccess(arrayList);
    }

    @Override
    public void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        mlFaceAnalyzer = MLAnalyzerFactory.getInstance()
                .getFaceAnalyzer(RequestBuilder.createFaceAnalyzerSetting(call));

        MLFrame frame = Commons.frameFromBitmap(path);

        mlFaceAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(this::onSuccess)
                .addOnFailureListener(handler::exception);
    }

    @Override
    public void isAvailable() {
        if (mlFaceAnalyzer == null) {
            handler.noService();
            return;
        }
        handler.success(mlFaceAnalyzer.isAvailable());
    }

    @Override
    public void destroy() {
        if (mlFaceAnalyzer == null) {
            handler.noService();
            return;
        }

        mlFaceAnalyzer.destroy();
        handler.success(true);
    }

    @Override
    public void stop() {
        if (mlFaceAnalyzer == null) {
            handler.noService();
            return;
        }

        try {
            mlFaceAnalyzer.stop();
            handler.success(true);
        } catch (IOException e) {
            handler.exception(e);
        }
    }

    private void onSuccess(List<MLFace> faces) {
        handler.success(ToMap.FaceToMap.createMLFaceJSON(faces));
    }
}
