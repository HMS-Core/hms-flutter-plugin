/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.lensview;

import android.app.Activity;
import android.graphics.SurfaceTexture;
import android.hardware.Camera;

import androidx.annotation.NonNull;

import com.huawei.hms.common.size.Size;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.transactors.ClassificationTransactor;
import com.huawei.hms.flutter.ml.transactors.Face3DTransactor;
import com.huawei.hms.flutter.ml.transactors.FaceAnalyzerTransactor;
import com.huawei.hms.flutter.ml.transactors.HandKeypointAnalyzerTransactor;
import com.huawei.hms.flutter.ml.transactors.MaxFaceTransactor;
import com.huawei.hms.flutter.ml.transactors.ObjectAnalyzerTransactor;
import com.huawei.hms.flutter.ml.transactors.SceneAnalyzerTransactor;
import com.huawei.hms.flutter.ml.transactors.SkeletonAnalyzerTransactor;
import com.huawei.hms.flutter.ml.transactors.TextAnalyzerTransactor;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.classification.MLImageClassificationAnalyzer;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzer;
import com.huawei.hms.mlsdk.face.MLMaxSizeFaceTransactor;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzer;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzerSetting;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzer;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerFactory;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerFactory;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzer;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzerFactory;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class LensViewMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = LensViewMethodHandler.class.getSimpleName();

    private Activity activity;
    private TextureRegistry registry;
    private TextureRegistry.SurfaceTextureEntry entry;
    private MethodChannel.Result mResult;

    private SurfaceTexture surfaceTexture;
    private LensEngine lensEngine;
    private MLAnalyzer<?> analyzer;

    Integer lensType = 0;
    Double fps = 30.0;
    Integer maxFrameLostCount;
    Integer width;
    Integer height;
    String flashMode;
    String focusMode;
    Boolean autoFocus;
    List<String> analyzerList;

    public LensViewMethodHandler(Activity activity, TextureRegistry registry) {
        this.activity = activity;
        this.registry = registry;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "initializeLensView":
                initializeLensView(call);
                break;
            case "run":
                runLensView();
                break;
            case "switchCamera":
                changeLensCamera();
                break;
            case "photograph":
                captureFromLens();
                break;
            case "zoom":
                zoom(call);
                break;
            case "release":
                releaseLensEngine();
                break;
            case "getLensType":
                getLensType();
                break;
            case "getDisplayDimensions":
                getDpDimensions();
                break;
            case "getLens":
                getLens();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void initializeLensView(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("initLensView");
        if (registry == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("initLensView", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "Could not initialize the texture", MlConstants.NULL_OBJECT);
            return;
        }

        width = call.argument("dimensionWidth");
        height = call.argument("dimensionHeight");
        lensType = call.argument("lensType");
        fps = call.argument("applyFps");
        flashMode = call.argument("flashMode");
        focusMode = call.argument("focusMode");
        autoFocus = call.argument("automaticFocus");
        analyzerList = call.argument("analyzerList");
        maxFrameLostCount = call.argument("maxFrameLostCount");

        String analyzerType = call.argument("analyzerType");

        if (analyzerType == null || analyzerType.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("initLensView", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Invalid or missing parameter", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = createAnalyzerObject(analyzerType);

        entry = registry.createSurfaceTexture();
        surfaceTexture = entry.surfaceTexture();
        surfaceTexture.setDefaultBufferSize(width, height);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("initLensView");
        mResult.success(entry.id());
    }

    private void runLensView() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("runLensEngine");
        lensEngine = new LensEngine.Creator(activity.getApplicationContext(), analyzer)
                .setLensType(lensType)
                .applyDisplayDimension(width, height)
                .applyFps(fps.floatValue())
                .enableAutomaticFocus(autoFocus)
                .setFlashMode(flashMode)
                .setFocusMode(focusMode)
                .create();

        if (surfaceTexture == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("runLensEngine", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "Lens texture is not initialized!", MlConstants.NULL_OBJECT);
            return;
        }
        try {
            lensEngine.run(surfaceTexture);
        } catch (IOException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("runLensEngine", e.getMessage());
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void changeLensCamera() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("switchLensCamera");
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("switchLensCamera", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Lens engine is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        if (lensType == 0) {
            lensType = 1;
        } else {
            lensType = 0;
        }
        lensEngine.close();
        runLensView();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("switchLensCamera");
        mResult.success(true);
    }

    private void captureFromLens() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("captureImageFromLens");
        HmsMlUtils.captureImageFromLens(activity, lensEngine, mResult);
    }

    private void zoom(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("zoom");
        Double zoom = call.argument("zoom");
        if (lensEngine == null || zoom == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("zoom", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "Lens engine or zoom value is missing", MlConstants.NULL_OBJECT);
            return;
        }
        lensEngine.doZoom(zoom.floatValue());
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("zoom");
        mResult.success(true);
    }

    private void releaseLensEngine() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("releaseLensEngine");
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("releaseLensEngine", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Lens engine is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        lensEngine.release();
        entry.release();
        analyzer.setTransactor(null);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("releaseLensEngine");
        mResult.success(true);
    }

    private void getLensType() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLensType");
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLensType", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Lens engine is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLensType");
        mResult.success(lensEngine.getLensType());
    }

    private void getDpDimensions() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLensDimension");
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLensDimension", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Lens engine is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        Size size = lensEngine.getDisplayDimension();
        Map<String, Object> map = new HashMap<>();
        map.put("width", size.getWidth());
        map.put("height", size.getHeight());
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLensDimension");
        mResult.success(map);
    }

    private void getLens() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLens");
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLens", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Lens engine is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        Camera camera = lensEngine.getLens();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLens");
        mResult.success(camera != null);
    }

    private MLAnalyzer<?> createAnalyzerObject(String type) {
        switch (type) {
            case "FACE":
                MLFaceAnalyzer faceAnalyzer = MLAnalyzerFactory.getInstance().getFaceAnalyzer();
                faceAnalyzer.setTransactor(new FaceAnalyzerTransactor(activity));
                return faceAnalyzer;
            case "FACE3D":
                ML3DFaceAnalyzerSetting setting = new ML3DFaceAnalyzerSetting.Factory().setPerformanceType(ML3DFaceAnalyzerSetting.TYPE_SPEED).setTracingAllowed(true).create();
                ML3DFaceAnalyzer dFaceAnalyzer = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer(setting);
                dFaceAnalyzer.setTransactor(new Face3DTransactor(activity));
                return dFaceAnalyzer;
            case "MAX_SIZE_FACE":
                MLFaceAnalyzer faceAnalyzer1 = MLAnalyzerFactory.getInstance().getFaceAnalyzer();
                MLMaxSizeFaceTransactor transactor = new MLMaxSizeFaceTransactor.Creator(faceAnalyzer1, new MaxFaceTransactor(activity)).setMaxFrameLostCount(maxFrameLostCount).create();
                faceAnalyzer1.setTransactor(transactor);
                return faceAnalyzer1;
            case "HAND":
                MLHandKeypointAnalyzer handKeypointAnalyzer = MLHandKeypointAnalyzerFactory.getInstance().getHandKeypointAnalyzer();
                handKeypointAnalyzer.setTransactor(new HandKeypointAnalyzerTransactor(activity));
                return handKeypointAnalyzer;
            case "SKELETON":
                MLSkeletonAnalyzer skeletonAnalyzer = MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer();
                skeletonAnalyzer.setTransactor(new SkeletonAnalyzerTransactor(activity));
                return skeletonAnalyzer;
            case "TEXT":
                MLTextAnalyzer textAnalyzer = new MLTextAnalyzer.Factory(activity.getApplicationContext()).create();
                textAnalyzer.setTransactor(new TextAnalyzerTransactor(activity));
                return textAnalyzer;
            case "OBJECT":
                MLObjectAnalyzer mlObjectAnalyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer();
                mlObjectAnalyzer.setTransactor(new ObjectAnalyzerTransactor(activity));
                return analyzer;
            case "CLASSIFICATION":
                MLImageClassificationAnalyzer classificationAnalyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer();
                classificationAnalyzer.setTransactor(new ClassificationTransactor(activity));
                return classificationAnalyzer;
            case "SCENE":
                MLSceneDetectionAnalyzer sceneDetectionAnalyzer = MLSceneDetectionAnalyzerFactory.getInstance().getSceneDetectionAnalyzer();
                sceneDetectionAnalyzer.setTransactor(new SceneAnalyzerTransactor(activity));
                return sceneDetectionAnalyzer;
            default:
                return null;
        }
    }
}
