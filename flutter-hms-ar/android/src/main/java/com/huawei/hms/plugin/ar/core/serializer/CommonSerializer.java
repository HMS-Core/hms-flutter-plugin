/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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
import com.huawei.hiar.ARPose;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class CommonSerializer {
    private CommonSerializer() {
    }

    static Map<String, Object> arPoseToMap(ARPose pose) {
        Map<String, Object> jsonMap = new HashMap<>();
        float[] translation = new float[3];
        float[] rotation = new float[4];
        pose.getTranslation(translation, 0);
        pose.getRotationQuaternion(rotation, 0);
        jsonMap.put("translation", translation);
        jsonMap.put("rotation", rotation);
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
}
