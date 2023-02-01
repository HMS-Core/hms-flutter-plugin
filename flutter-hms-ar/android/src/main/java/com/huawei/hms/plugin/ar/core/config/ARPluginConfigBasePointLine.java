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

public abstract class ARPluginConfigBasePointLine extends ARPluginConfigBase {
    protected boolean drawLine = true;

    protected boolean drawPoint = true;

    protected float lineWidth = 19.9f;

    protected float pointSize = 50.0f;

    protected ColorRGBA lineColor = new ColorRGBA(0, 0, 255, 255);

    protected ColorRGBA pointColor = new ColorRGBA(0, 255, 0, 255);

    public boolean isDrawLine() {
        return drawLine;
    }

    public void setDrawLine(boolean drawLine) {
        this.drawLine = drawLine;
    }

    public boolean isDrawPoint() {
        return drawPoint;
    }

    public void setDrawPoint(boolean drawPoint) {
        this.drawPoint = drawPoint;
    }

    public float getLineWidth() {
        return lineWidth;
    }

    public void setLineWidth(float lineWidth) {
        this.lineWidth = lineWidth;
    }

    public float getPointSize() {
        return pointSize;
    }

    public void setPointSize(float pointSize) {
        this.pointSize = pointSize;
    }

    public ColorRGBA getLineColor() {
        return lineColor;
    }

    public void setLineColor(ColorRGBA lineColor) {
        this.lineColor = lineColor;
    }

    public ColorRGBA getPointColor() {
        return pointColor;
    }

    public void setPointColor(ColorRGBA pointColor) {
        this.pointColor = pointColor;
    }
}
