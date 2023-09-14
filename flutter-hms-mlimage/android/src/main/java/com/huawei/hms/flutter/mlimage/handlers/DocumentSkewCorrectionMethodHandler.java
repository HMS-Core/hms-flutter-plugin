/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.handlers;

import android.app.Activity;
import android.graphics.Point;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
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
    private static final String TAG = DocumentSkewCorrectionMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLDocumentSkewCorrectionAnalyzer analyzer;
    private MLFrame documentSkewFrame;
    private MLDocumentSkewDetectResult detectedDocument;

    public DocumentSkewCorrectionMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.ANALYZE_FRAME:
                analyseFrame(call);
                break;
            case Method.SYNC_DOCUMENT_SKEW_CORRECT:
                syncDocumentSkewCorrect();
                break;
            case Method.ASYNC_DOCUMENT_SKEW_DETECT:
                asyncDocumentSkewDetect(call);
                break;
            case Method.ASYNC_DOCUMENT_SKEW_CORRECT:
                asyncDocumentSkewCorrect();
                break;
            case Method.STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private JSONObject createDocumentPointJSON(Point point) {
        Map<String, Object> pointMap = new HashMap<>();
        if (point != null) {
            pointMap.put("x", point.x);
            pointMap.put("y", point.y);
        }
        return new JSONObject(pointMap);
    }

    private void sendDetectionResult(MLDocumentSkewDetectResult detectResult) {
        detectedDocument = detectResult;
        Map<String, Object> map = new HashMap<>();
        map.put(Param.LEFT_TOP, createDocumentPointJSON(detectedDocument.getLeftTopPosition()));
        map.put(Param.RIGHT_TOP, createDocumentPointJSON(detectedDocument.getRightTopPosition()));
        map.put(Param.LEFT_BOTTOM, createDocumentPointJSON(detectedDocument.getLeftBottomPosition()));
        map.put(Param.RIGHT_BOTTOM, createDocumentPointJSON(detectedDocument.getRightBottomPosition()));
        map.put(Param.RESULT_CODE, detectedDocument.getResultCode());
        responseHandler.success(new JSONObject(map).toString());
    }

    private void getSyncRefinedResult(List<Point> coordinates) {
        MLDocumentSkewCorrectionCoordinateInput coordinateData = new MLDocumentSkewCorrectionCoordinateInput(coordinates);

        SparseArray<MLDocumentSkewCorrectionResult> correct = analyzer.syncDocumentSkewCorrect(documentSkewFrame, coordinateData);
        sendCorrectionResult(correct.get(0));
    }

    private void getAsyncRefinedResult(List<Point> coordinates) {
        MLDocumentSkewCorrectionCoordinateInput coordinateData = new MLDocumentSkewCorrectionCoordinateInput(coordinates);

        analyzer.asyncDocumentSkewCorrect(documentSkewFrame, coordinateData)
                .addOnSuccessListener(this::sendCorrectionResult)
                .addOnFailureListener(responseHandler::exception);
    }

    private void sendCorrectionResult(@NonNull MLDocumentSkewCorrectionResult refineResult) {
        HashMap<String, Object> corrMap = new HashMap<>();
        corrMap.put(Param.BYTES, Commons.bitmapToByteArray(refineResult.getCorrected()));
        corrMap.put(Param.RESULT_CODE, refineResult.getResultCode());
        responseHandler.success(corrMap);
    }

    private void analyseFrame(MethodCall call) {
        String documentSkewImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        MLDocumentSkewCorrectionAnalyzerSetting setting = new MLDocumentSkewCorrectionAnalyzerSetting.Factory().create();
        analyzer = MLDocumentSkewCorrectionAnalyzerFactory.getInstance().getDocumentSkewCorrectionAnalyzer(setting);

        documentSkewFrame = SettingCreator.frameFromBitmap(documentSkewImagePath);
        SparseArray<MLDocumentSkewDetectResult> detectResult = analyzer.analyseFrame(documentSkewFrame);
        sendDetectionResult(detectResult.get(0));
    }

    private void syncDocumentSkewCorrect() {
        if (detectedDocument == null) {
            responseHandler.exception(new Exception("You have to detect skew first!"));
            return;
        }
        List<Point> coordinates = new ArrayList<>();
        coordinates.add(detectedDocument.getLeftTopPosition());
        coordinates.add(detectedDocument.getRightTopPosition());
        coordinates.add(detectedDocument.getRightBottomPosition());
        coordinates.add(detectedDocument.getLeftBottomPosition());
        getSyncRefinedResult(coordinates);
    }

    private void asyncDocumentSkewDetect(MethodCall call) {
        String asyncDetectImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        MLDocumentSkewCorrectionAnalyzerSetting setting = new MLDocumentSkewCorrectionAnalyzerSetting.Factory().create();
        analyzer = MLDocumentSkewCorrectionAnalyzerFactory.getInstance().getDocumentSkewCorrectionAnalyzer(setting);

        documentSkewFrame = SettingCreator.frameFromBitmap(asyncDetectImagePath);

        analyzer.asyncDocumentSkewDetect(documentSkewFrame)
                .addOnSuccessListener(this::sendDetectionResult)
                .addOnFailureListener(responseHandler::exception);
    }

    private void asyncDocumentSkewCorrect() {
        if (detectedDocument == null) {
            responseHandler.exception(new Exception("You have to detect skew first!"));
            return;
        }
        List<Point> coordinates = new ArrayList<>();
        coordinates.add(detectedDocument.getLeftTopPosition());
        coordinates.add(detectedDocument.getRightTopPosition());
        coordinates.add(detectedDocument.getRightBottomPosition());
        coordinates.add(detectedDocument.getLeftBottomPosition());
        getAsyncRefinedResult(coordinates);
    }

    private void stop() {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            analyzer.stop();
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }
}
