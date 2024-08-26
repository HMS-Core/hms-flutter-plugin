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

import com.huawei.hms.flutter.mlbody.data.Commons;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.faceverify.MLFaceTemplateResult;
import com.huawei.hms.mlsdk.faceverify.MLFaceVerificationAnalyzer;
import com.huawei.hms.mlsdk.faceverify.MLFaceVerificationAnalyzerFactory;
import com.huawei.hms.mlsdk.faceverify.MLFaceVerificationAnalyzerSetting;
import com.huawei.hms.mlsdk.faceverify.MLFaceVerificationResult;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class VerificationHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = VerificationHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private MLFaceVerificationAnalyzer verificationAnalyzer;

    public VerificationHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "faceVer#setTemplateFace":
                setTemplateFace(call);
                break;
            case "faceVer#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            case "faceVer#analyseFrame":
                aFrame(call);
                break;
            case "faceVer#stop":
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void setTemplateFace(@NonNull MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);
        Integer maxFaceNum = FromMap.toInteger("maxFaceNum", call.argument("maxFaceNum"));

        if (maxFaceNum == null) {
            maxFaceNum = 1;
        }

        MLFaceVerificationAnalyzerSetting setting = new MLFaceVerificationAnalyzerSetting.Factory()
                .setMaxFaceDetected(maxFaceNum).create();
        verificationAnalyzer = MLFaceVerificationAnalyzerFactory.getInstance().getFaceVerificationAnalyzer(setting);

        MLFrame frame = Commons.frameFromBitmap(path);
        List<MLFaceTemplateResult> results = verificationAnalyzer.setTemplateFace(frame);

        handler.success(ToMap.VerificationToMap.templateSuccess(results));
    }

    private void aFrame(MethodCall call) {
        String path0 = FromMap.toString("path", call.argument("path"), false);

        MLFrame frame0 = Commons.frameFromBitmap(path0);

        SparseArray<MLFaceVerificationResult> results = verificationAnalyzer.analyseFrame(frame0);
        List<MLFaceVerificationResult> arrayList = new ArrayList<>(results.size());
        for (int i = 0; i < results.size(); i++) {
            arrayList.add(results.valueAt(i));
        }

        handler.success(ToMap.VerificationToMap.verifySuccess(arrayList));
    }

    private void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        MLFrame frame = Commons.frameFromBitmap(path);

        verificationAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(res -> handler.success(ToMap.VerificationToMap.verifySuccess(res)))
                .addOnFailureListener(handler::exception);
    }

    private void stop() {
        if (verificationAnalyzer == null) {
            handler.noService();
            return;
        }
        verificationAnalyzer.stop();
        handler.success(true);
    }
}
