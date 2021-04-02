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
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.tojson.HandToJson;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzer;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerFactory;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoints;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HandKeypointDetectionMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = HandKeypointDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLHandKeypointAnalyzer analyzer;

    public HandKeypointDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncHandKeyPointAnalyze":
                asyncAnalyzeFrame(call);
                break;
            case "syncHandKeyPointAnalyze":
                analyzeFrame(call);
                break;
            case "stopHandKeyPointAnalyzer":
                stopAnalyzer();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncAnalyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncHandKeypointAnalyze");
        String asyncHandDetectionImagePath = call.argument("path");
        String asyncHandDetectionFrameType = call.argument("frameType");


        if (asyncHandDetectionImagePath == null || asyncHandDetectionImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncHandKeypointAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLHandKeypointAnalyzerFactory.getInstance().getHandKeypointAnalyzer(SettingUtils.createHandAnalyzerSetting(call));

        MLFrame asyncHandKeyPointFrame = SettingUtils.createMLFrame(
                activity,
                asyncHandDetectionFrameType != null ? asyncHandDetectionFrameType : "fromBitmap",
                asyncHandDetectionImagePath,
                call);
        FrameHolder.getInstance().setFrame(asyncHandKeyPointFrame);
        Task<List<MLHandKeypoints>> asyncHandTask = analyzer.asyncAnalyseFrame(asyncHandKeyPointFrame);

        asyncHandTask.addOnSuccessListener(results -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncHandKeypointAnalyze");
            mResult.success(HandToJson.handsToJSONArray(results).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncHandKeypointAnalyze", mResult));
    }

    private void analyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncHandKeypointAnalyze");
        String syncHandDetectionImagePath = call.argument("path");
        String syncHandDetectionFrameType = call.argument("frameType");

        if (syncHandDetectionImagePath == null || syncHandDetectionImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncHandKeypointAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLHandKeypointAnalyzerFactory.getInstance().getHandKeypointAnalyzer(SettingUtils.createHandAnalyzerSetting(call));

        MLFrame syncHandKeyPointFrame = SettingUtils.createMLFrame(
                activity,
                syncHandDetectionFrameType != null ? syncHandDetectionFrameType : "fromBitmap",
                syncHandDetectionImagePath,
                call);
        FrameHolder.getInstance().setFrame(syncHandKeyPointFrame);
        SparseArray<MLHandKeypoints> mlHandKeypointsSparseArray = analyzer.analyseFrame(syncHandKeyPointFrame);
        List<MLHandKeypoints> arrayList = new ArrayList<>(mlHandKeypointsSparseArray.size());
        for (int i = 0; i < mlHandKeypointsSparseArray.size(); i++) {
            arrayList.add(mlHandKeypointsSparseArray.valueAt(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncHandKeypointAnalyze");
        mResult.success(HandToJson.handsToJSONArray(arrayList).toString());
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopHandKeypointAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopHandKeypointAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        analyzer.stop();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopHandKeypointAnalyzer");
        mResult.success(true);
    }

    @Override
    public void onListen(Object h, EventChannel.EventSink j) {
        EventHandler.getInstance().setEventSink(j);
    }

    @Override
    public void onCancel(Object k) {
        EventHandler.getInstance().setEventSink(null);
    }
}
