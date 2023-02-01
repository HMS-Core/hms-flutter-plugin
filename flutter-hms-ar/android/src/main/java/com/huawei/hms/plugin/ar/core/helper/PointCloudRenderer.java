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

package com.huawei.hms.plugin.ar.core.helper;

import android.content.Context;
import android.opengl.GLES20;
import android.opengl.Matrix;

import com.huawei.hiar.ARPointCloud;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.WorldShaderUtil;

public class PointCloudRenderer {
    private static final String TAG = ARPointCloud.class.getSimpleName();

    private static final int POSITION_COMPONENTS_NUMBERS = 4;

    private static final int BYTES_FLOAT = Float.SIZE / 8;

    private static final int FLOATS_POINT = 4; // X,Y,Z,confidence.

    private static final int BYTES_POINT = BYTES_FLOAT * FLOATS_POINT;

    private static final int INITIAL_BUFFER_POINT_SIZE = 1000;

    private int mProgramName;

    private int mPointBuffer;

    private int mPointBufferSize;

    private int mPositionAttribute;

    private int mViewProjectionUniform;

    private int mPointUniform;

    private int mColorUniform;

    private int mNumPoints = 0;

    private ARPointCloud mPointCloud = null;

    /**
     * Constructor.
     */
    public PointCloudRenderer() {
    }

    /**
     * Allocates and initializes OpenGL resources needed by the plane renderer. Must be
     * called on the OpenGL thread, typically in
     *
     * @param context Needed to access shader source.
     */
    public void init(Context context) {
        ErrorUtil.checkGLError(TAG, "PointCloud before create");

        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        mPointBuffer = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mPointBuffer);

        mPointBufferSize = INITIAL_BUFFER_POINT_SIZE * BYTES_POINT;
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mPointBufferSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "PointCloud buffer alloc");

        mProgramName = WorldShaderUtil.getPointCloudProgram();
        GLES20.glUseProgram(mProgramName);

        ErrorUtil.checkGLError(TAG, "PointCloud program");

        mPositionAttribute = GLES20.glGetAttribLocation(mProgramName, "a_Position");
        mColorUniform = GLES20.glGetUniformLocation(mProgramName, "u_Color");
        mViewProjectionUniform = GLES20.glGetUniformLocation(mProgramName, "u_ModelViewProjection");
        mPointUniform = GLES20.glGetUniformLocation(mProgramName, "u_PointSize");
        ErrorUtil.checkGLError(TAG, "PointCloud program params");
    }

    /**
     * Update point cloud data in buffer and setting up input data in shader program and drawing, when draw the point.
     *
     * @param cloud Data types defined by HW(ARPointCloud).
     * @param cameraView Camera view data.
     * @param cameraPerspective Camera perspective data.
     */
    public void onDrawFrame(ARPointCloud cloud, float[] cameraView, float[] cameraPerspective) {
        ErrorUtil.checkGLError(TAG, "PointCloud start update");
        if (mPointCloud == cloud) {
            return;
        }
        ErrorUtil.checkGLError(TAG, "PointCloud before update");
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mPointBuffer);
        mPointCloud = cloud;

        mNumPoints = mPointCloud.getPoints().remaining() / FLOATS_POINT;
        if (mPointBufferSize < mNumPoints * BYTES_POINT) {
            while (mPointBufferSize < mNumPoints * BYTES_POINT) {
                mPointBufferSize *= 2; // If vertice VBO size is not big enough ,double it.
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mPointBufferSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, mNumPoints * BYTES_POINT, mPointCloud.getPoints());
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "PointCloud end update and before draw");
        float[] modelViewProjection = new float[16];
        Matrix.multiplyMM(modelViewProjection, 0, cameraPerspective, 0, cameraView, 0);

        GLES20.glUseProgram(mProgramName);
        GLES20.glEnableVertexAttribArray(mPositionAttribute);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mPointBuffer);
        GLES20.glVertexAttribPointer(mPositionAttribute, POSITION_COMPONENTS_NUMBERS, GLES20.GL_FLOAT, false,
            BYTES_POINT, 0);
        GLES20.glUniform4f(mColorUniform, 255.0f / 255.0f, 241.0f / 255.0f, 67.0f / 255.0f, 1.0f);
        GLES20.glUniformMatrix4fv(mViewProjectionUniform, 1, false, modelViewProjection, 0);
        GLES20.glUniform1f(mPointUniform, 10.0f); // Set the size of Point to 10.

        GLES20.glDrawArrays(GLES20.GL_POINTS, 0, mNumPoints);
        GLES20.glDisableVertexAttribArray(mPositionAttribute);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "PointCloud after draw");
    }
}