/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

public class ARPluginConfigFace extends ARPluginConfigBase {
    private float pointSize;
    private ColorRGBA depthColor;
    private String texturePath;
    private boolean drawFace;

    public ARPluginConfigFace() {
        this.pointSize = 5.0f;
        this.drawFace = true;

        this.depthColor = new ColorRGBA(0, 255, 0, 255);

        this.texturePath = "";
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigFace) {
            ARPluginConfigFace configFace = (ARPluginConfigFace) configBase;
            this.pointSize = configFace.pointSize;
            this.depthColor = configFace.depthColor;
        }
    }

    public float getPointSize() {
        return pointSize;
    }

    public boolean isDrawFace() {
        return drawFace;
    }

    public void setDrawFace(boolean drawFace) {
        this.drawFace = drawFace;
    }

    public ColorRGBA getDepthColor() {
        return this.depthColor;
    }

    public String getTexturePath() {
        return texturePath;
    }

    public void setPointSize(float pointSize) {
        this.pointSize = pointSize;
    }

    public void setDepthColor(ColorRGBA depthColor) {
        this.depthColor = depthColor;
    }

    public void setTexturePath(String texturePath) {
        this.texturePath = texturePath;
    }
}
