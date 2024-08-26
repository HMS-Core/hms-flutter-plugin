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

package com.huawei.hms.flutter.mltext.handlers;

import android.app.Activity;
import android.graphics.SurfaceTexture;

import androidx.annotation.NonNull;

import com.huawei.hms.common.size.Size;

import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.transactors.TextTransactor;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

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
    private final TextResponseHandler handler;

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
        this.handler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.LENS_INIT:
                init(call);
                break;
            case Method.LENS_SETUP:
                setup(call);
                break;
            case Method.LENS_RUN:
                run();
                break;
            case Method.LENS_SWITCH_CAM:
                switchCam();
                break;
            case Method.LENS_CAPTURE:
                capture(result);
                break;
            case Method.LENS_ZOOM:
                zoom(call);
                break;
            case Method.LENS_RELEASE:
                release();
                break;
            case Method.LENS_GET_LENS_TYPE:
                getLensType();
                break;
            case Method.LENS_GET_DIMENSIONS:
                getDimensions();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void init(MethodCall call) {
        width = FromMap.toInteger(Param.WIDTH, call.argument(Param.WIDTH));
        height = FromMap.toInteger(Param.HEIGHT, call.argument(Param.HEIGHT));

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
        fps = FromMap.toLong(Param.APPLY_FPS, call.argument(Param.APPLY_FPS));
        lensType = FromMap.toInteger(Param.LENS_TYPE, call.argument(Param.LENS_TYPE));
        autoFocus = FromMap.toBoolean(Param.AUTOMATIC_FOCUS, call.argument(Param.AUTOMATIC_FOCUS));
        flashMode = FromMap.toString(Param.FLASH_MODE, call.argument(Param.FLASH_MODE), true);
        focusMode = FromMap.toString(Param.FOCUS_MODE, call.argument(Param.FOCUS_MODE), true);

        String analyzerType = FromMap.toString(Param.ANALYZER_TYPE, call.argument(Param.ANALYZER_TYPE), false);

        if (analyzerType == null || analyzerType.isEmpty()) {
            handler.exception(new Exception(CallbackTypes.LENS_ANALYZER_TYPE));
            return;
        }
        analyzer = pickAnalyzer();
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
            handler.exception(new Exception(CallbackTypes.LENS_TEXTURE));
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
            handler.exception(new Exception(CallbackTypes.LENS_ENGINE));
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
        Long zoom = FromMap.toLong(Param.ZOOM, call.argument(Param.ZOOM));

        if (lensEngine == null) {
            handler.exception(new Exception(CallbackTypes.LENS_ENGINE));
            return;
        }

        if (zoom != null) {
            lensEngine.doZoom(zoom.floatValue());
            handler.success(true);
        }
    }

    private void release() {
        if (lensEngine == null) {
            handler.exception(new Exception(CallbackTypes.LENS_ENGINE));
            return;
        }
        lensEngine.release();
        entry.release();
        handler.success(true);
    }

    private void getLensType() {
        if (lensEngine == null) {
            handler.exception(new Exception(CallbackTypes.LENS_ENGINE));
            return;
        }
        handler.success(lensEngine.getLensType());
    }

    private void getDimensions() {
        if (lensEngine == null) {
            handler.exception(new Exception(CallbackTypes.LENS_ENGINE));
            return;
        }
        Size size = lensEngine.getDisplayDimension();
        Map<String, Object> map = new HashMap<>();
        map.put(Param.WIDTH, size.getWidth());
        map.put(Param.HEIGHT, size.getHeight());
        handler.success(map);
    }

    private MLTextAnalyzer pickAnalyzer() {
        MLTextAnalyzer a1 = new MLTextAnalyzer.Factory(activity).create();
        TextTransactor t1 = new TextTransactor(activity, mChannel);
        a1.setTransactor(t1);
        return a1;
    }
}
