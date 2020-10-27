/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.plugin.ar.core.renderer;

import android.opengl.GLSurfaceView;

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.PluginCallbackHelper;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;

import com.huawei.hiar.ARSession;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARBaseRenderer implements GLSurfaceView.Renderer {
    protected ARSession arSession;
    protected DisplayRotationManager displayRotationManager;
    protected PluginCallbackHelper callbackHelper;
    protected ARPluginConfigBase pluginConfig;
    protected TextureDisplay textureDisplay;

    public ARBaseRenderer() {
    }

    public ARBaseRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase configBase) {
        this.arSession = arSession;
        this.displayRotationManager = displayRotationManager;
        this.textureDisplay = textureDisplay;
        this.pluginConfig = configBase;
        this.callbackHelper = arTrackables -> {
        };
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
    }

    public void setCallbackHelper(PluginCallbackHelper callbackHelper) {
        this.callbackHelper = callbackHelper;
    }

    public void setPluginConfig(ARPluginConfigBase pluginConfig) {
        this.pluginConfig.copyValues(pluginConfig);
    }
}
