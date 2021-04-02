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

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.skeleton.MLJoint;
import com.huawei.hms.mlsdk.skeleton.MLSkeleton;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SkeletonToJson {
    public static JSONObject skeletonJSON(@NonNull MLSkeleton skeleton) {
        Map<String, Object> map = new HashMap<>();
        map.put("joints", jointToJSONArray(skeleton.getJoints()));
        return new JSONObject(map);
    }

    public static JSONArray skeletonToJSONArray(@NonNull List<MLSkeleton> list) {
        ArrayList<Map<String, Object>> skeletonList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLSkeleton skeleton = list.get(i);
            map.put("joints", jointToJSONArray(skeleton.getJoints()));
            skeletonList.add(map);
        }
        return new JSONArray(skeletonList);
    }

    public static JSONArray jointToJSONArray(@NonNull List<MLJoint> list) {
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
        return new JSONArray(jointList);
    }
}
