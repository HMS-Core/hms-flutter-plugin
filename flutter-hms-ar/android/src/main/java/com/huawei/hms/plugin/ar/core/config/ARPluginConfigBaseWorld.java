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

public abstract class ARPluginConfigBaseWorld extends ARPluginConfigBasePointLine {
    protected String objPath = "AR_logo.obj";

    protected String texturePath = "AR_logo.png";

    protected boolean labelDraw = true;

    protected String imageOther;

    protected String imageWall;

    protected String imageFloor;

    protected String imageSeat;

    protected String imageTable;

    protected String imageCeiling;

    protected String imageDoor;

    protected String imageWindow;

    protected String imageBed;

    protected String textOther = "other";

    protected String textWall = "wall";

    protected String textFloor = "floor";

    protected String textSeat = "seat";

    protected String textTable = "table";

    protected String textCeiling = "ceiling";

    protected String textDoor = "door";

    protected String textWindow = "window";

    protected String textBed = "bed";

    protected ColorRGBA colorOther = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorWall = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorFloor = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorSeat = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorTable = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorCeiling = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorDoor = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorWindow = new ColorRGBA(255, 0, 0, 255);

    protected ColorRGBA colorBed = new ColorRGBA(255, 0, 0, 255);

    protected long maxMapSize = 800L;

    public long getMaxMapSize() {
        return maxMapSize;
    }

    public void setMaxMapSize(long maxMapSize) {
        this.maxMapSize = maxMapSize;
    }

    public boolean isLabelDraw() {
        return labelDraw;
    }

    public void setLabelDraw(boolean draw) {
        this.labelDraw = draw;
    }

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

    public String getImageDoor() {
        return imageDoor;
    }

    public void setImageDoor(String imageDoor) {
        this.imageDoor = imageDoor;
    }

    public String getImageWindow() {
        return imageWindow;
    }

    public void setImageWindow(String imageWindow) {
        this.imageWindow = imageWindow;
    }

    public String getImageBed() {
        return imageBed;
    }

    public void setImageBed(String imageBed) {
        this.imageBed = imageBed;
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

    public String getTextDoor() {
        return textDoor;
    }

    public void setTextDoor(String textDoor) {
        this.textDoor = textDoor;
    }

    public String getTextWindow() {
        return textWindow;
    }

    public void setTextWindow(String textWindow) {
        this.textWindow = textWindow;
    }

    public String getTextBed() {
        return textBed;
    }

    public void setTextBed(String textBed) {
        this.textBed = textBed;
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

    public ColorRGBA getColorDoor() {
        return colorDoor;
    }

    public void setColorDoor(ColorRGBA colorDoor) {
        this.colorDoor = colorDoor;
    }

    public ColorRGBA getColorWindow() {
        return colorWindow;
    }

    public void setColorWindow(ColorRGBA colorWindow) {
        this.colorWindow = colorWindow;
    }

    public ColorRGBA getColorBed() {
        return colorBed;
    }

    public void setColorBed(ColorRGBA colorBed) {
        this.colorBed = colorBed;
    }

}
