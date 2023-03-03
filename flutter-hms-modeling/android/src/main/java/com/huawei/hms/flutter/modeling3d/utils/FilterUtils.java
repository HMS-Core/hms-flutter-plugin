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
import java.util.List;

public class FilterUtils {
    public static List<List<Float>> filterDataQuaternions(Modeling3dMotionCaptureSkeleton fromData) {
        List<List<Float>> quaternions = new ArrayList<>();
        for (int n = 0; n < fromData.getJointQuaternions().size(); n++) {
            List<Float> rotParcelList = new ArrayList<>();
            rotParcelList.add(fromData.getJointQuaternions().get(n).getPointW());
            rotParcelList.add(fromData.getJointQuaternions().get(n).getPointX());
            rotParcelList.add(fromData.getJointQuaternions().get(n).getPointY());
            rotParcelList.add(fromData.getJointQuaternions().get(n).getPointZ());
            quaternions.add(rotParcelList);
        }
        return quaternions;
    }

    public static List<Float> filterDataJointShift(Modeling3dMotionCaptureSkeleton fromData) {
        if (fromData.getJointShift() != null) {
            return fromData.getJointShift();
        }
        return new ArrayList<>();
    }

    public static List<List<Float>> filterDataJoints3ds(Modeling3dMotionCaptureSkeleton fromData) {
        List<List<Float>> joints3ds = new ArrayList<>();
        for (int j = 0; j < fromData.getJoints().size(); j++) {
            List<Float> jointParcelList = new ArrayList<>();
            jointParcelList.add(fromData.getJoints().get(j).getPointX());
            jointParcelList.add(fromData.getJoints().get(j).getPointY());
            jointParcelList.add(fromData.getJoints().get(j).getPointZ());
            joints3ds.add(jointParcelList);
        }
        return joints3ds;
    }
}
