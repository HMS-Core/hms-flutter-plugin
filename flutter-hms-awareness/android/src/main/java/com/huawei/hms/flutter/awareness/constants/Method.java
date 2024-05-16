/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.awareness.constants;

public interface Method {
    // Common Client Methods
    String ENABLE_UPDATE_WINDOW = "enableUpdateWindow";

    // Awareness Capture Client Methods
    String GET_BEACON_STATUS = "getBeaconStatus";
    String GET_BEHAVIOR = "getBehavior";
    String GET_HEADSET_STATUS = "getHeadsetStatus";
    String GET_LOCATION = "getLocation";
    String GET_CURRENT_LOCATION = "getCurrentLocation";
    String GET_TIME_CATEGORIES = "getTimeCategories";
    String GET_TIME_CATEGORIES_BY_USER = "getTimeCategoriesByUser";
    String GET_TIME_CATEGORIES_BY_COUNTRY_CODE = "getTimeCategoriesByCountryCode";
    String GET_TIME_CATEGORIES_BY_IP = "getTimeCategoriesByIP";
    String GET_TIME_CATEGORIES_FOR_FUTURE = "getTimeCategoriesForFuture";
    String GET_LIGHT_INTENSITY = "getLightIntensity";
    String GET_WEATHER_BY_DEVICE = "getWeatherByDevice";
    String GET_WEATHER_BY_POSITION = "getWeatherByPosition";
    String GET_BLUETOOTH_STATUS = "getBluetoothStatus";
    String QUERY_SUPPORTING_CAPABILITIES = "querySupportingCapabilities";
    String GET_SCREEN_STATUS = "getScreenStatus";
    String GET_WIFI_STATUS = "getWifiStatus";
    String GET_APPLICATION_STATUS = "getApplicationStatus";
    String GET_DARK_MODE_STATUS = "getDarkModeStatus";

    // Awareness Barrier Client Methods
    String QUERY_BARRIERS = "queryBarriers";
    String DELETE_BARRIER = "deleteBarrier";
    String UPDATE_BARRIER = "updateBarriers";

    // Awareness Utils Client Methods
    String ENABLE_LOGGER = "enableLogger";
    String DISABLE_LOGGER = "disableLogger";
}
