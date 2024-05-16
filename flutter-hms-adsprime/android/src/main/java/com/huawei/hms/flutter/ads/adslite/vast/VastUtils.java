/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.ads.adslite.vast;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.vast.adapter.VastSdkConfiguration;
import com.huawei.hms.ads.vast.application.requestinfo.CreativeMatchStrategy;
import com.huawei.hms.ads.vast.openalliance.ad.beans.parameter.RequestOptions;
import com.huawei.hms.ads.vast.player.api.PlayerConfig;
import com.huawei.hms.ads.vast.player.model.adslot.LinearAdSlot;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public abstract class VastUtils {
    public static @NonNull Map<String, Object> vastSdkConfigurationToMap(@NonNull VastSdkConfiguration configuration) {
        final Map<String, Object> map = new HashMap<>();
        map.put("httpCallTimeoutMs", configuration.getHttpCallTimeoutMs());
        map.put("httpConnectTimeoutMs", configuration.getHttpConnectTimeoutMs());
        map.put("httpKeepAliveDurationMs", configuration.getHttpKeepAliveDurationMs());
        map.put("httpReadTimeoutMs", configuration.getHttpReadTimeoutMs());
        map.put("maxHttpConnections", configuration.getMaxHttpConnections());
        map.put("maxRedirectWrapperLimit", configuration.getMaxRedirectWrapperLimit());
        map.put("isTest", configuration.isTest());
        map.put("vastEventRetryBatchSize", configuration.getVastEventRetryBatchSize());
        map.put("vastEventRetryIntervalSeconds", configuration.getVastEventRetryIntervalSeconds());
        map.put("vastEventRetryUploadTimes", configuration.getVastEventRetryUploadTimes());
        return map;
    }

    public static @NonNull VastSdkConfiguration vastSdkConfigurationFromMap(@NonNull Map<String, Object> map) {
        final VastSdkConfiguration configuration = new VastSdkConfiguration("hms");
        configuration.setHttpCallTimeoutMs((Integer) Objects.requireNonNull(map.get("httpCallTimeoutMs")));
        configuration.setHttpConnectTimeoutMs((Integer) Objects.requireNonNull(map.get("httpConnectTimeoutMs")));
        configuration.setHttpKeepAliveDurationMs((Integer) Objects.requireNonNull(map.get("httpKeepAliveDurationMs")));
        configuration.setHttpReadTimeoutMs((Integer) Objects.requireNonNull(map.get("httpReadTimeoutMs")));
        configuration.setMaxHttpConnections((Integer) Objects.requireNonNull(map.get("maxHttpConnections")));
        configuration.setMaxRedirectWrapperLimit((Integer) Objects.requireNonNull(map.get("maxRedirectWrapperLimit")));
        configuration.setTest((Boolean) Objects.requireNonNull(map.get("isTest")));
        configuration.setVastEventRetryBatchSize((Integer) Objects.requireNonNull(map.get("vastEventRetryBatchSize")));
        configuration.setVastEventRetryIntervalSeconds((Integer) Objects.requireNonNull(map.get("vastEventRetryIntervalSeconds")));
        configuration.setVastEventRetryUploadTimes((Integer) Objects.requireNonNull(map.get("vastEventRetryUploadTimes")));
        return configuration;
    }

    public static @NonNull Map<String, Object> playerConfigToMap(@NonNull PlayerConfig playerConfig) {
        final Map<String, Object> map = new HashMap<>();
        map.put("isEnableCutout", playerConfig.isEnableCutout());
        map.put("isEnablePortrait", playerConfig.isEnablePortrait());
        map.put("isEnableRotation", playerConfig.isEnableRotation());
        map.put("isForceMute", playerConfig.isForceMute());
        map.put("isIndustryIconShow", playerConfig.isIndustryIconShow());
        map.put("isSkipLinearAd", playerConfig.isSkipLinearAd());
        return map;
    }

    public static @NonNull PlayerConfig playerConfigFromMap(@NonNull Map<String, Object> map) {
        final PlayerConfig.Builder builder = PlayerConfig.newBuilder();
        builder.setIsEnableCutout((Boolean) Objects.requireNonNull(map.get("isEnableCutout")));
        builder.setIsEnablePortrait((Boolean) Objects.requireNonNull(map.get("isEnablePortrait")));
        builder.setEnableRotation((Boolean) Objects.requireNonNull(map.get("isEnableRotation")));
        builder.setForceMute((Boolean) Objects.requireNonNull(map.get("isForceMute")));
        builder.setAdPrivacyCompliance((Boolean) Objects.requireNonNull(map.get("isIndustryIconShow")));
        builder.setSkipLinearAd((Boolean) Objects.requireNonNull(map.get("isSkipLinearAd")));
        return builder.build();
    }

    public static @NonNull LinearAdSlot linearAdSlotFromMap(@NonNull Map<String, Object> map) {
        final LinearAdSlot linearAdSlot = new LinearAdSlot();
        linearAdSlot.setSlotId((String) Objects.requireNonNull(map.get("slotId")));
        linearAdSlot.setTotalDuration((int) Objects.requireNonNull(map.get("totalDuration")));
        if (map.get("width") != null && map.get("height") != null) {
            linearAdSlot.setSize((int) Objects.requireNonNull(map.get("width")), (int) Objects.requireNonNull(map.get("height")));
        }
        linearAdSlot.setRequestOptions(requestOptionsFromMap((Map<String, Object>) Objects.requireNonNull(map.get("requestOptions"))));
        linearAdSlot.setOrientation((int) Objects.requireNonNull(map.get("orientation")));
        if (map.get("maxAdPods") != null) {
            linearAdSlot.setMaxAdPods((int) Objects.requireNonNull(map.get("maxAdPods")));
        }
        if (map.get("creativeMatchStrategy") != null) {
            final String name = (String) Objects.requireNonNull(map.get("creativeMatchStrategy"));
            final CreativeMatchStrategy.CreativeMatchType type = CreativeMatchStrategy.CreativeMatchType.valueOf(name);
            final CreativeMatchStrategy strategy = new CreativeMatchStrategy(type);
            linearAdSlot.setCreativeMatchStrategy(strategy);
        }
        linearAdSlot.setAllowMobileTraffic((Boolean) Objects.requireNonNull(map.get("allowMobileTraffic")));
        return linearAdSlot;
    }

    private static @NonNull RequestOptions requestOptionsFromMap(@NonNull Map<String, Object> map) {
        final RequestOptions.Builder builder = new RequestOptions.Builder();
        if (map.get("adContentClassification") != null) {
            builder.setAdContentClassification((String) Objects.requireNonNull(map.get("adContentClassification")));
        }
        if (map.get("tagForUnderAgeOfPromise") != null) {
            builder.setTagForUnderAgeOfPromise((Integer) Objects.requireNonNull(map.get("tagForUnderAgeOfPromise")));
        }
        if (map.get("tagForChildProtection") != null) {
            builder.setTagForChildProtection((Integer) Objects.requireNonNull(map.get("tagForChildProtection")));
        }
        if (map.get("isPersonalizedAd") != null) {
            builder.setNonPersonalizedAd((Integer) Objects.requireNonNull(map.get("isPersonalizedAd")));
        }
        if (map.get("appCountry") != null) {
            builder.setAppCountry((String) Objects.requireNonNull(map.get("appCountry")));
        }
        if (map.get("appLang") != null) {
            builder.setAppLang((String) Objects.requireNonNull(map.get("appLang")));
        }
        if (map.get("consent") != null) {
            builder.setConsent((String) Objects.requireNonNull(map.get("consent")));
        }
        if (map.get("requestLocation") != null) {
            builder.setRequestLocation((Boolean) Objects.requireNonNull(map.get("requestLocation")));
        }
        if (map.get("searchTerm") != null) {
            builder.setSearchTerm((String) Objects.requireNonNull(map.get("searchTerm")));
        }
        return builder.build();
    }
}
