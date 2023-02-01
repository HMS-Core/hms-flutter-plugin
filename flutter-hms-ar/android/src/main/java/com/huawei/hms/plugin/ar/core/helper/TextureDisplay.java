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

import android.opengl.GLES11Ext;
import android.opengl.GLES20;

import com.huawei.hiar.ARFrame;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.MatrixUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

import javax.microedition.khronos.opengles.GL10;

public class TextureDisplay {
    private static final String TAG = TextureDisplay.class.getSimpleName();

    private static final String LS = System.lineSeparator();

    private static final String BASE_FRAGMENT = 
    "#extension GL_OES_EGL_image_external : require" + LS
        + "precision mediump float;" + LS 
        + "varying vec2 textureCoordinate;" + LS
        + "uniform samplerExternalOES vTexture;" + LS 
        + "void main() {" + LS
        + "    gl_FragColor = texture2D(vTexture, textureCoordinate );" + LS
        + "}";

    private static final String BASE_VERTEX = 
    "attribute vec4 vPosition;" + LS 
    + "attribute vec2 vCoord;" + LS
        + "uniform mat4 vMatrix;" + LS 
        + "uniform mat4 vCoordMatrix;" + LS 
        + "varying vec2 textureCoordinate;" + LS
        + "void main(){" + LS
        + "    gl_Position = vMatrix*vPosition;" + LS
        + "    textureCoordinate = (vCoordMatrix*vec4(vCoord,0,1)).xy;" + LS 
        + "}";

    private static final float[] COORDINATES_OF_VERTEX = {-1.0f, 1.0f, -1.0f, -1.0f, 1.0f, 1.0f, 1.0f, -1.0f};

    private static final float[] TEXTURE_COORDINATES = {0.0f, 0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 1.0f};

    private static final int MATRIX_SIZE = 16;

    private static final float RGB_CLEAR_VALUE = 0.8157f;

    private int externalTextureId;

    private int program;

    private int position;

    private int coord;

    private int matrix;

    private int texture;

    private int coordMatrix;

    private FloatBuffer verBuffer;

    private FloatBuffer texTransformedBuffer;

    private FloatBuffer texBuffer;

    private float[] projectionMatrix = new float[MATRIX_SIZE];

    private float[] coordMatrixs;

    public TextureDisplay() {
        coordMatrixs = MatrixUtil.getIdentityMatrix();
        initBuffers();
    }

    public void onSurfaceChanged(int width, int height) {
        MatrixUtil.getProjectionMatrix(projectionMatrix, width, height);
    }

    public void onDrawFrame(ARFrame arFrame) {
        ErrorUtil.checkGLError(TAG, "On draw frame start..");
        if (arFrame == null) {
            return;
        }

        if (arFrame.hasDisplayGeometryChanged()) {
            arFrame.transformDisplayUvCoords(texBuffer, texTransformedBuffer);
        }
        clear();

        GLES20.glDisable(GLES20.GL_DEPTH_TEST);
        GLES20.glDepthMask(false);
        GLES20.glUseProgram(program);

        GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, externalTextureId);
        GLES20.glUniformMatrix4fv(matrix, 1, false, projectionMatrix, 0);
        GLES20.glUniformMatrix4fv(coordMatrix, 1, false, coordMatrixs, 0);

        GLES20.glEnableVertexAttribArray(position);
        GLES20.glVertexAttribPointer(position, 2, GLES20.GL_FLOAT, false, 0, verBuffer);

        GLES20.glEnableVertexAttribArray(coord);
        GLES20.glVertexAttribPointer(coord, 2, GLES20.GL_FLOAT, false, 0, texTransformedBuffer);

        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);
        GLES20.glDisableVertexAttribArray(position);
        GLES20.glDisableVertexAttribArray(coord);

        GLES20.glDepthMask(true);
        GLES20.glEnable(GLES20.GL_DEPTH_TEST);
        ErrorUtil.checkGLError(TAG, "On draw frame end..");
    }

    public void init() {
        int[] textures = new int[1];
        GLES20.glGenTextures(1, textures, 0);
        externalTextureId = textures[0];
        generateExternalTexture();
        createProgram();
    }

    public void init(int textureId) {
        externalTextureId = textureId;
        generateExternalTexture();
        createProgram();
    }

    private void generateExternalTexture() {
        GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, externalTextureId);
        GLES20.glTexParameteri(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GL10.GL_TEXTURE_WRAP_S, GL10.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GL10.GL_TEXTURE_WRAP_T, GL10.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameterf(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GL10.GL_TEXTURE_MIN_FILTER, GL10.GL_NEAREST);
        GLES20.glTexParameterf(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GL10.GL_TEXTURE_MAG_FILTER, GL10.GL_NEAREST);
    }

    public void createProgram() {
        program = OpenGLUtil.createGlProgram(BASE_VERTEX, BASE_FRAGMENT);
        position = GLES20.glGetAttribLocation(program, "vPosition");
        coord = GLES20.glGetAttribLocation(program, "vCoord");
        matrix = GLES20.glGetUniformLocation(program, "vMatrix");
        texture = GLES20.glGetUniformLocation(program, "vTexture");
        coordMatrix = GLES20.glGetUniformLocation(program, "vCoordMatrix");
    }

    private void initBuffers() {
        ByteBuffer byteBufferForVer = ByteBuffer.allocateDirect(32);
        byteBufferForVer.order(ByteOrder.nativeOrder());
        verBuffer = byteBufferForVer.asFloatBuffer();
        verBuffer.put(COORDINATES_OF_VERTEX);
        verBuffer.position(0);

        ByteBuffer byteBufferForTex = ByteBuffer.allocateDirect(32);
        byteBufferForTex.order(ByteOrder.nativeOrder());
        texBuffer = byteBufferForTex.asFloatBuffer();
        texBuffer.put(TEXTURE_COORDINATES);
        texBuffer.position(0);

        ByteBuffer byteBufferForTransformedTex = ByteBuffer.allocateDirect(32);
        byteBufferForTransformedTex.order(ByteOrder.nativeOrder());
        texTransformedBuffer = byteBufferForTransformedTex.asFloatBuffer();
    }

    private void clear() {
        GLES20.glClearColor(RGB_CLEAR_VALUE, RGB_CLEAR_VALUE, RGB_CLEAR_VALUE, 1.0f);
        GLES20.glClear(GLES20.GL_DEPTH_BUFFER_BIT);
    }

    public int getExternalTextureId() {
        return externalTextureId;
    }
}
