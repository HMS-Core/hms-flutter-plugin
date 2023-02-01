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

import com.huawei.hiar.ARConfigBase;
import com.huawei.hms.plugin.ar.core.model.AugmentedImageDBModel;

import java.util.Arrays;
import java.util.List;

public class ARPluginConfigWorldBody extends ARPluginConfigBaseWorld {
    private List<AugmentedImageDBModel> augmentedImageDBModels = Arrays.asList();

    private ARConfigBase.PlaneFindingMode planeFindingMode = ARConfigBase.PlaneFindingMode.ENABLE;

    public List<AugmentedImageDBModel> getAugmentedImageDBModels() {
        return augmentedImageDBModels;
    }

    public void setAugmentedImageDBModels(List<AugmentedImageDBModel> augmentedImageDBModels) {
        this.augmentedImageDBModels = augmentedImageDBModels;
    }

    public ARConfigBase.PlaneFindingMode getPlaneFindingMode() {
        return planeFindingMode;
    }

    public void setPlaneFindingMode(ARConfigBase.PlaneFindingMode planeFindingMode) {
        this.planeFindingMode = planeFindingMode;
    }

    @Override
    public void copyValues(ARPluginConfigBase configBase) {
        if (configBase instanceof ARPluginConfigWorldBody) {
            ARPluginConfigWorldBody configWorld = (ARPluginConfigWorldBody) configBase;
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
            this.lightMode = configWorld.lightMode;
            this.semanticMode = configWorld.semanticMode;
            this.showSemanticSupportedInfo = configWorld.showSemanticSupportedInfo;
            this.maxMapSize = configWorld.maxMapSize;
            this.focusMode = configWorld.focusMode;
            this.powerMode = configWorld.powerMode;
            this.updateMode = configWorld.updateMode;
            this.planeFindingMode = configWorld.planeFindingMode;
            this.drawLine = configWorld.drawLine;
            this.drawPoint = configWorld.drawPoint;
            this.lineWidth = configWorld.lineWidth;
            this.pointSize = configWorld.pointSize;
            this.lineColor = configWorld.lineColor;
            this.pointColor = configWorld.pointColor;
        }
    }
}
