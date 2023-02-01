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
import android.opengl.Matrix;
import android.util.Log;
import android.util.Pair;

import com.huawei.hiar.ARAnchor;
import com.huawei.hiar.ARAugmentedImage;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hiar.exceptions.ARSessionPausedException;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigAugmentedImage;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.augmentedImage.ImageKeyLineDisplay;
import com.huawei.hms.plugin.ar.core.helper.augmentedImage.ImageKeyPointDisplay;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARAugmentedImageRender extends ARBaseRenderer {
    private final static String TAG = ARAugmentedImageRender.class.getSimpleName();

    private static final int PROJ_MATRIX_SIZE = 16;

    private static final int PROJ_MATRIX_OFFSET = 0;

    private static final float PROJ_MATRIX_NEAR = 0.1f;

    private static final float PROJ_MATRIX_FAR = 100.0f;

    private boolean isImageTrackOnly = false;

    private ImageKeyPointDisplay imageKeyPointDisplay;

    private ImageKeyLineDisplay imageKeyLineDisplay;

    /**
     * Anchors of the augmented image and its related center,
     * which is controlled by the index key of the augmented image in the database.
     */
    private Map<Integer, Pair<ARAugmentedImage, ARAnchor>> augmentedImageMap = new HashMap<>();

    public ARAugmentedImageRender(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigAugmentedImage pluginConfig, Context context) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfig);
        imageKeyPointDisplay = new ImageKeyPointDisplay(pluginConfig.getPointColor(), pluginConfig.getPointSize());
        imageKeyLineDisplay = new ImageKeyLineDisplay(pluginConfig.getLineColor(), pluginConfig.getLineWidth());
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        imageKeyPointDisplay.init();
        imageKeyLineDisplay.init();
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        super.onSurfaceChanged(gl10, width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);
        ARFrame arFrame;
        try {
            arFrame = arSession.update();
        } catch (ARSessionPausedException e) {
            Log.e(TAG, "Invoke session.resume before invoking Session.update.");
            return;
        }
        ARCamera arCamera = arFrame.getCamera();

        textureDisplay.onDrawFrame(arFrame);

        // If tracking is not set, the augmented image is not drawn.
        if (arCamera.getTrackingState() == ARTrackable.TrackingState.PAUSED) {
            Log.i(TAG, "Draw background paused!");
            return;
        }

        // Obtain the projection matrix.
        float[] projectionMatrix = new float[PROJ_MATRIX_SIZE];
        arCamera.getProjectionMatrix(projectionMatrix, PROJ_MATRIX_OFFSET, PROJ_MATRIX_NEAR, PROJ_MATRIX_FAR);

        // Obtain the view matrix.
        float[] viewMatrix = new float[PROJ_MATRIX_SIZE];
        if (isImageTrackOnly) {
            Matrix.setIdentityM(viewMatrix, 0);
        } else {
            arCamera.getViewMatrix(viewMatrix, 0);
        }

        // Draw the augmented image.
        drawAugmentedImages(arFrame, projectionMatrix, viewMatrix);

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }
    }

    private void drawAugmentedImages(ARFrame frame, float[] projmtx, float[] viewmtx) {
        Collection<ARAugmentedImage> updatedAugmentedImages = frame.getUpdatedTrackables(ARAugmentedImage.class);
        callbackHelper.onDrawFrame(new ArrayList<>(updatedAugmentedImages));
        Log.d(TAG, "drawAugmentedImages: Updated augment image is " + updatedAugmentedImages.size());

        // Iteratively update the augmented image mapping and remove the elements that cannot be drawn.
        for (ARAugmentedImage augmentedImage : updatedAugmentedImages) {
            switch (augmentedImage.getTrackingState()) {
                case PAUSED:
                    // When an image is in paused state but the camera is not paused,
                    // the image is detected but not tracked.
                    break;
                case TRACKING:
                    initTrackingImages(augmentedImage);
                    break;
                case STOPPED:
                    augmentedImageMap.remove(augmentedImage.getIndex());
                    break;
                default:
                    break;
            }
        }

        // Map the anchor to the AugmentedImage object and draw all augmentation effects.
        for (Pair<ARAugmentedImage, ARAnchor> pair : augmentedImageMap.values()) {
            ARAugmentedImage augmentedImage = pair.first;
            if (augmentedImage.getTrackingState() != ARTrackable.TrackingState.TRACKING) {
                continue;
            }

            if (((ARPluginConfigAugmentedImage) pluginConfig).isDrawLine()) {
                imageKeyLineDisplay.onDrawFrame(augmentedImage, viewmtx, projmtx);
            }

            if (((ARPluginConfigAugmentedImage) pluginConfig).isDrawPoint()) {
                imageKeyPointDisplay.onDrawFrame(augmentedImage, viewmtx, projmtx);
            }
        }
    }

    private void initTrackingImages(ARAugmentedImage augmentedImage) {
        // Create an anchor for the newly found image and bind it to the image object.
        if (!augmentedImageMap.containsKey(augmentedImage.getIndex())) {
            ARAnchor centerPoseAnchor = null;
            if (!isImageTrackOnly) {
                centerPoseAnchor = augmentedImage.createAnchor(augmentedImage.getCenterPose());
            }
            augmentedImageMap.put(augmentedImage.getIndex(), Pair.create(augmentedImage, centerPoseAnchor));
        }
    }

    public void setImageTrackOnly(boolean isOnlyImageTrack) {
        this.isImageTrackOnly = isOnlyImageTrack;
    }

}
