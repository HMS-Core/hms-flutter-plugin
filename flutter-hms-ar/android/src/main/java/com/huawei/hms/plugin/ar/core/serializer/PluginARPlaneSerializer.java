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

import com.huawei.hiar.ARPlane;

import java.util.HashMap;
import java.util.Map;

class PluginARPlaneSerializer {
    private PluginARPlaneSerializer() {
    }

    static Map<String, Object> convertARPlaneToMap(ARPlane plane) {
        Map<String, Object> map = new HashMap<>();
        map.put("centerPose", CommonSerializer.arPoseToMap(plane.getCenterPose()));
        map.put("extentX", plane.getExtentX());
        map.put("extentZ", plane.getExtentZ());
        map.put("planePolygon", plane.getPlanePolygon().array());
        map.put("label", plane.getLabel().ordinal());
        map.put("type", plane.getType().ordinal());
        map.put("trackingState", plane.getTrackingState().ordinal());
        map.put("anchors", CommonSerializer.anchorsToList(plane.getAnchors()));
        return map;
    }
}
