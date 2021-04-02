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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLCoordinate;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmark;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzer;

import org.json.JSONArray;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LandMarkAnalyzeMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = LandMarkAnalyzeMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLRemoteLandmarkAnalyzer analyzer;

    public LandMarkAnalyzeMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeLandmark":
                analyzeLandmark(call);
                break;
            case "stopLandmarkAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private @NonNull JSONArray landmarkToJSONArray(@NonNull List<MLRemoteLandmark> list) {
        ArrayList<Map<String, Object>> landmarkList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLRemoteLandmark landmark = list.get(i);
            map.put("landmark", landmark.getLandmark());
            map.put("border", FaceToJson.createBorderJSON(landmark.getBorder()));
            map.put("landmarkIdentity", landmark.getLandmarkIdentity());
            map.put("possibility", landmark.getPossibility());
            map.put("positionInfos", coordinatesToJSONArray(landmark.getPositionInfos()));
            landmarkList.add(map);
        }
        return new JSONArray(landmarkList);
    }

    private @NonNull JSONArray coordinatesToJSONArray(@NonNull List<MLCoordinate> list) {
        ArrayList<Map<String, Object>> coordinateList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLCoordinate coordinate = list.get(i);
            map.put("lat", coordinate.getLat());
            map.put("lng", coordinate.getLng());
            coordinateList.add(map);
        }
        return new JSONArray(coordinateList);
    }

    private void analyzeLandmark(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeLandmark");
        String landmarkImagePath = call.argument("path");
        String frameType = call.argument("frameType");

        if (landmarkImagePath == null || landmarkImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeLandmark", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLAnalyzerFactory.getInstance().getRemoteLandmarkAnalyzer(SettingUtils.createLandmarkAnalyzerSetting(call));
        MLFrame landmarkFrame = SettingUtils.createMLFrame(
                activity,
                frameType != null ? frameType : "fromBitmap",
                landmarkImagePath,
                call);
        FrameHolder.getInstance().setFrame(landmarkFrame);
        Task<List<MLRemoteLandmark>> landmarkTask = analyzer.asyncAnalyseFrame(landmarkFrame);
        landmarkTask.addOnSuccessListener(list -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncLandmarkRecognition");
            mResult.success(landmarkToJSONArray(list).toString());
        }).addOnFailureListener(analyzeError -> HmsMlUtils.handleException(activity, TAG, analyzeError, "asyncLandmarkRecognition", mResult));
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopLandmarkAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopLandmarkAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized.", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                this.analyzer.close();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopLandmarkAnalyzer");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopLandmarkAnalyzer", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}