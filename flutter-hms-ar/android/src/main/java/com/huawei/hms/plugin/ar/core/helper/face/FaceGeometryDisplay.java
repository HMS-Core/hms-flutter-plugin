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

package com.huawei.hms.plugin.ar.core.helper.face;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.opengl.GLES20;
import android.opengl.GLUtils;
import android.opengl.Matrix;
import android.util.Log;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFace;
import com.huawei.hiar.ARFaceGeometry;
import com.huawei.hiar.ARPose;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.util.ErrorUtil;
import com.huawei.hms.plugin.ar.core.util.OpenGLUtil;

import java.io.IOException;
import java.io.InputStream;
import java.nio.FloatBuffer;
import java.nio.IntBuffer;

public class FaceGeometryDisplay {
    private static final String TAG = FaceGeometryDisplay.class.getSimpleName();

    private static final String LS = System.lineSeparator();

    private static final String FACE_GEOMETRY_VERTEX = "attribute vec2 inTexCoord;" + LS + "uniform mat4 inMVPMatrix;"
        + LS + "uniform float inPointSize;" + LS + "attribute vec4 inPosition;" + LS + "uniform vec4 inColor;" + LS
        + "varying vec4 varAmbient;" + LS + "varying vec4 varColor;" + LS + "varying vec2 varCoord;" + LS
        + "void main() {" + LS + "    varAmbient = vec4(1.0, 1.0, 1.0, 1.0);" + LS
        + "    gl_Position = inMVPMatrix * vec4(inPosition.xyz, 1.0);" + LS + "    varColor = inColor;" + LS
        + "    gl_PointSize = inPointSize;" + LS + "    varCoord = inTexCoord;" + LS + "}";

    private static final String FACE_GEOMETRY_FRAGMENT = "precision mediump float;" + LS
        + "uniform sampler2D inTexture;" + LS + "varying vec4 varColor;" + LS + "varying vec2 varCoord;" + LS
        + "varying vec4 varAmbient;" + LS + "void main() {" + LS
        + "    vec4 objectColor = texture2D(inTexture, vec2(varCoord.x, 1.0 - varCoord.y));" + LS
        + "    if(varColor.x != 0.0) {" + LS + "        gl_FragColor = varColor * varAmbient;" + LS + "    }" + LS
        + "    else {" + LS + "        gl_FragColor = objectColor * varAmbient;" + LS + "    }" + LS + "}";

    private static final int BYTES_PER_POINT = 4 * 3;

    private static final int BYTES_PER_COORD = 4 * 2;

    private static final int BUFFER_OBJECT_NUMBER = 2;

    private static final int POSITION_COMPONENTS_NUMBER = 4;

    private static final int TEXCOORD_COMPONENTS_NUMBER = 2;

    private static final float PROJECTION_MATRIX_NEAR = 0.1f;

    private static final float PROJECTION_MATRIX_FAR = 100.0f;

    private int verticeId;

    private int verticeBufferSize = 8000;

    private int triangleId;

    private int triangleBufferSize = 5000;

    private int program;

    private int textureName;

    private int positionAttribute;

    private int colorUniform;

    private int modelViewProjectionUniform;

    private int pointSizeUniform;

    private int textureUniform;

    private int textureCoordAttribute;

    private int numberOfGeometricVertices = 0;

    private int trianglesNum = 0;

    private float[] modelViewProjections = new float[16];

    private ARPluginConfigFace configBase = new ARPluginConfigFace();

    public FaceGeometryDisplay(Context context, ARPluginConfigBase pluginConfigBase) {
        if (pluginConfigBase instanceof ARPluginConfigFace) {
            this.configBase = (ARPluginConfigFace) pluginConfigBase;
        }
        ErrorUtil.checkGLError(TAG, "init start..");
        int[] texNames = new int[1];
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glGenTextures(1, texNames, 0);
        this.textureName = texNames[0];

        int[] buffers = new int[BUFFER_OBJECT_NUMBER];
        GLES20.glGenBuffers(BUFFER_OBJECT_NUMBER, buffers, 0);
        verticeId = buffers[0];
        triangleId = buffers[1];

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, verticeId);
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, verticeBufferSize * BYTES_PER_POINT, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, triangleId);

        GLES20.glBufferData(GLES20.GL_ELEMENT_ARRAY_BUFFER, triangleBufferSize * 4, null, GLES20.GL_DYNAMIC_DRAW);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, textureName);

        createProgram();
        Bitmap textureBitmap;
        try (InputStream inputStream = context.getAssets().open(configBase.getTexturePath())) {
            textureBitmap = BitmapFactory.decodeStream(inputStream);
        } catch (final OutOfMemoryError | IllegalArgumentException | IOException e) {
            Log.e(TAG, "Open bitmap error!");
            return;
        }

        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR_MIPMAP_LINEAR);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR);
        GLUtils.texImage2D(GLES20.GL_TEXTURE_2D, 0, textureBitmap, 0);
        GLES20.glGenerateMipmap(GLES20.GL_TEXTURE_2D);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0);
        ErrorUtil.checkGLError(TAG, "Init end.");
    }

    private void createProgram() {
        ErrorUtil.checkGLError(TAG, "Create gl program start..");
        program = OpenGLUtil.createGlProgram(FACE_GEOMETRY_VERTEX, FACE_GEOMETRY_FRAGMENT);
        positionAttribute = GLES20.glGetAttribLocation(program, "inPosition");
        colorUniform = GLES20.glGetUniformLocation(program, "inColor");
        modelViewProjectionUniform = GLES20.glGetUniformLocation(program, "inMVPMatrix");
        pointSizeUniform = GLES20.glGetUniformLocation(program, "inPointSize");
        textureUniform = GLES20.glGetUniformLocation(program, "inTexture");

        textureCoordAttribute = GLES20.glGetAttribLocation(program, "inTexCoord");
        ErrorUtil.checkGLError(TAG, "Create gl program end..");
    }

    public void onDrawFrame(ARCamera arCamera, ARFace arFace) {
        ARFaceGeometry faceGeometry = arFace.getFaceGeometry();
        updateFaceGeometryData(faceGeometry);
        updateModelViewProjectionData(arCamera, arFace);
        drawFaceGeometry();
        faceGeometry.release();
    }

    private void updateFaceGeometryData(ARFaceGeometry arFaceGeometry) {
        ErrorUtil.checkGLError(TAG, "Before update data..");
        FloatBuffer faceVertices = arFaceGeometry.getVertices();

        numberOfGeometricVertices = faceVertices.limit() / 3;

        FloatBuffer textureCoordinates = arFaceGeometry.getTextureCoordinates();
        int numOfGeoTextures = textureCoordinates.limit() / 2;
        Log.d(TAG, "updateFaceGeometryData: texture coordinates size: " + numOfGeoTextures);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, verticeId);
        if (verticeBufferSize < (numberOfGeometricVertices + numOfGeoTextures) * BYTES_PER_POINT) {
            while (verticeBufferSize < (numberOfGeometricVertices + numOfGeoTextures) * BYTES_PER_POINT) {
                verticeBufferSize *= 2;
            }

            GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, verticeBufferSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, 0, numberOfGeometricVertices * BYTES_PER_POINT, faceVertices);
        GLES20.glBufferSubData(GLES20.GL_ARRAY_BUFFER, numberOfGeometricVertices * BYTES_PER_POINT,
            numOfGeoTextures * BYTES_PER_COORD, textureCoordinates);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        trianglesNum = arFaceGeometry.getTriangleCount();
        IntBuffer faceTriangleIndices = arFaceGeometry.getTriangleIndices();
        Log.d(TAG, "update face geometry data: faceTriangleIndices.size: " + faceTriangleIndices.limit());

        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, triangleId);
        if (triangleBufferSize < trianglesNum * BYTES_PER_POINT) {
            while (triangleBufferSize < trianglesNum * BYTES_PER_POINT) {
                triangleBufferSize *= 2;
            }
            GLES20.glBufferData(GLES20.GL_ELEMENT_ARRAY_BUFFER, triangleBufferSize, null, GLES20.GL_DYNAMIC_DRAW);
        }
        GLES20.glBufferSubData(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0, trianglesNum * BYTES_PER_POINT, faceTriangleIndices);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "After update data..");
    }

    private void updateModelViewProjectionData(ARCamera camera, ARFace face) {
        float[] projectionMatrix = new float[16];
        camera.getProjectionMatrix(projectionMatrix, 0, PROJECTION_MATRIX_NEAR, PROJECTION_MATRIX_FAR);
        ARPose facePose = face.getPose();

        float[] facePoseViewMatrix = new float[16];
        facePose.toMatrix(facePoseViewMatrix, 0);
        Matrix.multiplyMM(modelViewProjections, 0, projectionMatrix, 0, facePoseViewMatrix, 0);
    }

    private void drawFaceGeometry() {
        ErrorUtil.checkGLError(TAG, "Before draw.");
        Log.d(TAG, "Draw face geometry: mPointsNum: " + numberOfGeometricVertices + " mTrianglesNum: " + trianglesNum);

        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, textureName);
        GLES20.glUniform1i(textureUniform, 0);
        ErrorUtil.checkGLError(TAG, "Init texture.");

        GLES20.glEnable(GLES20.GL_DEPTH_TEST);
        GLES20.glEnable(GLES20.GL_CULL_FACE);

        GLES20.glUseProgram(program);
        GLES20.glEnableVertexAttribArray(positionAttribute);
        GLES20.glEnableVertexAttribArray(textureCoordAttribute);
        GLES20.glEnableVertexAttribArray(colorUniform);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, verticeId);
        GLES20.glVertexAttribPointer(positionAttribute, POSITION_COMPONENTS_NUMBER, GLES20.GL_FLOAT, false,
            BYTES_PER_POINT, 0);
        GLES20.glVertexAttribPointer(textureCoordAttribute, TEXCOORD_COMPONENTS_NUMBER, GLES20.GL_FLOAT, false,
            BYTES_PER_COORD, 0);

        if (configBase.getTexturePath().isEmpty()) {
            ColorRGBA depthColor = configBase.getDepthColor();
            GLES20.glUniform4f(colorUniform, depthColor.red > 0 ? depthColor.red : 0.0001f, depthColor.green,
                depthColor.blue, depthColor.alpha);
        }

        GLES20.glUniformMatrix4fv(modelViewProjectionUniform, 1, false, modelViewProjections, 0);
        GLES20.glUniform1f(pointSizeUniform, configBase.getPointSize()); // Set the size of Point to 5.
        GLES20.glDrawArrays(GLES20.GL_POINTS, 0, numberOfGeometricVertices);
        GLES20.glDisableVertexAttribArray(colorUniform);
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
        ErrorUtil.checkGLError(TAG, "Draw point.");

        GLES20.glEnableVertexAttribArray(colorUniform);

        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, triangleId);

        GLES20.glDrawElements(GLES20.GL_TRIANGLES, trianglesNum * 3, GLES20.GL_UNSIGNED_INT, 0);
        GLES20.glBindBuffer(GLES20.GL_ELEMENT_ARRAY_BUFFER, 0);
        GLES20.glDisableVertexAttribArray(colorUniform);
        ErrorUtil.checkGLError(TAG, "Draw triangles.");

        GLES20.glDisableVertexAttribArray(textureCoordAttribute);
        GLES20.glDisableVertexAttribArray(positionAttribute);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0);

        GLES20.glDisable(GLES20.GL_DEPTH_TEST);
        GLES20.glDisable(GLES20.GL_CULL_FACE);
        ErrorUtil.checkGLError(TAG, "Draw after.");
    }
}
