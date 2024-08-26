/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mlbody.data;

import android.graphics.PointF;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.common.MLPosition;
import com.huawei.hms.mlsdk.face.MLFace;
import com.huawei.hms.mlsdk.face.MLFaceEmotion;
import com.huawei.hms.mlsdk.face.MLFaceFeature;
import com.huawei.hms.mlsdk.face.MLFaceKeyPoint;
import com.huawei.hms.mlsdk.face.MLFaceShape;
import com.huawei.hms.mlsdk.face.face3d.ML3DFace;
import com.huawei.hms.mlsdk.faceverify.MLFaceInfo;
import com.huawei.hms.mlsdk.faceverify.MLFaceTemplateResult;
import com.huawei.hms.mlsdk.faceverify.MLFaceVerificationResult;
import com.huawei.hms.mlsdk.gesture.MLGesture;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoint;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoints;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCaptureResult;
import com.huawei.hms.mlsdk.livenessdetection.MLLivenessCaptureResult;
import com.huawei.hms.mlsdk.skeleton.MLJoint;
import com.huawei.hms.mlsdk.skeleton.MLSkeleton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToMap {
    public static class FaceToMap {
        public static ArrayList<Map<String, Object>> createMLFaceJSON(@NonNull List<MLFace> faces) {
            ArrayList<Map<String, Object>> faceList = new ArrayList<>();
            for (int i = 0; i < faces.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLFace face = faces.get(i);
                map.put("allPoints", createMLPositionsJSON(face.getAllPoints()));
                map.put("keyPoints", createMLFaceKeyPointJSON(face.getFaceKeyPoints()));
                map.put("faceShapeList", createMLFaceShapesJSON(face.getFaceShapeList()));
                map.put("border", Commons.createBorderMap(face.getBorder()));
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
            return faceList;
        }

        public static ArrayList<Map<String, Object>> createMLPositionsJSON(@NonNull List<MLPosition> positions) {
            ArrayList<Map<String, Object>> positionList = new ArrayList<>();
            for (int i = 0; i < positions.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLPosition position = positions.get(i);
                map.put("x", position.getX());
                map.put("y", position.getY());
                map.put("z", position.getZ());
                positionList.add(map);
            }
            return positionList;
        }

        public static Map<String, Object> createPointFJSON(@NonNull PointF pointF) {
            Map<String, Object> map = new HashMap<>();
            map.put("y", pointF.x);
            map.put("x", pointF.y);
            return map;
        }

        public static ArrayList<Map<String, Object>> createPointsFJSON(@NonNull PointF[] pointFS) {
            ArrayList<Map<String, Object>> pointList = new ArrayList<>();
            for (PointF f : pointFS) {
                Map<String, Object> map = new HashMap<>();
                map.put("x", f.x);
                map.put("y", f.y);
                pointList.add(map);
            }
            return pointList;
        }

        public static Map<String, Object> createMLPositionJSON(@NonNull MLPosition position) {
            Map<String, Object> map = new HashMap<>();
            map.put("x", position.getX());
            map.put("y", position.getY());
            map.put("z", position.getZ());
            return map;
        }

        public static ArrayList<Map<String, Object>> createMLFaceKeyPointJSON(@NonNull List<MLFaceKeyPoint> keyPoints) {
            ArrayList<Map<String, Object>> keyPointList = new ArrayList<>();
            for (int i = 0; i < keyPoints.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLFaceKeyPoint keyPoint = keyPoints.get(i);
                map.put("coordinatePoint", createPointFJSON(keyPoint.getCoordinatePoint()));
                map.put("point", createMLPositionJSON(keyPoint.getPoint()));
                map.put("type", keyPoint.getType());
                keyPointList.add(map);
            }
            return keyPointList;
        }

        public static ArrayList<Map<String, Object>> createMLFaceShapesJSON(@NonNull List<MLFaceShape> shapes) {
            ArrayList<Map<String, Object>> shapeList = new ArrayList<>();
            for (int i = 0; i < shapes.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLFaceShape faceShape = shapes.get(i);
                map.put("faceShapeType", faceShape.getFaceShapeType());
                map.put("points", createMLPositionsJSON(faceShape.getPoints()));
                map.put("coordinatePoints", createPointsFJSON(faceShape.getCoordinatePoints()));
                shapeList.add(map);
            }
            return shapeList;
        }

        public static Map<String, Object> createEmotionJSON(@NonNull MLFaceEmotion emotion) {
            Map<String, Object> map = new HashMap<>();
            map.put("angryProbability", emotion.getAngryProbability());
            map.put("disgustProbability", emotion.getDisgustProbability());
            map.put("fearProbability", emotion.getFearProbability());
            map.put("neutralProbability", emotion.getNeutralProbability());
            map.put("sadProbability", emotion.getSadProbability());
            map.put("smilingProbability", emotion.getSmilingProbability());
            map.put("surpriseProbability", emotion.getSurpriseProbability());
            return map;
        }

        public static Map<String, Object> createFeatureJSON(@NonNull MLFaceFeature feature) {
            Map<String, Object> map = new HashMap<>();
            map.put("age", feature.getAge());
            map.put("hatProbability", feature.getHatProbability());
            map.put("leftEyeOpenProbability", feature.getLeftEyeOpenProbability());
            map.put("moustacheProbability", feature.getMoustacheProbability());
            map.put("rightEyeOpenProbability", feature.getRightEyeOpenProbability());
            map.put("sexProbability", feature.getSexProbability());
            map.put("sunGlassProbability", feature.getSunGlassProbability());
            return map;
        }

        public static ArrayList<Map<String, Object>> face3DToJSONArray(@NonNull List<ML3DFace> ml3DFaces) {
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
            return faceList;
        }
    }

    // SKELETON
    public static class SkeletonToMap {
        public static ArrayList<Map<String, Object>> skeletonToJSONArray(@NonNull List<MLSkeleton> list) {
            ArrayList<Map<String, Object>> skeletonList = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLSkeleton skeleton = list.get(i);
                map.put("joints", jointToJSONArray(skeleton.getJoints()));
                skeletonList.add(map);
            }
            return skeletonList;
        }

        public static ArrayList<Map<String, Object>> jointToJSONArray(@NonNull List<MLJoint> list) {
            ArrayList<Map<String, Object>> jointList = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLJoint joint = list.get(i);
                map.put("pointX", joint.getPointX());
                map.put("pointY", joint.getPointY());
                map.put("score", joint.getScore());
                map.put("type", joint.getType());
                jointList.add(map);
            }
            return jointList;
        }
    }

    // HAND
    public static class HandToMap {
        public static ArrayList<Map<String, Object>> handsToJSONArray(@NonNull List<MLHandKeypoints> list) {
            ArrayList<Map<String, Object>> hList = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLHandKeypoints hands = list.get(i);
                map.put("score", hands.getScore());
                map.put("border", Commons.createBorderMap(hands.getRect()));
                map.put("handKeypoints", handToJSONArray(hands.getHandKeypoints()));
                hList.add(map);
            }
            return hList;
        }

        public static ArrayList<Map<String, Object>> handToJSONArray(@NonNull List<MLHandKeypoint> list) {
            ArrayList<Map<String, Object>> hList = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLHandKeypoint hand = list.get(i);
                map.put("pointX", hand.getPointX());
                map.put("pointY", hand.getPointY());
                map.put("score", hand.getScore());
                map.put("type", hand.getType());
                hList.add(map);
            }
            return hList;
        }
    }

    // GESTURE
    public static class GestureToMap {
        public static ArrayList<Map<String, Object>> onGestureAnalyzeSuccess(List<MLGesture> mlGestures) {
            ArrayList<Map<String, Object>> gestureList = new ArrayList<>();
            for (int i = 0; i < mlGestures.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLGesture gesture = mlGestures.get(i);
                map.put("category", gesture.getCategory());
                map.put("score", gesture.getScore());
                map.put("rect", Commons.createBorderMap(gesture.getRect()));
                gestureList.add(map);
            }
            return gestureList;
        }
    }

    // VERIFICATION
    public static class VerificationToMap {
        public static ArrayList<Map<String, Object>> verifySuccess(List<MLFaceVerificationResult> verificationResults) {
            ArrayList<Map<String, Object>> verifiedList = new ArrayList<>();
            for (int i = 0; i < verificationResults.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLFaceVerificationResult result = verificationResults.get(i);
                map.put("faceInfo", faceInfoToJSON(result.getFaceInfo()));
                map.put("similarity", result.getSimilarity());
                map.put("templateId", result.getTemplateId());
                verifiedList.add(map);
            }
            return verifiedList;
        }

        public static ArrayList<Map<String, Object>> templateSuccess(List<MLFaceTemplateResult> templateResults) {
            ArrayList<Map<String, Object>> templateList = new ArrayList<>();
            for (int i = 0; i < templateResults.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLFaceTemplateResult result = templateResults.get(i);
                map.put("templateId", result.getTemplateId());
                map.put("faceInfo", faceInfoToJSON(result.getFaceInfo()));
                templateList.add(map);
            }
            return templateList;
        }

        public static Map<String, Object> faceInfoToJSON(MLFaceInfo info) {
            Map<String, Object> map = new HashMap<>();
            map.put("rect", Commons.createBorderMap(info.getFaceRect()));
            return map;
        }
    }

    // Static Biometric Verification
    public static class LivenessToMap {
        public static Map<String, Object> getResult(MLLivenessCaptureResult result) {
            final Map<String, Object> map = new HashMap<>();
            map.put("score", result.getScore());
            map.put("pitch", result.getPitch());
            map.put("roll", result.getRoll());
            map.put("yaw", result.getYaw());
            map.put("bitmap", Commons.bitmapToByteArray(result.getBitmap()));
            map.put("isLive", result.isLive());
            return map;
        }
    }

    // Interactive Biometric Verification
    public static class InteractiveLivenessToMap {
        public static Map<String, Object> getResult(MLInteractiveLivenessCaptureResult result) {
            final Map<String, Object> map = new HashMap<>();
            if (result.getBitmap() != null) {
                map.put("bitmap", Commons.bitmapToByteArray(result.getBitmap()));
            }
            map.put("score", result.getScore());
            map.put("stateCode", result.getStateCode());
            map.put("actionType", result.getActionType());
            map.put("frameNum", result.getFrameNum());
            return map;
        }
    }
}
