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

import com.huawei.hiar.ARBody;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.body.BodySkeletonDisplay;
import com.huawei.hms.plugin.ar.core.helper.body.BodySkeletonLineDisplay;

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
        TextureDisplay textureDisplay, ARPluginConfigBody pluginConfig) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfig);
        bodySkeletonDisplay = new BodySkeletonDisplay(pluginConfig.getPointColor(), pluginConfig.getPointSize());
        bodySkeletonLineDisplay = new BodySkeletonLineDisplay(pluginConfig.getLineColor(), pluginConfig.getLineWidth());
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        bodySkeletonDisplay.init();
        bodySkeletonLineDisplay.init();
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);
        ARFrame arFrame = arSession.update();
        float[] projectionMatrix = new float[16];
        ARCamera camera = arFrame.getCamera();

        camera.getProjectionMatrix(projectionMatrix, PROJECTION_MATRIX_OFFSET, PROJECTION_MATRIX_NEAR,
            PROJECTION_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARBody> arBodyCollection = arSession.getAllTrackables(ARBody.class);
        if (callbackHelper != null) {
            callbackHelper.onDrawFrame(new ArrayList<>(arBodyCollection));
        }
        if (((ARPluginConfigBody) pluginConfig).isDrawLine()) {
            bodySkeletonLineDisplay.onDrawFrame(arBodyCollection, projectionMatrix);
        }
        if (((ARPluginConfigBody) pluginConfig).isDrawPoint()) {
            bodySkeletonDisplay.onDrawFrame(arBodyCollection, projectionMatrix);
        }

        StringBuilder sb = new StringBuilder();
        updateMessageData(sb, arBodyCollection);
        messageDataListener.handleMessageData(sb.toString());

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(camera.getCameraImageIntrinsics());
            lock = true;
        }
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        textureDisplay.onSurfaceChanged(width, height);
        GLES20.glViewport(0, 0, width, height);
        displayRotationManager.updateViewportRotation(width, height);
    }

    private void updateMessageData(StringBuilder sb, Collection<ARBody> bodies) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS=").append(fpsResult).append(System.lineSeparator());
        int trackingBodySum = 0;
        for (ARBody body : bodies) {
            if (body.getTrackingState() != ARTrackable.TrackingState.TRACKING) {
                continue;
            }
            trackingBodySum++;
            sb.append("body action: ").append(body.getBodyAction()).append(System.lineSeparator());
        }
        sb.append("tracking body sum: ").append(trackingBodySum).append(System.lineSeparator());
    }
}
