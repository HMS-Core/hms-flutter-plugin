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
import com.huawei.hiar.ARWorldTrackingConfig;

public abstract class ARPluginConfigBase {
    protected int lightMode = ARConfigBase.LIGHT_MODE_NONE;

    protected int semanticMode = ARWorldTrackingConfig.SEMANTIC_NONE;

    protected boolean showSemanticSupportedInfo = true;

    protected ARConfigBase.FocusMode focusMode = ARConfigBase.FocusMode.AUTO_FOCUS;

    protected ARConfigBase.PowerMode powerMode = ARConfigBase.PowerMode.PERFORMANCE_FIRST;

    protected ARConfigBase.UpdateMode updateMode = ARConfigBase.UpdateMode.LATEST_CAMERA_IMAGE;

    /**
     * Copies values of given config
     *
     * @param configBase base config
     */
    public abstract void copyValues(ARPluginConfigBase configBase);

    public ARConfigBase.FocusMode getFocusMode() {
        return focusMode;
    }

    public void setFocusMode(ARConfigBase.FocusMode focusMode) {
        this.focusMode = focusMode;
    }

    public ARConfigBase.PowerMode getPowerMode() {
        return powerMode;
    }

    public void setPowerMode(ARConfigBase.PowerMode powerMode) {
        this.powerMode = powerMode;
    }

    public ARConfigBase.UpdateMode getUpdateMode() {
        return updateMode;
    }

    public void setUpdateMode(ARConfigBase.UpdateMode updateMode) {
        this.updateMode = updateMode;
    }

    public int getSemanticMode() {
        return semanticMode;
    }

    public void setSemanticMode(int semanticMode) {
        this.semanticMode = semanticMode;
    }

    public boolean getShowSemanticSupportedInfo() {
        return showSemanticSupportedInfo;
    }

    public void setShowSemanticSupportedInfo(boolean showSemanticSupportedInfo) {
        this.showSemanticSupportedInfo = showSemanticSupportedInfo;
    }

    public int getLightMode() {
        return this.lightMode;
    }

    public void setLightMode(int lightMode) {
        this.lightMode = lightMode;
    }

}
