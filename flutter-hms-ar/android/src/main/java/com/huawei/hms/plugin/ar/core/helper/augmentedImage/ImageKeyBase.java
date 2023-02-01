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

package com.huawei.hms.plugin.ar.core.helper.augmentedImage;

import android.opengl.GLES20;

import com.huawei.hiar.ARAugmentedImage;
import com.huawei.hiar.ARPose;

public class ImageKeyBase {
    protected static final int BYTES_PER_CORNER = 4;

    /**
     * 3D coordinates. The coordinates have four components (x, y, z, and alpha).
     * One float occupies 4 bytes.
     */
    protected static final int BYTES_PER_POINT = 4 * 4;

    /**
     * 0.5 indicates half of the edge length.
     * The four corners of an image can be obtained by using this parameter and the enums.
     */
    private static final float[] COEFFICIENTS = {0.5f, 0.5f};

    protected int mProgram;

    protected int mPosition;

    protected int mColor;

    protected int index = 0;

    protected float[] cornerPointCoordinates;

    protected void createProgram() {
        mProgram = ImageShaderUtil.getImageKeyMsgProgram();
        mPosition = GLES20.glGetAttribLocation(mProgram, "inPosition");
        mColor = GLES20.glGetUniformLocation(mProgram, "inColor");
    }

    /**
     * Obtain the vertex coordinates of the four corners of the augmented image and
     * write them to the cornerPointCoordinates array.
     *
     * @param augmentedImage Augmented image object.
     * @param cornerType Corner type.
     */
    protected void createImageCorner(ARAugmentedImage augmentedImage, CornerType cornerType) {
        ARPose localBoundaryPose;
        float[] coefficient = new float[COEFFICIENTS.length];
        switch (cornerType) {
            case LOWER_RIGHT:
                generateCoefficent(coefficient, 1, 1);
                break;
            case UPPER_LEFT:
                generateCoefficent(coefficient, -1, -1);
                break;
            case UPPER_RIGHT:
                generateCoefficent(coefficient, 1, -1);
                break;
            case LOWER_LEFT:
                generateCoefficent(coefficient, -1, 1);
                break;
            default:
                break;
        }

        localBoundaryPose = ARPose.makeTranslation(coefficient[0] * augmentedImage.getExtentX(), 0.0f,
            coefficient[1] * augmentedImage.getExtentZ());

        ARPose centerPose = augmentedImage.getCenterPose();
        ARPose composeCenterPose;
        int cornerCoordinatePos = index * BYTES_PER_CORNER;
        composeCenterPose = centerPose.compose(localBoundaryPose);
        cornerPointCoordinates[cornerCoordinatePos] = composeCenterPose.tx();
        cornerPointCoordinates[cornerCoordinatePos + 1] = composeCenterPose.ty();
        cornerPointCoordinates[cornerCoordinatePos + 2] = composeCenterPose.tz();
        cornerPointCoordinates[cornerCoordinatePos + 3] = 1.0f;
        index++;
    }

    private void generateCoefficent(float[] coefficient, int coefficentX, int coefficentZ) {
        for (int i = 0; i < coefficient.length; i += 2) {
            coefficient[i] = coefficentX * COEFFICIENTS[i];
            coefficient[i + 1] = coefficentZ * COEFFICIENTS[i + 1];
        }
    }
}
