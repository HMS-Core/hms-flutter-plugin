/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.handlers;

import android.app.Activity;
import android.graphics.SurfaceTexture;

import androidx.annotation.NonNull;

import com.huawei.hms.common.size.Size;
import com.huawei.hms.flutter.mlimage.transactors.ClassificationTransactor;
import com.huawei.hms.flutter.mlimage.transactors.ObjectTransactor;
import com.huawei.hms.flutter.mlimage.transactors.SceneTransactor;
import com.huawei.hms.flutter.mlimage.transactors.SegmentationTransactor;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.classification.MLImageClassificationAnalyzer;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationAnalyzer;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationScene;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationSetting;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class LensHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "LensHandler";

    private final Activity activity;
    private final MethodChannel mChannel;
    private final MLResponseHandler handler;

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

    public LensHandler(Activity activity, MethodChannel mChannel, TextureRegistry registry) {
        this.activity = activity;
        this.mChannel = mChannel;
        this.registry = registry;
        this.handler = MLResponseHandler.getInstance(activity);
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
            case "classification":
                MLImageClassificationAnalyzer clsAnalyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer();
                ClassificationTransactor ct = new ClassificationTransactor(activity, mChannel);
                clsAnalyzer.setTransactor(ct);
                return clsAnalyzer;
            case "segmentation":
                MLImageSegmentationSetting segSetting = new MLImageSegmentationSetting.Factory()
                        .setAnalyzerType(MLImageSegmentationSetting.BODY_SEG)
                        .setScene(MLImageSegmentationScene.ALL)
                        .setExact(false)
                        .create();
                MLImageSegmentationAnalyzer segAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(segSetting);
                SegmentationTransactor st = new SegmentationTransactor(activity, mChannel);
                segAnalyzer.setTransactor(st);
                return segAnalyzer;
            case "object":
                MLObjectAnalyzer mlObjectAnalyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer();
                ObjectTransactor objectTransactor = new ObjectTransactor(activity, mChannel);
                mlObjectAnalyzer.setTransactor(objectTransactor);
                return mlObjectAnalyzer;
            case "scene":
                MLSceneDetectionAnalyzer sceneDetectionAnalyzer = MLSceneDetectionAnalyzerFactory.getInstance().getSceneDetectionAnalyzer();
                SceneTransactor sceneTransactor = new SceneTransactor(activity, mChannel);
                sceneDetectionAnalyzer.setTransactor(sceneTransactor);
                return sceneDetectionAnalyzer;
            default:
                return null;
        }
    }
}
