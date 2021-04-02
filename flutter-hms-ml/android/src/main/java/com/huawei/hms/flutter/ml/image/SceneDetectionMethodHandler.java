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
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.scd.MLSceneDetection;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerFactory;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SceneDetectionMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private final static String TAG = SceneDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    MLSceneDetectionAnalyzer analyzer;

    public SceneDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncSceneDetection":
                asyncSceneDetection(call);
                break;
            case "analyzeFrameSceneDetection":
                syncSceneDetection(call);
                break;
            case "stopSceneDetection":
                stopSceneDetection();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncSceneDetection(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncSceneDetection");
        String imagePath = call.argument("path");
        String sceneFrame = call.argument("frameType");


        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSceneDetection", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLSceneDetectionAnalyzerFactory
                .getInstance()
                .getSceneDetectionAnalyzer(
                        SettingUtils.createSceneDetectionSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                sceneFrame != null ? sceneFrame : "fromBitmap",
                imagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);

        Task<List<MLSceneDetection>> task = analyzer.asyncAnalyseFrame(frame);
        task.addOnSuccessListener(mlSceneDetections -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSceneDetection");
            mResult.success(sceneListToJSON(mlSceneDetections).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncSceneDetection", mResult));

    }

    private void syncSceneDetection(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeFrameSceneDetection");
        String imagePath = call.argument("path");
        String syncFrame = call.argument("frameType");

        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeFrameSceneDetection", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLSceneDetectionAnalyzerFactory
                .getInstance()
                .getSceneDetectionAnalyzer(
                        SettingUtils.createSceneDetectionSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                syncFrame != null ? syncFrame : "fromBitmap",
                imagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);

        SparseArray<MLSceneDetection> results = analyzer.analyseFrame(frame);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeFrameSceneDetection");
        mResult.success(sparseSceneToJSON(results).toString());
    }

    private void stopSceneDetection() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopSceneDetection");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSceneDetection", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            analyzer.stop();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSceneDetection");
            mResult.success(true);
        }
    }

    public static JSONObject sceneJSON(MLSceneDetection sceneDetection) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", sceneDetection.getResult());
        map.put("confidence", sceneDetection.getConfidence());
        return new JSONObject(map);
    }

    private JSONArray sceneListToJSON(List<MLSceneDetection> mlSceneDetections) {
        ArrayList<Map<String, Object>> sceneList = new ArrayList<>();
        for (int i = 0; i < mlSceneDetections.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLSceneDetection detection = mlSceneDetections.get(i);
            map.put("result", detection.getResult());
            map.put("confidence", detection.getConfidence());
            sceneList.add(map);
        }
        return new JSONArray(sceneList);
    }

    private JSONArray sparseSceneToJSON(SparseArray<MLSceneDetection> detections) {
        List<MLSceneDetection> list = new ArrayList<>(detections.size());
        for (int i = 0; i < detections.size(); i++) {
            list.add(detections.get(i));
        }
        return sceneListToJSON(list);
    }

    @Override
    public void onListen(Object b, EventChannel.EventSink c) {
        EventHandler.getInstance().setEventSink(c);
    }

    @Override
    public void onCancel(Object a) {
        EventHandler.getInstance().setEventSink(null);
    }
}
