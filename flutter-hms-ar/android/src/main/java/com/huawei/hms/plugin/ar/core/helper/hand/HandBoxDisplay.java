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
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.HandShaderUtil;
import com.huawei.hms.plugin.ar.core.util.MatrixUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;

import java.nio.FloatBuffer;
import java.util.Arrays;
import java.util.Collection;

public class HandBoxDisplay {
    private static final String TAG = HandBoxDisplay.class.getSimpleName();

    private static final int BYTES_PER_POINT = 4 * 3;

    private static final int INITIAL_BUFFER_POINTS = 150;

    private static final int COORDINATE_DIMENSION = 3;

    private int vbo;

    private int vboSize = INITIAL_BUFFER_POINTS * BYTES_PER_POINT;

    private int program;

    private int position;

    private int color;

    private int modelViewProjectionMatrix;

    private int pointSize;

    private int numPoints = 0;

    private float[] mvpMatrix;

    private ARPluginConfigHand configHand = new ARPluginConfigHand();

    public HandBoxDisplay(ARPluginConfigBase arPluginConfigHand) {
        if (arPluginConfigHand instanceof ARPluginConfigHand) {
            this.configHand = (ARPluginConfigHand) arPluginConfigHand;
        }
    }

    public void init() {
        ErrorUtil.checkGLError(TAG, "Init start.");
        mvpMatrix = MatrixUtil.getIdentityMatrix();
        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        vbo = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, vbo);

        createProgram();
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, vboSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Init end.");
    }

    private void createProgram() {
        ErrorUtil.checkGLError(TAG, "Create program start.");
        program = OpenGLUtil.createGlProgram(HandShaderUtil.HAND_VERTEX, HandShaderUtil.HAND_FRAGMENT);
        position = GLES20.glGetAttribLocation(program, "inPosition");
        color = GLES20.glGetUniformLocation(program, "inColor");
        pointSize = GLES20.glGetUniformLocation(program, "inPointSize");
        modelViewProjectionMatrix = GLES20.glGetUniformLocation(program, "inMVPMatrix");
        ErrorUtil.checkGLError(TAG, "Create program start.");
    }

    public void onDrawFrame(Collection<ARHand> arHandCollection, float[] projectionMatrix) {
        if (arHandCollection.size() == 0) {
            return;
        }
        if (projectionMatrix != null) {
            Log.d(TAG, "Camera projection matrix: " + Arrays.toString(projectionMatrix));
        }

        for (ARHand hand : arHandCollection) {
            if (hand.getTrackingState() == ARTrackable.TrackingState.TRACKING) {
                updateHandBoundingBoxCoordinates(hand.getGestureHandBox());
                renderHandBoundingBox();
            }
        }
    }

    private void updateHandBoundingBoxCoordinates(float[] gesturePoints) {
        ErrorUtil.checkGLError(TAG, "Update hand box data start.");
        float[] glGesturePoints = {
            gesturePoints[0], gesturePoints[1], gesturePoints[2], gesturePoints[3], gesturePoints[1], gesturePoints[2],
            gesturePoints[3], gesturePoints[4], gesturePoints[5], gesturePoints[0], gesturePoints[4], gesturePoints[5]
        };
        int gesturePointsNum = glGesturePoints.length / COORDINATE_DIMENSION;

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, vbo);

        numPoints = gesturePointsNum;
        if (vboSize < numPoints * BYTES_PER_POINT) {
            while (vboSize < numPoints * BYTES_PER_POINT) {
                vboSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, vboSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        Log.d(TAG, "gesture.getGestureHandPointsNum()" + numPoints);
        FloatBuffer mVertices = FloatBuffer.wrap(glGesturePoints);
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, numPoints * BYTES_PER_POINT, mVertices);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Update hand box data end.");
    }

    private void renderHandBoundingBox() {
        ErrorUtil.checkGLError(TAG, "Draw hand box start.");
        GLES20.glUseProgram(program);
        GLES20.glEnableVertexAttribArray(position);
        GLES20.glEnableVertexAttribArray(color);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, vbo);
        GLES20.glVertexAttribPointer(position, COORDINATE_DIMENSION, GLES20.GL_FLOAT, false, BYTES_PER_POINT, 0);
        ColorRGBA boxColor = configHand.getBoxColor();
        GLES20.glUniform4f(color, boxColor.red, boxColor.green, boxColor.blue, boxColor.alpha);
        GLES20.glUniformMatrix4fv(modelViewProjectionMatrix, 1, false, mvpMatrix, 0);
        GLES20.glUniform1f(pointSize, 50.0f);

        GLES20.glLineWidth(configHand.getLineWidth());
        GLES20.glDrawArrays(GLES20.GL_LINE_LOOP, 0, numPoints);
        GLES20.glDisableVertexAttribArray(position);
        GLES20.glDisableVertexAttribArray(color);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "Draw hand box end.");
    }
}
