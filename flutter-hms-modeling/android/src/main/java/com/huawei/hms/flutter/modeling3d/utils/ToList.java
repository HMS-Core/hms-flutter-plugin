/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.modeling3d.utils;

import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureJoint;
import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureQuaternion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToList {
    public static List<Map<String, Object>> jointQuaternionsToList(List<Modeling3dMotionCaptureQuaternion> jointQuaternionsList) {
        List<Map<String, Object>> jointQuaternionsCollection = new ArrayList<>();
        for (Modeling3dMotionCaptureQuaternion jointQuaternions : jointQuaternionsList) {
            Map<String, Object> jsonMap = new HashMap<>();
            jsonMap.put("pointW", jointQuaternions.getPointW());
            jsonMap.put("pointX", jointQuaternions.getPointX());
            jsonMap.put("pointY", jointQuaternions.getPointY());
            jsonMap.put("pointZ", jointQuaternions.getPointZ());
            jsonMap.put("type", jointQuaternions.getType());
            jointQuaternionsCollection.add(jsonMap);
        }
        return jointQuaternionsCollection;
    }

    public static List<Map<String, Object>> jointsToList(List<Modeling3dMotionCaptureJoint> modeling3dMotionCaptureJoints) {
        List<Map<String, Object>> jointsCollection = new ArrayList<>();
        for (Modeling3dMotionCaptureJoint joins : modeling3dMotionCaptureJoints) {
            Map<String, Object> jsonMap = new HashMap<>();
            jsonMap.put("pointX", joins.getPointX());
            jsonMap.put("pointY", joins.getPointY());
            jsonMap.put("pointZ", joins.getPointZ());
            jsonMap.put("type", joins.getType());
            jointsCollection.add(jsonMap);
        }
        return jointsCollection;
    }
}
