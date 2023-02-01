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

import android.opengl.Matrix;

import java.math.BigDecimal;

public final class MatrixUtil {
    private static final int MATRIX_SIZE = 16;

    private MatrixUtil() {
    }

    public static void getProjectionMatrix(float[] matrix, int width, int height) {
        if (height <= 0 || width <= 0) {
            return;
        }

        float[] projection = new float[MATRIX_SIZE];
        float[] camera = new float[MATRIX_SIZE];

        Matrix.orthoM(projection, 0, -1, 1, -1, 1, 1, 3);
        Matrix.setLookAtM(camera, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0);
        Matrix.multiplyMM(matrix, 0, projection, 0, camera, 0);
    }

    public static void normalizeVec3(float[] vector) {
        BigDecimal result = BigDecimal.valueOf(
            Math.sqrt(vector[0] * vector[0] + vector[1] * vector[1] + vector[2] * vector[2]));
        float length = new BigDecimal("1.0").divide(result, BigDecimal.ROUND_CEILING).floatValue();
        vector[0] *= length;
        vector[1] *= length;
        vector[2] *= length;
    }

    public static float[] getIdentityMatrix() {
        return new float[] {
            1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
        };
    }
}
