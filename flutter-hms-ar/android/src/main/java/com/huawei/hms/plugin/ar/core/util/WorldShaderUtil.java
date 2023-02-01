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

package com.huawei.hms.plugin.ar.core.util;

public class WorldShaderUtil {
    private static final String LS = System.lineSeparator();

    private static final String LABEL_VERTEX = 
            "uniform mat2 inPlanUVMatrix;" + LS 
            + "uniform mat4 inMVPMatrix;" + LS
            + "attribute vec3 inPosXZAlpha;" + LS 
            + "varying vec3 varTexCoordAlpha;" + LS 
            + "void main() {" + LS
            + "    vec4 tempPosition = vec4(inPosXZAlpha.x, 0.0, inPosXZAlpha.y, 1.0);" + LS
            + "    vec2 tempUV = inPlanUVMatrix * inPosXZAlpha.xy;" + LS
            + "    varTexCoordAlpha = vec3(tempUV.x + 0.5, tempUV.y + 0.5, inPosXZAlpha.z);" + LS
            + "    gl_Position = inMVPMatrix * tempPosition;" + LS 
            + "}";

    private static final String LABEL_FRAGMENT = 
            "precision highp float;" + LS 
            + "uniform sampler2D inTexture;" + LS
            + "varying vec3 varTexCoordAlpha;" + LS 
            + "void main() {" + LS
            + "    vec4 control = texture2D(inTexture, varTexCoordAlpha.xy);" + LS
            + "    gl_FragColor = vec4(control.rgb, 1.0);" + LS 
            + "}";

    private static final String OBJECT_VERTEX = 
            "uniform mat4 inMVPMatrix;" + LS 
            + "uniform mat4 inViewMatrix;" + LS
            + "attribute vec3 inObjectNormalVector;" + LS 
            + "attribute vec4 inObjectPosition;" + LS
            + "attribute vec2 inTexCoordinate;" + LS 
            + "varying vec3 varCameraNormalVector;" + LS
            + "varying vec2 varTexCoordinate;" + LS 
            + "varying vec3 varCameraPos;" + LS 
            + "void main() {" + LS
            + "    gl_Position = inMVPMatrix * inObjectPosition;" + LS
            + "    varCameraNormalVector = (inViewMatrix * vec4(inObjectNormalVector, 0.0)).xyz;" + LS
            + "    varTexCoordinate = inTexCoordinate;" + LS 
            + "    varCameraPos = (inViewMatrix * inObjectPosition).xyz;" + LS 
            + "}";

    private static final String OBJECT_FRAGMENT = 
            "precision mediump float;" + LS 
            + " uniform vec4 inLight;" + LS
            + "uniform vec4 inObjectColor;" + LS 
            + "uniform sampler2D inObjectTexture;" + LS 
            + "varying vec3 varCameraPos;" + LS 
            + "varying vec3 varCameraNormalVector;" + LS 
            + "varying vec2 varTexCoordinate;" + LS 
            + "void main() {" + LS
            + "    vec4 objectColor = texture2D(inObjectTexture, vec2(varTexCoordinate.x, 1.0 - " + 
            "varTexCoordinate.y));" + LS 
            + "    objectColor.rgb = inObjectColor.rgb / 255.0;" + LS
            + "    vec3 viewNormal = normalize(varCameraNormalVector);" + LS
            + "    vec3 reflectedLightDirection = reflect(inLight.xyz, viewNormal);" + LS
            + "    vec3 normalCameraPos = normalize(varCameraPos);" + LS
            + "    float specularStrength = max(0.0, dot(normalCameraPos, reflectedLightDirection));" + LS
            + "    gl_FragColor.a = objectColor.a;" + LS 
            + "    float diffuse = inLight.w * 3.5 *" + LS
            + "        0.5 * (dot(viewNormal, inLight.xyz) + 1.0);" + LS 
            + "    float specular = inLight.w *" + LS
            + "        pow(specularStrength, 6.0);" + LS 
            + "    gl_FragColor.rgb = objectColor.rgb * + diffuse + specular;" + LS 
            + "}";

    private static final String POINTCLOUD_VERTEX = 
            "uniform mat4 u_ModelViewProjection;" + LS 
            + "uniform vec4 u_Color;" + LS 
            + "uniform float u_PointSize;" + LS 
            + "attribute vec4 a_Position;" + LS 
            + "varying vec4 v_Color;" + LS
            + "void main() {" + LS 
            + "   v_Color = u_Color;" + LS
            + "   gl_Position = u_ModelViewProjection * vec4(a_Position.xyz, 1.0);" + LS 
            + "   gl_PointSize = u_PointSize;" + LS 
            + "}";

    private static final String POINTCLOUD_FRAGMENT = 
            "precision mediump float;" + LS 
            + "varying vec4 v_Color;" + LS
            + "void main() {" + LS 
            + "    gl_FragColor = v_Color;" + LS 
            + "}";

    private WorldShaderUtil() {
    }

    public static int getLabelProgram() {
        return OpenGLUtil.createGlProgram(LABEL_VERTEX, LABEL_FRAGMENT);
    }

    public static int getObjectProgram() {
        return OpenGLUtil.createGlProgram(OBJECT_VERTEX, OBJECT_FRAGMENT);
    }

    public static int getPointCloudProgram() {
        return OpenGLUtil.createGlProgram(POINTCLOUD_VERTEX, POINTCLOUD_FRAGMENT);
    }
}
