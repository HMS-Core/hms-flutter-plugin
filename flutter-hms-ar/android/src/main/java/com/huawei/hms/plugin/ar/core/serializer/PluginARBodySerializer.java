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

import com.huawei.hiar.ARBody;

import java.util.HashMap;
import java.util.Map;

class PluginARBodySerializer {
    private PluginARBodySerializer() {
    }

    static Map<String, Object> convertARBodyToMap(ARBody body) {
        Map<String, Object> result = new HashMap<>();
        result.put("bodyAction", body.getBodyAction());
        result.put("anchors", CommonSerializer.anchorsToList(body.getAnchors()));
        result.put("trackingState", body.getTrackingState().ordinal());
        result.put("bodySkeletonTypes", createIntegerEnumValuesArrayFromBodySkeletonTypes(body.getBodySkeletonType()));
        result.put("skeletonPoint2D", body.getSkeletonPoint2D());
        result.put("skeletonPoint3D", body.getSkeletonPoint3D());
        result.put("skeletonConfidence", body.getSkeletonConfidence());
        result.put("bodySkeletonConnection", body.getBodySkeletonConnection());
        result.put("skeletonPointIsExist2D", body.getSkeletonPointIsExist2D());
        result.put("skeletonPointIsExist3D", body.getSkeletonPointIsExist3D());
        result.put("coordinateSystemType", body.getCoordinateSystemType().getKeyValues());
        result.put("maskConfidence", body.getMaskConfidence());
        result.put("maskDepth", body.getMaskDepth());
        return result;
    }

    private static int[] createIntegerEnumValuesArrayFromBodySkeletonTypes(
        ARBody.ARBodySkeletonType[] bodySkeletonTypes) {
        int[] bodyTypesNumeric = new int[bodySkeletonTypes.length];
        for (int i = 0; i < bodySkeletonTypes.length; ++i) {
            bodyTypesNumeric[i] = bodySkeletonTypes[i].ordinal();
        }
        return bodyTypesNumeric;
    }
}
