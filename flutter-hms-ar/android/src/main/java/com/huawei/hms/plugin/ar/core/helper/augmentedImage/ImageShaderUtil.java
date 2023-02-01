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
import android.util.Log;

public class ImageShaderUtil {
    private static final String TAG = ImageShaderUtil.class.getSimpleName();

    /**
     * Newline character.
     */
    private static final String LS = System.lineSeparator();

    /**
     * Vertex shader used for label rendering.
     */
    private static final String LABEL_VERTEX = "uniform mat2 inPlanUVMatrix;" + LS + "uniform mat4 inMVPMatrix;" + LS
        + "attribute vec3 inPosXZAlpha;" + LS + "varying vec3 varTexCoordAlpha;" + LS + "void main() {" + LS
        + "    vec4 tempPosition = vec4(inPosXZAlpha.x, 0.0, inPosXZAlpha.y, 1.0);" + LS
        + "    vec2 tempUV = inPlanUVMatrix * inPosXZAlpha.xy;" + LS
        + "    varTexCoordAlpha = vec3(tempUV.x + 0.5, tempUV.y + 0.5, inPosXZAlpha.z);" + LS
        + "    gl_Position = inMVPMatrix * tempPosition;" + LS + "}";

    /**
     * Segment shader used for label rendering.
     */
    private static final String LABEL_FRAGMENT = "precision highp float;" + LS + "uniform sampler2D inTexture;" + LS
        + "varying vec3 varTexCoordAlpha;" + LS + "void main() {" + LS
        + "    vec4 control = texture2D(inTexture, varTexCoordAlpha.xy);" + LS
        + "    gl_FragColor = vec4(control.rgb, 1.0);" + LS + "}";

    /**
     * Code of the image vertex shader.
     */
    private static final String LP_VERTEX = "uniform vec4 inColor;" + LS + "attribute vec4 inPosition;" + LS
        + "uniform float inPointSize;" + LS + "varying vec4 varColor;" + LS + "uniform mat4 inMVPMatrix;" + LS
        + "void main() {" + LS + "    gl_PointSize = inPointSize;" + LS
        + "    gl_Position = inMVPMatrix * vec4(inPosition.xyz, 1.0);" + LS + "    varColor = inColor;" + LS + "}";

    /**
     * Code of the image fragment shader.
     */
    private static final String LP_FRAGMENT = "precision mediump float;" + LS + "varying vec4 varColor;" + LS
        + "void main() {" + LS + "    gl_FragColor = varColor;" + LS + "}";

    private ImageShaderUtil() {
    }

    static int getLabelProgram() {
        return createGlProgram(LABEL_VERTEX, LABEL_FRAGMENT);
    }

    static int getImageKeyMsgProgram() {
        return createGlProgram(LP_VERTEX, LP_FRAGMENT);
    }

    /**
     * Shader program generator.
     *
     * @param vertexCode Code of the vertex shader.
     * @param fragmentCode Code of the image fragment shader.
     * @return Program handle.
     */
    private static int createGlProgram(String vertexCode, String fragmentCode) {
        int vertex = loadShader(GLES20.GL_VERTEX_SHADER, vertexCode);
        if (vertex == 0) {
            return 0;
        }
        int fragment = loadShader(GLES20.GL_FRAGMENT_SHADER, fragmentCode);
        if (fragment == 0) {
            return 0;
        }
        int program = GLES20.glCreateProgram();
        if (program != 0) {
            GLES20.glAttachShader(program, vertex);
            GLES20.glAttachShader(program, fragment);
            GLES20.glLinkProgram(program);
            int[] linkStatus = new int[1];
            GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, linkStatus, 0);
            if (linkStatus[0] != GLES20.GL_TRUE) {
                Log.e(TAG, "Could not link program: " + GLES20.glGetProgramInfoLog(program));
                GLES20.glDeleteProgram(program);
                program = 0;
            }
        }
        return program;
    }

    private static int loadShader(int shaderType, String source) {
        int shader = GLES20.glCreateShader(shaderType);
        if (shader != 0) {
            GLES20.glShaderSource(shader, source);
            GLES20.glCompileShader(shader);
            int[] compiled = new int[1];
            GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, compiled, 0);
            if (compiled[0] == 0) {
                Log.e(TAG, "glError: Could not compile shader " + shaderType);
                Log.e(TAG, "GLES20 Error: " + GLES20.glGetShaderInfoLog(shader));
                GLES20.glDeleteShader(shader);
                shader = 0;
            }
        }
        return shader;
    }
}