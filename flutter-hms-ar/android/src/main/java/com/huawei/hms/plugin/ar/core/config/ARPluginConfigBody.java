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

public class ARPluginConfigBody extends ARPluginConfigBase {
    private boolean drawLine;
    private boolean drawPoint;

    private float lineWidth;
    private float pointSize;

    private ColorRGBA lineColor;
    private ColorRGBA pointColor;

    public ARPluginConfigBody() {
        this.drawLine = true;
        this.drawPoint = true;

        this.lineWidth = 19.9f;
        this.pointSize = 50.0f;

        this.lineColor = new ColorRGBA(0, 0, 255, 255);
        this.pointColor = new ColorRGBA(0, 255, 0, 255);
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigBody) {
            ARPluginConfigBody configBody = (ARPluginConfigBody) configBase;
            this.drawLine = configBody.drawLine;
            this.drawPoint = configBody.drawPoint;

            this.lineWidth = configBody.lineWidth;
            this.pointSize = configBody.pointSize;

            this.lineColor = configBody.lineColor;
            this.pointColor = configBody.pointColor;
        }
    }

    public boolean isDrawLine() {
        return drawLine;
    }

    public boolean isDrawPoint() {
        return drawPoint;
    }

    public float getLineWidth() {
        return lineWidth;
    }

    public float getPointSize() {
        return pointSize;
    }

    public ColorRGBA getLineColor() {
        return lineColor;
    }

    public ColorRGBA getPointColor() {
        return pointColor;
    }

    public void setLineWidth(float lineWidth) {
        this.lineWidth = lineWidth;
    }

    public void setDrawLine(boolean drawLine) {
        this.drawLine = drawLine;
    }

    public void setDrawPoint(boolean drawPoint) {
        this.drawPoint = drawPoint;
    }

    public void setLineColor(ColorRGBA lineColor) {
        this.lineColor = lineColor;
    }

    public void setPointColor(ColorRGBA pointColor) {
        this.pointColor = pointColor;
    }

    public void setPointSize(float pointSize) {
        this.pointSize = pointSize;
    }
}
