/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mlbody.handlers;

import android.app.Activity;
import android.graphics.SurfaceTexture;

import androidx.annotation.NonNull;

import com.huawei.hms.common.size.Size;
import com.huawei.hms.flutter.mlbody.data.Commons;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.transactors.Face3dTransactor;
import com.huawei.hms.flutter.mlbody.transactors.FaceTransactor;
import com.huawei.hms.flutter.mlbody.transactors.GestureTransactor;
import com.huawei.hms.flutter.mlbody.transactors.HandTransactor;
import com.huawei.hms.flutter.mlbody.transactors.SkeletonTransactor;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzer;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzer;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzer;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzerFactory;
import com.huawei.hms.mlsdk.gesture.MLGestureAnalyzerSetting;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzer;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerFactory;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzer;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class LensHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = LensHandler.class.getSimpleName();

    private final Activity activity;
    private final MethodChannel mChannel;
    private final BodyResponseHandler handler;
    private final TextureRegistry registry;

    private TextureRegistry.SurfaceTextureEntry entry;
    private SurfaceTexture surfaceTexture;
    private LensEngine lensEngine;
    private MLAnalyzer<?> analyzer;

    private Integer width = 1440;
    private Integer height = 1080;
    private Integer lensType = 0;
    private Long fps = (long) 30.0;
    private String flashMode;
    private String focusMode;
    private Boolean autoFocus;

    public LensHandler(Activity a, MethodChannel mChannel, TextureRegistry registry) {
        this.activity = a;
        this.mChannel = mChannel;
        this.registry = registry;
        this.handler = BodyResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "lens#init":
                init(call);
                break;
            case "lens#setup":
                setup(call);
                break;
            case "lens#run":
                run();
                break;
            case "lens#switchCam":
                switchCam();
                break;
            case "lens#capture":
                capture(result);
                break;
            case "lens#zoom":
                zoom(call);
                break;
            case "lens#release":
                release();
                break;
            case "lens#getLensType":
                getLensType();
                break;
            case "lens#getDimensions":
                getDimensions();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void init(MethodCall call) {
        width = FromMap.toInteger("width", call.argument("width"));
        height = FromMap.toInteger("height", call.argument("height"));

        if (width == null) {
            width = 1440;
        }
        if (height == null) {
            height = 1080;
        }

        entry = registry.createSurfaceTexture();
        surfaceTexture = entry.surfaceTexture();
        surfaceTexture.setDefaultBufferSize(width, height);
        handler.success(entry.id());
    }

    private void setup(MethodCall call) {
        fps = FromMap.toLong("applyFps", call.argument("applyFps"));
        lensType = FromMap.toInteger("lensType", call.argument("lensType"));
        autoFocus = FromMap.toBoolean("automaticFocus", call.argument("automaticFocus"));
        flashMode = FromMap.toString("flashMode", call.argument("flashMode"), true);
        focusMode = FromMap.toString("focusMode", call.argument("focusMode"), true);

        String analyzerType = FromMap.toString("analyzerType", call.argument("analyzerType"), false);

        if (analyzerType == null || analyzerType.isEmpty()) {
            handler.exception(new Exception("Analyzer type must be provided!"));
            return;
        }

        analyzer = pickAnalyzer(analyzerType);
        handler.success(true);
    }

    private void run() {
        lensEngine = new LensEngine.Creator(activity.getApplicationContext(), analyzer)
                .setLensType(lensType)
                .applyDisplayDimension(width, height)
                .applyFps(fps.floatValue())
                .enableAutomaticFocus(autoFocus)
                .setFlashMode(flashMode)
                .setFocusMode(focusMode)
                .create();

        if (surfaceTexture == null) {
            handler.exception(new Exception("Lens texture is not initialized!"));
            return;
        }

        try {
            lensEngine.run(surfaceTexture);
            handler.success(true);
        } catch (IOException e) {
            handler.exception(e);
        }
    }

    private void switchCam() {
        if (lensEngine == null) {
            handler.exception(new Exception("Lens engine is not initialized!"));
            return;
        }

        if (lensType == 0) {
            lensType = 1;
        } else {
            lensType = 0;
        }

        lensEngine.close();
        run();
        handler.success(true);
    }

    private void capture(MethodChannel.Result result) {
        Commons.captureImageFromLens(activity, lensEngine, result);
    }

    private void zoom(MethodCall call) {
        Long zoom = FromMap.toLong("zoom", call.argument("zoom"));

        if (lensEngine == null) {
            handler.exception(new Exception("Lens engine is not initialized!"));
            return;
        }

        if (zoom != null) {
            lensEngine.doZoom(zoom.floatValue());
            handler.success(lensEngine.doZoom(zoom.floatValue()));
        }
    }

    private void release() {
        if (lensEngine == null) {
            handler.exception(new Exception("Lens engine is not initialized!"));
            return;
        }

        lensEngine.release();
        entry.release();
        handler.success(true);
    }

    private void getLensType() {
        if (lensEngine == null) {
            handler.exception(new Exception("Lens engine is not initialized!"));
            return;
        }
        handler.success(lensEngine.getLensType());
    }

    private void getDimensions() {
        if (lensEngine == null) {
            handler.exception(new Exception("Lens engine is not initialized!"));
            return;
        }

        Size size = lensEngine.getDisplayDimension();
        Map<String, Object> map = new HashMap<>();
        map.put("width", size.getWidth());
        map.put("height", size.getHeight());
        handler.success(map);
    }

    private MLAnalyzer<?> pickAnalyzer(String type) {
        switch (type) {
            case "face":
                MLFaceAnalyzer a1 = MLAnalyzerFactory.getInstance().getFaceAnalyzer();
                FaceTransactor t1 = new FaceTransactor(activity, mChannel);
                a1.setTransactor(t1);
                return a1;
            case "face3d":
                ML3DFaceAnalyzer a2 = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer();
                Face3dTransactor t2 = new Face3dTransactor(activity, mChannel);
                a2.setTransactor(t2);
                return a2;
            case "hand":
                MLHandKeypointAnalyzer a3 = MLHandKeypointAnalyzerFactory.getInstance().getHandKeypointAnalyzer();
                HandTransactor t3 = new HandTransactor(activity, mChannel);
                a3.setTransactor(t3);
                return a3;
            case "gesture":
                MLGestureAnalyzerSetting s1 = new MLGestureAnalyzerSetting.Factory().create();
                MLGestureAnalyzer a4 = MLGestureAnalyzerFactory.getInstance().getGestureAnalyzer(s1);
                GestureTransactor t4 = new GestureTransactor(activity, mChannel);
                a4.setTransactor(t4);
                return a4;
            case "skeleton":
                MLSkeletonAnalyzer a5 = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();
                SkeletonTransactor t5 = new SkeletonTransactor(activity, mChannel);
                a5.setTransactor(t5);
                return a5;
            default:
                return null;
        }
    }
}
