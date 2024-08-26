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
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.skeleton.MLJoint;
import com.huawei.hms.mlsdk.skeleton.MLSkeleton;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzer;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzerFactory;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SkeletonHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = SkeletonHandler.class.getSimpleName();

    private final BodyResponseHandler handler;

    private MLSkeletonAnalyzer skeletonAnalyzer;

    public SkeletonHandler(final Activity activity) {
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "skeleton#analyseFrame":
                aFrame(call);
                break;
            case "skeleton#asyncAnalyseFrame":
                asyncAFrame(call);
                break;
            case "skeleton#destroy":
                destroy();
                break;
            case "skeleton#isAvailable":
                isAvailable();
                break;
            case "skeleton#stop":
                stop();
                break;
            case "skeleton#similarity":
                try {
                    similarity(call);
                } catch (JSONException e) {
                    handler.exception(e);
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void aFrame(MethodCall skeletonCall) {
        String skeletonPath = FromMap.toString("path", skeletonCall.argument("path"), false);

        skeletonAnalyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();

        MLFrame skeletonFrame = Commons.frameFromBitmap(skeletonPath);

        SparseArray<MLSkeleton> sparseArray = skeletonAnalyzer.analyseFrame(skeletonFrame);

        List<MLSkeleton> arrayList = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            arrayList.add(sparseArray.valueAt(i));
        }

        handler.success(ToMap.SkeletonToMap.skeletonToJSONArray(arrayList));
    }

    @Override
    public void asyncAFrame(MethodCall call) {
        String path = FromMap.toString("path", call.argument("path"), false);

        skeletonAnalyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();

        MLFrame skeletonFrame = Commons.frameFromBitmap(path);

        skeletonAnalyzer.asyncAnalyseFrame(skeletonFrame)
                .addOnSuccessListener(res -> handler.success(ToMap.SkeletonToMap.skeletonToJSONArray(res)))
                .addOnFailureListener(handler::exception);
    }

    private void similarity(MethodCall call) throws JSONException {
        skeletonAnalyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();

        String json1 = call.argument("list1");
        String json2 = call.argument("list2");

        JSONArray jsonArray1 = new JSONArray(json1);
        List<MLSkeleton> skeletons1 = new ArrayList<>();
        List<MLJoint> joints1 = new ArrayList<>();

        for (int i = 0; i < jsonArray1.length(); i++) {
            JSONObject skeletonObject = jsonArray1.getJSONObject(i);
            JSONArray jointArray = skeletonObject.getJSONArray("joints");
            for (int j = 0; j < jointArray.length(); j++) {
                JSONObject jointObject = jointArray.getJSONObject(j);
                MLJoint mlJoint = new MLJoint(
                        (float) jointObject.getDouble("pointX"),
                        (float) jointObject.getDouble("pointY"),
                        jointObject.getInt("type"),
                        (float) jointObject.getDouble("score"));
                joints1.add(mlJoint);
            }
            MLSkeleton mlSkeleton = new MLSkeleton(joints1);
            skeletons1.add(mlSkeleton);
        }

        JSONArray jsonArray2 = new JSONArray(json2);
        List<MLSkeleton> skeletons2 = new ArrayList<>();
        List<MLJoint> joints2 = new ArrayList<>();

        for (int i = 0; i < jsonArray2.length(); i++) {
            JSONObject skeletonObject = jsonArray2.getJSONObject(i);
            JSONArray jointArray = skeletonObject.getJSONArray("joints");
            for (int j = 0; j < jointArray.length(); j++) {
                JSONObject jointObject = jointArray.getJSONObject(j);
                MLJoint mlJoint = new MLJoint(
                        (float) jointObject.getDouble("pointX"),
                        (float) jointObject.getDouble("pointY"),
                        jointObject.getInt("type"),
                        (float) jointObject.getDouble("score"));
                joints2.add(mlJoint);
            }
            MLSkeleton mlSkeleton = new MLSkeleton(joints2);
            skeletons2.add(mlSkeleton);
        }

        handler.success(skeletonAnalyzer.caluteSimilarity(skeletons1, skeletons2));
    }

    @Override
    public void isAvailable() {
        if (skeletonAnalyzer == null) {
            handler.noService();
            return;
        }
        handler.success(skeletonAnalyzer.isAvailable());
    }

    @Override
    public void destroy() {
        if (skeletonAnalyzer == null) {
            handler.noService();
            return;
        }

        skeletonAnalyzer.destroy();
        handler.success(true);
    }

    @Override
    public void stop() {
        if (skeletonAnalyzer == null) {
            handler.noService();
            return;
        }

        try {
            skeletonAnalyzer.stop();
            handler.success(true);
        } catch (IOException e) {
            handler.exception(e);
        }
    }
}
