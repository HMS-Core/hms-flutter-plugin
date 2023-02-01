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

import com.huawei.hiar.ARHand;

import java.util.HashMap;
import java.util.Map;

class PluginARHandSerializer {
    private PluginARHandSerializer() {
    }

    static Map<String, Object> convertARHandToMap(ARHand hand) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("handType", hand.getHandtype().getKeyValues());
        resultMap.put("handSkeletonArray", hand.getHandskeletonArray());
        resultMap.put("handSkeletonConnection", hand.getHandSkeletonConnection());
        resultMap.put("handSkeletonTypes", hand.getHandskeletonTypes());
        resultMap.put("anchors", CommonSerializer.anchorsToList(hand.getAnchors()));
        resultMap.put("gestureType", hand.getGestureType());
        resultMap.put("gestureHandBox", hand.getGestureHandBox());
        resultMap.put("gestureCenter", hand.getGestureCenter());
        resultMap.put("gestureCoordinateSystem", hand.getGestureCoordinateSystem().getKeyValues());
        resultMap.put("skeletonCoordinateSystem", hand.getSkeletonCoordinateSystem().getKeyValues());
        resultMap.put("trackingState", hand.getTrackingState().ordinal());
        return resultMap;
    }
}
