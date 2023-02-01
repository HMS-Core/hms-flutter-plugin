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

import android.util.Log;

import com.huawei.hiar.ARFace;
import com.huawei.hiar.ARFaceBlendShapes;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

class PluginARFaceSerializer {
    private PluginARFaceSerializer() {
    }

    static Map<String, Object> convertARFaceToMap(ARFace arFace) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("trackingState", arFace.getTrackingState().ordinal());
        resultMap.put("anchors", CommonSerializer.anchorsToList(arFace.getAnchors()));
        resultMap.put("faceBlendShapes", faceBlendShapesToMap(arFace.getFaceBlendShapes()));
        resultMap.put("pose", CommonSerializer.arPoseToMap(arFace.getPose()));
        resultMap.put("healthParameterCount", arFace.getHealthParameterCount());
        resultMap.put("healthParameters", healthParametersToMap(arFace.getHealthParameters()));
        return resultMap;
    }

    private static Map<String, Object> faceBlendShapesToMap(ARFaceBlendShapes faceBlendShapes) {
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("blendShapeCount", faceBlendShapes.getBlendShapeCount());
        jsonMap.put("blendShapeData", faceBlendShapes.getBlendShapeData().array());
        jsonMap.put("blendShapeType", faceBlendShapes.getBlendShapeType());
        jsonMap.put("blendShapeDataMap", faceBlendShapes.getBlendShapeDataMapKeyString());
        return jsonMap;
    }

    private static JSONObject healthParametersToMap(HashMap<ARFace.HealthParameter, Float> healthParameters) {
        JSONObject jsonMap = new JSONObject();
        try {
            for (Map.Entry<ARFace.HealthParameter, Float> entry : healthParameters.entrySet()) {
                jsonMap.put(entry.getKey().name(), entry.getValue());
            }
        } catch (JSONException e) {
            Log.d("PluginARFaceSerializer", e.getLocalizedMessage());
        }

        return jsonMap;
    }
}
