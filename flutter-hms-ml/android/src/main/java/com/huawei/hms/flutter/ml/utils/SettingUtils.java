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

package com.huawei.hms.flutter.ml.utils;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.ImageFormat;
import android.graphics.Rect;
import android.media.Image;
import android.media.ImageReader;
import android.net.Uri;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.image.product.ProductsFragment;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureConfig;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureConfig;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureUIConfig;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCaptureConfig;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftSetting;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzerSetting;
import com.huawei.hms.mlsdk.classification.MLLocalClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.classification.MLRemoteClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.common.MLCompositeAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.document.MLDocumentSetting;
import com.huawei.hms.mlsdk.face.MLFaceAnalyzerSetting;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzerSetting;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerFactory;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerSetting;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzerSetting;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationSetting;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzerSetting;
import com.huawei.hms.mlsdk.langdetect.cloud.MLRemoteLangDetectorSetting;
import com.huawei.hms.mlsdk.langdetect.local.MLLocalLangDetectorSetting;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadListener;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadStrategy;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzerSetting;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzerSetting;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerSetting;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzerFactory;
import com.huawei.hms.mlsdk.skeleton.MLSkeletonAnalyzerSetting;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionConfig;
import com.huawei.hms.mlsdk.text.MLLocalTextSetting;
import com.huawei.hms.mlsdk.text.MLRemoteTextSetting;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslateSetting;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslateSetting;
import com.huawei.hms.mlsdk.tts.MLTtsConfig;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SettingUtils {
    private static final String TAG = SettingUtils.class.getSimpleName();

    public static MLFrame createMLFrame(Activity activity, String type, String imagePath, MethodCall call) {
        MLFrame mFrame = null;
        switch (type) {
            case "fromBitmap":
                final String encodedImage = HmsMlUtils.pathToBase64(imagePath);
                byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                mFrame = MLFrame.fromBitmap(bitmap);
                break;
            case "fromFilePath":
                Uri uri = Uri.fromFile(new File(imagePath));
                try {
                    mFrame = MLFrame.fromFilePath(activity.getApplicationContext(), uri);
                } catch (IOException e) {
                    Log.i(TAG, "Error while creating MLFrame from file path", e.getCause());
                }
                break;
            case "fromByteArray": {
                File file = new File(imagePath);
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    try {
                        byte[] content = Files.readAllBytes(file.toPath());
                        MLFrame.Property property = createFrameProperty(call);
                        mFrame = MLFrame.fromByteArray(content, property);
                    } catch (IOException e) {
                        Log.i(TAG, "Failed to create MLFrame from byte array" + e.getMessage());
                    }
                }
                break;
            }
            case "fromByteBuffer": {
                File file = new File(imagePath);
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    try {
                        byte[] content = Files.readAllBytes(file.toPath());
                        ByteBuffer byteBuffer = ByteBuffer.wrap(content);
                        MLFrame.Property property = createFrameProperty(call);
                        mFrame = MLFrame.fromByteBuffer(byteBuffer, property);
                    } catch (IOException e) {
                        Log.i(TAG, "Failed to create MLFrame from byte buffer", e.getCause());
                    }
                }
                break;
            }
            case "fromMediaImage":
                MLFrame.Property property = createFrameProperty(call);
                ImageReader imageReader = ImageReader.newInstance(property.getWidth(), property.getHeight(), ImageFormat.YUV_420_888, 1);
                Image image = imageReader.acquireLatestImage();
                mFrame = MLFrame.fromMediaImage(image, property.getQuadrant());
                imageReader.close();
                break;
            case "fromCreator":
                mFrame = crateFrameWithCreator(call, imagePath);
                break;
            default:
                break;
        }
        return mFrame;
    }

    public static MLFrame.Property createFrameProperty(MethodCall call) {
        MLFrame.Property.Creator creator = new MLFrame.Property.Creator();
        Map<String, Object> map = call.argument("property");

        if (map == null) {
            return creator.create();
        }

        JSONObject jsonObject = new JSONObject(map);

        try {
            int width = jsonObject.getInt("width");
            int height = jsonObject.getInt("height");
            int quadrant = jsonObject.getInt("quadrant");
            int formatType = jsonObject.getInt("formatType");
            int itemIdentity = jsonObject.getInt("itemIdentity");
            int timeStamp = jsonObject.getInt("timestamp");

            creator
                    .setWidth(width)
                    .setHeight(height)
                    .setQuadrant(quadrant)
                    .setFormatType(formatType)
                    .setItemIdentity(itemIdentity)
                    .setTimestamp(timeStamp)
                    .setExt(createFramePropertyExt(jsonObject.getJSONObject("ext")));
        } catch (JSONException e) {
            Log.w(TAG, "Failed to create MLFrame Property from arguments" + e.getMessage());
        }

        return creator.create();
    }

    public static MLFrame.Property.Ext createFramePropertyExt(JSONObject extObject) {
        MLFrame.Property.Ext.Creator creator = new MLFrame.Property.Ext.Creator();

        if (extObject == null) {
            return creator.build();
        }

        try {
            JSONObject rectObject = extObject.getJSONObject("border");
            int lensId = extObject.getInt("lensId");
            int maxZoom = extObject.getInt("maxZoom");
            int zoom = extObject.getInt("zoom");

            int top = rectObject.getInt("top");
            int left = rectObject.getInt("left");
            int bottom = rectObject.getInt("bottom");
            int right = rectObject.getInt("right");

            creator.setLensId(lensId).setMaxZoom(maxZoom).setZoom(zoom).setRect(new Rect(left, top, right, bottom));
        } catch (JSONException e) {
            Log.w(TAG, "Failed to create MLFrame Property Ext from arguments" + e.getMessage());
        }
        return creator.build();
    }

    public static MLFrame crateFrameWithCreator(MethodCall call, String imagePath) {
        MLFrame.Creator creator = new MLFrame.Creator();
        Map<String, Object> map = call.argument("property");

        if (map == null) {
            return null;
        }

        JSONObject jsonObject = new JSONObject(map);

        try {
            int itemIdentity = jsonObject.getInt("itemIdentity");
            int quadrant = jsonObject.getInt("quadrant");
            int timeStamp = jsonObject.getInt("timestamp");
            int width = jsonObject.getInt("width");
            int height = jsonObject.getInt("height");

            int formatType = jsonObject.getInt("formatType");

            creator
                    .setQuadrant(quadrant)
                    .setItemIdentity(itemIdentity)
                    .setTimestamp(timeStamp)
                    .setFramePropertyExt(createFramePropertyExt(jsonObject.getJSONObject("ext")));

            File file = new File(imagePath);
            byte[] content = new byte[0];
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                content = Files.readAllBytes(file.toPath());
            }
            ByteBuffer byteBuffer = ByteBuffer.wrap(content);
            creator.writeByteBufferData(byteBuffer, width, height, formatType);

        } catch (JSONException | IOException e) {
            Log.w(TAG, "Failed to create MLFrame Property from arguments" + e.getMessage());
        }

        final String encodedImage = HmsMlUtils.pathToBase64(imagePath);
        final byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        final Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        creator.setBitmap(bitmap);

        return creator.create();
    }

    /**
     * Creates settings for face analyzer
     *
     * @param call Customized parameters
     * @return MLFaceAnalyzerSetting
     */
    public static MLFaceAnalyzerSetting createFaceAnalyzerSetting(MethodCall call) {
        Integer keyPointType = call.argument("keyPointType");
        Integer featureType = call.argument("featureType");
        Integer shapeType = call.argument("shapeType");
        Integer performanceType = call.argument("performanceType");
        Integer tracingMode = call.argument("tracingMode");
        Boolean tracingAllowed = call.argument("tracingAllowed");
        Boolean poseDisabled = call.argument("poseDisabled");
        Boolean maxSizeFaceOnly = call.argument("maxSizeFaceOnly");
        Double minFaceProportion = call.argument("minFaceProportion");

        return new MLFaceAnalyzerSetting.Factory()
                .setKeyPointType(keyPointType == null ? 1 : keyPointType)
                .setFeatureType(featureType == null ? 1 : featureType)
                .setShapeType(shapeType == null ? 2 : shapeType)
                .setTracingAllowed(tracingAllowed == null ? false : tracingAllowed, tracingMode == null ? 2 : 1)
                .setPoseDisabled(poseDisabled == null ? false : poseDisabled)
                .setPerformanceType(performanceType == null ? 1 : performanceType)
                .setMaxSizeFaceOnly(maxSizeFaceOnly == null ? true : maxSizeFaceOnly)
                .setMinFaceProportion(minFaceProportion == null ? 0.5f : minFaceProportion.floatValue())
                .create();
    }

    /**
     * Creates settings for bankcard analyzer
     *
     * @param call Customized parameters
     * @return MLBcrAnalyzerSetting
     */
    public static MLBcrAnalyzerSetting createBcrAnalyzerSetting(MethodCall call) {
        String langType = call.argument("langType");
        Integer resultType = call.argument("resultType");
        Integer rectMode = call.argument("rectMode");

        return new MLBcrAnalyzerSetting.Factory()
                .setLangType(langType)
                .setResultType(resultType == null ? 2 : resultType)
                .setRecMode(rectMode != null ? rectMode : 1)
                .create();
    }

    /**
     * Creates settings for bankcard capturing
     *
     * @param call Customized parameters
     * @return MLBcrCaptureConfig
     */
    public static MLBcrCaptureConfig createBcrCaptureConfig(MethodCall call) {
        Integer resultType = call.argument("resultType");
        Integer orientation = call.argument("orientation");
        Integer rectMode = call.argument("rectMode");

        return new MLBcrCaptureConfig.Factory()
                .setOrientation(orientation != null ? orientation : 0)
                .setResultType(resultType != null ? resultType : 2)
                .setRecMode(rectMode != null ? rectMode : 1)
                .create();
    }

    public static MLLocalTextSetting createLocalTextSetting(MethodCall call) {
        String language = call.argument("language");
        return new MLLocalTextSetting.Factory()
                .setOCRMode(1)
                .setLanguage(language)
                .create();
    }

    public static MLRemoteTextSetting createRemoteTextSetting(MethodCall call) {
        String borderType = call.argument("borderType");
        Integer textDensityScene = call.argument("textDensityScene");
        List<String> languages = call.argument("languages");

        return new MLRemoteTextSetting.Factory()
                .setTextDensityScene(textDensityScene == null ? 2 : textDensityScene)
                .setLanguageList(languages)
                .setBorderType(borderType)
                .create();
    }

    public static MLTextAnalyzer createAnalyzerForSyncDetection(MethodCall call, Activity activity) {
        String language = call.argument("language");

        return new MLTextAnalyzer.Factory(activity.getApplicationContext())
                .setLocalOCRMode(1)
                .setLanguage(language)
                .create();
    }

    /**
     * Creates settings for document analyzer
     *
     * @param call Customized parameters
     * @return MLDocumentSetting
     */
    public static MLDocumentSetting createDocumentSetting(MethodCall call) {
        String borderType = call.argument("borderType");
        List<String> languageList = call.argument("languageList");
        Boolean fingerPrint = call.argument("fingerPrint");

        MLDocumentSetting documentSetting;
        if (fingerPrint == null || !fingerPrint) {
            documentSetting = new MLDocumentSetting.Factory()
                    .setBorderType(borderType == null ? "ARC" : "NGON")
                    .setLanguageList(languageList)
                    .create();
        } else {
            documentSetting = new MLDocumentSetting.Factory()
                    .setBorderType(borderType == null ? "ARC" : "NGON")
                    .setLanguageList(languageList)
                    .enableFingerprintVerification()
                    .create();
        }

        return documentSetting;
    }

    /**
     * Creates setting for hand analyzer
     *
     * @param call Customized parameters
     * @return MLHandKeypointAnalyzerSetting
     */
    public static MLHandKeypointAnalyzerSetting createHandAnalyzerSetting(MethodCall call) {
        Integer sceneType = call.argument("sceneType");
        Integer maxHandResults = call.argument("maxHandResults");

        return new MLHandKeypointAnalyzerSetting.Factory()
                .setMaxHandResults(maxHandResults != null ? maxHandResults : 10)
                .setSceneType(sceneType != null ? sceneType : 0)
                .create();
    }

    /**
     * Creates setting for skeleton analyzer
     *
     * @param call Customized parameters
     * @return MLSkeletonAnalyzerSetting
     */
    public static MLSkeletonAnalyzerSetting createSkeletonAnalyzerSetting(MethodCall call) {
        Integer analyzerType = call.argument("analyzerType");

        return new MLSkeletonAnalyzerSetting.Factory()
                .setAnalyzerType(analyzerType == null ? 0 : analyzerType)
                .create();
    }

    /**
     * Creates setting for product analyzer
     *
     * @param call Customized parameters
     * @return MLRemoteProductVisionSearchAnalyzerSetting
     */
    public static MLRemoteProductVisionSearchAnalyzerSetting createProductSetting(MethodCall call) {
        String productSetId = call.argument("productSetId");
        Integer largestNumberOfReturns = call.argument("largestNumberOfReturns");
        Integer region = call.argument("region");

        return new MLRemoteProductVisionSearchAnalyzerSetting
                .Factory()
                .setLargestNumOfReturns(largestNumberOfReturns == null ? 20 : largestNumberOfReturns)
                .setRegion(region == null ? 1002 : region)
                .setProductSetId(productSetId == null ? "vmall" : productSetId)
                .create();
    }

    public static MLProductVisionSearchCaptureConfig createPluginProductSetting(MethodCall call, Activity activity, MethodChannel.Result result) {
        String productSetId = call.argument("productSetId");
        Integer largestNumberOfReturns = call.argument("largestNumberOfReturns");
        Integer region = call.argument("region");

        return new MLProductVisionSearchCaptureConfig.Factory()
                .setLargestNumOfReturns(largestNumberOfReturns != null ? largestNumberOfReturns : 20)
                .setProductSetId(productSetId != null ? productSetId : "vmall")
                .setRegion(region == null ? 1002 : region)
                .setProductFragment(new ProductsFragment(activity.getApplicationContext(), result))
                .create();
    }

    /**
     * Creates setting for object analyzer
     *
     * @param call Customized parameters
     * @return MLObjectAnalyzerSetting
     */
    public static MLObjectAnalyzerSetting createObjectAnalyzerSetting(MethodCall call) {
        Boolean allowMultiResults = call.argument("allowMultiResults");
        Boolean allowClassification = call.argument("allowClassification");
        Integer analyzerType = call.argument("analyzerType");

        if (allowMultiResults == null) allowMultiResults = true;

        if (allowClassification == null) allowClassification = true;

        if (analyzerType == null) analyzerType = 0;

        MLObjectAnalyzerSetting setting;
        if (allowMultiResults && allowClassification) {
            setting = new MLObjectAnalyzerSetting.Factory()
                    .allowClassification()
                    .allowMultiResults()
                    .setAnalyzerType(analyzerType)
                    .create();
        } else if (allowMultiResults) {
            setting = new MLObjectAnalyzerSetting.Factory()
                    .allowMultiResults()
                    .setAnalyzerType(analyzerType)
                    .create();
        } else if (allowClassification) {
            setting = new MLObjectAnalyzerSetting.Factory()
                    .allowClassification()
                    .setAnalyzerType(analyzerType)
                    .create();
        } else {
            setting = new MLObjectAnalyzerSetting.Factory()
                    .setAnalyzerType(analyzerType)
                    .create();
        }

        return setting;
    }

    public static MLRemoteLandmarkAnalyzerSetting createLandmarkAnalyzerSetting(MethodCall call) {
        Integer maxResults = call.argument("largestNumberOfReturns");
        Integer patternType = call.argument("patternType");

        return new MLRemoteLandmarkAnalyzerSetting.Factory()
                .setLargestNumOfReturns(maxResults != null ? maxResults : 10)
                .setPatternType(patternType != null ? patternType : 1)
                .create();
    }

    public static MLImageSegmentationSetting createSegmentationSetting(MethodCall call) {
        Integer analyzerType = call.argument("analyzerType");
        Integer scene = call.argument("scene");
        Boolean exactMode = call.argument("exactMode");

        return new MLImageSegmentationSetting.Factory()
                .setExact(exactMode != null ? exactMode : true)
                .setAnalyzerType(analyzerType != null ? analyzerType : 1)
                .setScene(scene != null ? scene : 0)
                .create();
    }

    public static MLImageSuperResolutionAnalyzerSetting createImageResolutionSetting(MethodCall call) {
        Double scale = call.argument("scale");

        return new MLImageSuperResolutionAnalyzerSetting.Factory()
                .setScale(scale == null ? 1.0f : scale.floatValue())
                .create();
    }

    public static MLSceneDetectionAnalyzerSetting createSceneDetectionSetting(MethodCall call) {
        Double confidence = call.argument("confidence");

        return new MLSceneDetectionAnalyzerSetting.Factory()
                .setConfidence(confidence != null ? confidence.floatValue() : 0.5f)
                .create();
    }

    public static MLGcrCaptureConfig createGcrCaptureConfig(MethodCall call) {
        String localImageLanguage = call.argument("language");

        return new MLGcrCaptureConfig.Factory().setLanguage(localImageLanguage).create();
    }

    public static MLGcrCaptureUIConfig createGcrUiConfig(MethodCall call) {
        String tipText = call.argument("tipText");
        Integer photoButtonResId = call.argument("photoButtonResId");
        Integer backButtonResId = call.argument("backButtonResId");
        Integer torchOnResId = call.argument("torchOnResId");
        Integer torchOffResId = call.argument("torchOffResId");
        String tipTextColor = call.argument("tipTextColor");
        String scanBoxCornerColor = call.argument("scanBoxCornerColor");

        if (backButtonResId == null) backButtonResId = 1234576;

        if (photoButtonResId == null) photoButtonResId = 1234567;

        if (torchOffResId == null) torchOffResId = 1234567;

        if (torchOnResId == null) torchOnResId = 1234567;

        return new MLGcrCaptureUIConfig.Factory()
                .setBackButtonResId(backButtonResId)
                .setTipText(tipText)
                .setScanBoxCornerColor(Color.parseColor(scanBoxCornerColor))
                .setPhotoButtonResId(photoButtonResId)
                .setTipTextColor(Color.parseColor(tipTextColor))
                .setTorchResId(torchOnResId, torchOffResId)
                .create();
    }

    public static ML3DFaceAnalyzerSetting create3DAnalyzeSetting(MethodCall call) {
        Integer performanceType = call.argument("performanceType");
        Boolean tracingAllowed = call.argument("tracingAllowed");

        return new ML3DFaceAnalyzerSetting.Factory()
                .setPerformanceType(performanceType != null ? performanceType : 1)
                .setTracingAllowed(tracingAllowed != null ? tracingAllowed : false)
                .create();
    }

    public static MLRemoteTranslateSetting createRemoteTranslateSetting(@NonNull MethodCall call) {
        String sourceLang = call.argument("sourceLang");
        String targetLang = call.argument("targetLang");

        return new MLRemoteTranslateSetting.Factory()
                .setSourceLangCode(sourceLang != null ? sourceLang : "zh")
                .setTargetLangCode(targetLang != null ? targetLang : "en")
                .create();
    }

    public static MLLocalTranslateSetting createLocalTranslateSetting(@NonNull MethodCall call) {
        String sourceLang = call.argument("sourceLang");
        String targetLang = call.argument("targetLang");

        return new MLLocalTranslateSetting.Factory()
                .setSourceLangCode(sourceLang != null ? sourceLang : "zh")
                .setTargetLangCode(targetLang != null ? targetLang : "en")
                .create();
    }

    public static MLModelDownloadStrategy createModelDownloadStrategy(@NonNull MethodCall call) {
        MLModelDownloadStrategy.Factory factory = new MLModelDownloadStrategy.Factory();
        Boolean wifiNeeded = call.argument("needWifi");
        Boolean chargingNeeded = call.argument("needCharging");
        Boolean idleNeeded = call.argument("needDeviceIdle");
        Integer region = call.argument("region");

        if (wifiNeeded == null) wifiNeeded = true;

        if (chargingNeeded == null) chargingNeeded = false;

        if (idleNeeded == null) idleNeeded = false;

        if (region == null) region = 1002;

        if (wifiNeeded) {
            factory.needWifi();
        }

        if (chargingNeeded) {
            factory.needCharging();
        }

        if (idleNeeded) {
            factory.needDeviceIdle();
        }

        factory.setRegion(region);
        return factory.create();
    }

    public static final MLModelDownloadListener MODEL_DOWNLOAD_LISTENER = (l, l1) -> Log.i("ModelDownloadListener", "Downloaded: " + l + " From: " + l1);

    public static MLLocalLangDetectorSetting createLocalLangDetectorSetting(@NonNull MethodCall call) {
        Double threshold = call.argument("trustedThreshold");

        if (threshold == null) threshold = 0.5;

        return new MLLocalLangDetectorSetting.Factory().setTrustedThreshold(threshold.floatValue()).create();
    }

    public static MLRemoteLangDetectorSetting createRemoteLangDetectorSetting(@NonNull MethodCall call) {
        Double threshold = call.argument("trustedThreshold");

        if (threshold == null) threshold = 0.5;

        return new MLRemoteLangDetectorSetting.Factory().setTrustedThreshold(threshold.floatValue()).create();
    }

    public static MLRemoteAftSetting createAftSetting(@NonNull MethodCall call) {
        String language = call.argument("language");
        Boolean enablePunctuation = call.argument("enablePunctuation");
        Boolean enableWordTimeOffset = call.argument("enableWordTimeOffset");
        Boolean enableSentenceTimeOffset = call.argument("enableSentenceTimeOffset");

        return new MLRemoteAftSetting.Factory()
                .setLanguageCode(language)
                .enablePunctuation(enablePunctuation == null ? false : enablePunctuation)
                .enableWordTimeOffset(enableWordTimeOffset == null ? false : enableWordTimeOffset)
                .enableSentenceTimeOffset(enableSentenceTimeOffset == null ? false : enableSentenceTimeOffset)
                .create();
    }

    public static MLSpeechRealTimeTranscriptionConfig createRttConfig(@NonNull MethodCall call) {
        MLSpeechRealTimeTranscriptionConfig.Factory configFactory = new MLSpeechRealTimeTranscriptionConfig.Factory();
        String language = call.argument("language");
        String scene = call.argument("scene");
        Boolean punctuationEnabled = call.argument("punctuationEnabled");
        Boolean sentenceTimeOffsetEnabled = call.argument("sentenceTimeOffsetEnabled");
        Boolean wordTimeOffsetEnabled = call.argument("wordTimeOffsetEnabled");

        if (scene != null && scene.contains("z")) {
            configFactory.setScenes(scene);
        }

        configFactory
                .setLanguage(language)
                .enablePunctuation(punctuationEnabled == null ? false : punctuationEnabled)
                .enableSentenceTimeOffset(sentenceTimeOffsetEnabled == null ? false : sentenceTimeOffsetEnabled)
                .enableWordTimeOffset(wordTimeOffsetEnabled == null ? false : wordTimeOffsetEnabled);
        return configFactory.create();
    }

    public static MLTtsConfig createTtsConfig(@NonNull MethodCall call) {
        String language = call.argument("language");
        String person = call.argument("person");
        String synthesizeMode = call.argument("synthesizeMode");
        Double speed = call.argument("speed");
        Double volume = call.argument("volume");

        return new MLTtsConfig()
                .setLanguage(language)
                .setPerson(person)
                .setSpeed(speed != null ? speed.floatValue() : 1.0f)
                .setVolume(volume != null ? volume.floatValue() : 1.0f)
                .setSynthesizeMode(synthesizeMode);
    }

    public static MLCompositeAnalyzer.Creator createCompositeCreator(@NonNull List<String> list) {
        MLCompositeAnalyzer.Creator creator = new MLCompositeAnalyzer.Creator();

        if (!list.isEmpty()) {
            if (list.contains("TEXT_ANALYZER"))
                creator.add(MLAnalyzerFactory.getInstance().getLocalTextAnalyzer());
            if (list.contains("FACE_ANALYZER"))
                creator.add(MLAnalyzerFactory.getInstance().getFaceAnalyzer());
            if (list.contains("SKELETON_ANALYZER"))
                creator.add(MLSkeletonAnalyzerFactory.getInstance().getSkeletonAnalyzer());
            if (list.contains("HAND_ANALYZER"))
                creator.add(MLHandKeypointAnalyzerFactory.getInstance().getHandKeypointAnalyzer());
            if (list.contains("OBJECT_ANALYZER"))
                creator.add(MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer());
            if (list.contains("CLASSIFICATION_ANALYZER"))
                creator.add(MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer());
        }
        return creator;
    }

    public static MLRemoteClassificationAnalyzerSetting getRemoteClsSetting(@NonNull MethodCall call) {
        MLRemoteClassificationAnalyzerSetting.Factory factory = new MLRemoteClassificationAnalyzerSetting.Factory();
        Double minAccPossibility = call.argument("minAcceptablePossibility");
        Integer largestNum = call.argument("largestNumberOfReturns");
        Boolean fingerPrint = call.argument("fingerprintVerification");

        if (fingerPrint != null && fingerPrint)
            factory.enableFingerprintVerification();

        return factory
                .setLargestNumOfReturns(largestNum != null ? largestNum : 10)
                .setMinAcceptablePossibility(minAccPossibility != null ? minAccPossibility.floatValue() : 0.5f)
                .create();
    }

    public static MLLocalClassificationAnalyzerSetting getLocalClsSetting(@NonNull MethodCall call) {
        Double minAccPossibility = call.argument("minAcceptablePossibility");

        return new MLLocalClassificationAnalyzerSetting.Factory()
                .setMinAcceptablePossibility(minAccPossibility != null ? minAccPossibility.floatValue() : 0.5f)
                .create();
    }
}
