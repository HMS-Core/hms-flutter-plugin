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
import android.view.MotionEvent;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARHitResult;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARPoint;
import com.huawei.hiar.ARPose;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARTrackable;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.ObjectDisplay;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.VirtualObject;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;

public class ARBaseDrawObject extends ARBaseRenderer {
    protected static final int PROJ_MATRIX_OFFSET = 0;

    protected static final float PROJ_MATRIX_NEAR = 0.1f;

    protected static final float PROJ_MATRIX_FAR = 100.0f;

    private static final String TAG = ARBaseDrawObject.class.getSimpleName();

    private static final float[] BLUE_COLORS = new float[] {66.0f, 133.0f, 244.0f, 255.0f};

    private static final float[] GREEN_COLORS = new float[] {66.0f, 133.0f, 244.0f, 255.0f};

    protected List<VirtualObject> virtualObjects;

    protected ObjectDisplay objectDisplay;

    protected boolean mHaveSetEnvTextureData = false;

    protected Boolean hasError = false;

    protected ArrayBlockingQueue<GestureEvent> queuedSingleTaps;

    protected VirtualObject selectedObject;

    protected Context context;

    public ARBaseDrawObject(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase configBase) {
        super(arSession, displayRotationManager, textureDisplay, configBase);
    }

    /**
     * Calculate the distance between a point in a space and a plane. This method is used
     * to calculate the distance between a camera in a space and a specified plane.
     *
     * @param planePose ARPose of a plane.
     * @param cameraPose ARPose of a camera.
     * @return Calculation results.
     */
    protected static float calculateDistanceToPlane(ARPose planePose, ARPose cameraPose) {
        // The dimension of the direction vector is 3.
        float[] normals = new float[3];

        // Obtain the unit coordinate vector of a normal vector of a plane.
        planePose.getTransformedAxis(1, 1.0f, normals, 0);

        // Calculate the distance based on projection.
        return (cameraPose.tx() - planePose.tx()) * normals[0] // 0:x
            + (cameraPose.ty() - planePose.ty()) * normals[1] // 1:y
            + (cameraPose.tz() - planePose.tz()) * normals[2]; // 2:z
    }

    protected void drawAllObjects(float[] projectionMatrix, float[] viewMatrix, float lightPixelIntensity) {
        Iterator<VirtualObject> ite = virtualObjects.iterator();
        while (ite.hasNext()) {
            VirtualObject obj = ite.next();
            if (obj.getAnchor().getTrackingState() == ARTrackable.TrackingState.STOPPED) {
                ite.remove();
            }
            if (obj.getAnchor().getTrackingState() == ARTrackable.TrackingState.TRACKING) {
                objectDisplay.onDrawFrame(viewMatrix, projectionMatrix, lightPixelIntensity, obj);
            }
        }
    }

    protected void setEnvTextureData() {
        if (!mHaveSetEnvTextureData) {
            try {
                float[] boundBox = objectDisplay.getBoundingBox();
                arSession.setEnvironmentTextureProbe(boundBox);
                Log.i(TAG, "setEnvironmentTextureProbe = " + Arrays.toString(boundBox));
                arSession.setEnvironmentTextureUpdateMode(ARSession.EnvironmentTextureUpdateMode.AUTO);
            } catch (Exception e) {
                Log.e(TAG, "setEnvTextureData");
                hasError = true;
            }
            mHaveSetEnvTextureData = true;
        }
    }

    protected void handleGestureEvent(ARFrame arFrame, ARCamera arCamera, float[] projectionMatrix,
        float[] viewMatrix) {
        GestureEvent event = queuedSingleTaps.poll();
        if (event == null) {
            return;
        }
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

    protected void doWhenEventTypeDown(float[] viewMatrix, float[] projectionMatrix, GestureEvent event) {
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

    protected void doWhenEventTypeSingleTap(ARHitResult hitResult) {
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

            boolean isPlanHitJudge = trackable instanceof ARPlane && ((ARPlane) trackable).isPoseInPolygon(
                hitResultTemp.getHitPose()) && (calculateDistanceToPlane(hitResultTemp.getHitPose(), camera.getPose())
                > 0);

            // Determine whether the point cloud is clicked and whether the point faces the camera.
            boolean isPointHitJudge = trackable instanceof ARPoint
                && ((ARPoint) trackable).getOrientationMode() == ARPoint.OrientationMode.ESTIMATED_SURFACE_NORMAL
                && trackable.getTrackingState() == ARTrackable.TrackingState.TRACKING;

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
}
