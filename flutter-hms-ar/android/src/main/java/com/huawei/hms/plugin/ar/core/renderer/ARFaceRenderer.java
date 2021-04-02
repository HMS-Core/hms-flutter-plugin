/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import android.opengl.GLES20;
import android.util.Log;

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.FaceGeometryDisplay;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFace;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;

import java.util.ArrayList;
import java.util.Collection;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARFaceRenderer extends ARBaseRenderer {
    private static final String TAG = ARFaceRenderer.class.getSimpleName();

    private int textureId = -1;
    private FaceGeometryDisplay faceGeometryDisplay;

    private Context context;

    public ARFaceRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase pluginConfigBase, Context context) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfigBase);
        this.context = context;
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        GLES20.glClearColor(0.1f, 0.1f, 0.1f, 1.0f);

        textureDisplay.init();
        Log.i(TAG, "onSurfaceCreated: textureId : " + textureId);
        faceGeometryDisplay = new FaceGeometryDisplay(context, pluginConfig);
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

        if (arSession == null) return;
        if (displayRotationManager.isDeviceRotated())
            displayRotationManager.updateARSessionDisplayGeometry(arSession);

        arSession.setCameraTextureName(textureDisplay.getExternalTextureId());
        ARFrame arFrame = arSession.update();
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARFace> arFaceCollection = arSession.getAllTrackables(ARFace.class);
        callbackHelper.onDrawFrame(new ArrayList<>(arFaceCollection));
        ARCamera arCamera = arFrame.getCamera();
        for (ARFace face : arFaceCollection) {
            if (face.getTrackingState() == ARTrackable.TrackingState.TRACKING
                && ((ARPluginConfigFace) pluginConfig).isDrawFace())
                faceGeometryDisplay.onDrawFrame(arCamera, face);
        }
    }
}
