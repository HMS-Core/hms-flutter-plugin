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
import com.huawei.hiar.ARPose;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;

import java.nio.FloatBuffer;

public class ImageKeyPointDisplay extends ImageKeyBase {

    private static final String TAG = ImageKeyPointDisplay.class.getSimpleName();

    private static final int INITIAL_POINTS_SIZE = 20;

    private float[] centerPointCoordinates;

    private float[] allPointCoordinates;

    private int mVbo;

    private int mVboSize;

    private int mMvpMatrix;

    private int mPointSize;

    private int mNumPoints;

    private ColorRGBA pointColor;

    private float pointSize;

    public ImageKeyPointDisplay(ColorRGBA pointColor, float pointSize) {
        this.pointColor = pointColor;
        this.pointSize = pointSize;
    }

    /**
     * Create and build shaders for image keypoints on the OpenGL thread.
     */
    public void init() {
        ErrorUtil.checkGLError(TAG, "ImageKeyPoint Init start.");
        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        mVbo = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        mVboSize = INITIAL_POINTS_SIZE * BYTES_PER_POINT;
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        createProgram();
        ErrorUtil.checkGLError(TAG, "ImageKeyPoint Init end.");
    }

    @Override
    protected void createProgram() {
        ErrorUtil.checkGLError(TAG, "ImageKeyPoint Create gl program start.");
        super.createProgram();
        mPointSize = GLES20.glGetUniformLocation(mProgram, "inPointSize");
        mMvpMatrix = GLES20.glGetUniformLocation(mProgram, "inMVPMatrix");
        ErrorUtil.checkGLError(TAG, "ImageKeyPoint Create program end.");
    }

    /**
     * Draw image key points to augment the image.
     *
     * @param augmentedImage Image to be augmented.
     * @param viewMatrix View matrix.
     * @param projectionMatrix Projection matrix.
     */
    public void onDrawFrame(ARAugmentedImage augmentedImage, float[] viewMatrix, float[] projectionMatrix) {
        float[] vpMatrix = new float[BYTES_PER_POINT];
        Matrix.multiplyMM(vpMatrix, 0, projectionMatrix, 0, viewMatrix, 0);
        draw(augmentedImage, vpMatrix);
    }

    private void draw(ARAugmentedImage augmentedImage, float[] viewProjectionMatrix) {
        createImageCenterPoint(augmentedImage);
        updateImageAllPoints(centerPointCoordinates);

        cornerPointCoordinates = new float[BYTES_PER_CORNER * 4];
        for (CornerType cornerType : CornerType.values()) {
            createImageCorner(augmentedImage, cornerType);
        }
        mergeArray(centerPointCoordinates, cornerPointCoordinates);

        updateImageAllPoints(allPointCoordinates);
        drawImageKeyPoint(viewProjectionMatrix);
        cornerPointCoordinates = null;
        index = 0;
    }

    /**
     * Obtain the coordinates of the center of the recognized image and
     * write the coordinates to the centerPointCoordinates array.
     *
     * @param augmentedImage Augmented image object.
     */
    private void createImageCenterPoint(ARAugmentedImage augmentedImage) {
        centerPointCoordinates = new float[4];
        ARPose centerPose = augmentedImage.getCenterPose();
        centerPointCoordinates[0] = centerPose.tx();
        centerPointCoordinates[1] = centerPose.ty();
        centerPointCoordinates[2] = centerPose.tz();
        centerPointCoordinates[3] = 1.0f;
    }

    /**
     * Combine the obtained central coordinate array and vertex coordinate array
     * into an allPointCoordinates array.
     *
     * @param centerCoordinates Center coordinate array.
     * @param cornerCoordinates Four-corner coordinate array.
     */
    private void mergeArray(float[] centerCoordinates, float[] cornerCoordinates) {
        allPointCoordinates = new float[centerCoordinates.length + cornerCoordinates.length];
        System.arraycopy(centerCoordinates, 0, allPointCoordinates, 0, centerCoordinates.length);
        System.arraycopy(cornerCoordinates, 0, allPointCoordinates, centerCoordinates.length, cornerCoordinates.length);
    }

    /**
     * Update the key point information of the augmented image.
     *
     * @param cornerPoints Array of key points of the augmented image,
     * including the four vertexes and center.
     */
    private void updateImageAllPoints(float[] cornerPoints) {
        ErrorUtil.checkGLError(TAG, "Update image key point data start.");
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
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, mNumPoints * BYTES_PER_POINT, cornerPointBuffer);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "Update image key point data end.");
    }

    private void drawImageKeyPoint(float[] viewProjectionMatrix) {
        ErrorUtil.checkGLError(TAG, "Draw image key point start.");
        GLES20.glUseProgram(mProgram);
        GLES20.glEnableVertexAttribArray(mPosition);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        GLES20.glVertexAttribPointer(mPosition, 4, GLES20.GL_FLOAT, false, BYTES_PER_POINT, 0);

        // Set the color of key points.
        GLES20.glUniform4f(mColor, pointColor.red, pointColor.green, pointColor.blue, pointColor.alpha);
        GLES20.glUniformMatrix4fv(mMvpMatrix, 1, false, viewProjectionMatrix, 0);

        // Set the size of the key points of the image.
        GLES20.glUniform1f(mPointSize, pointSize);
        GLES20.glDrawArrays(GLES20.GL_POINTS, 0, mNumPoints);
        GLES20.glDisableVertexAttribArray(mPosition);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Draw image key point end.");
    }
}