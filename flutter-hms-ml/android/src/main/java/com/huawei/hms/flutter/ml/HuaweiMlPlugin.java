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

package com.huawei.hms.flutter.ml;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.body.Face3DAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.language.AftMethodHandler;
import com.huawei.hms.flutter.ml.language.AsrMethodHandler;
import com.huawei.hms.flutter.ml.language.LocalTranslatorMethodHandler;
import com.huawei.hms.flutter.ml.language.RemoteTranslatorMethodHandler;
import com.huawei.hms.flutter.ml.language.SoundDetectionMethodHandler;
import com.huawei.hms.flutter.ml.lensview.LensViewMethodHandler;
import com.huawei.hms.flutter.ml.mlapplication.MlApplicationMethodHandler;
import com.huawei.hms.flutter.ml.mlframe.MLFrameMethodHandler;
import com.huawei.hms.flutter.ml.text.BankcardAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.image.ClassificationMethodHandler;
import com.huawei.hms.flutter.ml.custommodel.CustomModelMethodHandler;
import com.huawei.hms.flutter.ml.text.DocumentAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.image.DocumentSkewCorrectionMethodHandler;
import com.huawei.hms.flutter.ml.text.FormRecognitionMethodHandler;
import com.huawei.hms.flutter.ml.text.GeneralCardAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.body.HandKeypointDetectionMethodHandler;
import com.huawei.hms.flutter.ml.image.ImageSuperResolutionMethodHandler;
import com.huawei.hms.flutter.ml.image.ImageSegmentationMethodHandler;
import com.huawei.hms.flutter.ml.image.LandMarkAnalyzeMethodHandler;
import com.huawei.hms.flutter.ml.language.LangDetectionMethodHandler;
import com.huawei.hms.flutter.ml.body.LivenessDetectionMethodHandler;
import com.huawei.hms.flutter.ml.image.ObjectDetectionMethodHandler;
import com.huawei.hms.flutter.ml.permissions.PermissionHandler;
import com.huawei.hms.flutter.ml.image.product.ProductVisionSearchMethodHandler;
import com.huawei.hms.flutter.ml.language.RealTimeTranscriptionMethodHandler;
import com.huawei.hms.flutter.ml.image.SceneDetectionMethodHandler;
import com.huawei.hms.flutter.ml.body.SkeletonDetectionMethodHandler;
import com.huawei.hms.flutter.ml.text.TextAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.textembedding.TextEmbeddingMethodHandler;
import com.huawei.hms.flutter.ml.image.TextResolutionMethodHandler;
import com.huawei.hms.flutter.ml.language.TextToSpeechMethodHandler;
import com.huawei.hms.flutter.ml.body.FaceAnalyzerMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.view.TextureRegistry;

public class HuaweiMlPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;
    private MethodChannel textAnalyzerMethodChannel;
    private MethodChannel faceAnalyzerMethodChannel;
    private MethodChannel documentAnalyzerMethodChannel;
    private MethodChannel productVisionSearchMethodChannel;
    private MethodChannel languageDetectionMethodChannel;
    private MethodChannel imageSegmentationMethodChannel;
    private MethodChannel landMarkMethodChannel;
    private MethodChannel bankcardMethodChannel;
    private MethodChannel textToSpeechMethodChannel;
    private MethodChannel objectAnalyzerMethodChannel;
    private MethodChannel classificationMethodChannel;
    private MethodChannel generalCardMethodChannel;
    private MethodChannel asrMethodChannel;
    private MethodChannel aftMethodChannel;
    private MethodChannel permissionHandlerMethodChannel;
    private MethodChannel skeletonMethodChannel;
    private MethodChannel superResolutionMethodChannel;
    private MethodChannel documentCorrectionMethodChannel;
    private MethodChannel handKeypointDetectionMethodChannel;
    private MethodChannel livenessDetectionMethodChannel;
    private MethodChannel customModelMethodChannel;
    private MethodChannel sceneDetectionMethodChannel;
    private MethodChannel textResolutionMethodChannel;
    private MethodChannel realTimeTranscriptionMethodChannel;
    private MethodChannel textEmbeddingMethodChannel;
    private MethodChannel soundDetectionMethodChannel;
    private MethodChannel formDetectionMethodChannel;
    private MethodChannel lensViewMethodChannel;
    private MethodChannel mlApplicationMethodChannel;
    private MethodChannel face3dMethodChannel;
    private MethodChannel localTranslateMethodChannel;
    private MethodChannel remoteTranslateMethodChannel;
    private MethodChannel frameMethodChannel;

    private EventChannel textEventChannel;
    private EventChannel ttsEventChannel;
    private EventChannel aftEventChannel;
    private EventChannel asrEventChannel;
    private EventChannel faceEventChannel;
    private EventChannel skeletonEventChannel;
    private EventChannel handEventChannel;
    private EventChannel realTimeTranscriptionEventChannel;
    private EventChannel face3dEventChannel;
    private EventChannel objectEventChannel;
    private EventChannel classificationEventChannel;
    private EventChannel sceneEventChannel;


    public static void registerWith(Registrar registrar) {
        HuaweiMlPlugin huaweiMlPlugin = new HuaweiMlPlugin();
        registrar.publish(huaweiMlPlugin);
        huaweiMlPlugin.onAttachedToEngine(registrar.messenger(), registrar.activity(), registrar.textures());
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity, final TextureRegistry textureRegistry) {
        initializeChannels(messenger);
        setHandlers(activity, textureRegistry);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        textAnalyzerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/text/method");
        faceAnalyzerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/face/method");
        documentAnalyzerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/document/method");
        productVisionSearchMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/product/method");
        languageDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/lang_detection/method");
        imageSegmentationMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/segmentation/method");
        landMarkMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/landmark/method");
        bankcardMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/bankcard/method");
        textToSpeechMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/tts/method");
        objectAnalyzerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/object/method");
        classificationMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/classification/method");
        generalCardMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/gcr/method");
        asrMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/asr/method");
        aftMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/aft/method");
        permissionHandlerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/permission/method");
        skeletonMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/skeleton/method");
        superResolutionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/image_resolution/method");
        documentCorrectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/document_correction/method");
        handKeypointDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/hand/method");
        livenessDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/liveness/method");
        customModelMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/custom_model/method");
        sceneDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/scene/method");
        textResolutionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/text_resolution/method");
        realTimeTranscriptionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/rtt/method");
        textEmbeddingMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/text_embedding/method");
        soundDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/sound/method");
        formDetectionMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/form/method");
        lensViewMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/lens/method");
        mlApplicationMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/application/method");
        face3dMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/face/3d/method");
        localTranslateMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/translate/local/method");
        remoteTranslateMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/translate/remote/method");
        frameMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.ml/frame/method");

        textEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/text/event");
        ttsEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/tts/event");
        aftEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/aft/event");
        asrEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/asr/event");
        faceEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/face/event");
        face3dEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/face/3d/event");
        skeletonEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/skeleton/event");
        handEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/hand/event");
        realTimeTranscriptionEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/rtt/event");
        objectEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/object/event");
        classificationEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/classification/event");
        sceneEventChannel = new EventChannel(messenger, "com.huawei.hms.flutter.ml/scene/event");
    }

    private void setHandlers(final Activity activity, final TextureRegistry textureRegistry) {

        TextAnalyzerMethodHandler textAnalyzerMethodHandler = new TextAnalyzerMethodHandler(activity);
        textAnalyzerMethodChannel.setMethodCallHandler(textAnalyzerMethodHandler);
        textEventChannel.setStreamHandler(textAnalyzerMethodHandler);

        FaceAnalyzerMethodHandler faceAnalyzerMethodHandler = new FaceAnalyzerMethodHandler(activity);
        faceAnalyzerMethodChannel.setMethodCallHandler(faceAnalyzerMethodHandler);
        faceEventChannel.setStreamHandler(faceAnalyzerMethodHandler);

        documentAnalyzerMethodChannel.setMethodCallHandler(new DocumentAnalyzerMethodHandler(activity));

        productVisionSearchMethodChannel.setMethodCallHandler(new ProductVisionSearchMethodHandler(activity));

        languageDetectionMethodChannel.setMethodCallHandler(new LangDetectionMethodHandler(activity));

        ImageSegmentationMethodHandler imageSegmentationMethodHandler = new ImageSegmentationMethodHandler(activity);
        imageSegmentationMethodChannel.setMethodCallHandler(imageSegmentationMethodHandler);

        landMarkMethodChannel.setMethodCallHandler(new LandMarkAnalyzeMethodHandler(activity));

        bankcardMethodChannel.setMethodCallHandler(new BankcardAnalyzerMethodHandler(activity));

        TextToSpeechMethodHandler textToSpeechMethodHandler = new TextToSpeechMethodHandler(activity);
        textToSpeechMethodChannel.setMethodCallHandler(textToSpeechMethodHandler);
        ttsEventChannel.setStreamHandler(textToSpeechMethodHandler);

        ObjectDetectionMethodHandler objectDetectionMethodHandler = new ObjectDetectionMethodHandler(activity);
        objectAnalyzerMethodChannel.setMethodCallHandler(objectDetectionMethodHandler);
        objectEventChannel.setStreamHandler(objectDetectionMethodHandler);

        ClassificationMethodHandler classificationMethodHandler = new ClassificationMethodHandler(activity);
        classificationMethodChannel.setMethodCallHandler(classificationMethodHandler);
        classificationEventChannel.setStreamHandler(classificationMethodHandler);

        generalCardMethodChannel.setMethodCallHandler(new GeneralCardAnalyzerMethodHandler(activity));

        AsrMethodHandler asrMethodHandler = new AsrMethodHandler(activity);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addActivityResultListener(asrMethodHandler);
        }
        asrMethodChannel.setMethodCallHandler(asrMethodHandler);
        asrEventChannel.setStreamHandler(asrMethodHandler);

        AftMethodHandler aftMethodHandler = new AftMethodHandler(activity);
        aftMethodChannel.setMethodCallHandler(aftMethodHandler);
        aftEventChannel.setStreamHandler(aftMethodHandler);

        PermissionHandler permissionHandler = new PermissionHandler(activity);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addRequestPermissionsResultListener(permissionHandler);
        }
        permissionHandlerMethodChannel.setMethodCallHandler(permissionHandler);

        SkeletonDetectionMethodHandler methodHandler = new SkeletonDetectionMethodHandler(activity);
        skeletonMethodChannel.setMethodCallHandler(methodHandler);
        skeletonEventChannel.setStreamHandler(methodHandler);

        superResolutionMethodChannel.setMethodCallHandler(new ImageSuperResolutionMethodHandler(activity));

        documentCorrectionMethodChannel.setMethodCallHandler(new DocumentSkewCorrectionMethodHandler(activity));

        HandKeypointDetectionMethodHandler handKeypointDetectionMethodHandler = new HandKeypointDetectionMethodHandler(activity);
        handKeypointDetectionMethodChannel.setMethodCallHandler(handKeypointDetectionMethodHandler);
        handEventChannel.setStreamHandler(handKeypointDetectionMethodHandler);

        livenessDetectionMethodChannel.setMethodCallHandler(new LivenessDetectionMethodHandler(activity));

        customModelMethodChannel.setMethodCallHandler(new CustomModelMethodHandler(activity));

        SceneDetectionMethodHandler sceneDetectionMethodHandler = new SceneDetectionMethodHandler(activity);
        sceneDetectionMethodChannel.setMethodCallHandler(sceneDetectionMethodHandler);
        sceneEventChannel.setStreamHandler(sceneDetectionMethodHandler);

        textResolutionMethodChannel.setMethodCallHandler(new TextResolutionMethodHandler(activity));

        RealTimeTranscriptionMethodHandler realTimeTranscriptionMethodHandler = new RealTimeTranscriptionMethodHandler(activity);
        realTimeTranscriptionMethodChannel.setMethodCallHandler(realTimeTranscriptionMethodHandler);
        realTimeTranscriptionEventChannel.setStreamHandler(realTimeTranscriptionMethodHandler);

        textEmbeddingMethodChannel.setMethodCallHandler(new TextEmbeddingMethodHandler(activity));

        soundDetectionMethodChannel.setMethodCallHandler(new SoundDetectionMethodHandler(activity));

        formDetectionMethodChannel.setMethodCallHandler(new FormRecognitionMethodHandler(activity));

        lensViewMethodChannel.setMethodCallHandler(new LensViewMethodHandler(activity, textureRegistry));

        mlApplicationMethodChannel.setMethodCallHandler(new MlApplicationMethodHandler(activity));

        Face3DAnalyzerMethodHandler face3DAnalyzerMethodHandler = new Face3DAnalyzerMethodHandler(activity);
        face3dMethodChannel.setMethodCallHandler(face3DAnalyzerMethodHandler);
        face3dEventChannel.setStreamHandler(face3DAnalyzerMethodHandler);

        localTranslateMethodChannel.setMethodCallHandler(new LocalTranslatorMethodHandler(activity));

        remoteTranslateMethodChannel.setMethodCallHandler(new RemoteTranslatorMethodHandler(activity));

        frameMethodChannel.setMethodCallHandler(new MLFrameMethodHandler(activity));
    }

    private void removeChannels() {
        textAnalyzerMethodChannel = null;
        faceAnalyzerMethodChannel = null;
        documentAnalyzerMethodChannel = null;
        productVisionSearchMethodChannel = null;
        languageDetectionMethodChannel = null;
        imageSegmentationMethodChannel = null;
        landMarkMethodChannel = null;
        bankcardMethodChannel = null;
        textToSpeechMethodChannel = null;
        objectAnalyzerMethodChannel = null;
        classificationMethodChannel = null;
        generalCardMethodChannel = null;
        asrMethodChannel = null;
        aftMethodChannel = null;
        permissionHandlerMethodChannel = null;
        skeletonMethodChannel = null;
        superResolutionMethodChannel = null;
        documentCorrectionMethodChannel = null;
        handKeypointDetectionMethodChannel = null;
        livenessDetectionMethodChannel = null;
        customModelMethodChannel = null;
        sceneDetectionMethodChannel = null;
        textResolutionMethodChannel = null;
        realTimeTranscriptionMethodChannel = null;
        textEmbeddingMethodChannel = null;
        soundDetectionMethodChannel = null;
        formDetectionMethodChannel = null;
        lensViewMethodChannel = null;
        mlApplicationMethodChannel = null;
        face3dMethodChannel = null;
        localTranslateMethodChannel = null;
        remoteTranslateMethodChannel = null;
        frameMethodChannel = null;

        textEventChannel = null;
        ttsEventChannel = null;
        aftEventChannel = null;
        asrEventChannel = null;
        faceEventChannel = null;
        skeletonEventChannel = null;
        handEventChannel = null;
        realTimeTranscriptionEventChannel = null;
        face3dEventChannel = null;
        classificationEventChannel = null;
        objectEventChannel = null;
        sceneEventChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = binding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(), mFlutterPluginBinding.getTextureRegistry());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(), mFlutterPluginBinding.getTextureRegistry());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        textAnalyzerMethodChannel.setMethodCallHandler(null);
        faceAnalyzerMethodChannel.setMethodCallHandler(null);
        documentAnalyzerMethodChannel.setMethodCallHandler(null);
        productVisionSearchMethodChannel.setMethodCallHandler(null);
        languageDetectionMethodChannel.setMethodCallHandler(null);
        imageSegmentationMethodChannel.setMethodCallHandler(null);
        landMarkMethodChannel.setMethodCallHandler(null);
        bankcardMethodChannel.setMethodCallHandler(null);
        textToSpeechMethodChannel.setMethodCallHandler(null);
        objectAnalyzerMethodChannel.setMethodCallHandler(null);
        classificationMethodChannel.setMethodCallHandler(null);
        generalCardMethodChannel.setMethodCallHandler(null);
        asrMethodChannel.setMethodCallHandler(null);
        aftMethodChannel.setMethodCallHandler(null);
        skeletonMethodChannel.setMethodCallHandler(null);
        permissionHandlerMethodChannel.setMethodCallHandler(null);
        documentCorrectionMethodChannel.setMethodCallHandler(null);
        handKeypointDetectionMethodChannel.setMethodCallHandler(null);
        customModelMethodChannel.setMethodCallHandler(null);
        livenessDetectionMethodChannel.setMethodCallHandler(null);
        sceneDetectionMethodChannel.setMethodCallHandler(null);
        superResolutionMethodChannel.setMethodCallHandler(null);
        textResolutionMethodChannel.setMethodCallHandler(null);
        realTimeTranscriptionMethodChannel.setMethodCallHandler(null);
        textEmbeddingMethodChannel.setMethodCallHandler(null);
        soundDetectionMethodChannel.setMethodCallHandler(null);
        formDetectionMethodChannel.setMethodCallHandler(null);
        lensViewMethodChannel.setMethodCallHandler(null);
        mlApplicationMethodChannel.setMethodCallHandler(null);
        face3dMethodChannel.setMethodCallHandler(null);
        localTranslateMethodChannel.setMethodCallHandler(null);
        remoteTranslateMethodChannel.setMethodCallHandler(null);
        frameMethodChannel.setMethodCallHandler(null);

        textEventChannel.setStreamHandler(null);
        ttsEventChannel.setStreamHandler(null);
        aftEventChannel.setStreamHandler(null);
        asrEventChannel.setStreamHandler(null);
        faceEventChannel.setStreamHandler(null);
        skeletonEventChannel.setStreamHandler(null);
        handEventChannel.setStreamHandler(null);
        realTimeTranscriptionEventChannel.setStreamHandler(null);
        face3dEventChannel.setStreamHandler(null);
        objectEventChannel.setStreamHandler(null);
        classificationEventChannel.setStreamHandler(null);
        sceneEventChannel.setStreamHandler(null);

        mActivityPluginBinding = null;
    }
}