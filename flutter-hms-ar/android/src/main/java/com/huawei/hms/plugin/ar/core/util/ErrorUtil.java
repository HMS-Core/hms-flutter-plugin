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

import android.opengl.GLES20;
import android.util.Log;

import com.huawei.hms.plugin.ar.core.helper.ArDemoRuntimeException;

public final class ErrorUtil {
    private static final String TAG = ErrorUtil.class.getSimpleName();

    private ErrorUtil() {
    }

    public static void checkGLError(String tag, String label) {
        int lastError = GLES20.GL_NO_ERROR;
        int error = GLES20.glGetError();

        while (error != GLES20.GL_NO_ERROR) {
            Log.e(TAG, label + " : checkGLError : " + error);
            lastError = error;
            error = GLES20.glGetError();
        }

        if (lastError != GLES20.GL_NO_ERROR) {
            throw new ArDemoRuntimeException(label + ": glError :" + lastError);
        }
    }
}
