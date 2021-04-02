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

public class ARPluginConfigHand extends ARPluginConfigBase {
    private boolean drawBox;
    private ColorRGBA boxColor;
    private float lineWidth;

    public ARPluginConfigHand() {
        this.boxColor = new ColorRGBA(0, 255, 0, 255);
        this.lineWidth = 18.0f;
        this.drawBox = true;
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigHand) {
            ARPluginConfigHand configHand = (ARPluginConfigHand) configBase;
            this.drawBox = configHand.drawBox;
            this.boxColor = configHand.boxColor;
            this.lineWidth = configHand.lineWidth;
        }
    }

    public ColorRGBA getBoxColor() {
        return boxColor;
    }

    public boolean isDrawBox() {
        return drawBox;
    }

    public float getLineWidth() {
        return lineWidth;
    }

    public void setBoxColor(ColorRGBA boxColor) {
        this.boxColor = boxColor;
    }

    public void setDrawBox(boolean drawBox) {
        this.drawBox = drawBox;
    }

    public void setLineWidth(float lineWidth) {
        this.lineWidth = lineWidth;
    }
}
