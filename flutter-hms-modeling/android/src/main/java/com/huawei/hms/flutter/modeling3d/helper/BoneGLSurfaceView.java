/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.modeling3d.helper;

import android.opengl.GLES20;
import android.opengl.GLES30;
import android.opengl.GLSurfaceView;
import android.opengl.Matrix;

import com.huawei.hms.flutter.modeling3d.utils.ShaderUtils;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.List;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class BoneGLSurfaceView implements GLSurfaceView.Renderer {
    private List<List<Float>> joints;
    private boolean hasBoneData = false;
    private int shaderProgram;
    private FloatBuffer modelViewProjectionBuffer;
    private int uniformModelViewProjection;
    private int uniformColor;
    private final FloatBuffer vertexBuffer;

    // Different colors for the middle, left and right bones
    private final static int MIDDLE_BONE_COUNT = 10;
    private final static int LEFT_BONE_COUNT = 18;
    private final static int RIGHT_BONE_COUNT = 18;

    private final float[] jointsPositions = new float[24 * 3];
    private final float[] lerpedPositions = new float[24 * 3];

    private final int[][] bonePairs = new int[][]{
            {0, 3}, {3, 6}, {6, 9}, {9, 12}, {12, 15}, // Middle bone
            {0, 2}, {2, 5}, {5, 8}, {8, 11}, {9, 14}, {14, 17}, {17, 19}, {19, 21}, {21, 23}, // Left bone
            {0, 1}, {1, 4}, {4, 7}, {7, 10}, {9, 13}, {13, 16}, {16, 18}, {18, 20}, {20, 22} // Right bone
    };
    private final float[] bonePositions = new float[bonePairs.length * 2 * 3];

    /**
     * Vertex shader
     */
    private final String vertexShader = "#version 300 es \n" + "layout (location = 0) in vec4 vPosition;\n"
            + "uniform mat4 uModelViewProj;\n" + "void main() { \n" + "gl_Position = vPosition * uModelViewProj;\n" + "}\n";

    private final String fragmentShader = "#version 300 es \n" + "precision mediump float;\n" + "out vec4 fragColor;\n"
            + "uniform vec3 uColor;" + "void main() { \n" + "fragColor = vec4(uColor, 0.0); \n" + "}\n";

    public BoneGLSurfaceView() {
        vertexBuffer = ByteBuffer.allocateDirect(bonePositions.length * 4)
                .order(ByteOrder.nativeOrder())
                .asFloatBuffer();
    }

    private static float lerp(float a, float b, float t) {
        if (t <= 0) {
            return a;
        } else if (t >= 1) {
            return b;
        }
        return a + (b - a) * t;
    }

    @Override
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        GLES30.glClearColor(0.8f, 0.8f, 0.8f, 1.0f);
        shaderProgram = ShaderUtils.createProgram(vertexShader, fragmentShader);
        uniformModelViewProjection = GLES30.glGetUniformLocation(shaderProgram, "uModelViewProj");
        uniformColor = GLES30.glGetUniformLocation(shaderProgram, "uColor");
        GLES30.glLineWidth(5.f);
    }

    @Override
    public void onSurfaceChanged(GL10 gl, int width, int height) {
        GLES20.glViewport(0, 0, width, height);
        float aspectRatio = (float) width / height;
        float[] viewMatrix = new float[16];
        float[] projMatrix = new float[16];
        float[] modelMatrix = new float[16];
        float[] modelViewMatrix = new float[16];
        float[] modelViewProjection = new float[16];
        Matrix.setLookAtM(viewMatrix, 0, 0, 0, 4.5f, 0, 0, 0, 0, 1, 0);
        Matrix.perspectiveM(projMatrix, 0, 25.0f, aspectRatio, 0.3f, 1000.f);
        Matrix.setIdentityM(modelMatrix, 0);
        Matrix.scaleM(modelMatrix, 0, 1, 1, 1);
        Matrix.multiplyMM(modelViewMatrix, 0, viewMatrix, 0, modelMatrix, 0);
        Matrix.multiplyMM(modelViewProjection, 0, projMatrix, 0, modelViewMatrix, 0);
        modelViewProjectionBuffer = ByteBuffer.allocateDirect(modelViewProjection.length * 4)
                .order(ByteOrder.nativeOrder())
                .asFloatBuffer();
        modelViewProjectionBuffer.put(modelViewProjection);
        modelViewProjectionBuffer.position(0);
    }

    @Override
    public void onDrawFrame(GL10 gl) {
        GLES30.glUseProgram(shaderProgram);
        GLES20.glClear(GL10.GL_COLOR_BUFFER_BIT | GLES20.GL_DEPTH_BUFFER_BIT);
        if (!hasBoneData) {
            return;
        }
        GLES30.glUniformMatrix4fv(uniformModelViewProjection, 1, false, modelViewProjectionBuffer);
        GLES30.glVertexAttribPointer(0, 3, GLES30.GL_FLOAT, false, 0, vertexBuffer);
        GLES30.glEnableVertexAttribArray(0);
        updateVertexBuffer();

        GLES30.glUniform3f(uniformColor, 1.0f, 0.0f, 0.0f);
        GLES30.glDrawArrays(GLES30.GL_LINES, 0, MIDDLE_BONE_COUNT);
        GLES30.glUniform3f(uniformColor, 0.0f, 1.0f, 0.0f);
        GLES30.glDrawArrays(GLES30.GL_LINES, MIDDLE_BONE_COUNT, LEFT_BONE_COUNT);
        GLES30.glUniform3f(uniformColor, 0.0f, 0.0f, 1.0f);
        GLES30.glDrawArrays(GLES30.GL_LINES, MIDDLE_BONE_COUNT + LEFT_BONE_COUNT, RIGHT_BONE_COUNT);
    }

    public void setData(List<List<Float>> joints, List<Float> trans) {
        if (null == joints) {
            hasBoneData = false;
            return;
        }
        hasBoneData = true;
        this.joints = joints;
        int index = 0;
        for (int i = 0; i < joints.size(); i++) {
            for (int j = 0; j < joints.get(i).size(); j++) {
                if (j == 1) {
                    jointsPositions[index] = -joints.get(i).get(j) - trans.get(j);
                } else if (j == 0) {
                    jointsPositions[index] = joints.get(i).get(j) + trans.get(j);
                } else {
                    jointsPositions[index] = joints.get(i).get(j);
                }
                index++;
            }
        }
    }

    private void updateVertexBuffer() {
        // Interpolation
        for (int i = 0; i < jointsPositions.length; i++) {
            lerpedPositions[i] = lerp(lerpedPositions[i], jointsPositions[i], 0.1f);
        }
        // Get the vertex array of the bone connection
        int index = 0;
        for (int[] bonePair : bonePairs) {
            bonePositions[index++] = lerpedPositions[bonePair[0] * 3];
            bonePositions[index++] = lerpedPositions[bonePair[0] * 3 + 1];
            bonePositions[index++] = lerpedPositions[bonePair[0] * 3 + 2];
            bonePositions[index++] = lerpedPositions[bonePair[1] * 3];
            bonePositions[index++] = lerpedPositions[bonePair[1] * 3 + 1];
            bonePositions[index++] = lerpedPositions[bonePair[1] * 3 + 2];
        }
        vertexBuffer.clear();
        vertexBuffer.put(bonePositions);
        vertexBuffer.position(0);
    }
}
