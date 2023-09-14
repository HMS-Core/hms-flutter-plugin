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
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.scd.MLSceneDetection;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SceneDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = SceneDetectionMethodHandler.class.getSimpleName();

    private final MLResponseHandler rsHandler;

    private MLSceneDetectionAnalyzer analyzer;

    public SceneDetectionMethodHandler(Activity activity) {
        this.rsHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call1, @NonNull MethodChannel.Result result) {
        rsHandler.setup(TAG, call1.method, result);
        switch (call1.method) {
            case Method.ASYNC_ANALYZE_FRAME:
                asyncAnalyzeFrame(call1);
                break;
            case Method.ANALYZE_FRAME:
                analyzeFrame(call1);
                break;
            case Method.STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public static ArrayList<Map<String, Object>> sceneListToJSON(List<MLSceneDetection> mlSceneDetections) {
        ArrayList<Map<String, Object>> sceneList = new ArrayList<>();
        for (int i = 0; i < mlSceneDetections.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLSceneDetection detection = mlSceneDetections.get(i);
            map.put(Param.RESULT, detection.getResult());
            map.put(Param.CONFIDENCE, detection.getConfidence());
            sceneList.add(map);
        }
        return sceneList;
    }

    private void sparseSceneToJSON(SparseArray<MLSceneDetection> detections) {
        List<MLSceneDetection> list = new ArrayList<>(detections.size());
        for (int i = 0; i < detections.size(); i++) {
            list.add(detections.get(i));
        }
        rsHandler.success(sceneListToJSON(list));
    }

    private void analyzeFrame(MethodCall call) {
        String sceneImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        analyzer = MLSceneDetectionAnalyzerFactory.getInstance()
                .getSceneDetectionAnalyzer(SettingCreator.createSceneDetectionSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(sceneImagePath);

        SparseArray<MLSceneDetection> results = analyzer.analyseFrame(frame);
        sparseSceneToJSON(results);
    }

    private void asyncAnalyzeFrame(MethodCall call) {
        String sceneImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        analyzer = MLSceneDetectionAnalyzerFactory.getInstance()
                .getSceneDetectionAnalyzer(SettingCreator.createSceneDetectionSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(sceneImagePath);

        analyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(scenes -> rsHandler.success(sceneListToJSON(scenes)))
                .addOnFailureListener(rsHandler::exception);
    }

    private void stop() {
        if (analyzer == null) {
            rsHandler.noService();
            return;
        }
        analyzer.stop();
        analyzer = null;
        rsHandler.success(true);
    }
}
