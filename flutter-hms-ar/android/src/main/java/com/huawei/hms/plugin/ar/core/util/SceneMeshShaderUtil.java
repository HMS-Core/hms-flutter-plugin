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

public class SceneMeshShaderUtil {
    public static final String LS = System.lineSeparator();

    public static final String SCENE_MESH_VERTEX = "uniform mat4 u_ModelViewProjection;" + LS + "uniform vec4 u_Color;"
        + LS + "uniform float u_PointSize;" + LS + "attribute vec2 a_TexCoord;" + LS + "attribute vec4 a_Position;" + LS
        + "varying vec4 v_Color;" + LS + "varying vec4 v_Ambient;" + LS + "varying vec2 v_TexCoord;" + LS
        + "void main() {" + LS + "    v_Color = u_Color;" + LS
        + "    gl_Position = u_ModelViewProjection * vec4(a_Position.xyz, 1.0);" + LS
        + "    gl_PointSize = u_PointSize;" + LS + "    v_TexCoord = a_TexCoord;" + LS
        + "    v_Ambient = vec4(1.0, 1.0, 1.0, 1.0);" + LS + "}";

    public static final String SCENE_MESH_FRAGMENT = "precision mediump float;" + LS + "uniform sampler2D vv;" + LS
        + "varying vec4 v_Color;" + LS + "varying vec4 v_Ambient;" + LS + "varying vec2 v_TexCoord;" + LS
        + "void main() {" + LS + "    gl_FragColor = v_Color;" + LS + "}";

    private SceneMeshShaderUtil() {
    }
}
