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

public class ARPluginConfigWorld extends ARPluginConfigBase {
    private String objPath;
    private String texturePath;
    private boolean labelDraw;

    private String imageOther;
    private String imageWall;
    private String imageFloor;
    private String imageSeat;
    private String imageTable;
    private String imageCeiling;
    private String textOther;
    private String textWall;
    private String textFloor;
    private String textSeat;
    private String textTable;
    private String textCeiling;
    private ColorRGBA colorOther;
    private ColorRGBA colorWall;
    private ColorRGBA colorFloor;
    private ColorRGBA colorSeat;
    private ColorRGBA colorTable;
    private ColorRGBA colorCeiling;

    public ARPluginConfigWorld() {
        this.objPath = "AR_logo.obj";
        this.texturePath = "AR_logo.png";
        this.labelDraw = true;
        this.textOther = "other";
        this.textWall = "wall";
        this.textFloor = "floor";
        this.textSeat = "seat";
        this.textTable = "table";
        this.textCeiling = "ceiling";
        this.colorOther = new ColorRGBA(255, 0, 0, 255);
        this.colorWall = new ColorRGBA(255, 0, 0, 255);
        this.colorFloor = new ColorRGBA(255, 0, 0, 255);
        this.colorSeat = new ColorRGBA(255, 0, 0, 255);
        this.colorTable = new ColorRGBA(255, 0, 0, 255);
        this.colorCeiling = new ColorRGBA(255, 0, 0, 255);
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigWorld) {
            ARPluginConfigWorld configWorld = (ARPluginConfigWorld) configBase;
            this.objPath = configWorld.objPath;
            this.texturePath = configWorld.texturePath;
            this.labelDraw = configWorld.labelDraw;
            this.textOther = configWorld.textOther;
            this.textWall = configWorld.textWall;
            this.textFloor = configWorld.textFloor;
            this.textSeat = configWorld.textSeat;
            this.textTable = configWorld.textTable;
            this.textCeiling = configWorld.textCeiling;
            this.colorOther = configWorld.colorOther;
            this.colorWall = configWorld.colorWall;
            this.colorFloor = configWorld.colorFloor;
            this.colorSeat = configWorld.colorSeat;
            this.colorTable = configWorld.colorTable;
            this.colorCeiling = configWorld.colorCeiling;
        }
    }

    public boolean isLabelDraw() {
        return labelDraw;
    }

    public void setLabelDraw(boolean draw) {
        this.labelDraw = draw;
    }

    public void setTexturePath(String texturePath) {
        this.texturePath = texturePath;
    }

    public void setObjPath(String objPath) {
        this.objPath = objPath;
    }

    public String getObjPath() {
        return objPath;
    }

    public String getTexturePath() {
        if (texturePath == null || texturePath.isEmpty()) {
            return "texture.png";
        }
        return texturePath;
    }

    public String getImageOther() {
        return imageOther;
    }

    public void setImageOther(String imageOther) {
        this.imageOther = imageOther;
    }

    public String getImageWall() {
        return imageWall;
    }

    public void setImageWall(String imageWall) {
        this.imageWall = imageWall;
    }

    public String getImageFloor() {
        return imageFloor;
    }

    public void setImageFloor(String imageFloor) {
        this.imageFloor = imageFloor;
    }

    public String getImageSeat() {
        return imageSeat;
    }

    public void setImageSeat(String imageSeat) {
        this.imageSeat = imageSeat;
    }

    public String getImageTable() {
        return imageTable;
    }

    public void setImageTable(String imageTable) {
        this.imageTable = imageTable;
    }

    public String getImageCeiling() {
        return imageCeiling;
    }

    public void setImageCeiling(String imageCeiling) {
        this.imageCeiling = imageCeiling;
    }

    public String getTextOther() {
        return textOther;
    }

    public void setTextOther(String textOther) {
        this.textOther = textOther;
    }

    public String getTextWall() {
        return textWall;
    }

    public void setTextWall(String textWall) {
        this.textWall = textWall;
    }

    public String getTextFloor() {
        return textFloor;
    }

    public void setTextFloor(String textFloor) {
        this.textFloor = textFloor;
    }

    public String getTextSeat() {
        return textSeat;
    }

    public void setTextSeat(String textSeat) {
        this.textSeat = textSeat;
    }

    public String getTextTable() {
        return textTable;
    }

    public void setTextTable(String textTable) {
        this.textTable = textTable;
    }

    public String getTextCeiling() {
        return textCeiling;
    }

    public void setTextCeiling(String textCeiling) {
        this.textCeiling = textCeiling;
    }

    public ColorRGBA getColorOther() {
        return colorOther;
    }

    public void setColorOther(ColorRGBA colorOther) {
        this.colorOther = colorOther;
    }

    public ColorRGBA getColorWall() {
        return colorWall;
    }

    public void setColorWall(ColorRGBA colorWall) {
        this.colorWall = colorWall;
    }

    public ColorRGBA getColorFloor() {
        return colorFloor;
    }

    public void setColorFloor(ColorRGBA colorFloor) {
        this.colorFloor = colorFloor;
    }

    public ColorRGBA getColorSeat() {
        return colorSeat;
    }

    public void setColorSeat(ColorRGBA colorSeat) {
        this.colorSeat = colorSeat;
    }

    public ColorRGBA getColorTable() {
        return colorTable;
    }

    public void setColorTable(ColorRGBA colorTable) {
        this.colorTable = colorTable;
    }

    public ColorRGBA getColorCeiling() {
        return colorCeiling;
    }

    public void setColorCeiling(ColorRGBA colorCeiling) {
        this.colorCeiling = colorCeiling;
    }
}
