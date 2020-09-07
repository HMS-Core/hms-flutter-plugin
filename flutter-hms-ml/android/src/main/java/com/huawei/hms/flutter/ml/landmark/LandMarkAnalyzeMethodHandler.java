/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.ml.landmark;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlTextUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLCoordinate;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmark;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzer;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzerSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

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
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        switch (call.method) {
            case "defaultLandmarkAnalyze":
                defaultLandmarkAnalyze(call);
                break;
            case "analyzeLandmark":
                analyzeLandmark(call);
                break;
            case "stopAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void defaultLandmarkAnalyze(MethodCall call) {
        if (call.argument("path") == null) {
            mResult.error(TAG, "Image path must not be null!", "");
        } else {
            String imagePath = call.argument("path");
            analyzer = MLAnalyzerFactory.getInstance().getRemoteLandmarkAnalyzer();
            final String landmarkEncodedImage = ImagePathHelper.pathToBase64(imagePath);
            MLFrame frame = HmsMlUtils.getFrame(landmarkEncodedImage);
            Task<List<MLRemoteLandmark>> task = analyzer.asyncAnalyseFrame(frame);
            task.addOnSuccessListener(new OnSuccessListener<List<MLRemoteLandmark>>() {
                @Override
                public void onSuccess(List<MLRemoteLandmark> mlRemoteLandmarks) {
                    try {
                        mResult.success(onAnalyzeSuccess(mlRemoteLandmarks).toString());
                    } catch (JSONException landmarkError) {
                        mResult.error(TAG, landmarkError.getMessage(), "");
                    }
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(Exception landmarkError) {
                    mResult.error(TAG, landmarkError.getMessage(), "");
                }
            });
        }
    }

    private void analyzeLandmark(MethodCall call) {
        try {
            String landmarkJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                landmarkJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (landmarkJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject landmarkObject = new JSONObject(landmarkJsonString);
                String imagePath = landmarkObject.getString("path");
                int largestNumberOfReturns = landmarkObject.getInt("largestNumberOfReturns");
                int patternType = landmarkObject.getInt("patternType");

                MLRemoteLandmarkAnalyzerSetting settings = new MLRemoteLandmarkAnalyzerSetting.Factory()
                        .setLargestNumOfReturns(largestNumberOfReturns)
                        .setPatternType(patternType)
                        .create();
                analyzer = MLAnalyzerFactory.getInstance()
                        .getRemoteLandmarkAnalyzer(settings);

                final String landmarkImage = ImagePathHelper.pathToBase64(imagePath);
                MLFrame landmarkFrame = HmsMlUtils.getFrame(landmarkImage);

                Task<List<MLRemoteLandmark>> landmarkTask = analyzer.asyncAnalyseFrame(landmarkFrame);

                landmarkTask.addOnSuccessListener(new OnSuccessListener<List<MLRemoteLandmark>>() {
                    @Override
                    public void onSuccess(List<MLRemoteLandmark> mlRemoteLandmarks) {
                        try {
                            mResult.success(onAnalyzeSuccess(mlRemoteLandmarks).toString());
                        } catch (JSONException analyzeError) {
                            mResult.error(TAG, analyzeError.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception analyzeError) {
                        mResult.error(TAG, analyzeError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException analyzeError) {
            mResult.error(TAG, analyzeError.getMessage(), "");
        }
    }

    private static JSONObject onAnalyzeSuccess(List<MLRemoteLandmark> mlRemoteLandmarks) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLRemoteLandmark landmark : mlRemoteLandmarks) {
            object.putOpt("border", MlTextUtils.getBorders(landmark.getBorder()));
            object.putOpt("landmark", landmark.getLandmark());
            object.putOpt("landmarkIdentity", landmark.getLandmarkIdentity());
            object.putOpt("possibility", landmark.getPossibility());
            object.putOpt("position", getPositionInfo(landmark.getPositionInfos()));
        }
        return object;
    }

    private static JSONObject getPositionInfo(List<MLCoordinate> coordinates) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLCoordinate coordinate : coordinates) {
            object.putOpt("lat", coordinate.getLat());
            object.putOpt("lng", coordinate.getLng());
        }
        return object;
    }

    private void stopAnalyzer() {
        if (analyzer == null) {
            mResult.error(TAG, "Analyser is not initialized.", "");
        } else {
            try {
                this.analyzer.close();
                String success = "Landmark Analyser is closed";
                mResult.success(success);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}