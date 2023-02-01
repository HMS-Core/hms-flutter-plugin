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

import com.huawei.hiar.ARAugmentedImage;

import java.util.HashMap;
import java.util.Map;

class PluginARAugmentedImageSerializer {
    private PluginARAugmentedImageSerializer() {
    }

    static Map<String, Object> convertARAugmentedImageToMap(ARAugmentedImage target) {
        Map<String, Object> result = new HashMap<>();
        result.put("anchors", CommonSerializer.anchorsToList(target.getAnchors()));
        result.put("centerPose", CommonSerializer.arPoseToMap(target.getCenterPose()));
        result.put("extentX", target.getExtentX());
        result.put("extentZ", target.getExtentZ());
        result.put("index", target.getIndex());
        result.put("name", target.getName());
        result.put("trackingState", target.getTrackingState().ordinal());
        return result;
    }
}
