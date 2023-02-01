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
import com.huawei.hiar.ARBody;
import com.huawei.hiar.ARFace;
import com.huawei.hiar.ARHand;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARTarget;
import com.huawei.hiar.ARTrackable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class PluginARTrackableSerializer {
    private PluginARTrackableSerializer() {
    }

    public static List<Map<String, Object>> serialize(Collection<ARTrackable> arTrackableCollection) {
        List<Map<String, Object>> arTrackableJsonArray = new ArrayList<>();
        for (ARTrackable arTrackable : arTrackableCollection) {
            arTrackableJsonArray.add(serialize(arTrackable));
        }
        return arTrackableJsonArray;
    }

    public static Map<String, Object> serialize(ARTrackable arTrackable) {
        if (arTrackable instanceof ARFace) {
            return PluginARFaceSerializer.convertARFaceToMap((ARFace) arTrackable);
        } else if (arTrackable instanceof ARHand) {
            return PluginARHandSerializer.convertARHandToMap((ARHand) arTrackable);
        } else if (arTrackable instanceof ARPlane) {
            return PluginARPlaneSerializer.convertARPlaneToMap((ARPlane) arTrackable);
        } else if (arTrackable instanceof ARBody) {
            return PluginARBodySerializer.convertARBodyToMap((ARBody) arTrackable);
        } else if (arTrackable instanceof ARTarget) {
            return PluginARTargetSerializer.convertARTargetToMap((ARTarget) arTrackable);
        } else if (arTrackable instanceof ARAugmentedImage) {
            return PluginARAugmentedImageSerializer.convertARAugmentedImageToMap((ARAugmentedImage) arTrackable);
        } else {
            return Collections.emptyMap();
        }
    }
}
