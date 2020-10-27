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

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.opengl.GLES20;
import android.util.Log;
import android.view.MotionEvent;

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.LabelDisplay;
import com.huawei.hms.plugin.ar.core.helper.ObjectDisplay;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.VirtualObject;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARHitResult;
import com.huawei.hiar.ARLightEstimate;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARPoint;
import com.huawei.hiar.ARPose;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARWorldRenderer extends ARBaseRenderer {
    private static final String TAG = ARBaseRenderer.class.getSimpleName();
    private static final int PROJ_MATRIX_OFFSET = 0;
    private static final float PROJ_MATRIX_NEAR = 0.1f;
    private static final float PROJ_MATRIX_FAR = 100.0f;
    private static final float MATRIX_SCALE_SX = -1.0f;
    private static final float MATRIX_SCALE_SY = -1.0f;

    private static final float[] BLUE_COLORS = new float[]{66.0f, 133.0f, 244.0f, 255.0f};
    private static final float[] GREEN_COLORS = new float[]{66.0f, 133.0f, 244.0f, 255.0f};

    private ArrayBlockingQueue<GestureEvent> queuedSingleTaps;

    private ObjectDisplay objectDisplay;
    private LabelDisplay labelDisplay;
    private List<VirtualObject> virtualObjects;
    private VirtualObject selectedObject;
    private Context context;

    public ARWorldRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase configBase,
        ArrayBlockingQueue<GestureEvent> queuedSingleTaps, Context context) {
        super(arSession, displayRotationManager, textureDisplay, configBase);
        this.queuedSingleTaps = queuedSingleTaps;
        this.context = context;
        virtualObjects = new ArrayList<>();
        objectDisplay = new ObjectDisplay(pluginConfig);
        labelDisplay = new LabelDisplay();
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        GLES20.glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        textureDisplay.init();
        objectDisplay.init(context);
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
        textureDisplay.onSurfaceChanged(width, height);
        GLES20.glViewport(0, 0, width, height);
        displayRotationManager.updateViewportRotation(width, height);
        objectDisplay.setSize(width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT | GLES20.GL_DEPTH_BUFFER_BIT);
        if (arSession == null) return;
        if (displayRotationManager.isDeviceRotated())
            displayRotationManager.updateARSessionDisplayGeometry(arSession);
        arSession.setCameraTextureName(textureDisplay.getExternalTextureId());
        ARFrame arFrame = arSession.update();
        ARCamera arCamera = arFrame.getCamera();

        float[] projectionMatrix = new float[16];
        arCamera.getProjectionMatrix(projectionMatrix, PROJ_MATRIX_OFFSET, PROJ_MATRIX_NEAR, PROJ_MATRIX_FAR);
        textureDisplay.onDrawFrame(arFrame);
        callbackHelper.onDrawFrame(new ArrayList<>(arSession.getAllTrackables(ARPlane.class)));
        float[] viewMatrix = new float[16];
        arCamera.getViewMatrix(viewMatrix, 0);
        handleGestureEvent(arFrame, arCamera, projectionMatrix, viewMatrix);
        ARLightEstimate lightEstimate = arFrame.getLightEstimate();
        float lightPixelIntensity = 1;
        if (lightEstimate.getState() != ARLightEstimate.State.NOT_VALID)
            lightPixelIntensity = lightEstimate.getPixelIntensity();

        if (((ARPluginConfigWorld) pluginConfig).isLabelDraw())
            labelDisplay.onDrawFrame(arSession.getAllTrackables(ARPlane.class),
                    arCamera.getDisplayOrientedPose(), projectionMatrix);
        drawAllObjects(projectionMatrix, viewMatrix, lightPixelIntensity);
    }

    private void drawAllObjects(float[] projectionMatrix, float[] viewMatrix, float lightPixelIntensity) {
        Iterator<VirtualObject> ite = virtualObjects.iterator();
        while (ite.hasNext()) {
            VirtualObject obj = ite.next();
            if (obj.getAnchor().getTrackingState() == ARTrackable.TrackingState.STOPPED)
                ite.remove();
            if (obj.getAnchor().getTrackingState() == ARTrackable.TrackingState.TRACKING)
                objectDisplay.onDrawFrame(viewMatrix, projectionMatrix, lightPixelIntensity, obj);
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
        } catch (IllegalArgumentException | IOException e) {
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
        bitmaps.add(getBitmap(pluginWorld.getImageCeiling(), pluginWorld.getTextCeiling(),
                pluginWorld.getColorCeiling()));
        return bitmaps;
    }

    private void handleGestureEvent(ARFrame arFrame, ARCamera arCamera, float[] projectionMatrix, float[] viewMatrix) {
        GestureEvent event = queuedSingleTaps.poll();
        if (event == null) return;
        if (arCamera.getTrackingState() != ARTrackable.TrackingState.TRACKING) {
            return;
        }

        int eventType = event.getType();
        switch (eventType) {
            case GestureEvent.GESTURE_EVENT_TYPE_DOWN: {
                doWhenEventTypeDown(viewMatrix, projectionMatrix, event);
                break;
            }
            case GestureEvent.GESTURE_EVENT_TYPE_SCROLL: {
                if (selectedObject == null) {
                    break;
                }
                ARHitResult hitResult = hitTest4Result(arFrame, arCamera, event.getEventSecond());
                if (hitResult != null) {
                    selectedObject.setAnchor(hitResult.createAnchor());
                }
                break;
            }
            case GestureEvent.GESTURE_EVENT_TYPE_SINGLETAPUP: {
                // Do not perform anything when an object is selected.
                if (selectedObject != null) {
                    return;
                }

                MotionEvent tap = event.getEventFirst();
                ARHitResult hitResult = null;

                hitResult = hitTest4Result(arFrame, arCamera, tap);

                if (hitResult == null) {
                    break;
                }
                doWhenEventTypeSingleTap(hitResult);
                break;
            }
            default: {
                Log.e(TAG, "Unknown motion event type, and do nothing.");
            }
        }
    }

    private void doWhenEventTypeDown(float[] viewMatrix, float[] projectionMatrix, GestureEvent event) {
        if (selectedObject != null) {
            selectedObject.setIsSelected(false);
            selectedObject = null;
        }
        for (VirtualObject obj : virtualObjects) {
            if (objectDisplay.hitTest(viewMatrix, projectionMatrix, obj, event.getEventFirst())) {
                obj.setIsSelected(true);
                selectedObject = obj;
                break;
            }
        }
    }

    private void doWhenEventTypeSingleTap(ARHitResult hitResult) {
        // The hit results are sorted by distance. Only the nearest hit point is valid.
        // Set the number of stored objects to 10 to avoid the overload of rendering and AR Engine.
        if (virtualObjects.size() >= 16) {
            virtualObjects.get(0).getAnchor().detach();
            virtualObjects.remove(0);
        }

        ARTrackable currentTrackable = hitResult.getTrackable();
        if (currentTrackable instanceof ARPoint) {
            virtualObjects.add(new VirtualObject(hitResult.createAnchor(), BLUE_COLORS));
        } else if (currentTrackable instanceof ARPlane) {
            virtualObjects.add(new VirtualObject(hitResult.createAnchor(), GREEN_COLORS));
        } else {
            Log.i(TAG, "Hit result is not plane or point.");
        }
    }

    private ARHitResult hitTest4Result(ARFrame frame, ARCamera camera, MotionEvent event) {
        ARHitResult hitResult = null;
        List<ARHitResult> hitTestResults = frame.hitTest(event);

        for (int i = 0; i < hitTestResults.size(); i++) {
            // Determine whether the hit point is within the plane polygon.
            ARHitResult hitResultTemp = hitTestResults.get(i);
            if (hitResultTemp == null) {
                continue;
            }
            ARTrackable trackable = hitResultTemp.getTrackable();

            boolean isPlanHitJudge =
                    trackable instanceof ARPlane && ((ARPlane) trackable).isPoseInPolygon(hitResultTemp.getHitPose())
                            && (calculateDistanceToPlane(hitResultTemp.getHitPose(), camera.getPose()) > 0);

            // Determine whether the point cloud is clicked and whether the point faces the camera.
            boolean isPointHitJudge = trackable instanceof ARPoint
                    && ((ARPoint) trackable).getOrientationMode() == ARPoint.OrientationMode.ESTIMATED_SURFACE_NORMAL;

            // Select points on the plane preferentially.
            if (isPlanHitJudge || isPointHitJudge) {
                hitResult = hitResultTemp;
                if (trackable instanceof ARPlane) {
                    break;
                }
            }
        }
        return hitResult;
    }

    /**
     * Calculate the distance between a point in a space and a plane. This method is used
     * to calculate the distance between a camera in a space and a specified plane.
     *
     * @param planePose  ARPose of a plane.
     * @param cameraPose ARPose of a camera.
     * @return Calculation results.
     */
    private static float calculateDistanceToPlane(ARPose planePose, ARPose cameraPose) {
        // The dimension of the direction vector is 3.
        float[] normals = new float[3];

        // Obtain the unit coordinate vector of a normal vector of a plane.
        planePose.getTransformedAxis(1, 1.0f, normals, 0);

        // Calculate the distance based on projection.
        return (cameraPose.tx() - planePose.tx()) * normals[0] // 0:x
                + (cameraPose.ty() - planePose.ty()) * normals[1] // 1:y
                + (cameraPose.tz() - planePose.tz()) * normals[2]; // 2:z
    }
}
