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
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.RequestBuilder;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzer;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerFactory;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoints;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HandMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = HandMethodHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private MLHandKeypointAnalyzer handAnalyzer;

    public HandMethodHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "hand#analyseFrame":
                aFrame(call);
                break;
            case "hand#destroy":
                destroy();
                break;
            case "hand#isAvailable":
                isAvailable();
                break;
            case "hand#stop":
                stop();
                break;
            case "hand#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void aFrame(MethodCall mCallHand) {
        String handPath = FromMap.toString("path", mCallHand.argument("path"), false);

        handAnalyzer = MLHandKeypointAnalyzerFactory.getInstance()
                .getHandKeypointAnalyzer(RequestBuilder.createHandAnalyzerSetting(mCallHand));

        MLFrame frame = Commons.frameFromBitmap(handPath);

        SparseArray<MLHandKeypoints> mlHandKeypointsSparseArray = handAnalyzer.analyseFrame(frame);
        List<MLHandKeypoints> arrayList = new ArrayList<>(mlHandKeypointsSparseArray.size());
        for (int i = 0; i < mlHandKeypointsSparseArray.size(); i++) {
            arrayList.add(mlHandKeypointsSparseArray.valueAt(i));
        }

        handler.success(ToMap.HandToMap.handsToJSONArray(arrayList));
    }

    @Override
    public void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        handAnalyzer = MLHandKeypointAnalyzerFactory.getInstance()
                .getHandKeypointAnalyzer(RequestBuilder.createHandAnalyzerSetting(call));

        MLFrame frame = Commons.frameFromBitmap(path);

        handAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(hands -> handler.success(ToMap.HandToMap.handsToJSONArray(hands)))
                .addOnFailureListener(handler::exception);
    }

    @Override
    public void isAvailable() {
        if (handAnalyzer == null) {
            handler.noService();
            return;
        }
        handler.success(handAnalyzer.isAvailable());
    }

    @Override
    public void destroy() {
        if (handAnalyzer == null) {
            handler.noService();
            return;
        }

        handAnalyzer.destroy();
        handler.success(true);
    }

    @Override
    public void stop() {
        if (handAnalyzer == null) {
            handler.noService();
            return;
        }
        handAnalyzer.stop();
        handler.success(true);
    }
}
