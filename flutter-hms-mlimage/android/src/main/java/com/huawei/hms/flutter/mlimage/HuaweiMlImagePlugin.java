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

package com.huawei.hms.flutter.mlimage;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Channel;
import com.huawei.hms.flutter.mlimage.handlers.ClassificationMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.CustomModelMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.DocumentSkewCorrectionMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.ImageSuperResolutionMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.LandmarkMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.LensHandler;
import com.huawei.hms.flutter.mlimage.handlers.ObjectDetectionMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.SceneDetectionMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.SegmentationMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.TextResolutionMethodHandler;
import com.huawei.hms.flutter.mlimage.handlers.product.ProductVisionSearchMethodHandler;
import com.huawei.hms.flutter.mlimage.mlapplication.MlApplicationMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class HuaweiMlImagePlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private MethodChannel classificationMethodChannel;
    private MethodChannel mlApplicationMethodChannel;
    private MethodChannel objectAnalyzerMethodChannel;
    private MethodChannel landMarkMethodChannel;
    private MethodChannel segmentationMethodChannel;
    private MethodChannel superResolutionMethodChannel;
    private MethodChannel documentCorrectionMethodChannel;
    private MethodChannel textResolutionMethodChannel;
    private MethodChannel sceneDetectionMethodChannel;
    private MethodChannel customModelMethodChannel;
    private MethodChannel lensChannel;
    private MethodChannel productVisionSearchMethodChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = flutterPluginBinding;
    }

    private void onAttachedToEngine(@NonNull final BinaryMessenger messenger, @NonNull final Activity activity, final TextureRegistry textureRegistry) {
        initializeChannels(messenger);
        setHandlers(activity, textureRegistry);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        classificationMethodChannel = new MethodChannel(messenger, Channel.CLASSIFICATION_CHANNEL);
        mlApplicationMethodChannel = new MethodChannel(messenger, Channel.APPLICATION_CHANNEL);
        objectAnalyzerMethodChannel = new MethodChannel(messenger, Channel.OBJECT_CHANNEL);
        landMarkMethodChannel = new MethodChannel(messenger, Channel.LANDMARK_CHANNEL);
        segmentationMethodChannel = new MethodChannel(messenger, Channel.SEGMENTATION_CHANNEL);
        superResolutionMethodChannel = new MethodChannel(messenger, Channel.IMAGE_RESOLUTION_CHANNEL);
        documentCorrectionMethodChannel = new MethodChannel(messenger, Channel.DOCUMENT_CORRECTION);
        textResolutionMethodChannel = new MethodChannel(messenger, Channel.TEXT_RESOLUTION);
        sceneDetectionMethodChannel = new MethodChannel(messenger, Channel.SCENE);
        customModelMethodChannel = new MethodChannel(messenger, Channel.CUSTOM_MODEL);
        lensChannel = new MethodChannel(messenger, Channel.IMAGE_LENS);
        productVisionSearchMethodChannel = new MethodChannel(messenger, Channel.PRODUCT);

    }

    private void setHandlers(final Activity activity, TextureRegistry registry) {
        classificationMethodChannel.setMethodCallHandler(new ClassificationMethodHandler(activity));
        mlApplicationMethodChannel.setMethodCallHandler(new MlApplicationMethodHandler(activity));
        objectAnalyzerMethodChannel.setMethodCallHandler(new ObjectDetectionMethodHandler(activity));
        landMarkMethodChannel.setMethodCallHandler(new LandmarkMethodHandler(activity));
        segmentationMethodChannel.setMethodCallHandler(new SegmentationMethodHandler(activity));
        superResolutionMethodChannel.setMethodCallHandler(new ImageSuperResolutionMethodHandler(activity));
        documentCorrectionMethodChannel.setMethodCallHandler(new DocumentSkewCorrectionMethodHandler(activity));
        textResolutionMethodChannel.setMethodCallHandler(new TextResolutionMethodHandler(activity));
        sceneDetectionMethodChannel.setMethodCallHandler(new SceneDetectionMethodHandler(activity));
        customModelMethodChannel.setMethodCallHandler(new CustomModelMethodHandler(activity));
        lensChannel.setMethodCallHandler(new LensHandler(activity, lensChannel, registry));
        productVisionSearchMethodChannel.setMethodCallHandler(new ProductVisionSearchMethodHandler(activity));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity(), mFlutterPluginBinding.getTextureRegistry());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity(), mFlutterPluginBinding.getTextureRegistry());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        classificationMethodChannel.setMethodCallHandler(null);
        mlApplicationMethodChannel.setMethodCallHandler(null);
        objectAnalyzerMethodChannel.setMethodCallHandler(null);
        landMarkMethodChannel.setMethodCallHandler(null);
        segmentationMethodChannel.setMethodCallHandler(null);
        superResolutionMethodChannel.setMethodCallHandler(null);
        documentCorrectionMethodChannel.setMethodCallHandler(null);
        textResolutionMethodChannel.setMethodCallHandler(null);
        sceneDetectionMethodChannel.setMethodCallHandler(null);
        customModelMethodChannel.setMethodCallHandler(null);
        lensChannel.setMethodCallHandler(null);
        productVisionSearchMethodChannel.setMethodCallHandler(null);
    }

    private void removeChannels() {
        classificationMethodChannel = null;
        mlApplicationMethodChannel = null;
        objectAnalyzerMethodChannel = null;
        landMarkMethodChannel = null;
        segmentationMethodChannel = null;
        superResolutionMethodChannel = null;
        documentCorrectionMethodChannel = null;
        textResolutionMethodChannel = null;
        sceneDetectionMethodChannel = null;
        customModelMethodChannel = null;
        lensChannel = null;
        productVisionSearchMethodChannel = null;
    }
}
