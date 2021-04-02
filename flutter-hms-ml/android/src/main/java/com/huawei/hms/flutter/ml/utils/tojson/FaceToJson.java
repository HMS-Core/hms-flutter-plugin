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

package com.huawei.hms.flutter.ml.utils.tojson;

import android.graphics.PointF;
import android.graphics.Rect;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.common.MLPosition;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceEmotion;
import com.huawei.hms.mlsdk.face.MLFaceFeature;
import com.huawei.hms.mlsdk.face.MLFaceKeyPoint;
import com.huawei.hms.mlsdk.face.MLFaceShape;
import com.huawei.hms.mlsdk.face.face3d.ML3DFace;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FaceToJson {
    public static JSONObject liveFaceJSON(@NonNull MLFace face) {
        Map<String, Object> map = new HashMap<>();
        map.put("allPoints", createMLPositionsJSON(face.getAllPoints()));
        map.put("keyPoints", createMLFaceKeyPointJSON(face.getFaceKeyPoints()));
        map.put("tracingIdentity", face.getTracingIdentity());
        map.put("width", face.getWidth());
        map.put("features", createFeatureJSON(face.getFeatures()));
        map.put("height", face.getHeight());
        map.put("rotationAngleX", face.getRotationAngleX());
        map.put("faceShapeList", createMLFaceShapesJSON(face.getFaceShapeList()));
        map.put("border", createBorderJSON(face.getBorder()));
        map.put("emotions", createEmotionJSON(face.getEmotions()));
        map.put("rotationAngleY", face.getRotationAngleX());
        map.put("rotationAngleZ", face.getRotationAngleX());
        map.put("opennessOfLeftEye", face.opennessOfLeftEye());
        map.put("opennessOfRightEye", face.opennessOfRightEye());
        map.put("possibilityOfSmiling", face.possibilityOfSmiling());
        return new JSONObject(map);
    }

    public static JSONArray createMLFaceJSON(@NonNull List<MLFace> faces) {
        ArrayList<Map<String, Object>> faceList = new ArrayList<>();
        for (int i = 0; i < faces.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLFace face = faces.get(i);
            map.put("allPoints", createMLPositionsJSON(face.getAllPoints()));
            map.put("keyPoints", createMLFaceKeyPointJSON(face.getFaceKeyPoints()));
            map.put("faceShapeList", createMLFaceShapesJSON(face.getFaceShapeList()));
            map.put("border", createBorderJSON(face.getBorder()));
            map.put("emotions", createEmotionJSON(face.getEmotions()));
            map.put("features", createFeatureJSON(face.getFeatures()));
            map.put("height", face.getHeight());
            map.put("rotationAngleX", face.getRotationAngleX());
            map.put("rotationAngleY", face.getRotationAngleX());
            map.put("rotationAngleZ", face.getRotationAngleX());
            map.put("tracingIdentity", face.getTracingIdentity());
            map.put("width", face.getWidth());
            map.put("opennessOfLeftEye", face.opennessOfLeftEye());
            map.put("opennessOfRightEye", face.opennessOfRightEye());
            map.put("possibilityOfSmiling", face.possibilityOfSmiling());
            faceList.add(map);
        }
        return new JSONArray(faceList);
    }

    public static JSONArray createMLPositionsJSON(@NonNull List<MLPosition> positions) {
        ArrayList<Map<String, Object>> positionList = new ArrayList<>();
        for (int i = 0; i < positions.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLPosition position = positions.get(i);
            map.put("x", position.getX());
            map.put("y", position.getY());
            map.put("z", position.getZ());
            positionList.add(map);
        }
        return new JSONArray(positionList);
    }

    public static JSONObject createPointFJSON(@NonNull PointF pointF) {
        Map<String, Object> map = new HashMap<>();
        map.put("y", pointF.x);
        map.put("x", pointF.y);
        return new JSONObject(map);
    }

    public static JSONArray createPointsFJSON(@NonNull PointF[] pointFS) {
        ArrayList<Map<String, Object>> pointList = new ArrayList<>();
        for (PointF f : pointFS) {
            Map<String, Object> map = new HashMap<>();
            map.put("x", f.x);
            map.put("y", f.y);
            pointList.add(map);
        }
        return new JSONArray(pointList);
    }

    public static JSONObject createMLPositionJSON(@NonNull MLPosition position) {
        Map<String, Object> map = new HashMap<>();
        map.put("x", position.getX());
        map.put("y", position.getY());
        map.put("z", position.getZ());
        return new JSONObject(map);
    }

    public static JSONArray createMLFaceKeyPointJSON(@NonNull List<MLFaceKeyPoint> keyPoints) {
        ArrayList<Map<String, Object>> keyPointList = new ArrayList<>();
        for (int i = 0; i < keyPoints.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLFaceKeyPoint keyPoint = keyPoints.get(i);
            map.put("coordinatePoint", createPointFJSON(keyPoint.getCoordinatePoint()));
            map.put("point", createMLPositionJSON(keyPoint.getPoint()));
            map.put("type", keyPoint.getType());
            keyPointList.add(map);
        }
        return new JSONArray(keyPointList);
    }

    public static JSONArray createMLFaceShapesJSON(@NonNull List<MLFaceShape> shapes) {
        ArrayList<Map<String, Object>> shapeList = new ArrayList<>();
        for (int i = 0; i < shapes.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLFaceShape faceShape = shapes.get(i);
            map.put("faceShapeType", faceShape.getFaceShapeType());
            map.put("points", createMLPositionsJSON(faceShape.getPoints()));
            map.put("coordinatePoints", createPointsFJSON(faceShape.getCoordinatePoints()));
            shapeList.add(map);
        }
        return new JSONArray(shapeList);
    }

    public static JSONObject createBorderJSON(@NonNull Rect rect) {
        Map<String, Object> map = new HashMap<>();
        map.put("top", rect.top);
        map.put("left", rect.left);
        map.put("right", rect.right);
        map.put("bottom", rect.bottom);
        return new JSONObject(map);
    }

    public static JSONObject createEmotionJSON(@NonNull MLFaceEmotion emotion) {
        Map<String, Object> map = new HashMap<>();
        map.put("angryProbability", emotion.getAngryProbability());
        map.put("disgustProbability", emotion.getDisgustProbability());
        map.put("fearProbability", emotion.getFearProbability());
        map.put("neutralProbability", emotion.getNeutralProbability());
        map.put("sadProbability", emotion.getSadProbability());
        map.put("smilingProbability", emotion.getSmilingProbability());
        map.put("surpriseProbability", emotion.getSurpriseProbability());
        return new JSONObject(map);
    }

    public static JSONObject createFeatureJSON(@NonNull MLFaceFeature feature) {
        Map<String, Object> map = new HashMap<>();
        map.put("age", feature.getAge());
        map.put("hatProbability", feature.getHatProbability());
        map.put("leftEyeOpenProbability", feature.getLeftEyeOpenProbability());
        map.put("moustacheProbability", feature.getMoustacheProbability());
        map.put("rightEyeOpenProbability", feature.getRightEyeOpenProbability());
        map.put("sexProbability", feature.getSexProbability());
        map.put("sunGlassProbability", feature.getSunGlassProbability());
        return new JSONObject(map);
    }

    public static JSONArray face3DToJSONArray(@NonNull List<ML3DFace> ml3DFaces) {
        ArrayList<Map<String, Object>> faceList = new ArrayList<>();
        for (int i = 0; i < ml3DFaces.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            ML3DFace face = ml3DFaces.get(i);
            map.put("eulerX", face.get3DFaceEulerX());
            map.put("eulerY", face.get3DFaceEulerY());
            map.put("eulerZ", face.get3DFaceEulerZ());
            map.put("allVertexes", createMLPositionsJSON(face.get3DAllVertexs()));
            faceList.add(map);
        }
        return new JSONArray(faceList);
    }

    public static JSONObject f3DToJSON(ML3DFace face) {
        Map<String, Object> map = new HashMap<>();
        map.put("eulerX", face.get3DFaceEulerX());
        map.put("eulerY", face.get3DFaceEulerY());
        map.put("eulerZ", face.get3DFaceEulerZ());
        map.put("allVertexes", createMLPositionsJSON(face.get3DAllVertexs()));
        return new JSONObject(map);
    }
}
