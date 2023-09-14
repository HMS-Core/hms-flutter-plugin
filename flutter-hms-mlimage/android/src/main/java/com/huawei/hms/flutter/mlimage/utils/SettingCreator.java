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

package com.huawei.hms.flutter.mlimage.utils;

import android.app.Activity;
import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.handlers.product.ProductsFragment;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCaptureConfig;
import com.huawei.hms.mlsdk.classification.MLLocalClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.classification.MLRemoteClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzerSetting;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationSetting;
import com.huawei.hms.mlsdk.landmark.MLRemoteLandmarkAnalyzerSetting;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzerSetting;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzerSetting;
import com.huawei.hms.mlsdk.scd.MLSceneDetectionAnalyzerSetting;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SettingCreator {
    /**
     * @param path Local image path
     * @return MLFrame instance
     */
    public static MLFrame frameFromBitmap(String path) {
        Bitmap bt = Commons.bitmapFromPath(path);
        return MLFrame.fromBitmap(bt);
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

        if (allowMultiResults == null) {
            allowMultiResults = true;
        }

        if (allowClassification == null) {
            allowClassification = true;
        }

        if (analyzerType == null) {
            analyzerType = 0;
        }

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

    public static MLRemoteClassificationAnalyzerSetting getRemoteClsSetting(@NonNull MethodCall call) {
        MLRemoteClassificationAnalyzerSetting.Factory factory = new MLRemoteClassificationAnalyzerSetting.Factory();
        Double minAccPossibility = call.argument("minAcceptablePossibility");
        Integer largestNum = call.argument("largestNumberOfReturns");
        Boolean fingerPrint = call.argument("fingerprintVerification");

        if (fingerPrint != null && fingerPrint) {
            factory.enableFingerprintVerification();
        }

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
