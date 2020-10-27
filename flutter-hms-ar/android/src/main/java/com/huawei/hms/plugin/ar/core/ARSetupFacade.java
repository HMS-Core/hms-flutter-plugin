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

package com.huawei.hms.plugin.ar.core;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;

import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.GestureEvent;
import com.huawei.hms.plugin.ar.core.helper.PluginCallbackHelper;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.renderer.ARBaseRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARBodyRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARFaceRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARHandRenderer;
import com.huawei.hms.plugin.ar.core.renderer.ARWorldRenderer;

import com.huawei.hiar.ARBodyTrackingConfig;
import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARFaceTrackingConfig;
import com.huawei.hiar.ARHandTrackingConfig;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.ARWorldTrackingConfig;

import java.util.concurrent.ArrayBlockingQueue;

public class ARSetupFacade {
    private ARBaseRenderer renderer;
    private ARConfigBase arConfigBase;
    private ARSession arSession;
    private GLSurfaceView surfaceView;
    private DisplayRotationManager displayRotationManager;
    private TextureDisplay textureDisplay;
    private final Context context;

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

    public void startHand(ARPluginConfigHand config) {
        renderer = new ARHandRenderer(arSession, displayRotationManager, textureDisplay, config);
        surfaceView.setRenderer(renderer);
        surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

        arConfigBase = new ARHandTrackingConfig(arSession);
        ((ARHandTrackingConfig) arConfigBase).setCameraLensFacing(ARConfigBase.CameraLensFacing.FRONT);
        arConfigBase.setPowerMode(ARConfigBase.PowerMode.PERFORMANCE_FIRST);
        arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH);
        arSession.configure(arConfigBase);

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();
    }

    public void startFace(ARPluginConfigFace config) {
        renderer = new ARFaceRenderer(arSession, displayRotationManager, textureDisplay, config, context);
        surfaceView.setRenderer(renderer);
        surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

        arConfigBase = new ARFaceTrackingConfig(arSession);
        arConfigBase.setPowerMode(ARConfigBase.PowerMode.PERFORMANCE_FIRST);
        arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH);
        arSession.configure(arConfigBase);

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();
    }

    public void startBody(ARPluginConfigBody config) {
        renderer = new ARBodyRenderer(arSession, displayRotationManager, textureDisplay, config);
        surfaceView.setRenderer(renderer);
        surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

        arConfigBase = new ARBodyTrackingConfig(arSession);
        arConfigBase.setPowerMode(ARConfigBase.PowerMode.PERFORMANCE_FIRST);
        arConfigBase.setEnableItem(ARConfigBase.ENABLE_DEPTH | ARConfigBase.ENABLE_MASK);
        arSession.configure(arConfigBase);

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();
    }

    public void startWorld(ARPluginConfigWorld config) {
        queue = new ArrayBlockingQueue<>(2);
        initGestureDetector();
        renderer = new ARWorldRenderer(arSession, displayRotationManager, textureDisplay,
                config, queue, context);
        surfaceView.setRenderer(renderer);
        surfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);

        arConfigBase = new ARWorldTrackingConfig(arSession);
        arConfigBase.setFocusMode(ARConfigBase.FocusMode.AUTO_FOCUS);
        arConfigBase.setSemanticMode(ARConfigBase.SEMANTIC_PLANE);
        arSession.configure(arConfigBase);

        arSession.resume();
        displayRotationManager.registerDisplayListener();
        surfaceView.onResume();
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

    private GestureDetector gestureDetector;
    private ArrayBlockingQueue<GestureEvent> queue;

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
}

