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

package com.huawei.hms.flutter.ads.factory;

import com.huawei.hms.ads.VideoConfiguration;
import com.huawei.hms.flutter.ads.utils.FromMap;

import java.util.Map;

public class VideoConfigurationFactory {
    private final Map<String, Object> videoConfigurationMap;

    public VideoConfigurationFactory(Map<String, Object> videoConfigurationMap) {
        this.videoConfigurationMap = videoConfigurationMap;
    }

    public VideoConfiguration createVideoConfiguration() {
        VideoConfiguration.Builder builder = new VideoConfiguration.Builder();

        Integer audioFocusType = FromMap.toInteger("audioFocusType", videoConfigurationMap.get("audioFocusType"));
        if (audioFocusType != null) {
            builder.setAudioFocusType(audioFocusType);
        }

        Boolean customizeOperationRequested = FromMap.toBoolean("customizeOperationRequested",
            videoConfigurationMap.get("customizeOperationRequested"));
        if (videoConfigurationMap.get("customizeOperationRequested") != null) {
            builder.setCustomizeOperateRequested(customizeOperationRequested);
        }

        Boolean startMuted = FromMap.toBoolean("startMuted", videoConfigurationMap.get("startMuted"));
        if (videoConfigurationMap.get("startMuted") != null) {
            builder.setStartMuted(startMuted);
        }

        Integer autoPlayNetwork = FromMap.toInteger("autoPlayNetwork", videoConfigurationMap.get("autoPlayNetwork"));
        if (autoPlayNetwork != null) {
            builder.setAutoPlayNetwork(autoPlayNetwork);
        }

        return builder.build();
    }
}
