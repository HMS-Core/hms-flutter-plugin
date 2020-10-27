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

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.helper.BodySkeletonDisplay;
import com.huawei.hms.plugin.ar.core.helper.BodySkeletonLineDisplay;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;

import com.huawei.hiar.ARBody;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARSession;

import java.util.ArrayList;
import java.util.Collection;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARBodyRenderer extends ARBaseRenderer {
    private static final int PROJECTION_MATRIX_OFFSET = 0;
    private static final float PROJECTION_MATRIX_NEAR = 0.1f;
    private static final float PROJECTION_MATRIX_FAR = 100.f;

    private BodySkeletonDisplay bodySkeletonDisplay;
    private BodySkeletonLineDisplay bodySkeletonLineDisplay;

    public ARBodyRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase pluginConfigBase) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfigBase);
        bodySkeletonDisplay = new BodySkeletonDisplay(pluginConfigBase);
        bodySkeletonLineDisplay = new BodySkeletonLineDisplay(pluginConfigBase);
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        GLES20.glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        bodySkeletonDisplay.init();
        bodySkeletonLineDisplay.init();
        textureDisplay.init();
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT | GLES20.GL_DEPTH_BUFFER_BIT);

        if (arSession == null) return;
        if (displayRotationManager.isDeviceRotated())
            displayRotationManager.updateARSessionDisplayGeometry(arSession);

        arSession.setCameraTextureName(textureDisplay.getExternalTextureId());
        ARFrame arFrame = arSession.update();
        float[] projectionMatrix = new float[16];
        ARCamera camera = arFrame.getCamera();

        camera.getProjectionMatrix(projectionMatrix, PROJECTION_MATRIX_OFFSET, PROJECTION_MATRIX_NEAR,
                PROJECTION_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARBody> arBodyCollection = arSession.getAllTrackables(ARBody.class);
        callbackHelper.onDrawFrame(new ArrayList<>(arBodyCollection));
        if (((ARPluginConfigBody) pluginConfig).isDrawLine())
            bodySkeletonLineDisplay.onDrawFrame(arBodyCollection, projectionMatrix);
        if (((ARPluginConfigBody) pluginConfig).isDrawPoint())
            bodySkeletonDisplay.onDrawFrame(arBodyCollection, projectionMatrix);
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        textureDisplay.onSurfaceChanged(width, height);
        GLES20.glViewport(0, 0, width, height);
        displayRotationManager.updateViewportRotation(width, height);
    }
}
