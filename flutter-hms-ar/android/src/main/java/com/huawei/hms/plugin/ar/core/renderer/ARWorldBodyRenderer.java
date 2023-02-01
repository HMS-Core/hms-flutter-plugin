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

import com.huawei.hiar.ARBody;
import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARPointCloud;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorldBody;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.LabelDisplay;
import com.huawei.hms.plugin.ar.core.helper.ObjectDisplay;
import com.huawei.hms.plugin.ar.core.helper.PointCloudRenderer;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.body.BodySkeletonDisplay;
import com.huawei.hms.plugin.ar.core.helper.body.BodySkeletonLineDisplay;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.ArrayBlockingQueue;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARWorldBodyRenderer extends ARBaseDrawObject {
    private static final String TAG = ARBaseRenderer.class.getSimpleName();

    private PointCloudRenderer pointCloud = new PointCloudRenderer();

    private LabelDisplay labelDisplay;

    private BodySkeletonDisplay bodySkeletonDisplay;

    private BodySkeletonLineDisplay bodySkeletonLineDisplay;

    public ARWorldBodyRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigWorldBody pluginConfig,
        ArrayBlockingQueue<GestureEvent> queuedSingleTaps, Context context) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfig);
        this.queuedSingleTaps = queuedSingleTaps;
        this.context = context;
        virtualObjects = new ArrayList<>();
        objectDisplay = new ObjectDisplay(pluginConfig.getObjPath(), pluginConfig.getTexturePath());
        bodySkeletonDisplay = new BodySkeletonDisplay(pluginConfig.getPointColor(), pluginConfig.getPointSize());
        bodySkeletonLineDisplay = new BodySkeletonLineDisplay(pluginConfig.getLineColor(), pluginConfig.getLineWidth());
        labelDisplay = new LabelDisplay();
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        bodySkeletonDisplay.init();
        bodySkeletonLineDisplay.init();

        objectDisplay.init(context);
        pointCloud.init(context);

        initLabelDisplay();
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

        float[] viewMatrix = new float[16];
        arCamera.getViewMatrix(viewMatrix, 0);
        handleGestureEvent(arFrame, arCamera, projectionMatrix, viewMatrix);
        ARLightEstimate lightEstimate = arFrame.getLightEstimate();
        float lightPixelIntensity = 1f;
        if (lightEstimate.getState() != ARLightEstimate.State.NOT_VALID) {
            lightPixelIntensity = lightEstimate.getPixelIntensity();
        }

        Collection<ARBody> bodies = arSession.getAllTrackables(ARBody.class);
        callbackHelper.onDrawFrame(new ArrayList<>(bodies));
        if (((ARPluginConfigWorldBody) pluginConfig).isDrawPoint()) {
            bodySkeletonDisplay.onDrawFrame(bodies, projectionMatrix);
        }
        if (((ARPluginConfigWorldBody) pluginConfig).isDrawLine()) {
            bodySkeletonLineDisplay.onDrawFrame(bodies, projectionMatrix);
        }
        if (((ARPluginConfigWorldBody) pluginConfig).isLabelDraw()) {
            labelDisplay.onDrawFrame(arSession.getAllTrackables(ARPlane.class), arCamera.getDisplayOrientedPose(),
                projectionMatrix);
        }

        ARPointCloud arPointCloud = arFrame.acquirePointCloud();

        drawAllObjects(projectionMatrix, viewMatrix, lightPixelIntensity);
        pointCloud.onDrawFrame(arPointCloud, viewMatrix, projectionMatrix);

        StringBuilder sb = new StringBuilder();
        updateMessageData(bodies, sb);
        messageDataListener.handleMessageData(sb.toString());

        if (!lock) {
            cameraConfigListener.handleCameraConfigData(arSession.getCameraConfig());
            cameraIntrinsicsListener.handleCameraIntrinsicsData(arCamera.getCameraImageIntrinsics());
            lock = true;
        }
    }

    private void updateMessageData(Collection<ARBody> bodies, StringBuilder sb) {
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
        sb.append("virtual object number: ").append(virtualObjects.size()).append(System.lineSeparator());
    }

    private void initLabelDisplay() {
        if (pluginConfig instanceof ARPluginConfigWorldBody) {
            ARPluginConfigWorldBody pluginWorld = (ARPluginConfigWorldBody) pluginConfig;
            labelDisplay.init(getPlaneBitmaps(pluginWorld));
        }
    }

    private Bitmap getBitmap(String imageOther, String textOther, ColorRGBA colorOther) {
        android.graphics.Matrix matrix = new android.graphics.Matrix();
        matrix.setScale(-1, -1);
        if (imageOther != null && !imageOther.isEmpty()) {
            return getImageBitmap(matrix, imageOther);
        }
        return getTextBitmap(matrix, textOther, colorOther);
    }

    private ArrayList<Bitmap> getPlaneBitmaps(ARPluginConfigWorldBody pluginWorld) {
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

    private Bitmap getImageBitmap(android.graphics.Matrix matrix, String assetFileName) {
        try (InputStream inputStream = context.getAssets().open(assetFileName)) {
            Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
            return Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        } catch (IllegalArgumentException | IOException e) {
            Log.e(TAG, "Get data error!");
        }
        return null;
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
}
