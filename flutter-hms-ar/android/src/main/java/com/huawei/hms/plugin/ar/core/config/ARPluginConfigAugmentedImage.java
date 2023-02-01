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

import com.huawei.hms.plugin.ar.core.model.AugmentedImageDBModel;

import java.util.Arrays;
import java.util.List;

public class ARPluginConfigAugmentedImage extends ARPluginConfigBasePointLine {
    private List<AugmentedImageDBModel> augmentedImageDBModels = Arrays.asList();

    public List<AugmentedImageDBModel> getAugmentedImageDBModels() {
        return augmentedImageDBModels;
    }

    public void setAugmentedImageDBModels(List<AugmentedImageDBModel> augmentedImageDBModels) {
        this.augmentedImageDBModels = augmentedImageDBModels;
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigAugmentedImage) {
            ARPluginConfigAugmentedImage configAugmentedImage = (ARPluginConfigAugmentedImage) configBase;
            this.lightMode = configAugmentedImage.lightMode;
            this.semanticMode = configAugmentedImage.semanticMode;
            this.showSemanticSupportedInfo = configAugmentedImage.showSemanticSupportedInfo;
            this.focusMode = configAugmentedImage.focusMode;
            this.powerMode = configAugmentedImage.powerMode;
            this.updateMode = configAugmentedImage.updateMode;
            this.drawLine = configAugmentedImage.drawLine;
            this.drawPoint = configAugmentedImage.drawPoint;
            this.lineWidth = configAugmentedImage.lineWidth;
            this.pointSize = configAugmentedImage.pointSize;
            this.lineColor = configAugmentedImage.lineColor;
            this.pointColor = configAugmentedImage.pointColor;
        }
    }
}
