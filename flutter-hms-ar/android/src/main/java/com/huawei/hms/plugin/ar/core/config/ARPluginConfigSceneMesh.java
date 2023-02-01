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

package com.huawei.hms.plugin.ar.core.config;

public class ARPluginConfigSceneMesh extends ARPluginConfigBase {

    private String objPath = "AR_logo.obj";

    private String texturePath = "AR_logo.png";

    public String getObjPath() {
        return objPath;
    }

    public void setObjPath(String objPath) {
        this.objPath = objPath;
    }

    public String getTexturePath() {
        return texturePath;
    }

    public void setTexturePath(String texturePath) {
        this.texturePath = texturePath;
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigSceneMesh) {
            ARPluginConfigSceneMesh configWorld = (ARPluginConfigSceneMesh) configBase;
            this.texturePath = configWorld.texturePath;
            this.objPath = configWorld.objPath;
            this.lightMode = configWorld.lightMode;
            this.semanticMode = configWorld.semanticMode;
            this.showSemanticSupportedInfo = configWorld.showSemanticSupportedInfo;
            this.focusMode = configWorld.focusMode;
            this.powerMode = configWorld.powerMode;
            this.updateMode = configWorld.updateMode;
        }
    }
}
