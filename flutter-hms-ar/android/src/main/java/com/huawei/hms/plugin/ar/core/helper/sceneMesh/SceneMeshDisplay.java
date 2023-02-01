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

package com.huawei.hms.plugin.ar.core.helper.sceneMesh;

import static javax.microedition.khronos.opengles.GL10.GL_BLEND;
import static javax.microedition.khronos.opengles.GL10.GL_ONE_MINUS_SRC_ALPHA;
import static javax.microedition.khronos.opengles.GL10.GL_SRC_ALPHA;

import android.content.Context;
import android.opengl.GLES20;
import android.opengl.Matrix;
import android.util.Log;

import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARSceneMesh;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;
import com.huawei.hms.plugin.ar.core.util.SceneMeshShaderUtil;

import java.nio.FloatBuffer;
import java.nio.IntBuffer;

public class SceneMeshDisplay {
    private static final String TAG = SceneMeshDisplay.class.getSimpleName();

    private static final int BYTES_PER_FLOAT = Float.SIZE / 8;

    private static final int FLOATS_PER_POINT = 3;

    private static final int BYTES_PER_POINT = BYTES_PER_FLOAT * FLOATS_PER_POINT;

    private static final int BUFFER_OBJECT_NUMBER = 2;

    private static final int INT_PER_TRIANGE = 3;

    private static final int MODLE_VIEW_PROJ_SIZE = 16;

    private static final int POSITION_COMPONENTS_NUMBER = 4;

    private int mVerticeVBO;

    /**
     * Initialize the VBO size. The actual size is 7365.
     */
    private int mVerticeVBOSize = 8000;

    private int mTriangleVBO;

    /**
     * Initialize the size of the triangle VBO. The actual size is 4434.
     */
    private int mTriangleVBOSize = 5000;

    private int mProgram;

    private int mPositionAttribute;

    private int mColorUniform;

    private int mModelViewProjectionUniform;

    private int mPointSizeUniform;

    private int mPointsNum = 0;

    private int mTrianglesNum = 0;

    private float[] mModelViewProjection = new float[MODLE_VIEW_PROJ_SIZE];

    /**
     * Scene mesh display constructor.
     */
    public SceneMeshDisplay() {
    }

    public void init(Context context) {
        int[] buffers = new int[BUFFER_OBJECT_NUMBER];
        GLES20.glGenBuffers(BUFFER_OBJECT_NUMBER, buffers, 0);
        mVerticeVBO = buffers[0];
        mTriangleVBO = buffers[1];

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVerticeVBO);
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVerticeVBOSize * BYTES_PER_POINT, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, mTriangleVBO);
        GLES20.glBufferData(GLES20.GL_ELEMENT_ARRAY_BUFFER, mTriangleVBOSize * BYTES_PER_FLOAT, null,
            GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);

        ErrorUtil.checkGLError(TAG, "SceneMesh buffer alloc");

        mProgram = OpenGLUtil.createGlProgram(SceneMeshShaderUtil.SCENE_MESH_VERTEX,
            SceneMeshShaderUtil.SCENE_MESH_FRAGMENT);
        GLES20.glUseProgram(mProgram);
        ErrorUtil.checkGLError(TAG, "SceneMesh program");

        mPositionAttribute = GLES20.glGetAttribLocation(mProgram, "a_Position");
        mColorUniform = GLES20.glGetUniformLocation(mProgram, "u_Color");
        mModelViewProjectionUniform = GLES20.glGetUniformLocation(mProgram, "u_ModelViewProjection");
        mPointSizeUniform = GLES20.glGetUniformLocation(mProgram, "u_PointSize");
        ErrorUtil.checkGLError(TAG, "SceneMesh program params");
    }

    public void onDrawFrame(ARFrame arFrame, float[] viewmtxs, float[] projmtxs) {
        ARSceneMesh arSceneMesh = arFrame.acquireSceneMesh();
        updateSceneMeshData(arSceneMesh);
        arSceneMesh.release();
        draw(viewmtxs, projmtxs);
    }

    /**
     * Update the mesh data in the buffer.
     *
     * @param sceneMesh Data structure in the AR mesh scene.
     */
    public void updateSceneMeshData(ARSceneMesh sceneMesh) {
        ErrorUtil.checkGLError(TAG, "SceneMesh before update");
        FloatBuffer meshVertices = sceneMesh.getVertices();
        mPointsNum = meshVertices.limit() / FLOATS_PER_POINT;
        Log.d(TAG, "SceneMesh updateData: Meshsize:" + mPointsNum + "position:" + meshVertices.position() + " limit:"
            + meshVertices.limit() + " remaining:" + meshVertices.remaining());
        Log.d(TAG, "SceneMesh Vertices = ");

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVerticeVBO);
        if (mVerticeVBOSize < mPointsNum * BYTES_PER_POINT) {
            while (mVerticeVBOSize < mPointsNum * BYTES_PER_POINT) {
                // If the VBO is not large enough in size, double it.
                mVerticeVBOSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, mVerticeVBOSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, mPointsNum * BYTES_PER_POINT, meshVertices);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        IntBuffer meshTriangleIndices = sceneMesh.getTriangleIndices();
        mTrianglesNum = meshTriangleIndices.limit() / INT_PER_TRIANGE;
        Log.d(TAG,
            "SceneMesh updateData: MeshTrianglesize:" + mTrianglesNum + "position:" + meshTriangleIndices.position()
                + " limit:" + meshTriangleIndices.limit() + " remaining:" + meshTriangleIndices.remaining());

        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, mTriangleVBO);
        if (mTriangleVBOSize < mTrianglesNum * BYTES_PER_POINT) {
            while (mTriangleVBOSize < mTrianglesNum * BYTES_PER_POINT) {
                // If the triangle VBO is not large enough in size, double it.
                mTriangleVBOSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ELEMENT_ARRAY_BUFFER, mTriangleVBOSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0, mTrianglesNum * BYTES_PER_POINT, meshTriangleIndices);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "SceneMesh after update");
    }

    /**
     * Set up the input data in the shader program and in the drawing program.
     *
     * @param cameraView Camera view data.
     * @param cameraPerspective Perspective data of the camera.
     */
    public void draw(float[] cameraView, float[] cameraPerspective) {
        ErrorUtil.checkGLError(TAG, "SceneMesh Before draw");
        Log.d(TAG, "SceneMesh draw: mPointsNum:" + mPointsNum + " mTrianglesNum:" + mTrianglesNum);

        GLES20.glEnable(GLES20.GL_DEPTH_TEST);
        GLES20.glEnable(GLES20.GL_CULL_FACE);
        Matrix.multiplyMM(mModelViewProjection, 0, cameraPerspective, 0, cameraView, 0);

        // Drawing point.
        GLES20.glUseProgram(mProgram);
        GLES20.glEnableVertexAttribArray(mPositionAttribute);
        GLES20.glEnableVertexAttribArray(mColorUniform);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVerticeVBO);
        GLES20.glVertexAttribPointer(mPositionAttribute, POSITION_COMPONENTS_NUMBER, GLES20.GL_FLOAT, false,
            BYTES_PER_POINT, 0);
        GLES20.glUniform4f(mColorUniform, 1.0f, 0.0f, 0.0f, 1.0f);
        GLES20.glUniformMatrix4fv(mModelViewProjectionUniform, 1, false, mModelViewProjection, 0);

        // Set the point size to 5.
        GLES20.glUniform1f(mPointSizeUniform, 5.0f);
        GLES20.glDrawArrays(GLES20.GL_POINTS, 0, mPointsNum);
        GLES20.glDisableVertexAttribArray(mColorUniform);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "SceneMesh Draw point");

        // Draw a triangle.
        GLES20.glEnable(GL_BLEND);
        GLES20.glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        GLES20.glEnableVertexAttribArray(mColorUniform);
        GLES20.glUniform4f(mColorUniform, 0.0f, 1.0f, 0.0f, 0.5f);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, mTriangleVBO);

        // Each triangle has three vertices.
        GLES20.glDrawElements(GLES20.GL_TRIANGLES, mTrianglesNum * 3, GLES20.GL_UNSIGNED_INT, 0);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);
        GLES20.glDisableVertexAttribArray(mColorUniform);
        ErrorUtil.checkGLError(TAG, "SceneMesh Draw triangles");
        GLES20.glDisableVertexAttribArray(mPositionAttribute);

        GLES20.glDisable(GLES20.GL_CULL_FACE);
        GLES20.glDisable(GL_BLEND);
        ErrorUtil.checkGLError(TAG, "SceneMesh Draw after");
    }
}
