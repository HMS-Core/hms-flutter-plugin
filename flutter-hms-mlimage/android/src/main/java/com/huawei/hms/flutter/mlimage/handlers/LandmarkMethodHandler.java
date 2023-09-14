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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLCoordinate;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmark;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LandmarkMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = LandmarkMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLRemoteLandmarkAnalyzer mlRemoteLandmarkAnalyzer;

    public LandmarkMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.ASYNC_ANALYZE_FRAME:
                asyncAnalyzeFrame(call);
                break;
            case Method.STOP:
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private ArrayList<Map<String, Object>> landmarkToJSONArray(List<MLRemoteLandmark> list) {
        ArrayList<Map<String, Object>> landmarkList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLRemoteLandmark landmark = list.get(i);
            map.put(Param.BORDER, Commons.createBorderMap(landmark.getBorder()));
            map.put(Param.POSSIBILITY, landmark.getPossibility());
            map.put(Param.LANDMARK, landmark.getLandmark());
            map.put(Param.LANDMARK_IDENTITY, landmark.getLandmarkIdentity());
            map.put(Param.POSITION_INFOS, coordinatesToJSONArray(landmark.getPositionInfos()));
            landmarkList.add(map);
        }
        return landmarkList;

    }

    private ArrayList<Map<String, Object>> coordinatesToJSONArray(List<MLCoordinate> list) {
        ArrayList<Map<String, Object>> coordinateList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLCoordinate coordinate = list.get(i);
            map.put("lat", coordinate.getLat());
            map.put("lng", coordinate.getLng());
            coordinateList.add(map);
        }
        return coordinateList;
    }

    private void asyncAnalyzeFrame(@NonNull MethodCall call) {
        String landmarkImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);
        mlRemoteLandmarkAnalyzer = MLAnalyzerFactory.getInstance().getRemoteLandmarkAnalyzer(SettingCreator.createLandmarkAnalyzerSetting(call));

        MLFrame landmarkFrame = SettingCreator.frameFromBitmap(landmarkImagePath);

        mlRemoteLandmarkAnalyzer.asyncAnalyseFrame(landmarkFrame)
                .addOnSuccessListener(mlObjects -> responseHandler.success(landmarkToJSONArray(mlObjects)))
                .addOnFailureListener(responseHandler::exception);
    }

    private void stopAnalyzer() {
        if (mlRemoteLandmarkAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            this.mlRemoteLandmarkAnalyzer.close();
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }
}
