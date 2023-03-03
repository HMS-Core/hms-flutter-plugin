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

import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureSkeleton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToJson {
    public static ArrayList<Map<String, Object>> modeling3dMotionCaptureSkeletonListToJSON(List<Modeling3dMotionCaptureSkeleton> modeling3dMotionCaptureSkeletons) {
        ArrayList<Map<String, Object>> modeling3dMotionCaptureSkeletonList = new ArrayList<>();
        for (int i = 0; i < modeling3dMotionCaptureSkeletons.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            Modeling3dMotionCaptureSkeleton modeling3dMotionCaptureSkeleton = modeling3dMotionCaptureSkeletons.get(i);
            map.put("itemIdentity", modeling3dMotionCaptureSkeleton.getItemIdentity());
            map.put("jointQuaternions", ToList.jointQuaternionsToList(modeling3dMotionCaptureSkeleton.getJointQuaternions()));
            map.put("joints", ToList.jointsToList(modeling3dMotionCaptureSkeleton.getJoints()));
            map.put("jointShift", modeling3dMotionCaptureSkeleton.getJointShift());
            modeling3dMotionCaptureSkeletonList.add(map);
        }
        return modeling3dMotionCaptureSkeletonList;
    }
}
