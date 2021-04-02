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
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.flutter.ml.utils.tojson.SkeletonToJson;
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

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SkeletonDetectionMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = SkeletonDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MLSkeletonAnalyzer analyzer;
    private MethodChannel.Result mResult;

    public SkeletonDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncSkeletonAnalyze":
                asyncAnalyzeFrame(call);
                break;
            case "syncSkeletonAnalyze":
                analyzeFrame(call);
                break;
            case "calculateSkeletonSimilarity":
                try {
                    HMSLogger.getInstance(activity).startMethodExecutionTimer("calculateSimilarity");
                    calculateSimilarity(call);
                } catch (JSONException e) {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("calculateSimilarity", e.getMessage());
                    mResult.error(TAG, e.getMessage(), "");
                }
                break;
            case "stopSkeletonDetection":
                stopDetection();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncAnalyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncSkeletonAnalyze");
        String imagePath = call.argument("path");
        String skeletonFrame = call.argument("frameType");


        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSkeletonAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer(SettingUtils.createSkeletonAnalyzerSetting(call));
        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                skeletonFrame != null ? skeletonFrame : "fromBitmap",
                imagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);
        Task<List<MLSkeleton>> asyncSkeletonTask = analyzer.asyncAnalyseFrame(frame);
        asyncSkeletonTask.addOnSuccessListener(results -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSkeletonAnalyze");
            mResult.success(SkeletonToJson.skeletonToJSONArray(results).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncSkeletonAnalyze", mResult));
    }

    private void analyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncSkeletonAnalyze");
        String analyzeFrameImagePath = call.argument("path");
        String analyzeFrameFrameType = call.argument("frameType");

        if (analyzeFrameImagePath == null || analyzeFrameImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncSkeletonAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();

        MLFrame skeletonFrame = SettingUtils.createMLFrame(
                activity,
                analyzeFrameFrameType != null ? analyzeFrameFrameType : "fromBitmap",
                analyzeFrameImagePath,
                call);
        FrameHolder.getInstance().setFrame(skeletonFrame);

        SparseArray<MLSkeleton> sparseArray = analyzer.analyseFrame(skeletonFrame);

        List<MLSkeleton> arrayList = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            arrayList.add(sparseArray.valueAt(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncSkeletonAnalyze");
        mResult.success(SkeletonToJson.skeletonToJSONArray(arrayList).toString());
    }

    private void calculateSimilarity(@NonNull MethodCall call) throws JSONException {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("calculateSimilarity");
        analyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();
        String json1 = call.argument("list1");
        String json2 = call.argument("list2");
        if (json1 == null || json2 == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("calculateSimilarity", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Lists are empty", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
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
                        (float) jointObject.getDouble("score")
                );
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
                        (float) jointObject.getDouble("score")
                );
                joints2.add(mlJoint);
            }
            MLSkeleton mlSkeleton = new MLSkeleton(joints2);
            skeletons2.add(mlSkeleton);
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("calculateSimilarity");
        mResult.success(analyzer.caluteSimilarity(skeletons1, skeletons2));
    }

    @Override
    public void onListen(Object mArguments, EventChannel.EventSink mEvents) {
        EventHandler.getInstance().setEventSink(mEvents);
    }

    @Override
    public void onCancel(Object arguments3) {
        EventHandler.getInstance().setEventSink(null);
    }

    private void stopDetection() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopSkeletonDetection");
        try {
            if (analyzer == null) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSkeletonDetection", MlConstants.UNINITIALIZED_ANALYZER);
                mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            } else {
                analyzer.stop();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSkeletonDetection");
                mResult.success(true);
            }
        } catch (IOException w) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSkeletonDetection", w.getMessage());
            mResult.error(TAG, w.getMessage(), "");
        }
    }
}
