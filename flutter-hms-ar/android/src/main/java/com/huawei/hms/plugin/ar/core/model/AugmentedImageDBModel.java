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

package com.huawei.hms.plugin.ar.core.model;

public class AugmentedImageDBModel {
    private String imgFileFromAsset = "image_default.png";

    private float widthInMeters = 0f;

    private String imgName = "Image";

    public AugmentedImageDBModel() {

    }

    public AugmentedImageDBModel(String imgFileFromAsset, float widthInMeters, String imgName) {
        this.imgFileFromAsset = imgFileFromAsset;
        this.widthInMeters = widthInMeters;
        this.imgName = imgName;
    }

    public String getImgFileFromAsset() {
        return imgFileFromAsset;
    }

    public void setImgFileFromAsset(String imgFileFromAsset) {
        this.imgFileFromAsset = imgFileFromAsset;
    }

    public float getWidthInMeters() {
        return widthInMeters;
    }

    public void setWidthInMeters(float widthInMeters) {
        this.widthInMeters = widthInMeters;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }
}
