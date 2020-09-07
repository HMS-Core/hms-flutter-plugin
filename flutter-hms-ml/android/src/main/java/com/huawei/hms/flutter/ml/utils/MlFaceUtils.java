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

package com.huawei.hms.flutter.ml.utils;

import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.mlsdk.common.MLPosition;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceKeyPoint;
import com.huawei.hms.mlsdk.face.MLFaceShape;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;
import java.util.Objects;

public class MlFaceUtils {
    private static String TAG = MlFaceUtils.class.getSimpleName();

    public static JSONObject getFacePoints(List<MLPosition> positions) {
        JSONObject object = new JSONObject();
        for (MLPosition position : positions) {
            try {
                object.putOpt("X", position.getX());
                object.putOpt("Y", position.getY());
                object.putOpt("Z", position.getZ());
            } catch (JSONException e) {
                Log.i(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    public static JSONObject getFaceKeyPoints(List<MLFaceKeyPoint> keyPoints) {
        JSONObject object = new JSONObject();
        JSONObject points = new JSONObject();
        for (MLFaceKeyPoint keyPoint : keyPoints) {
            try {
                object.putOpt("type", keyPoint.getType());
                points.putOpt("X", keyPoint.getPoint().getX());
                points.putOpt("Y", keyPoint.getPoint().getY());
                points.putOpt("Z", keyPoint.getPoint().getZ());
                object.putOpt("points", points);
                JSONObject coordinatePoint = new JSONObject();
                coordinatePoint.putOpt("x", keyPoint.getCoordinatePoint().x);
                coordinatePoint.putOpt("y", keyPoint.getCoordinatePoint().y);
                coordinatePoint.putOpt("describeContents", keyPoint.getCoordinatePoint().describeContents());
                object.putOpt("coordinatePoint", coordinatePoint);
            } catch (JSONException e) {
                Log.i(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    public static JSONObject getFaceShapes(List<MLFaceShape> faceShapes) {
        JSONObject object = new JSONObject();
        for (MLFaceShape shape : faceShapes) {
            try {
                object.putOpt("faceShapeType", shape.getFaceShapeType());
                object.putOpt("points", getFacePoints(shape.getPoints()));
            } catch (JSONException e) {
                Log.i(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    public static JSONObject fromSparseArrayStillFaceAnalyseToJSON(SparseArray<MLFace> array) {
        JSONObject json = new JSONObject();
        try {
            for (int i = 0; i < array.size(); i++) {
                int key = array.keyAt(i);
                MLFace mlFace = array.get(key);
                json.putOpt(String.valueOf(key), mlFaceToJSON(mlFace));
            }
        } catch (JSONException e) {
            Log.i(TAG, Objects.requireNonNull(e.getMessage()));
        }
        return json;
    }

    private static JSONObject mlFaceToJSON(MLFace mFace) throws JSONException {
        JSONObject object = new JSONObject();
        object.putOpt("opennessOfLeftEye", mFace.opennessOfLeftEye());
        object.putOpt("opennessOfRightEye", mFace.opennessOfRightEye());
        object.putOpt("tracingIdentity", mFace.getTracingIdentity());
        object.putOpt("possibilityOfSmiling", mFace.possibilityOfSmiling());
        object.putOpt("rotationAngleX", mFace.getRotationAngleX());
        object.putOpt("rotationAngleY", mFace.getRotationAngleY());
        object.putOpt("rotationAngleZ", mFace.getRotationAngleZ());
        object.putOpt("height", mFace.getHeight());
        object.putOpt("width", mFace.getWidth());
        object.putOpt("border", MlTextUtils.getBorders(mFace.getBorder()));
        object.putOpt("allPoints", MlFaceUtils.getFacePoints(mFace.getAllPoints()));
        object.putOpt("keyPoints", MlFaceUtils.getFaceKeyPoints(mFace.getFaceKeyPoints()));
        object.putOpt("faceShapeList", MlFaceUtils.getFaceShapes(mFace.getFaceShapeList()));

        JSONObject features = new JSONObject();
        features.putOpt("sunGlassProbability", mFace.getFeatures().getSunGlassProbability());
        features.putOpt("sexProbability", mFace.getFeatures().getSexProbability());
        features.putOpt("rightEyeOpenProbability", mFace.getFeatures().getRightEyeOpenProbability());
        features.putOpt("leftEyeOpenProbability", mFace.getFeatures().getLeftEyeOpenProbability());
        features.putOpt("moustacheProbability", mFace.getFeatures().getMoustacheProbability());
        features.putOpt("age", mFace.getFeatures().getAge());
        features.putOpt("hatProbability", mFace.getFeatures().getHatProbability());

        object.putOpt("features", features);

        JSONObject emotions = new JSONObject();
        emotions.putOpt("surpriseProbability", mFace.getEmotions().getSurpriseProbability());
        emotions.putOpt("smilingProbability", mFace.getEmotions().getSmilingProbability());
        emotions.putOpt("sadProbability", mFace.getEmotions().getSadProbability());
        emotions.putOpt("neutralProbability", mFace.getEmotions().getNeutralProbability());
        emotions.putOpt("fearProbability", mFace.getEmotions().getFearProbability());
        emotions.putOpt("disgustProbability", mFace.getEmotions().getDisgustProbability());
        emotions.putOpt("angryProbability", mFace.getEmotions().getAngryProbability());

        object.putOpt("emotions", emotions);
        return object;
    }
}