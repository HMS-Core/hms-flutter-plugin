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
import com.huawei.hms.flutter.mlbody.data.RequestBuilder;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.flutter.mlbody.data.Commons;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.face.face3d.ML3DFace;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzer;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class Face3dMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = Face3dMethodHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private ML3DFaceAnalyzer faceAnalyzer;

    public Face3dMethodHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "face3d#analyseFrame":
                aFrame(call);
                break;
            case "face3d#destroy":
                destroy();
                break;
            case "face3d#stop":
                stop();
                break;
            case "face3d#isAvailable":
                isAvailable();
                break;
            case "face3d#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void aFrame(MethodCall mCall) {
        String framePath = FromMap.toString("path", mCall.argument("path"), false);

        faceAnalyzer = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer(RequestBuilder.create3DAnalyzeSetting(mCall));

        MLFrame frame = Commons.frameFromBitmap(framePath);

        SparseArray<ML3DFace> faceSparseArray = faceAnalyzer.analyseFrame(frame);
        List<ML3DFace> arrayList = new ArrayList<>(faceSparseArray.size());
        for (int i = 0; i < faceSparseArray.size(); i++) {
            arrayList.add(faceSparseArray.valueAt(i));
        }
        onSuccess(arrayList);
    }

    @Override
    public void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        faceAnalyzer = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer(RequestBuilder.create3DAnalyzeSetting(call));

        MLFrame frame = Commons.frameFromBitmap(path);

        faceAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(this::onSuccess)
                .addOnFailureListener(handler::exception);
    }

    @Override
    public void isAvailable() {
        if (faceAnalyzer == null) {
            handler.noService();
            return;
        }
        handler.success(faceAnalyzer.isAvailable());
    }

    @Override
    public void destroy() {
        if (faceAnalyzer == null) {
            handler.noService();
            return;
        }

        faceAnalyzer.destroy();
        handler.success(true);
    }

    @Override
    public void stop() {
        if (faceAnalyzer == null) {
            handler.noService();
            return;
        }

        try {
            faceAnalyzer.stop();
            handler.success(true);
        } catch (IOException e) {
            handler.exception(e);
        }
    }

    private void onSuccess(List<ML3DFace> faces) {
        handler.success(ToMap.FaceToMap.face3DToJSONArray(faces));
    }
}
