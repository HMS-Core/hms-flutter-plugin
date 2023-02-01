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

package com.huawei.hms.plugin.ar.core.renderer;

import android.opengl.GLES20;
import android.opengl.GLSurfaceView;

import com.huawei.hiar.ARSession;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.helper.CameraConfigListener;
import com.huawei.hms.plugin.ar.core.helper.CameraIntrinsicsListener;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.MessageTextListener;
import com.huawei.hms.plugin.ar.core.helper.PluginCallbackHelper;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARBaseRenderer implements GLSurfaceView.Renderer {
    protected ARSession arSession;

    protected DisplayRotationManager displayRotationManager;

    protected PluginCallbackHelper callbackHelper;

    protected CameraConfigListener cameraConfigListener;

    protected CameraIntrinsicsListener cameraIntrinsicsListener;

    protected MessageTextListener messageDataListener;

    protected ARPluginConfigBase pluginConfig;

    protected TextureDisplay textureDisplay;

    protected boolean lock = false;

    private int frames = 0;

    private long lastInterval;

    private float fps;

    public ARBaseRenderer() {
    }

    public ARBaseRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase configBase) {
        this.arSession = arSession;
        this.displayRotationManager = displayRotationManager;
        this.textureDisplay = textureDisplay;
        this.pluginConfig = configBase;
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        GLES20.glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        textureDisplay.init();
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        textureDisplay.onSurfaceChanged(width, height);
        GLES20.glViewport(0, 0, width, height);
        displayRotationManager.updateViewportRotation(width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT | GLES20.GL_DEPTH_BUFFER_BIT);
        if (arSession == null) {
            return;
        }
        if (displayRotationManager.isDeviceRotated()) {
            displayRotationManager.updateARSessionDisplayGeometry(arSession);
        }
        arSession.setCameraTextureName(textureDisplay.getExternalTextureId());
    }

    public void setCallbackHelper(PluginCallbackHelper callbackHelper) {
        this.callbackHelper = callbackHelper;
    }

    public void setPluginConfig(ARPluginConfigBase pluginConfig) {
        this.pluginConfig.copyValues(pluginConfig);
    }

    public void setCameraConfigListener(CameraConfigListener cameraConfigListener) {
        this.cameraConfigListener = cameraConfigListener;
    }

    public void setCameraIntrinsicsListener(CameraIntrinsicsListener cameraIntrinsicsListener) {
        this.cameraIntrinsicsListener = cameraIntrinsicsListener;
    }

    public void setMessageDataListener(MessageTextListener listener) {
        this.messageDataListener = listener;
    }

    protected float doFpsCalculate() {
        ++frames;
        long timeNow = System.currentTimeMillis();

        // Convert millisecond to second.
        if (((timeNow - lastInterval) / 1000.0f) > 0.5f) {
            fps = frames / ((timeNow - lastInterval) / 1000.0f);
            frames = 0;
            lastInterval = timeNow;
        }
        return fps;
    }
}
