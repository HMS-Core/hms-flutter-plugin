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

package com.huawei.hms.flutter.ml.image;

import android.app.Activity;
import android.graphics.Point;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewCorrectionAnalyzer;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewCorrectionAnalyzerFactory;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewCorrectionAnalyzerSetting;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewCorrectionCoordinateInput;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewCorrectionResult;
import com.huawei.hms.mlsdk.dsc.MLDocumentSkewDetectResult;

import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DocumentSkewCorrectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = DocumentSkewCorrectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLDocumentSkewCorrectionAnalyzer analyzer;
    private MLFrame documentSkewFrame;
    MLDocumentSkewDetectResult detectedDocument;

    public DocumentSkewCorrectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncDocumentSkewDetect":
                asyncDocumentSkewDetect(call);
                break;
            case "asyncDocumentSkewResult":
                asyncDocumentSkewResult();
                break;
            case "syncDocumentSkewDetect":
                syncDocumentSkewDetect(call);
                break;
            case "syncDocumentSkewResult":
                syncDocumentSkewResult();
                break;
            case "stopDocumentSkewCorrection":
                stopDocumentSkewCorrection();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncDocumentSkewDetect(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncDocumentSkewDetect");
        String asyncDetectImagePath = call.argument("path");

        if (asyncDetectImagePath == null || asyncDetectImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentSkewDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        MLDocumentSkewCorrectionAnalyzerSetting setting = new MLDocumentSkewCorrectionAnalyzerSetting.Factory().create();
        analyzer = MLDocumentSkewCorrectionAnalyzerFactory.getInstance().getDocumentSkewCorrectionAnalyzer(setting);

        documentSkewFrame = SettingUtils.createMLFrame(activity, "fromBitmap", asyncDetectImagePath, call);
        FrameHolder.getInstance().setFrame(documentSkewFrame);

        Task<MLDocumentSkewDetectResult> detectTask = analyzer.asyncDocumentSkewDetect(documentSkewFrame);

        detectTask.addOnSuccessListener(detectResult -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentSkewDetect");
            detectedDocument = detectResult;
            sendDetectionResult();
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncDocumentSkewDetect", mResult));
    }

    private void syncDocumentSkewDetect(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncDocumentSkewDetect");
        String syncDetectImagePath = call.argument("path");

        if (syncDetectImagePath == null || syncDetectImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncDocumentSkewDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        MLDocumentSkewCorrectionAnalyzerSetting setting = new MLDocumentSkewCorrectionAnalyzerSetting.Factory().create();
        analyzer = MLDocumentSkewCorrectionAnalyzerFactory.getInstance().getDocumentSkewCorrectionAnalyzer(setting);

        documentSkewFrame = SettingUtils.createMLFrame(activity, "fromBitmap", syncDetectImagePath, call);
        FrameHolder.getInstance().setFrame(documentSkewFrame);

        SparseArray<MLDocumentSkewDetectResult> detectResult = analyzer.analyseFrame(documentSkewFrame);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncDocumentSkewDetect");
        detectedDocument = detectResult.get(0);
        sendDetectionResult();

    }

    private void asyncDocumentSkewResult() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncDocumentSkewResult");

        if (detectedDocument == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentSkewResult", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "No detected document found", MlConstants.NULL_OBJECT);
            return;
        }

        List<Point> coordinates = new ArrayList<>();
        coordinates.add(detectedDocument.getLeftTopPosition());
        coordinates.add(detectedDocument.getRightTopPosition());
        coordinates.add(detectedDocument.getRightBottomPosition());
        coordinates.add(detectedDocument.getLeftBottomPosition());
        getAsyncRefinedResult(coordinates);
    }

    private void syncDocumentSkewResult() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncDocumentSkewResult");
        if (detectedDocument == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncDocumentSkewResult", "Error");
            mResult.error(TAG, "No detected document found", "");
            return;
        }

        List<Point> coordinates = new ArrayList<>();
        coordinates.add(detectedDocument.getLeftTopPosition());
        coordinates.add(detectedDocument.getRightTopPosition());
        coordinates.add(detectedDocument.getRightBottomPosition());
        coordinates.add(detectedDocument.getLeftBottomPosition());
        getSyncRefinedResult(coordinates);
    }

    private void stopDocumentSkewCorrection() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopDocumentSkewCorrection");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentSkewCorrection", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", "");
        } else {
            try {
                analyzer.stop();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentSkewCorrection");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentSkewCorrection", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    private void getAsyncRefinedResult(List<Point> coordinates) {
        MLDocumentSkewCorrectionCoordinateInput coordinateData = new MLDocumentSkewCorrectionCoordinateInput(coordinates);
        Task<MLDocumentSkewCorrectionResult> correctionTask = analyzer.asyncDocumentSkewCorrect(documentSkewFrame, coordinateData);
        correctionTask.addOnSuccessListener(refineResult -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentSkewResult");
            sendCorrectionResult(refineResult);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncDocumentSkewResult", mResult));
    }

    private void getSyncRefinedResult(List<Point> coordinates) {
        MLDocumentSkewCorrectionCoordinateInput coordinateData = new MLDocumentSkewCorrectionCoordinateInput(coordinates);

        SparseArray<MLDocumentSkewCorrectionResult> correct = analyzer.syncDocumentSkewCorrect(documentSkewFrame, coordinateData);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncDocumentSkewResult");
        sendCorrectionResult(correct.get(0));
    }

    private void sendCorrectionResult(@NonNull MLDocumentSkewCorrectionResult refineResult) {
        HashMap<String, Object> corrMap = new HashMap<>();
        corrMap.put("imagePath", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), refineResult.getCorrected()));
        corrMap.put("resultCode", refineResult.getResultCode());
        mResult.success(new JSONObject(corrMap).toString());
    }

    private void sendDetectionResult() {
        Map<String, Object> map = new HashMap<>();
        map.put("leftTop", createDocumentPointJSON(detectedDocument.getLeftTopPosition()));
        map.put("rightTop", createDocumentPointJSON(detectedDocument.getRightTopPosition()));
        map.put("leftBottom", createDocumentPointJSON(detectedDocument.getLeftBottomPosition()));
        map.put("rightBottom", createDocumentPointJSON(detectedDocument.getRightBottomPosition()));
        map.put("resultCode", detectedDocument.getResultCode());
        mResult.success(new JSONObject(map).toString());
    }

    private @NonNull JSONObject createDocumentPointJSON(Point point) {
        Map<String, Object> pointMap = new HashMap<>();
        if (point != null) {
            pointMap.put("x", point.x);
            pointMap.put("y", point.y);
        }
        return new JSONObject(pointMap);
    }
}
