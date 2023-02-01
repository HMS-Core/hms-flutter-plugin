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
import android.opengl.Matrix;

import com.huawei.hiar.ARAugmentedImage;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;

import java.nio.FloatBuffer;

public class ImageKeyLineDisplay extends ImageKeyBase {
    private static final String TAG = ImageKeyLineDisplay.class.getSimpleName();

    private static final int INITIAL_BUFFER_POINTS = 150;

    private static final int COORDINATE_DIMENSION = 3;

    private int mVboSize = INITIAL_BUFFER_POINTS * BYTES_PER_POINT;

    private int mModelViewProjectionMatrix;

    private int mVbo;

    private int mNumPoints = 0;

    private ColorRGBA lineColor;

    private float lineWidth;

    public ImageKeyLineDisplay(ColorRGBA lineColor, float lineWidth) {
        this.lineColor = lineColor;
        this.lineWidth = lineWidth;
    }

    /**
     * Create and build the augmented image shader on the OpenGL thread.
     */
    public void init() {
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Init start.");
        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        mVbo = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        createProgram();
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Init end.");
    }

    @Override
    protected void createProgram() {
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Create imageKeyLine program start.");
        super.createProgram();
        mModelViewProjectionMatrix = GLES20.glGetUniformLocation(mProgram, "inMVPMatrix");
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Create imageKeyLine program end.");
    }

    /**
     * Draw the borders of the augmented image.
     *
     * @param augmentedImage AugmentedImage object.
     * @param viewMatrix View matrix.
     * @param projectionMatrix AR camera projection matrix.
     */
    public void onDrawFrame(ARAugmentedImage augmentedImage, float[] viewMatrix, float[] projectionMatrix) {
        float[] vpMatrix = new float[BYTES_PER_POINT];
        Matrix.multiplyMM(vpMatrix, 0, projectionMatrix, 0, viewMatrix, 0);
        draw(augmentedImage, vpMatrix);
    }

    /**
     * Draw borders to augment the image.
     *
     * @param augmentedImage AugmentedImage object.
     * @param viewProjectionMatrix View projection matrix.
     */
    private void draw(ARAugmentedImage augmentedImage, float[] viewProjectionMatrix) {
        cornerPointCoordinates = new float[BYTES_PER_CORNER * 4];
        for (CornerType cornerType : CornerType.values()) {
            createImageCorner(augmentedImage, cornerType);
        }

        updateImageKeyLineData(cornerPointCoordinates);
        drawImageLine(viewProjectionMatrix);
        cornerPointCoordinates = null;
        index = 0;
    }

    private void updateImageKeyLineData(float[] cornerPoints) {
        // Total number of coordinates.
        int mPointsNum = cornerPoints.length / 4;
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        mNumPoints = mPointsNum;
        int vboSize = mVboSize;
        int numPoints = mNumPoints;
        if (vboSize < mNumPoints * BYTES_PER_POINT) {
            while (vboSize < numPoints * BYTES_PER_POINT) {
                // If the size of VBO is insufficient to accommodate the new vertex, resize the VBO.
                vboSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, vboSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        FloatBuffer cornerPointBuffer = FloatBuffer.wrap(cornerPoints);
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, numPoints * BYTES_PER_POINT, cornerPointBuffer);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
    }

    /**
     * Draw the image border.
     *
     * @param viewProjectionMatrix View projection matrix.
     */
    private void drawImageLine(float[] viewProjectionMatrix) {
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Draw image box start.");
        GLES20.glUseProgram(mProgram);
        GLES20.glEnableVertexAttribArray(mPosition);
        GLES20.glEnableVertexAttribArray(mColor);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        GLES20.glVertexAttribPointer(mPosition, COORDINATE_DIMENSION, GLES20.GL_FLOAT, false, BYTES_PER_POINT, 0);
        GLES20.glUniform4f(mColor, lineColor.red, lineColor.green, lineColor.blue, lineColor.alpha);
        GLES20.glUniformMatrix4fv(mModelViewProjectionMatrix, 1, false, viewProjectionMatrix, 0);

        // Set the width of a rendering stroke.
        GLES20.glLineWidth(lineWidth);
        GLES20.glDrawArrays(GLES20.GL_LINE_LOOP, 0, mNumPoints);
        GLES20.glDisableVertexAttribArray(mPosition);
        GLES20.glDisableVertexAttribArray(mColor);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "ImageKeyLine Draw image box end.");
    }
}
