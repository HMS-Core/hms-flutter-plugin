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

package com.huawei.hms.flutter.location.utils;

import com.huawei.hms.location.ActivityConversionData;
import com.huawei.hms.location.ActivityConversionInfo;
import com.huawei.hms.location.ActivityConversionRequest;
import com.huawei.hms.location.ActivityConversionResponse;
import com.huawei.hms.location.ActivityIdentificationData;
import com.huawei.hms.location.ActivityIdentificationResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ActivityUtils {
    /**
     * Utility method
     *
     * @param list List of the ActivityConversionInfo
     * @return ActivityConversionRequest object
     */
    static ActivityConversionRequest fromActivityConversionInfoListToActivityConversionRequest(
        final List<Map<String, Object>> list) {
        final List<ActivityConversionInfo> activityConversionInfos = new ArrayList<>();

        for (final Map<String, Object> map : list) {
            activityConversionInfos.add(fromMapToActivityConversionInfo(map));
        }

        return new ActivityConversionRequest(activityConversionInfos);
    }

    /**
     * Utility method
     *
     * @param map HashMap representation of the ActivityConversionInfo object
     * @return ActivityConversionInfo object
     */
    static ActivityConversionInfo fromMapToActivityConversionInfo(final Map<String, Object> map) {
        return new ActivityConversionInfo(ValueGetter.getInt("activityType", map),
            ValueGetter.getInt("conversionType", map));
    }

    /**
     * Utility method
     *
     * @param data ActivityIdentificationData object
     * @return HashMap representation of ActivityIdentificationData object
     */
    static Map<String, Object> activityIdentificationDataToMap(final ActivityIdentificationData data) {
        final Map<String, Object> map = new HashMap<>();

        if (data == null) {
            return map;
        }

        map.put("identificationActivity", data.getIdentificationActivity());
        map.put("possibility", data.getPossibility());

        return map;
    }

    /**
     * Utility method
     *
     * @param response ActivityIdentificationResponse object
     * @return HashMap representation of ActivityIdentificationResponse object
     */
    static Map<String, Object> activityIdentificationResponseToMap(final ActivityIdentificationResponse response) {
        final Map<String, Object> map = new HashMap<>();

        if (response == null) {
            return map;
        }

        map.put("time", response.getTime());
        map.put("elapsedTimeFromReboot", response.getElapsedTimeFromReboot());

        final List<Map<String, Object>> activityIdentificationDatas = new ArrayList<>();
        for (final ActivityIdentificationData data : response.getActivityIdentificationDatas()) {
            activityIdentificationDatas.add(activityIdentificationDataToMap(data));
        }
        map.put("activityIdentificationDatas", activityIdentificationDatas);

        return map;
    }

    /**
     * Utility method
     *
     * @param data ActivityConversionData object
     * @return HashMap representation of the ActivityConversionData object
     */
    static Map<String, Object> activityConversionDataToMap(final ActivityConversionData data) {
        final Map<String, Object> map = new HashMap<>();

        if (data == null) {
            return map;
        }

        map.put("activityType", data.getActivityType());
        map.put("conversionType", data.getConversionType());
        map.put("elapsedTimeFromReboot", data.getElapsedTimeFromReboot());

        return map;
    }

    /**
     * Utility method
     *
     * @param response ActivityConversionResponse object
     * @return HashMap representation of the ActivityConversionResponse object
     */
    static Map<String, Object> activityConversionResponseToMap(final ActivityConversionResponse response) {
        final Map<String, Object> map = new HashMap<>();

        if (response == null) {
            return map;
        }

        final List<Map<String, Object>> activityConversionDatas = new ArrayList<>();

        for (final ActivityConversionData data : response.getActivityConversionDatas()) {
            activityConversionDatas.add(ActivityUtils.activityConversionDataToMap(data));
        }

        map.put("activityConversionDatas", activityConversionDatas);
        return map;
    }
}
