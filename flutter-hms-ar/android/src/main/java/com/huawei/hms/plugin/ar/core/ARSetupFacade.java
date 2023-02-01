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

package com.huawei.hms.plugin.ar.core;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.opengl.GLSurfaceView;
import android.util.Log;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.huawei.hiar.ARAugmentedImageDatabase;
import com.huawei.hiar.ARBodyTrackingConfig;
import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARFaceTrackingConfig;
import com.huawei.hiar.ARHandTrackingConfig;
import com.huawei.hiar.ARImageTrackingConfig;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARWorldBodyTrackingConfig;
import com.huawei.hiar.ARWorldTrackingConfig;
import com.huawei.hiar.exceptions.ARUnSupportedConfigurationException;
import com.huawei.hiar.exceptions.ARUnavailableClientSdkTooOldException;
import com.huawei.hiar.exceptions.ARUnavailableServiceApkTooOldException;
import com.huawei.hiar.exceptions.ARUnavailableServiceNotInstalledException;
import com.huawei.hiar.listener.FaceHealthServiceListener;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigAugmentedImage;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigSceneMesh;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorldBody;
import com.huawei.hms.plugin.ar.core.helper.CameraConfigListener;
import com.huawei.hms.plugin.ar.core.helper.CameraIntrinsicsListener;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.MessageTextListener;
import com.huawei.hms.plugin.ar.core.helper.PluginCallbackHelper;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.helper.face.FaceHealthyResult;
import com.huawei.hms.plugin.ar.core.helper.sceneMesh.SceneMeshDrawFrameListener;
import com.huawei.hms.plugin.ar.core.model.AugmentedImageDBModel;
import com.huawei.hms.plugin.ar.core.renderer.ARAugmentedImageRender;
import com.huawei.hms.plugin.ar.core.renderer.ARBaseRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARBodyRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARCloud3DObjectRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARFaceRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARHandRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARSceneMeshRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARWorldBodyRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARWorldRenderer;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ArrayBlockingQueue;

public class ARSetupFacade {
    private final static String TAG = ARSetupFacade.class.getSimpleName();

    private final Context context;

    private ARBaseRenderer renderer;

    private ARConfigBase arConfigBase;

    private ARSession arSession;

    private GLSurfaceView surfaceView;

    private DisplayRotationManager displayRotationManager;

    private TextureDisplay textureDisplay;

    private String errorMessage = "";

    private GestureDetector gestureDetector;

    private ArrayBlockingQueue<GestureEvent> queue;

    public ProgressBar healthProgressBar;

    public TextView progressTips;

    public TextView healthCheckStatusTextView;

    public ARSetupFacade(Context context, GLSurfaceView view) {
        this.context = context;
        this.surfaceView = view;
        this.surfaceView.setPreserveEGLContextOnPause(true);
        this.surfaceView.setEGLContextClientVersion(2);
        this.surfaceView.setEGLConfigChooser(8, 8, 8, 8, 16, 0);
        this.arSession = new ARSession(context);
        this.displayRotationManager = new DisplayRotationManager(context);
        this.textureDisplay = new TextureDisplay();
        this.renderer = new ARBaseRenderer();
        this.queue = new ArrayBlockingQueue<>(1);
    }

    public ARSetupFacade(Context context, View view) {
        this.context = context;
        this.surfaceView = (GLSurfaceView) handleResources("healthSurfaceView", view);
        this.healthProgressBar = (ProgressBar) handleResources("health_progress_bar", view);
        this.progressTips = (TextView) handleResources("process_tips", view);
        this.healthCheckStatusTextView = (TextView) handleResources("health_check_status", view);
        this.surfaceView.setPreserveEGLContextOnPause(true);
        this.surfaceView.setEGLContextClientVersion(2);
        this.surfaceView.setEGLConfigChooser(8, 8, 8, 8, 16, 0);
        this.arSession = new ARSession(context);
        this.displayRotationManager = new DisplayRotationManager(context);
        this.textureDisplay = new TextureDisplay();
        this.renderer = new ARBaseRenderer();
        this.queue = new ArrayBlockingQueue<>(1);
    }

    private View handleResources(String resourceName, View view) {
        return view.findViewById(context.getResources().getIdentifier(resourceName, "id", context.getPackageName()));
    }

    public void startHand(ARPluginConfigHand config) {
        try {
            renderer = new ARHandRenderer(arSession, displayRotationManager, textureDisplay, config);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARHandTrackingConfig(arSession);
            ((ARHandTrackingConfig) arConfigBase).setCameraLensFacing(ARConfigBase.CameraLensFacing.FRONT);
            setCommonConfig(config);
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH);

            if (((ARHandTrackingConfig) arConfigBase).getCameraLensFacing() != config.getCameraLensFacing()
                || arConfigBase.getEnableItem() != ARConfigBase.ENABLE_DEPTH) {
                throw new ARUnSupportedConfigurationException();
            }
            checkCommonConfig(config);

            arSession.configure(arConfigBase);
        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startFace(ARPluginConfigFace config) {
        try {
            renderer = new ARFaceRenderer(arSession, displayRotationManager, textureDisplay, config, context,
                config.getHealth());
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARFaceTrackingConfig(arSession);

            ((ARFaceTrackingConfig) arConfigBase).setCameraLensFacing(config.getCameraLensFacing());

            if (!config.getHealth() && config.getMultiFace()) {
                ((ARFaceTrackingConfig) arConfigBase).setFaceDetectMode(
                    ARConfigBase.FaceDetectMode.FACE_ENABLE_MULTIFACE.getEnumValue()
                        | ARConfigBase.FaceDetectMode.FACE_ENABLE_DEFAULT.getEnumValue());
            }

            setCommonConfig(config);
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH);

            if (arConfigBase.getEnableItem() != ARConfigBase.ENABLE_DEPTH || (!config.getHealth()
                && config.getMultiFace() && ((ARFaceTrackingConfig) arConfigBase).getFaceDetectMode() != (
                ARConfigBase.FaceDetectMode.FACE_ENABLE_MULTIFACE.getEnumValue()
                    | ARConfigBase.FaceDetectMode.FACE_ENABLE_DEFAULT.getEnumValue()))) {
                throw new ARUnSupportedConfigurationException();
            }
            checkCommonConfig(config);

        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }
        arSession.configure(arConfigBase);
        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startBody(ARPluginConfigBody config) {
        try {
            renderer = new ARBodyRenderer(arSession, displayRotationManager, textureDisplay, config);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARBodyTrackingConfig(arSession);

            ((ARBodyTrackingConfig) arConfigBase).setCameraLensFacing(ARConfigBase.CameraLensFacing.REAR);

            setCommonConfig(config);
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK);

            if (((ARBodyTrackingConfig) arConfigBase).getCameraLensFacing() != ARConfigBase.CameraLensFacing.REAR
                || arConfigBase.getEnableItem() != (ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK)) {
                throw new ARUnSupportedConfigurationException();
            }
            checkCommonConfig(config);

            arSession.configure(arConfigBase);
        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startWorld(ARPluginConfigWorld config) {
        try {
            queue = new ArrayBlockingQueue<>(2);
            initGestureDetector();
            renderer = new ARWorldRenderer(arSession, displayRotationManager, textureDisplay, config, queue, context);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARWorldTrackingConfig(arSession);
            arConfigBase.setMaxMapSize(config.getMaxMapSize());
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH);
            setCommonConfig(config);
            arConfigBase.setSemanticMode(ARConfigBase.SEMANTIC_PLANE);
            ((ARWorldTrackingConfig) arConfigBase).setPlaneFindingMode(config.getPlaneFindingMode());
            arSession.configure(arConfigBase);

            if (config.getAugmentedImageDBModels().size() > 0) {
                ARAugmentedImageDatabase db = setupInitAugmentedImageDatabase(config.getAugmentedImageDBModels());
                if (db == null) {
                    setMessageWhenError(null, "Could not setup augmented image database");
                } else {
                    ((ARWorldTrackingConfig) arConfigBase).setAugmentedImageDatabase(db);
                }
            }
        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startCloud3DObject(String fileName) {
        try {
            queue = new ArrayBlockingQueue<>(2);
            renderer = new ARCloud3DObjectRenderer(arSession, displayRotationManager, textureDisplay, null, context, fileName);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARWorldTrackingConfig(arSession);
            arConfigBase.setFocusMode(ARConfigBase.FocusMode.AUTO_FOCUS);
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_CLOUD_OBJECT_RECOGNITION);
        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }
        arSession.configure(arConfigBase);

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();
    }

    public void startAugmentedImage(ARPluginConfigAugmentedImage config) {
        try {
            queue = new ArrayBlockingQueue<>(2);
            renderer = new ARAugmentedImageRender(arSession, displayRotationManager, textureDisplay, config, context);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARImageTrackingConfig(arSession);
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK);
            setCommonConfig(config);

            if (config.getAugmentedImageDBModels().size() > 0) {
                ARAugmentedImageDatabase db = setupInitAugmentedImageDatabase(config.getAugmentedImageDBModels());
                if (db == null) {
                    setMessageWhenError(null, "Could not setup augmented image database");
                } else {
                    ((ARImageTrackingConfig) arConfigBase).setAugmentedImageDatabase(db);
                }
            }

            if (arConfigBase.getEnableItem() != (ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK)) {
                throw new ARUnSupportedConfigurationException();
            }
            checkCommonConfig(config);

        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }
        arSession.configure(arConfigBase);
        ((ARAugmentedImageRender) renderer).setImageTrackOnly(true);

        arSession.resume();

        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startWorldBody(ARPluginConfigWorldBody config) {
        try {
            queue = new ArrayBlockingQueue<>(2);
            initGestureDetector();
            renderer = new ARWorldBodyRenderer(arSession, displayRotationManager, textureDisplay, config, queue,
                context);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARWorldBodyTrackingConfig(arSession);

            arConfigBase.setMaxMapSize(config.getMaxMapSize());
            arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK);
            setCommonConfig(config);
            arConfigBase.setSemanticMode(ARConfigBase.SEMANTIC_PLANE);
            ((ARWorldBodyTrackingConfig) arConfigBase).setPlaneFindingMode(config.getPlaneFindingMode());
            arSession.configure(arConfigBase);

            if (config.getAugmentedImageDBModels().size() > 0) {
                ARAugmentedImageDatabase db = setupInitAugmentedImageDatabase(config.getAugmentedImageDBModels());
                if (db == null) {
                    setMessageWhenError(null, "Could not setup augmented image database");
                } else {
                    ((ARWorldBodyTrackingConfig) arConfigBase).setAugmentedImageDatabase(db);
                }
            }

            checkCommonConfig(config);

        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }

        arSession.resume();

        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void startSceneMesh(ARPluginConfigSceneMesh config) {
        try {
            queue = new ArrayBlockingQueue<>(2);
            initGestureDetector();
            renderer = new ARSceneMeshRenderer(arSession, displayRotationManager, textureDisplay, config, queue,
                context);
            surfaceView.setRenderer(renderer);
            surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

            arConfigBase = new ARWorldTrackingConfig(arSession);

            arConfigBase.setEnableItem(ARConfigBase.ENABLE_MESH | ARConfigBase.ENABLE_DEPTH);
            arSession.configure(arConfigBase);
            setCommonConfig(config);

            if ((arConfigBase.getEnableItem() & ARConfigBase.ENABLE_MESH) == 0) {
                throw new ARUnSupportedConfigurationException();
            }

            checkCommonConfig(config);

        } catch (Exception capturedException) {
            setMessageWhenError(capturedException, "");
        }

        arSession.resume();

        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();

        showSemanticModeSupportedInfo(config);
    }

    public void setPluginConfig(ARPluginConfigBase config) {
        renderer.setPluginConfig(config);
    }

    public void stopTrackingSession() {
        displayRotationManager.unregisterDisplayListener();
        surfaceView.setPreserveEGLContextOnPause(false);
        surfaceView.onPause();
        renderer = null;
        arSession.stop();
        arSession = null;
    }

    public void setListener(PluginCallbackHelper helper) {
        renderer.setCallbackHelper(helper);
    }

    public void setCameraConfigListener(CameraConfigListener helper) {
        renderer.setCameraConfigListener(helper);
    }

    public void setCameraIntrinsicsListener(CameraIntrinsicsListener helper) {
        renderer.setCameraIntrinsicsListener(helper);
    }

    public void setMessageDataListener(MessageTextListener listener) {
        renderer.setMessageDataListener(listener);
    }

    public void setSceneMeshListener(SceneMeshDrawFrameListener listener) {
        if (renderer instanceof ARSceneMeshRenderer) {
            ARSceneMeshRenderer sceneMeshRenderer = (ARSceneMeshRenderer) renderer;
            sceneMeshRenderer.setSceneMeshListener(listener);
        }
    }

    public void setFaceHealthListener(FaceHealthServiceListener faceHealthListener) {
        if (renderer instanceof ARFaceRenderer) {
            ARFaceRenderer faceRenderer = (ARFaceRenderer) renderer;
            faceRenderer.setFaceHealthyListener(faceHealthListener);
            arSession.addServiceListener(faceRenderer);
        }
    }

    public void setFaceHealthResultListener(FaceHealthyResult faceHealthyResult) {
        if (renderer instanceof ARFaceRenderer) {
            ARFaceRenderer faceRenderer = (ARFaceRenderer) renderer;
            faceRenderer.setFaceHealthyResult(faceHealthyResult);
            arSession.addServiceListener(faceRenderer);
        }
    }

    public void setHealthCheckProgress(int progress) {
        if (renderer instanceof ARFaceRenderer) {
            ARFaceRenderer faceRenderer = (ARFaceRenderer) renderer;
            faceRenderer.setHealthCheckProgress(progress);
        }
    }

    private void initGestureDetector() {
        gestureDetector = new GestureDetector(context, new GestureDetector.SimpleOnGestureListener() {
            @Override
            public boolean onSingleTapUp(MotionEvent e) {
                return onGestureEvent(GestureEvent.createSingleTapUpEvent(e));
            }

            @Override
            public boolean onDown(MotionEvent e) {
                return onGestureEvent(GestureEvent.createDownEvent(e));
            }

            @Override
            public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
                return onGestureEvent(GestureEvent.createScrollEvent(e1, e2, distanceX, distanceY));
            }
        });

        surfaceView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return gestureDetector.onTouchEvent(event);
            }
        });
    }

    private boolean onGestureEvent(GestureEvent e) {
        return (queue.offer(e));
    }

    public void setEnableItem(long enableItem) {
        if (arConfigBase != null) {
            arSession.stop();
            arConfigBase.setEnableItem(enableItem);
            arSession.configure(arConfigBase);
            arSession.resume();
        }
    }

    protected void setMessageWhenError(Exception catchException, String directMessage) {
        if (directMessage.equals("")) {
            if (catchException instanceof ARUnavailableServiceNotInstalledException) {
                errorMessage = "ARUnavailableServiceNotInstalledException";
            } else if (catchException instanceof ARUnavailableServiceApkTooOldException) {
                errorMessage = "ARUnavailableServiceApkTooOldException: Please update HuaweiARService.apk";
            } else if (catchException instanceof ARUnavailableClientSdkTooOldException) {
                errorMessage = "ARUnavailableClientSdkTooOldException: Please update this SDK";
            } else if (catchException instanceof ARUnSupportedConfigurationException) {
                errorMessage = "ARUnSupportedConfigurationException: The configuration is not supported by the device!";
            } else {
                errorMessage = "exception throw";
            }
        } else {
            errorMessage = directMessage;
        }

        Toast.makeText(context, errorMessage, Toast.LENGTH_LONG).show();
        Log.e(ARSetupFacade.class.getSimpleName(), errorMessage);
    }

    private void showSemanticModeSupportedInfo(ARPluginConfigBase configPlugin) {
        if (!configPlugin.getShowSemanticSupportedInfo()) {
            return;
        }
        String toastMsg = "";
        switch (arSession.getSupportedSemanticMode()) {
            case ARWorldTrackingConfig.SEMANTIC_NONE:
                toastMsg = "The running environment does not support the semantic mode.";
                break;
            case ARWorldTrackingConfig.SEMANTIC_PLANE:
                toastMsg = "The running environment supports only the plane semantic mode.";
                break;
            case ARWorldTrackingConfig.SEMANTIC_TARGET:
                toastMsg = "The running environment supports only the target semantic mode.";
                break;
            default:
                break;
        }
        if (!toastMsg.isEmpty()) {
            Toast.makeText(context, toastMsg, Toast.LENGTH_LONG).show();
        }
    }

    private void setCommonConfig(ARPluginConfigBase configPlugin) {
        arConfigBase.setSemanticMode(configPlugin.getSemanticMode());
        arConfigBase.setFocusMode(configPlugin.getFocusMode());
        arConfigBase.setPowerMode(configPlugin.getPowerMode());
        arConfigBase.setUpdateMode(configPlugin.getUpdateMode());
        arConfigBase.setLightingMode(configPlugin.getLightMode());
    }

    private void checkCommonConfig(ARPluginConfigBase configPlugin) {
        if (arConfigBase.getUpdateMode() != configPlugin.getUpdateMode()
            || arConfigBase.getFocusMode() != configPlugin.getFocusMode()
            || arConfigBase.getPowerMode() != configPlugin.getPowerMode()) {
            throw new ARUnSupportedConfigurationException();
        }
        if (arConfigBase.getSemanticMode() != configPlugin.getSemanticMode()
            || arConfigBase.getLightingMode() != configPlugin.getLightMode()) {
            throw new ARUnSupportedConfigurationException();
        }
    }

    private ARAugmentedImageDatabase setupInitAugmentedImageDatabase(List<AugmentedImageDBModel> list) {
        if (list.size() == 0) {
            return null;
        }

        ARAugmentedImageDatabase augmentedImageDatabase = new ARAugmentedImageDatabase(arSession);

        for (AugmentedImageDBModel item : list) {
            Optional<Bitmap> augmentedImageBitmap = loadAugmentedImageBitmap(item.getImgFileFromAsset());
            if (!augmentedImageBitmap.isPresent()) {
                continue;
            }

            if (item.getWidthInMeters() > 0) {
                augmentedImageDatabase.addImage(item.getImgName(), augmentedImageBitmap.get(), item.getWidthInMeters());
            } else {
                augmentedImageDatabase.addImage(item.getImgName(), augmentedImageBitmap.get());
            }
        }
        return augmentedImageDatabase;
    }

    private Optional<Bitmap> loadAugmentedImageBitmap(String fileName) {
        try (InputStream is = context.getAssets().open(fileName)) {
            return Optional.of(BitmapFactory.decodeStream(is));
        } catch (IOException e) {
            Log.e(TAG, "IO exception loading augmented image bitmap.");
        }
        return Optional.empty();
    }
}