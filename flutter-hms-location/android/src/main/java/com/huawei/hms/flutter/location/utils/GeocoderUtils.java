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

import com.huawei.hms.location.GetFromLocationNameRequest;
import com.huawei.hms.location.GetFromLocationRequest;

import java.util.Locale;
import java.util.Map;

public interface GeocoderUtils {
    /**
     * Utility method
     *
     * @param map HashMap representation of the Locale object
     * @return Locale object
     */
    static Locale fromMapToLocale(final Map<String, Object> map) {
        final String language = ValueGetter.getString("language", map);
        final String country = ValueGetter.getString("country", map);
        return new Locale(language, country);
    }

    /**
     * Utility method
     *
     * @param map HashMap representation of the GetFromLocationRequest object
     * @return GetFromLocationRequest object
     */
    static GetFromLocationRequest fromMapToGetFromLocationRequest(final Map<String, Object> map) {

        double latitude = ValueGetter.getDouble("latitude", map);
        double longitude = ValueGetter.getDouble("longitude", map);
        int maxResults = ValueGetter.getInt("maxResults", map);
        return new GetFromLocationRequest(latitude, longitude, maxResults);

    }

    /**
     * Utility method
     *
     * @param map HashMap representation of the GetFromLocationNameRequest object
     * @return GetFromLocationNameRequest object
     */
    static GetFromLocationNameRequest fromMapToGetFromLocationNameRequest(final Map<String, Object> map) {

        String locationName = ValueGetter.getString("locationName", map);
        int maxResults = ValueGetter.getInt("maxResults", map);
        double lowerLeftLatitude = ValueGetter.getDouble("lowerLeftLatitude", map);
        double lowerLeftLongitude = ValueGetter.getDouble("lowerLeftLongitude", map);
        double upperRightLatitude = ValueGetter.getDouble("upperRightLatitude", map);
        double upperRightLongitude = ValueGetter.getDouble("upperRightLongitude", map);
        return new GetFromLocationNameRequest(locationName, maxResults, lowerLeftLatitude, lowerLeftLongitude,
            upperRightLatitude, upperRightLongitude);

    }
}
