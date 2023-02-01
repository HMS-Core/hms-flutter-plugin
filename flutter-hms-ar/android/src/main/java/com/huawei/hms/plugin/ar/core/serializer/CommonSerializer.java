/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.plugin.ar.core.serializer;

import com.huawei.hiar.ARAnchor;
import com.huawei.hiar.ARCameraConfig;
import com.huawei.hiar.ARCameraIntrinsics;
import com.huawei.hiar.ARPose;
import com.huawei.hiar.ARSceneMesh;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommonSerializer {
    private CommonSerializer() {
    }

    static Map<String, Object> arPoseToMap(ARPose pose) {
        Map<String, Object> jsonMap = new HashMap<>();
        float[] translation = new float[3];
        float[] rotation = new float[4];
        float[] rotationVector = new float[4];
        float[] rotationVectorOut = new float[4];
        int rotationVectorOutOffSet = 0;

        float[] transformPoint = new float[4];
        float[] transformPointOut = new float[4];
        int transformPointOutOffSet = 0;

        pose.rotateVector(rotationVector, 0, rotationVectorOut, rotationVectorOutOffSet);
        Map<String, Object> jsonMapRotateVector = new HashMap<>();
        jsonMapRotateVector.put("vector", rotationVectorOut);
        jsonMapRotateVector.put("offset", rotationVectorOutOffSet);

        pose.transformPoint(transformPoint, 0, transformPointOut, transformPointOutOffSet);
        Map<String, Object> jsonMapTransformPoint = new HashMap<>();
        jsonMapTransformPoint.put("point", transformPointOut);
        jsonMapTransformPoint.put("offset", transformPointOutOffSet);

        pose.getTranslation(translation, 0);
        pose.getRotationQuaternion(rotation, 0);

        jsonMap.put("translation", translation);
        jsonMap.put("rotation", rotation);
        jsonMap.put("xAxis", pose.getXAxis());
        jsonMap.put("yAxis", pose.getYAxis());
        jsonMap.put("zAxis", pose.getZAxis());
        jsonMap.put("qw", pose.qw());
        jsonMap.put("qx", pose.qx());
        jsonMap.put("qy", pose.qy());
        jsonMap.put("qz", pose.qz());
        jsonMap.put("rotationVector", jsonMapRotateVector);
        jsonMap.put("transformPoint", pose.transformPoint(new float[4]));
        jsonMap.put("transformPointObject", jsonMapTransformPoint);

        return jsonMap;
    }

    static List<Map<String, Object>> anchorsToList(Collection<ARAnchor> anchorList) {
        List<Map<String, Object>> anchorsCollection = new ArrayList<>();
        for (ARAnchor anchor : anchorList) {
            Map<String, Object> jsonMap = new HashMap<>();
            jsonMap.put("pose", arPoseToMap(anchor.getPose()));
            jsonMap.put("trackingState", anchor.getTrackingState());
            anchorsCollection.add(jsonMap);
        }
        return anchorsCollection;
    }

    public static Map<String, Object> arCameraConfigToMap(ARCameraConfig cameraConfig) {
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("imageDimensions", cameraConfig.getImageDimensions().toString());
        jsonMap.put("textureDimensions", cameraConfig.getTextureDimensions().toString());
        return jsonMap;
    }

    public static Map<String, Object> arCameraIntrinsicsToMap(ARCameraIntrinsics cameraIntrinsics) {
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("imageDimensions", cameraIntrinsics.getImageDimensions());
        jsonMap.put("distortions", cameraIntrinsics.getDistortions());
        jsonMap.put("focalLength", cameraIntrinsics.getFocalLength());
        jsonMap.put("principalPoint", cameraIntrinsics.getPrincipalPoint());
        return jsonMap;
    }

    public static Map<String, Object> arSceneMeshToMap(ARSceneMesh arSceneMesh) {
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("sceneDepth", arSceneMesh.getSceneDepth() == null ? null : arSceneMesh.getSceneDepth().array());
        jsonMap.put("sceneDepthHeight", arSceneMesh.getSceneDepthHeight());
        jsonMap.put("sceneDepthWidth", arSceneMesh.getSceneDepthWidth());
        jsonMap.put("triangleIndices", arSceneMesh.getTriangleIndices().array());
        jsonMap.put("vertexNormals", arSceneMesh.getVertexNormals().array());
        jsonMap.put("vertices", arSceneMesh.getVertices().array());
        return jsonMap;
    }
}
