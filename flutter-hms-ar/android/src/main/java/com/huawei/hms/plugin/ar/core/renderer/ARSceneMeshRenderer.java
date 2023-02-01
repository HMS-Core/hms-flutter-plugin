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

import android.content.Context;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARSceneMesh;
import com.huawei.hiar.ARSession;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigSceneMesh;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.ObjectDisplay;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.sceneMesh.SceneMeshDisplay;
import com.huawei.hms.plugin.ar.core.helper.sceneMesh.SceneMeshDrawFrameListener;

import java.util.ArrayList;
import java.util.concurrent.ArrayBlockingQueue;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARSceneMeshRenderer extends ARBaseDrawObject {
    private SceneMeshDisplay sceneMesh = new SceneMeshDisplay();

    private SceneMeshDrawFrameListener listener;

    public ARSceneMeshRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigSceneMesh configBase,
        ArrayBlockingQueue<GestureEvent> queuedSingleTaps, Context context) {
        super(arSession, displayRotationManager, textureDisplay, configBase);
        this.queuedSingleTaps = queuedSingleTaps;
        this.context = context;
        virtualObjects = new ArrayList<>();
        objectDisplay = new ObjectDisplay(configBase.getObjPath(), configBase.getTexturePath());
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        objectDisplay.init(context);
        sceneMesh.init(context);
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        super.onSurfaceChanged(gl10, width, height);
        objectDisplay.setSize(width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);
        ARFrame arFrame = arSession.update();

        setEnvTextureData();

        ARCamera arCamera = arFrame.getCamera();

        float[] projectionMatrix = new float[16];
        arCamera.getProjectionMatrix(projectionMatrix, PROJ_MATRIX_OFFSET, PROJ_MATRIX_NEAR, PROJ_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);

        if (hasError) {
            return;
        }

        StringBuilder sb = new StringBuilder();
        updateMessageData(sb);
        messageDataListener.handleMessageData(sb.toString());

        float[] viewMatrix = new float[16];
        arCamera.getViewMatrix(viewMatrix, 0);
        handleGestureEvent(arFrame, arCamera, projectionMatrix, viewMatrix);
        ARLightEstimate lightEstimate = arFrame.getLightEstimate();
        float lightPixelIntensity = 1f;
        if (lightEstimate.getState() != ARLightEstimate.State.NOT_VALID) {
            lightPixelIntensity = lightEstimate.getPixelIntensity();
        }

        sceneMesh.onDrawFrame(arFrame, viewMatrix, projectionMatrix);
        ARSceneMesh arSceneMesh = arFrame.acquireSceneMesh();
        this.listener.onDrawFrame(arSceneMesh);

        drawAllObjects(projectionMatrix, viewMatrix, lightPixelIntensity);

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }

    }

    private void updateMessageData(StringBuilder sb) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS=").append(fpsResult);
    }

    public void setSceneMeshListener(SceneMeshDrawFrameListener listener) {
        this.listener = listener;
    }
}
