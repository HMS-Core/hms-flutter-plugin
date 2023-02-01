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

package com.huawei.hms.plugin.ar.core.helper.body;

import android.opengl.GLES20;

import com.huawei.hiar.ARBody;
import com.huawei.hiar.ARCoordinateSystemType;
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.BodyShaderUtil;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;

import java.nio.FloatBuffer;
import java.util.Collection;

public class BodySkeletonLineDisplay {
    private static final String TAG = BodySkeletonLineDisplay.class.getSimpleName();

    private static final int BYTES_PER_POINT = 4 * 3;

    private static final int INITIAL_BUFFER_POINTS = 150;

    private static final float COORDINATE_SYSTEM_TYPE_3D_FLAG = 2.0f;

    private static final int LINE_POINT_RATIO = 6;

    private int mVbo;

    private int mVboSize = INITIAL_BUFFER_POINTS * BYTES_PER_POINT;

    private int mProgram;

    private int mPosition;

    private int mProjectionMatrix;

    private int mColor;

    private int mPointSize;

    private int mCoordinateSystem;

    private int mNumPoints = 0;

    private int mPointsLineNum = 0;

    private FloatBuffer mLinePoints;

    private ColorRGBA lineColor;

    private float lineWidth;

    public BodySkeletonLineDisplay(ColorRGBA lineColor, float lineWidth) {
        this.lineColor = lineColor;
        this.lineWidth = lineWidth;
    }

    public void init() {
        ErrorUtil.checkGLError(TAG, "Init start.");

        int[] buffers = new int[1];
        GLES20.glGenBuffers(1, buffers, 0);
        mVbo = buffers[0];
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);

        ErrorUtil.checkGLError(TAG, "Before create gl program.");
        createProgram();
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Init end.");
    }

    private void createProgram() {
        ErrorUtil.checkGLError(TAG, "Create gl program start.");
        mProgram = OpenGLUtil.createGlProgram(BodyShaderUtil.BODY_VERTEX, BodyShaderUtil.BODY_FRAGMENT);
        mPosition = GLES20.glGetAttribLocation(mProgram, "inPosition");
        mColor = GLES20.glGetUniformLocation(mProgram, "inColor");
        mPointSize = GLES20.glGetUniformLocation(mProgram, "inPointSize");
        mProjectionMatrix = GLES20.glGetUniformLocation(mProgram, "inProjectionMatrix");
        mCoordinateSystem = GLES20.glGetUniformLocation(mProgram, "inCoordinateSystem");
        ErrorUtil.checkGLError(TAG, "Create gl program end.");
    }

    private void drawSkeletonLine(float coordinate, float[] projectionMatrix) {
        ErrorUtil.checkGLError(TAG, "Draw skeleton line start.");
        GLES20.glUseProgram(mProgram);
        GLES20.glEnableVertexAttribArray(mPosition);
        GLES20.glEnableVertexAttribArray(mColor);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);

        GLES20.glLineWidth(lineWidth);

        GLES20.glVertexAttribPointer(mPosition, 4, GLES20.GL_FLOAT, false, BYTES_PER_POINT, 0);
        GLES20.glUniform4f(mColor, lineColor.red, lineColor.green, lineColor.blue, lineColor.alpha);
        GLES20.glUniformMatrix4fv(mProjectionMatrix, 1, false, projectionMatrix, 0);

        GLES20.glUniform1f(mPointSize, 100.0f);
        GLES20.glUniform1f(mCoordinateSystem, coordinate);

        GLES20.glDrawArrays(GLES20.GL_LINES, 0, mNumPoints);
        GLES20.glDisableVertexAttribArray(mPosition);
        GLES20.glDisableVertexAttribArray(mColor);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "Draw skeleton line end.");
    }

    public void onDrawFrame(Collection<ARBody> bodies, float[] projectionMatrix) {
        for (ARBody body : bodies) {
            if (body.getTrackingState() == ARTrackable.TrackingState.TRACKING) {
                float coordinate = 1.0f;
                if (body.getCoordinateSystemType() == ARCoordinateSystemType.COORDINATE_SYSTEM_TYPE_3D_CAMERA) {
                    coordinate = COORDINATE_SYSTEM_TYPE_3D_FLAG;
                }
                updateBodySkeletonLineData(body);
                drawSkeletonLine(coordinate, projectionMatrix);
            }
        }
    }

    private void updateBodySkeletonLineData(ARBody body) {
        findValidConnectionSkeletonLines(body);
        ErrorUtil.checkGLError(TAG, "Update body skeleton line data start.");
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVbo);
        mNumPoints = mPointsLineNum;
        if (mVboSize < mNumPoints * BYTES_PER_POINT) {
            while (mVboSize < mNumPoints * BYTES_PER_POINT) {
                // If the storage space is insufficient, allocate double the space.
                mVboSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVboSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, mNumPoints * BYTES_PER_POINT, mLinePoints);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Update body skeleton line data end.");
    }

    private void findValidConnectionSkeletonLines(ARBody arBody) {
        mPointsLineNum = 0;
        int[] connections = arBody.getBodySkeletonConnection();
        float[] linePoints = new float[LINE_POINT_RATIO * connections.length];
        float[] coors;
        int[] isExists;

        if (arBody.getCoordinateSystemType() == ARCoordinateSystemType.COORDINATE_SYSTEM_TYPE_3D_CAMERA) {
            coors = arBody.getSkeletonPoint3D();
            isExists = arBody.getSkeletonPointIsExist3D();
        } else {
            coors = arBody.getSkeletonPoint2D();
            isExists = arBody.getSkeletonPointIsExist2D();
        }

        // Filter out valid skeleton connection lines based on the returned results,
        // which consist of indexes of two ends, for example, [p0,p1;p0,p3;p0,p5;p1,p2].
        // The loop takes out the 3D coordinates of the end points of the valid connection
        // line and saves them in sequence.
        for (int j = 0; j < connections.length; j += 2) {
            if (isExists[connections[j]] != 0 && isExists[connections[j + 1]] != 0) {
                linePoints[mPointsLineNum * 3] = coors[3 * connections[j]];
                linePoints[mPointsLineNum * 3 + 1] = coors[3 * connections[j] + 1];
                linePoints[mPointsLineNum * 3 + 2] = coors[3 * connections[j] + 2];
                linePoints[mPointsLineNum * 3 + 3] = coors[3 * connections[j + 1]];
                linePoints[mPointsLineNum * 3 + 4] = coors[3 * connections[j + 1] + 1];
                linePoints[mPointsLineNum * 3 + 5] = coors[3 * connections[j + 1] + 2];
                mPointsLineNum += 2;
            }
        }
        mLinePoints = FloatBuffer.wrap(linePoints);
    }
}
