/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mllanguage.utils;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftSetting;
import com.huawei.hms.mlsdk.langdetect.cloud.MLRemoteLangDetectorSetting;
import com.huawei.hms.mlsdk.langdetect.local.MLLocalLangDetectorSetting;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadStrategy;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionConfig;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslateSetting;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslateSetting;
import com.huawei.hms.mlsdk.tts.MLTtsConfig;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;

public class RequestBuilder {
    public static MLLocalTranslateSetting createLocalTranslateSetting(@NonNull Map<String, Object> map) {
        String sourceLang = FromMap.toString("sourceLang", map.get("sourceLang"), true);
        String targetLang = FromMap.toString("targetLang", map.get("targetLang"), true);

        return new MLLocalTranslateSetting.Factory()
                .setSourceLangCode(sourceLang != null ? sourceLang : "zh")
                .setTargetLangCode(targetLang != null ? targetLang : "en")
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


    public static MLModelDownloadStrategy createModelDownloadStrategy(@NonNull Map<String, Object> map) {
        MLModelDownloadStrategy.Factory factory = new MLModelDownloadStrategy.Factory();

        Boolean wifiNeeded = FromMap.toBoolean("needWifi", map.get("needWifi"));
        Boolean chargingNeeded = FromMap.toBoolean("needCharging", map.get("needCharging"));
        Boolean idleNeeded = FromMap.toBoolean("needDeviceIdle", map.get("needDeviceIdle"));
        Integer region = FromMap.toInteger("region", map.get("region"));

        if (region == null) {
            region = 1002;
        }

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

    public static MLLocalLangDetectorSetting createLocalLangDetectorSetting(@NonNull MethodCall call) {
        Double threshold = call.argument("trustedThreshold");

        if (threshold == null) {
            threshold = 0.5;
        }

        return new MLLocalLangDetectorSetting.Factory().setTrustedThreshold(threshold.floatValue()).create();
    }

    public static MLRemoteLangDetectorSetting createRemoteLangDetectorSetting(@NonNull MethodCall call) {
        Double threshold = call.argument("trustedThreshold");

        if (threshold == null) {
            threshold = 0.5;
        }

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
        float s = 1.0f;
        float v = 1.0f;
        String language = FromMap.toString("language", call.argument("language"), true);
        String person = FromMap.toString("person", call.argument("person"), true);
        String synthesizeMode = FromMap.toString("synthesizeMode", call.argument("synthesizeMode"), true);
        Long speed = FromMap.toLong("speed", call.argument("speed"));
        Long volume = FromMap.toLong("volume", call.argument("volume"));

        if (speed != null) {
            s = speed;
        }

        if (volume != null) {
            v = volume;
        }

        return new MLTtsConfig()
                .setLanguage(language)
                .setPerson(person)
                .setSpeed(s)
                .setVolume(v)
                .setSynthesizeMode(synthesizeMode);
    }
}
