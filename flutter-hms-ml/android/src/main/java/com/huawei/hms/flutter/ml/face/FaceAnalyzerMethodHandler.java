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

package com.huawei.hms.flutter.ml.face;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlFaceUtils;
import com.huawei.hms.flutter.ml.utils.MlTextUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzer;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzerSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FaceAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = FaceAnalyzerMethodHandler.class.getSimpleName();

    private MethodChannel.Result mResult;
    private MLFaceAnalyzer analyzer;

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncAnalyzeFrame":
                faceAnalyzer(call);
                break;
            case "analyzeFrame":
                sparseFaceAnalyzer(call);
                break;
            case "defaultFaceAnalyze":
                defaultFaceAnalyzer(call);
                break;
            case "getAnalyzerInfo":
                getAnalyzerInfo();
                break;
            case "closeAnalyzer":
                closeAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void sparseFaceAnalyzer(MethodCall call) {
        if (call.argument("path") == null) {
            mResult.error(TAG, "Image path must not be null!", "");
        } else {
            String path = call.argument("path");
            final String encodedImage = ImagePathHelper.pathToBase64(path);
            byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);

            this.analyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer();
            Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
            MLFrame frame = MLFrame.fromBitmap(bitmap);

            SparseArray<MLFace> analyseFrame = analyzer.analyseFrame(frame);
            mResult.success(MlFaceUtils.fromSparseArrayStillFaceAnalyseToJSON(analyseFrame).toString());
        }
    }

    private void faceAnalyzer(MethodCall call) {
        try {
            String faceJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                faceJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (faceJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject faceObject = new JSONObject(faceJsonString);
                String imagePath = faceObject.getString("path");

                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);

                MLFaceAnalyzerSetting setting = new MLFaceAnalyzerSetting.Factory()
                        .setKeyPointType(faceObject.getInt("keyPointType"))
                        .setFeatureType(faceObject.getInt("featureType"))
                        .setShapeType(faceObject.getInt("shapeType"))
                        .setTracingAllowed(faceObject.getBoolean("tracingAllowed"))
                        .setPerformanceType(faceObject.getInt("performanceType"))
                        .create();

                this.analyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer(setting);
                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                MLFrame faceFrame = MLFrame.fromBitmap(bitmap);

                Task<List<MLFace>> faceTask = analyzer.asyncAnalyseFrame(faceFrame);

                faceTask.addOnSuccessListener(new OnSuccessListener<List<MLFace>>() {
                    @Override
                    public void onSuccess(List<MLFace> mlFaces) {
                        onAnalyzeSuccess(mlFaces);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception faceAnalyzeError) {
                        mResult.error(TAG, faceAnalyzeError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException faceAnalyzeError) {
            mResult.error(TAG, faceAnalyzeError.getMessage(), "");
        }
    }

    private void defaultFaceAnalyzer(MethodCall call) {
        if (call.argument("path") == null) {
            mResult.error(TAG, "Image path must not be null!", "");
        } else {
            String path = call.argument("path");
            final String encodedImage = ImagePathHelper.pathToBase64(path);
            this.analyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer();
            MLFrame defaultFaceFrame = HmsMlUtils.getFrame(encodedImage);
            Task<List<MLFace>> defaultFaceTask = analyzer.asyncAnalyseFrame(defaultFaceFrame);
            defaultFaceTask.addOnSuccessListener(new OnSuccessListener<List<MLFace>>() {
                @Override
                public void onSuccess(List<MLFace> results) {
                    onAnalyzeSuccess(results);
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(Exception error) {
                    mResult.error(TAG, error.getMessage(), "");
                }
            });
        }
    }

    private void onAnalyzeSuccess(List<MLFace> faces) {
        JSONObject object = new JSONObject();
        for (MLFace face : faces) {
            try {
                object.putOpt("opennessOfLeftEye", face.opennessOfLeftEye());
                object.putOpt("opennessOfRightEye", face.opennessOfRightEye());
                object.putOpt("tracingIdentity", face.getTracingIdentity());
                object.putOpt("possibilityOfSmiling", face.possibilityOfSmiling());
                object.putOpt("rotationAngleX", face.getRotationAngleX());
                object.putOpt("rotationAngleY", face.getRotationAngleY());
                object.putOpt("rotationAngleZ", face.getRotationAngleZ());
                object.putOpt("height", face.getHeight());
                object.putOpt("width", face.getWidth());
                object.putOpt("border", MlTextUtils.getBorders(face.getBorder()));
                object.putOpt("allPoints", MlFaceUtils.getFacePoints(face.getAllPoints()));
                object.putOpt("keyPoints", MlFaceUtils.getFaceKeyPoints(face.getFaceKeyPoints()));
                object.putOpt("faceShapeList", MlFaceUtils.getFaceShapes(face.getFaceShapeList()));

                JSONObject features = new JSONObject();
                features.putOpt("sunGlassProbability", face.getFeatures().getSunGlassProbability());
                features.putOpt("sexProbability", face.getFeatures().getSexProbability());
                features.putOpt("rightEyeOpenProbability", face.getFeatures().getRightEyeOpenProbability());
                features.putOpt("leftEyeOpenProbability", face.getFeatures().getLeftEyeOpenProbability());
                features.putOpt("moustacheProbability", face.getFeatures().getMoustacheProbability());
                features.putOpt("age", face.getFeatures().getAge());
                features.putOpt("hatProbability", face.getFeatures().getHatProbability());

                object.putOpt("features", features);

                JSONObject emotions = new JSONObject();
                emotions.putOpt("surpriseProbability", face.getEmotions().getSurpriseProbability());
                emotions.putOpt("smilingProbability", face.getEmotions().getSmilingProbability());
                emotions.putOpt("sadProbability", face.getEmotions().getSadProbability());
                emotions.putOpt("neutralProbability", face.getEmotions().getNeutralProbability());
                emotions.putOpt("fearProbability", face.getEmotions().getFearProbability());
                emotions.putOpt("disgustProbability", face.getEmotions().getDisgustProbability());
                emotions.putOpt("angryProbability", face.getEmotions().getAngryProbability());

                object.putOpt("emotions", emotions);
            } catch (JSONException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
        mResult.success(object.toString());
    }

    private void closeAnalyzer() {
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initialized", "");
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                final String faceSuccess = "Face analyzer is closed";
                mResult.success(faceSuccess);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    private void getAnalyzerInfo() {
        JSONObject object = new JSONObject();
        boolean isAvailable;
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initialized", "");
        } else {
            isAvailable = analyzer.isAvailable();
            try {
                object.putOpt("isAvailable", isAvailable);
                mResult.success(object.toString());
            } catch (JSONException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}