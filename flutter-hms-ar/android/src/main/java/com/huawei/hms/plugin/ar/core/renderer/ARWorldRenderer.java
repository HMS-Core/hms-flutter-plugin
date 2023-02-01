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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.Log;
import android.util.Pair;

import com.huawei.hiar.ARAnchor;
import com.huawei.hiar.ARAugmentedImage;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARPointCloud;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.LabelDisplay;
import com.huawei.hms.plugin.ar.core.helper.ObjectDisplay;
import com.huawei.hms.plugin.ar.core.helper.PointCloudRenderer;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.augmentedImage.ImageKeyLineDisplay;
import com.huawei.hms.plugin.ar.core.helper.augmentedImage.ImageKeyPointDisplay;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ArrayBlockingQueue;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARWorldRenderer extends ARBaseDrawObject {
    private static final String TAG = ARBaseRenderer.class.getSimpleName();

    private static final int PROJ_MATRIX_OFFSET = 0;

    private static final float PROJ_MATRIX_NEAR = 0.1f;

    private static final float PROJ_MATRIX_FAR = 100.0f;

    private LabelDisplay labelDisplay;

    private Context context;

    private ImageKeyPointDisplay imageKeyPointDisplay;

    private ImageKeyLineDisplay imageKeyLineDisplay;

    private PointCloudRenderer pointCloud = new PointCloudRenderer();

    private Map<Integer, Pair<ARAugmentedImage, ARAnchor>> augmentedImageMap = new HashMap<>();

    public ARWorldRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigWorld pluginConfig,
        ArrayBlockingQueue<GestureEvent> queuedSingleTaps, Context context) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfig);
        this.queuedSingleTaps = queuedSingleTaps;
        this.context = context;
        virtualObjects = new ArrayList<>();
        objectDisplay = new ObjectDisplay(pluginConfig.getObjPath(), pluginConfig.getTexturePath());
        labelDisplay = new LabelDisplay();
        imageKeyPointDisplay = new ImageKeyPointDisplay(pluginConfig.getPointColor(), pluginConfig.getPointSize());
        imageKeyLineDisplay = new ImageKeyLineDisplay(pluginConfig.getLineColor(), pluginConfig.getLineWidth());
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        objectDisplay.init(context);
        pointCloud.init(context);
        initLabelDisplay();
    }

    private void initLabelDisplay() {
        if (pluginConfig instanceof ARPluginConfigWorld) {
            ARPluginConfigWorld pluginWorld = (ARPluginConfigWorld) pluginConfig;
            labelDisplay.init(getPlaneBitmaps(pluginWorld));
        }
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
        updateMessageData(arFrame, sb);
        messageDataListener.handleMessageData(sb.toString());

        if (callbackHelper != null) {
            callbackHelper.onDrawFrame(new ArrayList<>(arSession.getAllTrackables(ARPlane.class)));
        }
        float[] viewMatrix = new float[16];
        arCamera.getViewMatrix(viewMatrix, 0);
        handleGestureEvent(arFrame, arCamera, projectionMatrix, viewMatrix);
        ARLightEstimate lightEstimate = arFrame.getLightEstimate();
        float lightPixelIntensity = 1;
        if (lightEstimate.getState() != ARLightEstimate.State.NOT_VALID) {
            lightPixelIntensity = lightEstimate.getPixelIntensity();
        }



        if (((ARPluginConfigWorld) pluginConfig).isLabelDraw()) {
            labelDisplay.onDrawFrame(arSession.getAllTrackables(ARPlane.class), arCamera.getDisplayOrientedPose(),
                projectionMatrix);
        }

        ARPointCloud arPointCloud = arFrame.acquirePointCloud();

        drawAllObjects(projectionMatrix, viewMatrix, lightPixelIntensity);
        pointCloud.onDrawFrame(arPointCloud, viewMatrix, projectionMatrix);

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }

        drawAugmentedImages(arFrame, projectionMatrix, viewMatrix);
    }

    private void updateMessageData(ARFrame arFrame, StringBuilder sb) {
        float fpsResult = doFpsCalculate();
        sb.append("FPS=").append(fpsResult).append(System.lineSeparator());

        ARLightEstimate lightEstimate = arFrame.getLightEstimate();

        if ((lightEstimate.getState() != ARLightEstimate.State.VALID)) {
            return;
        }

        // Obtain the estimated light data when the light intensity mode is enabled.
        if ((((ARPluginConfigWorld) pluginConfig).getLightMode() & ARConfigBase.LIGHT_MODE_AMBIENT_INTENSITY) != 0) {
            sb.append("PixelIntensity=").append(lightEstimate.getPixelIntensity()).append(System.lineSeparator());
        }
        // Obtain the texture data when the environment texture mode is enabled.
        if ((((ARPluginConfigWorld) pluginConfig).getLightMode() & ARConfigBase.LIGHT_MODE_ENVIRONMENT_LIGHTING) != 0) {
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

    private Bitmap getTextBitmap(android.graphics.Matrix matrix, String text, ColorRGBA color) {
        Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        paint.setTextSize(100);
        paint.setColor(color.getColor().toArgb());
        float baseline = -paint.ascent();
        Bitmap image = Bitmap.createBitmap((int) (paint.measureText(text) + 1.f),
            (int) (baseline + paint.descent() + 1.f), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(image);
        canvas.drawText(text, 0, baseline, paint);
        return Bitmap.createBitmap(image, 0, 0, image.getWidth(), image.getHeight(), matrix, true);
    }

    private Bitmap getImageBitmap(android.graphics.Matrix matrix, String assetFileName) {
        try (InputStream inputStream = context.getAssets().open(assetFileName)) {
            Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
            return Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        } catch (final OutOfMemoryError | IllegalArgumentException | IOException e) {
            Log.e(TAG, "Get data error!");
        }
        return null;
    }

    private Bitmap getBitmap(String imageOther, String textOther, ColorRGBA colorOther) {
        android.graphics.Matrix matrix = new android.graphics.Matrix();
        matrix.setScale(-1, -1);
        if (imageOther != null && !imageOther.isEmpty()) {
            return getImageBitmap(matrix, imageOther);
        }
        return getTextBitmap(matrix, textOther, colorOther);
    }

    private ArrayList<Bitmap> getPlaneBitmaps(ARPluginConfigWorld pluginWorld) {
        ArrayList<Bitmap> bitmaps = new ArrayList<>();
        bitmaps.add(getBitmap(pluginWorld.getImageOther(), pluginWorld.getTextOther(), pluginWorld.getColorOther()));
        bitmaps.add(getBitmap(pluginWorld.getImageWall(), pluginWorld.getTextWall(), pluginWorld.getColorWall()));
        bitmaps.add(getBitmap(pluginWorld.getImageFloor(), pluginWorld.getTextFloor(), pluginWorld.getColorFloor()));
        bitmaps.add(getBitmap(pluginWorld.getImageSeat(), pluginWorld.getTextSeat(), pluginWorld.getColorSeat()));
        bitmaps.add(getBitmap(pluginWorld.getImageTable(), pluginWorld.getTextTable(), pluginWorld.getColorTable()));
        bitmaps.add(
            getBitmap(pluginWorld.getImageCeiling(), pluginWorld.getTextCeiling(), pluginWorld.getColorCeiling()));
        bitmaps.add(getBitmap(pluginWorld.getImageDoor(), pluginWorld.getTextDoor(), pluginWorld.getColorDoor()));
        bitmaps.add(getBitmap(pluginWorld.getImageWindow(), pluginWorld.getTextWindow(), pluginWorld.getColorWindow()));
        bitmaps.add(getBitmap(pluginWorld.getImageBed(), pluginWorld.getTextBed(), pluginWorld.getColorBed()));
        return bitmaps;
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

            if (((ARPluginConfigWorld) pluginConfig).isDrawLine()) {
                imageKeyLineDisplay.onDrawFrame(augmentedImage, viewmtx, projmtx);
            }

            if (((ARPluginConfigWorld) pluginConfig).isDrawPoint()) {
                imageKeyPointDisplay.onDrawFrame(augmentedImage, viewmtx, projmtx);
            }
        }
    }

    private void initTrackingImages(ARAugmentedImage augmentedImage) {
        // Create an anchor for the newly found image and bind it to the image object.
        if (!augmentedImageMap.containsKey(augmentedImage.getIndex())) {
            ARAnchor centerPoseAnchor = augmentedImage.createAnchor(augmentedImage.getCenterPose());
            augmentedImageMap.put(augmentedImage.getIndex(), Pair.create(augmentedImage, centerPoseAnchor));
        }
    }
}
