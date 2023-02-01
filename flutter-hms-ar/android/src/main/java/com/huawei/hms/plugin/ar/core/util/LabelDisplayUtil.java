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

package com.huawei.hms.plugin.ar.core.util;

import android.util.Log;

import com.huawei.hiar.ARPose;

public class LabelDisplayUtil {
    private static final String TAG = LabelDisplayUtil.class.getSimpleName();

    private static final int INDEX_X = 0;

    private static final int INDEX_Y = 1;

    private static final int INDEX_Z = 2;

    private static final int DOUBLE_NUM = 2;

    private static final int QUATERNION_SIZE = 4;

    private static final float VERTICAL_INFO_PLANE = 90.0f;

    private static final float STRAIGHT_ANGLE = 180.0f;

    private static final float SOUTH_POLE_SINGULARITY = -1.0f;

    private static final float NORTH_POLE_SINGULARITY = 1.0f;

    private static final float GIMBAL_LOCK_NUM = 0.0000001f;

    /**
     * Obtains the AR pose rotation quaternion, x, y, z, and w.
     *
     * @param cameraDisplayPose Pose of the camera in the world coordinate system.
     * @param angle Rotation radian of the z axis.
     * @return Obtained rotation quaternion.
     */
    public static float[] getMeasureQuaternion(ARPose cameraDisplayPose, float angle) {
        float[] measureQuaternion = null;
        if (cameraDisplayPose == null) {
            Log.e(TAG, "cameraDisplayPose is null!");
            return measureQuaternion;
        }
        ARPose camRot = cameraDisplayPose.extractRotation();
        if (camRot == null) {
            Log.e(TAG, "getMeasureQuaternion camRot null!");
            return measureQuaternion;
        }
        float[] camEul = getEulerAngles(camRot);

        float perRad = STRAIGHT_ANGLE / (float) Math.PI;
        float anglesX = VERTICAL_INFO_PLANE / perRad - camEul[1] / DOUBLE_NUM;
        float anglesY = (camEul[0] * perRad) / perRad;
        float anglesZ = angle / perRad;
        float qx = (float) Math.sin(anglesY / DOUBLE_NUM) * (float) Math.sin(anglesZ / DOUBLE_NUM) * (float) Math.cos(
            anglesX / DOUBLE_NUM) + (float) Math.cos(anglesY / DOUBLE_NUM) * (float) Math.cos(anglesZ / DOUBLE_NUM)
            * (float) Math.sin(anglesX / DOUBLE_NUM);
        float qy = (float) Math.sin(anglesY / DOUBLE_NUM) * (float) Math.cos(anglesZ / DOUBLE_NUM) * (float) Math.cos(
            anglesX / DOUBLE_NUM) + (float) Math.cos(anglesY / DOUBLE_NUM) * (float) Math.sin(anglesZ / DOUBLE_NUM)
            * (float) Math.sin(anglesX / DOUBLE_NUM);
        float qz = (float) Math.cos(anglesY / DOUBLE_NUM) * (float) Math.sin(anglesZ / DOUBLE_NUM) * (float) Math.cos(
            anglesX / DOUBLE_NUM) - (float) Math.sin(anglesY / DOUBLE_NUM) * (float) Math.cos(anglesZ / DOUBLE_NUM)
            * (float) Math.sin(anglesX / DOUBLE_NUM);
        float qw = (float) Math.cos(anglesY / DOUBLE_NUM) * (float) Math.cos(anglesZ / DOUBLE_NUM) * (float) Math.cos(
            anglesX / DOUBLE_NUM) - (float) Math.sin(anglesY / DOUBLE_NUM) * (float) Math.sin(anglesZ / DOUBLE_NUM)
            * (float) Math.sin(anglesX / DOUBLE_NUM);

        float[] verticalQuaternion = {qx, qy, qz, qw};
        ARPose verticalPose = ARPose.makeRotation(verticalQuaternion);
        measureQuaternion = new float[QUATERNION_SIZE];

        verticalPose.getRotationQuaternion(measureQuaternion, 0);
        return measureQuaternion;
    }

    /**
     * Calculate the Euler angle.
     *
     * @param pose Pose of the target.
     * @return Euler angle of the target in the world coordinate system.
     */
    private static float[] getEulerAngles(ARPose pose) {
        float[] quaternion = {pose.qx(), pose.qy(), pose.qz()};
        float quaternionW = pose.qw();
        float squareW = quaternionW * quaternionW;
        float squareY = quaternion[INDEX_Y] * quaternion[INDEX_Y];
        float squareX = quaternion[INDEX_X] * quaternion[INDEX_X];
        float squareZ = quaternion[INDEX_Z] * quaternion[INDEX_Z];

        float psign = -DOUBLE_NUM * (-quaternionW * quaternion[INDEX_X] + quaternion[INDEX_Y] * quaternion[INDEX_Z]);
        float pitch;
        float yaw;
        float roll;

        if (psign < SOUTH_POLE_SINGULARITY + GIMBAL_LOCK_NUM) {
            // Antarctic singularity.
            yaw = 0.0f;
            pitch = -(float) Math.PI;
            roll = (float) Math.atan2(
                DOUBLE_NUM * (-quaternion[INDEX_Y] * quaternion[INDEX_X] + quaternionW * quaternion[INDEX_Z]),
                squareW + squareX - squareY - squareZ);
        } else if (psign > NORTH_POLE_SINGULARITY - GIMBAL_LOCK_NUM) {
            // Arctic singularity.
            yaw = 0.0f;
            pitch = (float) Math.PI * DOUBLE_NUM;
            roll = (float) Math.atan2(
                DOUBLE_NUM * (-quaternion[INDEX_Y] * quaternion[INDEX_X] + quaternionW * quaternion[INDEX_Z]),
                squareW + squareX - squareY - squareZ);
        } else {
            yaw = -(float) Math.atan2(
                -DOUBLE_NUM * (quaternionW * quaternion[INDEX_Y] + quaternion[INDEX_X] * quaternion[INDEX_Z]),
                squareW + squareZ - squareY - squareX);
            pitch = (float) Math.asin(psign);
            roll = (float) Math.atan2(
                DOUBLE_NUM * (quaternionW * quaternion[INDEX_Z] + quaternion[INDEX_Y] * quaternion[INDEX_X]),
                squareW + squareY - squareX - squareZ);
        }

        return new float[] {yaw, pitch, roll};
    }
}
