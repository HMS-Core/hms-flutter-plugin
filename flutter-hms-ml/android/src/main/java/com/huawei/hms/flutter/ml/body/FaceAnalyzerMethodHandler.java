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

import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FaceAnalyzerMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = FaceAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLFaceAnalyzer analyzer;

    public FaceAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncFaceAnalyze":
                performAsyncAnalyze(call);
                break;
            case "syncFaceAnalyze":
                performSyncAnalyze(call);
                break;
            case "isFaceAnalyzerAvailable":
                isAnalyzerAvailable();
                break;
            case "stopFaceAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void performSyncAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncFaceAnalyze");
        String sparseAnalyzeImagePath = call.argument("path");
        String frameType = call.argument("frameType");

        if (sparseAnalyzeImagePath == null || sparseAnalyzeImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncFaceAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        this.analyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer(SettingUtils.createFaceAnalyzerSetting(call));

        MLFrame sparseFrame = SettingUtils.createMLFrame(
                activity,
                frameType != null ? frameType : "fromBitmap",
                sparseAnalyzeImagePath,
                call);
        FrameHolder.getInstance().setFrame(sparseFrame);

        SparseArray<MLFace> analyseFrame = analyzer.analyseFrame(sparseFrame);

        List<MLFace> arrayList = new ArrayList<>(analyseFrame.size());
        for (int i = 0; i < analyseFrame.size(); i++) {
            arrayList.add(analyseFrame.valueAt(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncFaceAnalyze");
        mResult.success(FaceToJson.createMLFaceJSON(arrayList).toString());
    }

    private void performAsyncAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncFaceAnalyze");
        String faceAnalyzeImagePath = call.argument("path");
        String frameType = call.argument("frameType");

        if (faceAnalyzeImagePath == null || faceAnalyzeImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncFaceAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        this.analyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer(SettingUtils.createFaceAnalyzerSetting(call));

        MLFrame fr = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", faceAnalyzeImagePath, call);
        FrameHolder.getInstance().setFrame(fr);

        Task<List<MLFace>> faceTask = analyzer.asyncAnalyseFrame(fr);

        faceTask.addOnSuccessListener(mlFaces -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncFaceAnalyze");
            mResult.success(FaceToJson.createMLFaceJSON(mlFaces).toString());
        }).addOnFailureListener(faceAnalyzeError -> HmsMlUtils.handleException(activity, TAG, faceAnalyzeError, "asyncFaceAnalyze", mResult));
    }

    private void isAnalyzerAvailable() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getFaceAnalyzerInfo");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getFaceAnalyzerInfo", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getFaceAnalyzerInfo");
        mResult.success(analyzer.isAvailable());
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopFaceAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopFaceAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        try {
            analyzer.stop();
            analyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopFaceAnalyzer");
            mResult.success(true);
        } catch (IOException er) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopFaceAnalyzer", er.getMessage());
            mResult.error(TAG, er.getMessage(), "");
        }
    }

    @Override
    public void onListen(Object arguments2, EventChannel.EventSink events2) {
        EventHandler.getInstance().setEventSink(events2);
    }

    @Override
    public void onCancel(Object arguments2) {
        EventHandler.getInstance().setEventSink(null);
    }
}