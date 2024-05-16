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

package com.huawei.hms.flutter.ads.adslite.nativead;

import com.huawei.hms.ads.AdSize;
import com.huawei.hms.ads.VideoConfiguration;
import com.huawei.hms.ads.nativead.NativeAdConfiguration;
import com.huawei.hms.flutter.ads.factory.VideoConfigurationFactory;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;

import java.util.Map;

class NativeAdConfigurationFactory {
    private final Map<String, Object> configurationArgs;

    NativeAdConfigurationFactory(Map<String, Object> configurationArgs) {
        this.configurationArgs = configurationArgs;
    }

    NativeAdConfiguration createNativeAdConfiguration() {
        NativeAdConfiguration.Builder builder = new NativeAdConfiguration.Builder();
        if (configurationArgs == null) {
            return builder.build();
        }

        Map<String, Object> adSizeMap = ToMap.fromObject(configurationArgs.get("adSize"));
        if (!adSizeMap.isEmpty()) {
            Integer width = FromMap.toInteger("width", adSizeMap.get("width"));
            Integer height = FromMap.toInteger("height", adSizeMap.get("height"));
            if (height != null && width != null) {
                builder.setAdSize(new AdSize(width, height));
            }
        }

        Integer choicesPosition = FromMap.toInteger("choicesPosition", configurationArgs.get("choicesPosition"));
        if (choicesPosition != null) {
            builder.setChoicesPosition(choicesPosition);
        }

        Integer direction = FromMap.toInteger("direction", configurationArgs.get("direction"));
        if (direction != null) {
            builder.setMediaDirection(direction);
        }

        Integer aspect = FromMap.toInteger("aspect", configurationArgs.get("aspect"));
        if (aspect != null) {
            builder.setMediaAspect(aspect);
        }

        Boolean requestCustomDislike = FromMap.toBoolean("requestCustomDislike", configurationArgs.get("requestCustomDislike"));
        if (configurationArgs.get("requestCustomDislike") != null) {
            builder.setRequestCustomDislikeThisAd(requestCustomDislike);
        }

        Boolean requestMultiImage = FromMap.toBoolean("requestMultiImage", configurationArgs.get("requestMultiImage"));
        if (configurationArgs.get("requestMultiImage") != null) {
            builder.setRequestMultiImages(requestMultiImage);
        }

        Boolean returnUrlsForImages = FromMap.toBoolean("returnUrlsForImages", configurationArgs.get("returnUrlsForImages"));
        if (configurationArgs.get("returnUrlsForImages") != null) {
            builder.setReturnUrlsForImages(returnUrlsForImages);
        }

        Map<String, Object> videoConfigurationMap = ToMap.fromObject(configurationArgs.get("videoConfiguration"));
        if (!videoConfigurationMap.isEmpty()) {
            VideoConfigurationFactory videoConFactory = new VideoConfigurationFactory(videoConfigurationMap);
            VideoConfiguration videoConfiguration = videoConFactory.createVideoConfiguration();
            builder.setVideoConfiguration(videoConfiguration);
        }

        return builder.build();
    }
}
