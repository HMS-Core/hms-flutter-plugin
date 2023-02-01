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

package com.huawei.hms.plugin.ar.core.helper.hand;

import android.opengl.GLES20;
import android.util.Log;

import com.huawei.hiar.ARHand;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.HandShaderUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;

import java.nio.FloatBuffer;
import java.util.Collection;

public class HandSkeletonDisplay {
    private static final String TAG = HandSkeletonDisplay.class.getSimpleName();

    private static final int BYTES_PER_POINT = 4 * 3;

    private static final int INITIAL_POINTS_SIZE = 150;

    private int mVbo;

    private int mVboSize;

    private int mProgram;

    private int mPosition;

    private int mModelViewProjectionMatrix;

    private int mColor;

    private int mPointSize;

    private int mNumPoints = 0;

    private ARPluginConfigHand configBase = new ARPluginConfigHand();

    public HandSkeletonDisplay(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigHand) {
            this.configBase = (ARPluginConfigHand) configBase;
        }
    }

    public void init() {
        ErrorUtil.checkGLError(TAG, "HandSkeleton Init start.");
        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        mVbo = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        mVboSize = INITIAL_POINTS_SIZE * BYTES_PER_POINT;
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        createProgram();
        ErrorUtil.checkGLError(TAG, "HandSkeleton Init end.");
    }

    private void createProgram() {
        ErrorUtil.checkGLError(TAG, "HandSkeleton Create program start.");
        mProgram = OpenGLUtil.createGlProgram(HandShaderUtil.HAND_VERTEX, HandShaderUtil.HAND_FRAGMENT);
        ErrorUtil.checkGLError(TAG, "HandSkeleton program");
        mPosition = GLES20.glGetAttribLocation(mProgram, "inPosition");
        mColor = GLES20.glGetUniformLocation(mProgram, "inColor");
        mPointSize = GLES20.glGetUniformLocation(mProgram, "inPointSize");
        mModelViewProjectionMatrix = GLES20.glGetUniformLocation(mProgram, "inMVPMatrix");
        ErrorUtil.checkGLError(TAG, "HandSkeleton Create program end.");
    }

    public void onDrawFrame(Collection<ARHand> hands, float[] projectionMatrix) {
        // Verify external input. If the hand data is empty, the projection matrix is empty,
        // or the projection matrix is not 4 x 4, rendering is not performed.
        if (hands.isEmpty() || projectionMatrix == null || projectionMatrix.length != 16) {
            Log.e(TAG, "onDrawFrame Illegal external input!");
            return;
        }
        for (ARHand hand : hands) {
            float[] handSkeletons = hand.getHandskeletonArray();
            if (handSkeletons.length == 0) {
                continue;
            }
            updateHandSkeletonsData(handSkeletons);
            drawHandSkeletons(projectionMatrix);
        }
    }

    /**
     * Update the coordinates of hand skeleton points.
     *
     * @param handSkeletons hand skeletons data.
     */
    private void updateHandSkeletonsData(float[] handSkeletons) {
        ErrorUtil.checkGLError(TAG, "Update hand skeletons data start.");

        // Each point has a 3D coordinate. The total number of coordinates
        // is three times the number of skeleton points.
        int mPointsNum = handSkeletons.length / 3;
        Log.d(TAG, "ARHand HandSkeletonNumber = " + mPointsNum);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        mNumPoints = mPointsNum;
        if (mVboSize < mNumPoints * BYTES_PER_POINT) {
            while (mVboSize < mNumPoints * BYTES_PER_POINT) {
                // If the size of VBO is insufficient to accommodate the new point cloud, resize the VBO.
                mVboSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        FloatBuffer mSkeletonPoints = FloatBuffer.wrap(handSkeletons);
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, mNumPoints * BYTES_PER_POINT, mSkeletonPoints);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "Update hand skeletons data end.");
    }

    /**
     * Draw hand skeleton points.
     *
     * @param projectionMatrix Projection matrix.
     */
    private void drawHandSkeletons(float[] projectionMatrix) {
        ErrorUtil.checkGLError(TAG, "Draw hand skeletons start.");
        GLES20.glUseProgram(mProgram);
        GLES20.glEnableVertexAttribArray(mPosition);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);

        // The size of the vertex attribute is 4, and each vertex has four coordinate components
        GLES20.glVertexAttribPointer(mPosition, 4, GLES20.GL_FLOAT, false, BYTES_PER_POINT, 0);

        ColorRGBA pointColor = configBase.getPointColor();
        GLES20.glUniform4f(mColor, pointColor.red, pointColor.green, pointColor.blue, pointColor.alpha);
        GLES20.glUniformMatrix4fv(mModelViewProjectionMatrix, 1, false, projectionMatrix, 0);

        // Set the size of the skeleton points.
        GLES20.glUniform1f(mPointSize, configBase.getPointSize());

        GLES20.glDrawArrays(GLES20.GL_POINTS, 0, mNumPoints);
        GLES20.glDisableVertexAttribArray(mPosition);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "Draw hand skeletons end.");
    }
}