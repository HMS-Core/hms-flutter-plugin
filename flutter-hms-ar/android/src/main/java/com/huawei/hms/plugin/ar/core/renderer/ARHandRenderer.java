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

import android.util.Log;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARHand;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARSession;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.hand.HandBoxDisplay;
import com.huawei.hms.plugin.ar.core.helper.hand.HandSkeletonDisplay;
import com.huawei.hms.plugin.ar.core.helper.hand.HandSkeletonLineDisplay;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARHandRenderer extends ARBaseRenderer {
    private final static String TAG = ARHandRenderer.class.getSimpleName();

    private static final int PROJECTION_MATRIX_OFFSET = 0;

    private static final float PROJECTION_MATRIX_NEAR = 0.1f;

    private static final float PROJECTION_MATRIX_FAR = 100.0f;

    private HandBoxDisplay handBoxDisplay;

    private HandSkeletonDisplay handSkeletonDisplay;

    private HandSkeletonLineDisplay handSkeletonLineDisplay;

    public ARHandRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase config) {
        super(arSession, displayRotationManager, textureDisplay, config);
        this.pluginConfig = config;
        handBoxDisplay = new HandBoxDisplay(pluginConfig);
        handSkeletonDisplay = new HandSkeletonDisplay(config);
        handSkeletonLineDisplay = new HandSkeletonLineDisplay(config);
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        handBoxDisplay.init();
        handSkeletonDisplay.init();
        handSkeletonLineDisplay.init();
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        super.onSurfaceChanged(gl10, width, height);
        Log.d("ARHandRenderer", "onSurfaceChanged :: (width=" + width + ", height=" + height + ")");
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);

        ARFrame arFrame = arSession.update();
        ARCamera arCamera = arFrame.getCamera();

        float[] projectionMatrix = new float[16];

        arCamera.getProjectionMatrix(projectionMatrix, PROJECTION_MATRIX_OFFSET, PROJECTION_MATRIX_NEAR,
            PROJECTION_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARHand> arHandCollection = arSession.getAllTrackables(ARHand.class);

        for (ARHand hand : arHandCollection) {
            // Update the hand recognition information to be displayed on the screen.
            StringBuilder sb = new StringBuilder();
            updateMessageData(sb, hand);

            // Display hand recognition information on the screen.
            this.messageDataListener.handleMessageData(sb.toString());
        }

        if (callbackHelper != null) {
            callbackHelper.onDrawFrame(new ArrayList<>(arHandCollection));
        }
        if (pluginConfig instanceof ARPluginConfigHand) {
            ARPluginConfigHand configHand = (ARPluginConfigHand) pluginConfig;
            if (configHand.isDrawBox()) {
                handBoxDisplay.onDrawFrame(arHandCollection, projectionMatrix);
            }
            if (configHand.isDrawPoint()) {
                handSkeletonDisplay.onDrawFrame(arHandCollection, projectionMatrix);
            }
            if (configHand.isDrawLine()) {
                handSkeletonLineDisplay.onDrawFrame(arHandCollection, projectionMatrix);
            }
        }

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }
    }

    private void updateMessageData(StringBuilder sb, ARHand hand) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS=").append(fpsResult).append(System.lineSeparator());
        addHandNormalStringBuffer(sb, hand);
        addGestureActionStringBuffer(sb, hand);
        addGestureCenterStringBuffer(sb, hand);
        float[] gestureHandBoxPoints = hand.getGestureHandBox();

        sb.append("GestureHandBox length:[")
            .append(gestureHandBoxPoints.length)
            .append("]")
            .append(System.lineSeparator());
        for (int i = 0; i < gestureHandBoxPoints.length; i++) {
            Log.i(TAG, "gesturePoints:" + gestureHandBoxPoints[i]);
            sb.append("gesturePoints[")
                .append(i)
                .append("]:[")
                .append(gestureHandBoxPoints[i])
                .append("]")
                .append(System.lineSeparator());
        }
        addHandSkeletonStringBuffer(sb, hand);
    }

    private void addHandNormalStringBuffer(StringBuilder sb, ARHand hand) {
        sb.append("GestureType=").append(hand.getGestureType()).append(System.lineSeparator());
        sb.append("GestureCoordinateSystem=").append(hand.getGestureCoordinateSystem()).append(System.lineSeparator());
        float[] gestureOrientation = hand.getGestureOrientation();
        sb.append("gestureOrientation length:[")
            .append(gestureOrientation.length)
            .append("]")
            .append(System.lineSeparator());
        for (int i = 0; i < gestureOrientation.length; i++) {
            Log.i(TAG, "gestureOrientation:" + gestureOrientation[i]);
            sb.append("gestureOrientation[")
                .append(i)
                .append("]:[")
                .append(gestureOrientation[i])
                .append("]")
                .append(System.lineSeparator());
        }
        sb.append(System.lineSeparator());
    }

    private void addGestureActionStringBuffer(StringBuilder sb, ARHand hand) {
        int[] gestureAction = hand.getGestureAction();
        sb.append("gestureAction length:[").append(gestureAction.length).append("]").append(System.lineSeparator());
        for (int i = 0; i < gestureAction.length; i++) {
            Log.i(TAG, "GestureAction:" + gestureAction[i]);
            sb.append("gestureAction[")
                .append(i)
                .append("]:[")
                .append(gestureAction[i])
                .append("]")
                .append(System.lineSeparator());
        }
        sb.append(System.lineSeparator());
    }

    private void addGestureCenterStringBuffer(StringBuilder sb, ARHand hand) {
        float[] gestureCenter = hand.getGestureCenter();
        sb.append("gestureCenter length:[").append(gestureCenter.length).append("]").append(System.lineSeparator());
        for (int i = 0; i < gestureCenter.length; i++) {
            Log.i(TAG, "GestureCenter:" + gestureCenter[i]);
            sb.append("gestureCenter[")
                .append(i)
                .append("]:[")
                .append(gestureCenter[i])
                .append("]")
                .append(System.lineSeparator());
        }
        sb.append(System.lineSeparator());
    }

    private void addHandSkeletonStringBuffer(StringBuilder sb, ARHand hand) {
        sb.append(System.lineSeparator()).append("HandType=").append(hand.getHandtype()).append(System.lineSeparator());
        sb.append("SkeletonCoordinateSystem=").append(hand.getSkeletonCoordinateSystem());
        sb.append(System.lineSeparator());
        float[] skeletonArray = hand.getHandskeletonArray();
        sb.append("HandSkeletonArray length:[").append(skeletonArray.length).append("]").append(System.lineSeparator());
        Log.i(TAG, "SkeletonArray.length:" + skeletonArray.length);
        for (int i = 0; i < skeletonArray.length; i++) {
            Log.i(TAG, "SkeletonArray:" + skeletonArray[i]);
        }
        sb.append(System.lineSeparator());
        int[] handSkeletonConnection = hand.getHandSkeletonConnection();
        sb.append("HandSkeletonConnection length:[")
            .append(handSkeletonConnection.length)
            .append("]")
            .append(System.lineSeparator());
        Log.i(TAG, "handSkeletonConnection.length:" + handSkeletonConnection.length);
        for (int i = 0; i < handSkeletonConnection.length; i++) {
            Log.i(TAG, "handSkeletonConnection:" + handSkeletonConnection[i]);
        }
        sb.append(System.lineSeparator()).append("-----------------------------------------------------");
    }

    private void updateMessageData(ARFrame arFrame, StringBuilder sb) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS=").append(fpsResult).append(System.lineSeparator());

        ARLightEstimate lightEstimate = arFrame.getLightEstimate();

        if ((lightEstimate.getState() != ARLightEstimate.State.VALID)) {
            return;
        }

        // Obtain the estimated light data when the light intensity mode is enabled.
        if ((((ARPluginConfigHand) pluginConfig).getLightMode() & ARConfigBase.LIGHT_MODE_AMBIENT_INTENSITY) != 0) {
            sb.append("PixelIntensity=").append(lightEstimate.getPixelIntensity()).append(System.lineSeparator());
        }
        // Obtain the texture data when the environment texture mode is enabled.
        if ((((ARPluginConfigHand) pluginConfig).getLightMode() & ARConfigBase.LIGHT_MODE_ENVIRONMENT_LIGHTING) != 0) {
            sb.append("PrimaryLightIntensity=")
                .append(lightEstimate.getPrimaryLightIntensity())
                .append(System.lineSeparator());
            sb.append("PrimaryLightDirection=")
                .append(Arrays.toString(lightEstimate.getPrimaryLightDirection()))
                .append(System.lineSeparator());
            sb.append("PrimaryLightColor=")
                .append(Arrays.toString(lightEstimate.getPrimaryLightColor()))
                .append(System.lineSeparator());
            sb.append("LightShadowType=").append(lightEstimate.getLightShadowType()).append(System.lineSeparator());
            sb.append("LightShadowStrength=").append(lightEstimate.getShadowStrength()).append(System.lineSeparator());
            sb.append("LightSphericalHarmonicCoefficients=")
                .append(Arrays.toString(lightEstimate.getSphericalHarmonicCoefficients()))
                .append(System.lineSeparator());
        }
    }
}
