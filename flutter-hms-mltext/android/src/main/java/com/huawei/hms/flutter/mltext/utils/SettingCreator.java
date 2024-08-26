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

package com.huawei.hms.flutter.mltext.utils;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Color;

import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureConfig;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureConfig;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureUIConfig;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzerSetting;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.document.MLDocumentSetting;
import com.huawei.hms.mlsdk.text.MLLocalTextSetting;
import com.huawei.hms.mlsdk.text.MLRemoteTextSetting;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class SettingCreator {
    public static MLFrame frameFromBitmap(String path) {
        Bitmap bt = Commons.bitmapFromPath(path);
        return MLFrame.fromBitmap(bt);
    }

    /**
     * Creates settings for bankcard analyzer
     *
     * @param call Customized parameters
     * @return MLBcrAnalyzerSetting
     */
    public static MLBcrAnalyzerSetting createBcrAnalyzerSetting(MethodCall call) {
        String langType = call.argument(Param.LANG_TYPE);
        Integer resultType = call.argument(Param.RESULT_TYPE);
        Integer rectMode = call.argument(Param.RECT_MODE);

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
        Integer resultType = call.argument(Param.RESULT_TYPE);
        Integer orientation = call.argument(Param.ORIENTATION);
        Integer rectMode = call.argument(Param.RECT_MODE);

        return new MLBcrCaptureConfig.Factory()
                .setOrientation(orientation != null ? orientation : 0)
                .setResultType(resultType != null ? resultType : 2)
                .setRecMode(rectMode != null ? rectMode : 1)
                .create();
    }

    public static MLLocalTextSetting createLocalTextSetting(MethodCall call) {
        String language = call.argument(Param.LANGUAGE);
        return new MLLocalTextSetting.Factory()
                .setOCRMode(1)
                .setLanguage(language)
                .create();
    }

    public static MLRemoteTextSetting createRemoteTextSetting(MethodCall call) {
        String borderType = call.argument(Param.BORDER_TYPE);
        Integer textDensityScene = call.argument(Param.TEXT_DENSITY_SCENE);
        List<String> languages = call.argument(Param.LANGUAGES);

        return new MLRemoteTextSetting.Factory()
                .setTextDensityScene(textDensityScene == null ? 2 : textDensityScene)
                .setLanguageList(languages)
                .setBorderType(borderType)
                .create();
    }

    public static MLTextAnalyzer createAnalyzerForSyncDetection(MethodCall call, Activity activity) {
        String language = call.argument(Param.LANGUAGE);

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
        String borderType = call.argument(Param.BORDER_TYPE);
        List<String> languageList = call.argument(Param.LANGUAGE_LIST);
        Boolean fingerPrint = call.argument(Param.FINGER_PRINT);

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

    public static MLGcrCaptureConfig createGcrCaptureConfig(MethodCall call) {
        String localImageLanguage = call.argument(Param.LANGUAGE);

        return new MLGcrCaptureConfig.Factory().setLanguage(localImageLanguage).create();
    }

    public static MLGcrCaptureUIConfig createGcrUiConfig(MethodCall call) {
        String tipText = call.argument(Param.TIP_TEXT);
        Integer photoButtonResId = call.argument(Param.PHOTO_BUTTON_RES_ID);
        Integer backButtonResId = call.argument(Param.BACK_BUTTON_RES_ID);
        Integer torchOnResId = call.argument(Param.TORCH_ON_RES_ID);
        Integer torchOffResId = call.argument(Param.TORCH_OFF_RES_ID);
        String tipTextColor = call.argument(Param.TIP_TEXT_COLOR);
        String scanBoxCornerColor = call.argument(Param.SCAN_BOX_CORNER_COLOR);

        if (backButtonResId == null) {
            backButtonResId = 1234576;
        }

        if (photoButtonResId == null) {
            photoButtonResId = 1234567;
        }

        if (torchOffResId == null) {
            torchOffResId = 1234567;
        }

        if (torchOnResId == null) {
            torchOnResId = 1234567;
        }

        return new MLGcrCaptureUIConfig.Factory()
                .setBackButtonResId(backButtonResId)
                .setTipText(tipText)
                .setScanBoxCornerColor(Color.parseColor(scanBoxCornerColor))
                .setPhotoButtonResId(photoButtonResId)
                .setTipTextColor(Color.parseColor(tipTextColor))
                .setTorchResId(torchOnResId, torchOffResId)
                .create();
    }
}
