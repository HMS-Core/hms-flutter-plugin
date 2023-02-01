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
import android.util.Log;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARFace;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARPose;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hiar.listener.FaceHealthServiceListener;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.face.FaceGeometryDisplay;
import com.huawei.hms.plugin.ar.core.helper.face.FaceHealthyResult;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.EventObject;
import java.util.HashMap;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARFaceRenderer extends ARBaseRenderer implements FaceHealthServiceListener {
    private final static String TAG = ARFaceRenderer.class.getSimpleName();

    private static final int MAX_PROGRESS = 100;

    protected FaceHealthServiceListener faceHealthyListener;

    protected FaceHealthyResult faceHealthyResult;

    private int textureId = -1;

    private FaceGeometryDisplay faceGeometryDisplay;

    private Context context;

    private boolean health;

    private int progress = 0;

    public ARFaceRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase pluginConfigBase, Context context, boolean health) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfigBase);
        this.context = context;
        this.arSession.addServiceListener(this);
        this.health = health;

    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        Log.i(TAG, "onSurfaceCreated: textureId : " + textureId);
        faceGeometryDisplay = new FaceGeometryDisplay(context, pluginConfig);
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        super.onSurfaceChanged(gl10, width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);

        ARFrame arFrame = arSession.update();
        textureDisplay.onDrawFrame(arFrame);
        Collection<ARFace> arFaceCollection = arSession.getAllTrackables(ARFace.class);
        if (callbackHelper != null) {
            callbackHelper.onDrawFrame(new ArrayList<>(arFaceCollection));
        }
        ARCamera arCamera = arFrame.getCamera();
        for (ARFace face : arFaceCollection) {
            if (face.getTrackingState() == ARTrackable.TrackingState.TRACKING && this.health) {
                HashMap<ARFace.HealthParameter, Float> healthParams = face.getHealthParameters();
                if (progress < MAX_PROGRESS) {
                    updateHealthParamTable(healthParams);
                }
            } else if (face.getTrackingState() == ARTrackable.TrackingState.TRACKING
                && ((ARPluginConfigFace) pluginConfig).isDrawFace() && !this.health) {
                faceGeometryDisplay.onDrawFrame(arCamera, face);
            }
        }

        StringBuilder sb = new StringBuilder();
        updateMessageData(sb, arFaceCollection, arFrame);
        messageDataListener.handleMessageData(sb.toString());

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }
    }

    public void setFaceHealthyListener(FaceHealthServiceListener faceHealthyListener) {
        this.faceHealthyListener = faceHealthyListener;
    }

    public void setFaceHealthyResult(FaceHealthyResult faceHealthyResult) {
        this.faceHealthyResult = faceHealthyResult;
    }

    public void setHealthCheckProgress(int progress) {
        this.progress = progress;
    }

    @Override
    public void handleProcessProgressEvent(int i) {
        Log.i(TAG, "FaceHealthyListener handleProcessProgressEvent:" + i);
        this.faceHealthyListener.handleProcessProgressEvent(i);

    }

    @Override
    public void handleEvent(EventObject eventObject) {
        Log.i(TAG, "FaceHealthyListener handleEvent Object:" + eventObject);
        this.faceHealthyListener.handleEvent(eventObject);
    }

    private void updateHealthParamTable(final HashMap<ARFace.HealthParameter, Float> healthParams) {

        StringBuilder sb = new StringBuilder();
        sb.append("{ \"" + ARFace.HealthParameter.PARAMETER_HEART_RATE.toString() + "\":" + healthParams.getOrDefault(
            ARFace.HealthParameter.PARAMETER_HEART_RATE, 0.0f).toString() + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_FACE_AGE.toString() + "\":" + healthParams.getOrDefault(
            ARFace.HealthParameter.PARAMETER_FACE_AGE, 0.0f).toString() + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_BREATH_RATE_CONFIDENCE.toString() + "\":"
            + healthParams.getOrDefault(ARFace.HealthParameter.PARAMETER_BREATH_RATE_CONFIDENCE, 0.0f).toString()
            + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_HEART_WAVE.toString() + "\":" + healthParams.getOrDefault(
            ARFace.HealthParameter.PARAMETER_HEART_WAVE, 0.0f).toString() + ",");
        sb.append(
            "\"" + ARFace.HealthParameter.PARAMETER_BREATH_RATE_SNR.toString() + "\":" + healthParams.getOrDefault(
                ARFace.HealthParameter.PARAMETER_BREATH_RATE_SNR, 0.0f).toString() + ",");
        sb.append(
            "\"" + ARFace.HealthParameter.PARAMETER_GENDER_FEMALE_WEIGHT.toString() + "\":" + healthParams.getOrDefault(
                ARFace.HealthParameter.PARAMETER_GENDER_FEMALE_WEIGHT, 0.0f).toString() + ",");
        sb.append(
            "\"" + ARFace.HealthParameter.PARAMETER_GENDER_MALE_WEIGHT.toString() + "\":" + healthParams.getOrDefault(
                ARFace.HealthParameter.PARAMETER_GENDER_MALE_WEIGHT, 0.0f).toString() + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_HEART_RATE_CONFIDENCE.toString() + "\":"
            + healthParams.getOrDefault(ARFace.HealthParameter.PARAMETER_HEART_RATE_CONFIDENCE, 0.0f).toString() + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_HEART_RATE_SNR.toString() + "\":" + healthParams.getOrDefault(
            ARFace.HealthParameter.PARAMETER_HEART_RATE_SNR, 0.0f).toString() + ",");
        sb.append("\"" + ARFace.HealthParameter.PARAMETER_BREATH_RATE.toString() + "\":" + healthParams.getOrDefault(
            ARFace.HealthParameter.PARAMETER_BREATH_RATE, 0.0f).toString() + "}");

        this.faceHealthyResult.handleResult(sb.toString());
    }

    private void updateMessageData(StringBuilder sb, Collection<ARFace> faces, ARFrame frame) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS= ").append(fpsResult).append(System.lineSeparator());
        int index = 1;
        for (ARFace face : faces) {
            if (face.getTrackingState() != ARTrackable.TrackingState.TRACKING) {
                continue;
            }
            ARPose pose = face.getPose();
            if (pose == null) {
                continue;
            }
            sb.append("face " + index + " pose information:");
            sb.append("face pose tx:[").append(pose.tx()).append("]").append(System.lineSeparator());
            sb.append("face pose ty:[").append(pose.ty()).append("]").append(System.lineSeparator());
            sb.append("face pose tz:[").append(pose.tz()).append("]").append(System.lineSeparator());
            sb.append(System.lineSeparator());

            float[] textureCoordinates = face.getFaceGeometry().getTextureCoordinates().array();
            sb.append(" textureCoordinates length:[ ").append(textureCoordinates.length).append(" ]");
            sb.append(System.lineSeparator()).append(System.lineSeparator());
            index++;

            ARLightEstimate lightEstimate = frame.getLightEstimate();
            if (lightEstimate == null) {
                Log.w(TAG, "lightEstimate is null.");
                continue;
            }

            // Obtain the data of main light source and ambient light
            // when the ambient lighting estimation mode is enabled.
            if ((((ARPluginConfigFace) pluginConfig).getLightMode() & ARConfigBase.LIGHT_MODE_ENVIRONMENT_LIGHTING)
                != 0) {
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
                sb.append("LightShadowStrength=")
                    .append(lightEstimate.getShadowStrength())
                    .append(System.lineSeparator());
                sb.append("LightSphericalHarmonicCoefficients=")
                    .append(Arrays.toString(lightEstimate.getSphericalHarmonicCoefficients()))
                    .append(System.lineSeparator());
            }
        }
    }

}
