/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.ml;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.aft.AftMethodHandler;
import com.huawei.hms.flutter.ml.asr.AsrMethodHandler;
import com.huawei.hms.flutter.ml.bankcard.BankcardAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.classification.ClassificationMethodHandler;
import com.huawei.hms.flutter.ml.document.DocumentAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.face.FaceAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.generalcard.GeneralCardAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.imgseg.ImageSegmentationMethodHandler;
import com.huawei.hms.flutter.ml.landmark.LandMarkAnalyzeMethodHandler;
import com.huawei.hms.flutter.ml.langdetection.LangDetectionMethodHandler;
import com.huawei.hms.flutter.ml.object.ObjectDetectionMethodHandler;
import com.huawei.hms.flutter.ml.permissions.PermissionHandler;
import com.huawei.hms.flutter.ml.productvisionsearch.ProductVisionSearchMethodHandler;
import com.huawei.hms.flutter.ml.text.TextAnalyzerMethodHandler;
import com.huawei.hms.flutter.ml.translate.TranslatorMethodHandler;
import com.huawei.hms.flutter.ml.tts.TextToSpeechMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HuaweiMlPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel textAnalyzerMethodChannel;
    private MethodChannel faceAnalyzerMethodChannel;
    private MethodChannel documentAnalyzerMethodChannel;
    private MethodChannel translatorMethodChannel;
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

    public static void registerWith(Registrar registrar) {
        HuaweiMlPlugin huaweiMlPlugin = new HuaweiMlPlugin();
        final BinaryMessenger binaryMessenger = registrar.messenger();
        huaweiMlPlugin.onAttachedToEngine(binaryMessenger);
    }

    private void onAttachedToEngine(final BinaryMessenger messenger) {
        initializeChannels(messenger);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        textAnalyzerMethodChannel = new MethodChannel(messenger, "text");
        faceAnalyzerMethodChannel = new MethodChannel(messenger, "face_analyzer");
        documentAnalyzerMethodChannel = new MethodChannel(messenger, "document_analyzer");
        translatorMethodChannel = new MethodChannel(messenger, "translator");
        productVisionSearchMethodChannel = new MethodChannel(messenger, "product_vision_search");
        languageDetectionMethodChannel = new MethodChannel(messenger, "lang_detection");
        imageSegmentationMethodChannel = new MethodChannel(messenger, "image_segmentation");
        landMarkMethodChannel = new MethodChannel(messenger, "land_mark");
        bankcardMethodChannel = new MethodChannel(messenger, "bankcard");
        textToSpeechMethodChannel = new MethodChannel(messenger, "tts");
        objectAnalyzerMethodChannel = new MethodChannel(messenger, "object_analyzer");
        classificationMethodChannel = new MethodChannel(messenger, "image_classification");
        generalCardMethodChannel = new MethodChannel(messenger, "general_card");
        asrMethodChannel = new MethodChannel(messenger, "asr");
        aftMethodChannel = new MethodChannel(messenger, "aft");
        permissionHandlerMethodChannel = new MethodChannel(messenger, "permissions");
    }

    private void removeChannels() {
        textAnalyzerMethodChannel = null;
        faceAnalyzerMethodChannel = null;
        documentAnalyzerMethodChannel = null;
        translatorMethodChannel = null;
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
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        final Activity activity = binding.getActivity();

        TextAnalyzerMethodHandler textAnalyzerMethodHandler =
                new TextAnalyzerMethodHandler(activity);
        textAnalyzerMethodChannel.setMethodCallHandler(textAnalyzerMethodHandler);

        FaceAnalyzerMethodHandler faceAnalyzerMethodHandler =
                new FaceAnalyzerMethodHandler();
        faceAnalyzerMethodChannel.setMethodCallHandler(faceAnalyzerMethodHandler);

        DocumentAnalyzerMethodHandler documentAnalyzerMethodHandler =
                new DocumentAnalyzerMethodHandler(activity);
        documentAnalyzerMethodChannel.setMethodCallHandler(documentAnalyzerMethodHandler);

        TranslatorMethodHandler translatorMethodHandler =
                new TranslatorMethodHandler(activity);
        translatorMethodChannel.setMethodCallHandler(translatorMethodHandler);

        ProductVisionSearchMethodHandler productVisionSearchMethodHandler
                = new ProductVisionSearchMethodHandler(activity);
        productVisionSearchMethodChannel.setMethodCallHandler(productVisionSearchMethodHandler);

        LangDetectionMethodHandler langDetectionMethodHandler =
                new LangDetectionMethodHandler(activity);
        languageDetectionMethodChannel.setMethodCallHandler(langDetectionMethodHandler);

        ImageSegmentationMethodHandler imageSegmentationMethodHandler =
                new ImageSegmentationMethodHandler(activity);
        imageSegmentationMethodChannel.setMethodCallHandler(imageSegmentationMethodHandler);

        LandMarkAnalyzeMethodHandler landMarkAnalyzeMethodHandler =
                new LandMarkAnalyzeMethodHandler(activity);
        landMarkMethodChannel.setMethodCallHandler(landMarkAnalyzeMethodHandler);

        BankcardAnalyzerMethodHandler bankcardAnalyzerMethodHandler =
                new BankcardAnalyzerMethodHandler(activity);
        bankcardMethodChannel.setMethodCallHandler(bankcardAnalyzerMethodHandler);

        TextToSpeechMethodHandler textToSpeechMethodHandler =
                new TextToSpeechMethodHandler(activity);
        textToSpeechMethodChannel.setMethodCallHandler(textToSpeechMethodHandler);

        ObjectDetectionMethodHandler objectDetectionMethodHandler =
                new ObjectDetectionMethodHandler();
        objectAnalyzerMethodChannel.setMethodCallHandler(objectDetectionMethodHandler);

        ClassificationMethodHandler classificationMethodHandler =
                new ClassificationMethodHandler(activity);
        classificationMethodChannel.setMethodCallHandler(classificationMethodHandler);

        GeneralCardAnalyzerMethodHandler generalCardAnalyzerMethodHandler =
                new GeneralCardAnalyzerMethodHandler(activity);
        generalCardMethodChannel.setMethodCallHandler(generalCardAnalyzerMethodHandler);

        AsrMethodHandler asrMethodHandler = new AsrMethodHandler(activity);
        asrMethodChannel.setMethodCallHandler(asrMethodHandler);

        AftMethodHandler aftMethodHandler = new AftMethodHandler(activity);
        aftMethodChannel.setMethodCallHandler(aftMethodHandler);

        PermissionHandler permissionHandler = new PermissionHandler(activity);
        permissionHandlerMethodChannel.setMethodCallHandler(permissionHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        textAnalyzerMethodChannel.setMethodCallHandler(null);
        faceAnalyzerMethodChannel.setMethodCallHandler(null);
        documentAnalyzerMethodChannel.setMethodCallHandler(null);
        translatorMethodChannel.setMethodCallHandler(null);
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
        permissionHandlerMethodChannel.setMethodCallHandler(null);
    }
}