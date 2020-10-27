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

import android.opengl.GLES20;
import android.util.Log;

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.HandBoxDisplay;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARHand;
import com.huawei.hiar.ARSession;

import java.util.ArrayList;
import java.util.Collection;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARHandRenderer extends ARBaseRenderer {
    private static final int PROJECTION_MATRIX_OFFSET = 0;
    private static final float PROJECTION_MATRIX_NEAR = 0.1f;
    private static final float PROJECTION_MATRIX_FAR = 100.0f;

    private HandBoxDisplay handBoxDisplay;

    public ARHandRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase config) {
        super(arSession, displayRotationManager, textureDisplay, config);
        this.pluginConfig = config;
        handBoxDisplay = new HandBoxDisplay(pluginConfig);
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        GLES20.glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        handBoxDisplay.init();
        textureDisplay.init();
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        textureDisplay.onSurfaceChanged(width, height);
        GLES20.glViewport(0, 0, width, height);
        displayRotationManager.updateViewportRotation(width, height);
        Log.d("ARHandRenderer", "onSurfaceChanged :: (width=" + width + ", height=" + height + ")");
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

        ARFrame arFrame = arSession.update();
        ARCamera arCamera = arFrame.getCamera();

        float[] projectionMatrix = new float[16];

        arCamera.getProjectionMatrix(projectionMatrix, PROJECTION_MATRIX_OFFSET, PROJECTION_MATRIX_NEAR,
                PROJECTION_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARHand> arHandCollection = arSession.getAllTrackables(ARHand.class);
        callbackHelper.onDrawFrame(new ArrayList<>(arHandCollection));
        if (pluginConfig instanceof ARPluginConfigHand) {
            ARPluginConfigHand configHand = (ARPluginConfigHand) pluginConfig;
            if (configHand.isDrawBox()) {
                handBoxDisplay.onDrawFrame(arHandCollection, projectionMatrix);
            }
        }
    }
}
