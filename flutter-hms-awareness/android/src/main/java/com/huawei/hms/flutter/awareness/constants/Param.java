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

public interface Param {
    // Capture Client Parameters
    String COUNTRY_CODE = "countryCode";
    String FUTURE_TIMESTAMP = "futureTimestamp";
    String PACKAGE_NAME = "packageName";

    // Common Parameters
    String BARRIER_EVENT_TYPE = "barrierEventType";
    String BARRIER_TYPE = "barrierType";
    String BARRIER_LABEL = "barrierLabel";
    String BEACON_FILTER = "beaconFilters";
    String DEVICE_TYPE = "deviceType";
    String BARRIERS = "barriers";
    String TIME_ZONE = "timeZone";
    String AQI_VALUE = "aqiValue";
    String DATE_TIME_STAMP = "dateTimeStamp";
    String CN_WEATHER_ID = "cnWeatherId";
    String WEATHER_ID = "weatherId";
    String WIND_DIR = "windDir";
    String WIND_LEVEL = "windLevel";
    String WIND_SPEED = "windSpeed";
    String BEACON_ID = "beaconId";
    String BEACON_NAMESPACE = "beaconNamespace";
    String BEACON_TYPE = "beaconType";
    String BEACON_CONTENT = "beaconContent";
    String BLUETOOTH_STATUS = "bluetoothStatus";
    String HEADSET_STATUS = "headsetStatus";
    String LATITUDE = "latitude";
    String LONGITUDE = "longitude";
    String TIME = "time";
    String SCREEN_STATUS = "screenStatus";
    String CITY = "city";
    String BSSID = "bssid";
    String SSID = "ssid";
    String STATUS = "status";

    // AmbientLight Parameters
    String AMBIENT_LIGHT_BARRIER_RECEIVER_ACTION = "AMBIENT_LIGHT_BARRIER_RECEIVER_ACTION";
    String AMBIENT_LIGHT_ABOVE_BARRIER = "AMBIENT_LIGHT_ABOVE_BARRIER_LABEL";
    String AMBIENT_LIGHT_BELOW_BARRIER = "AMBIENT_LIGHT_BELOW_BARRIER_LABEL";
    String AMBIENT_LIGHT_RANGE_BARRIER = "AMBIENT_LIGHT_RANGE_BARRIER_LABEL";
    String MIN_LIGHT_INTENSITY = "minLightIntensity";
    String MAX_LIGHT_INTENSITY = "maxLightIntensity";

    // Barrier Parameters
    String BARRIER_STATUS = "barrierStatus";

    // Barrier Delete Request Parameters
    String DELETE_TYPE = "deleteType";
    String BARRIER_KEY = "barrierKey";
    String DELETE_ALL = "deleteAll";
    String WITH_LABEL = "withLabel";

    // Barrier Query Request Parameters
    String QUERY_TYPE_ALL = "queryTypeAll";
    String QUERY_TYPE_KEY = "queryTypeKey";
    String QUERY_TYPE = "queryType";
    String BARRIER_KEYS = "barrierKeys";

    // Barrier Status
    String LAST_BARRIER_UPDATE_TIME = "lastBarrierUpdateTime";
    String LAST_STATUS = "lastStatus";
    String PRESENT_STATUS = "presentStatus";

    // Beacon Barrier
    String BEACON_BARRIER_RECEIVER_ACTION = "BEACON_BARRIER_RECEIVER_ACTION";
    String BEACON_DISCOVER_BARRIER = "BEACON_DISCOVER_BARRIER_LABEL";
    String BEACON_MISSED_BARRIER = "BEACON_MISSED_BARRIER_LABEL";
    String BEACON_KEEP_BARRIER = "BEACON_KEEP_BARRIER_LABEL";

    // Behavior Barrier
    String BEHAVIOR_BARRIER_RECEIVER_ACTION = "BEHAVIOR_BARRIER_RECEIVER_ACTION";
    String BEHAVIOR_KEEPING_BARRIER = "BEHAVIOR_KEEPING_BARRIER_LABEL";
    String BEHAVIOR_BEGINNING_BARRIER = "BEHAVIOR_BEGINNING_BARRIER_LABEL";
    String BEHAVIOR_ENDING_BARRIER = "BEHAVIOR_ENDING_BARRIER_LABEL";
    String BEHAVIOR_TYPES = "behaviorTypes";

    // Bluetooth Barrier
    String BLUETOOTH_BARRIER_RECEIVER_ACTION = "BLUETOOTH_BARRIER_RECEIVER_ACTION";
    String BLUETOOTH_KEEP_BARRIER = "BLUETOOTH_KEEP_BARRIER_LABEL";
    String BLUETOOTH_CONNECTING_BARRIER = "BLUETOOTH_CONNECTING_BARRIER_LABEL";
    String BLUETOOTH_DISCONNECTING_BARRIER = "BLUETOOTH_DISCONNECTING_BARRIER_LABEL";

    // Combination Barrier
    String COMBINED_BARRIER_RECEIVER_ACTION = "COMBINED_BARRIER_RECEIVER_ACTION";
    String COMBINED_NOT = "COMBINED_NOT";
    String COMBINED_AND = "COMBINED_AND";
    String COMBINED_OR = "COMBINED_OR";
    String BARRIER = "barrier";

    // Headset Barrier
    String HEADSET_BARRIER_RECEIVER_ACTION = "HEADSET_BARRIER_RECEIVER_ACTION";
    String HEADSET_KEEPING_BARRIER = "HEADSET_KEEPING_BARRIER_LABEL";
    String HEADSET_CONNECTING_BARRIER = "HEADSET_CONNECTING_BARRIER_LABEL";
    String HEADSET_DISCONNECTING_BARRIER = "HEADSET_DISCONNECTING_BARRIER_LABEL";

    // Location Barrier
    String LOCATION_BARRIER_RECEIVER_ACTION = "LOCATION_BARRIER_RECEIVER_ACTION";
    String LOCATION_ENTER_BARRIER = "LOCATION_ENTER_BARRIER_LABEL";
    String LOCATION_STAY_BARRIER = "LOCATION_STAY_BARRIER_LABEL";
    String LOCATION_EXIT_BARRIER = "LOCATION_EXIT_BARRIER_LABEL";
    String RADIUS = "radius";
    String TIME_OF_DURATION = "timeOfDuration";

    // Screen Barrier
    String SCREEN_BARRIER_RECEIVER_ACTION = "SCREEN_BARRIER_RECEIVER_ACTION";
    String SCREEN_KEEPING_BARRIER = "SCREEN_KEEPING_BARRIER_LABEL";
    String SCREEN_ON_BARRIER = "SCREEN_ON_BARRIER_LABEL";
    String SCREEN_OFF_BARRIER = "SCREEN_OFF_BARRIER_LABEL";
    String SCREEN_UNLOCK_BARRIER = "SCREEN_UNLOCK_BARRIER_LABEL";

    // Time Barrier
    String TIME_BARRIER_RECEIVER_ACTION = "TIME_BARRIER_RECEIVER_ACTION";
    String TIME_IN_SUNRISE_OR_SUNSET_PERIOD_BARRIER = "TIME_IN_SUNRISE_OR_SUNSET_PERIOD_BARRIER_LABEL";
    String TIME_DURING_PERIOD_OF_DAY_BARRIER = "TIME_DURING_PERIOD_OF_DAY_BARRIER_LABEL";
    String TIME_DURING_TIME_PERIOD_BARRIER = "TIME_DURING_TIME_PERIOD_BARRIER_LABEL";
    String TIME_DURING_PERIOD_OF_WEEK_BARRIER = "TIME_DURING_PERIOD_OF_WEEK_BARRIER_LABEL";
    String TIME_IN_TIME_CATEGORY_BARRIER = "TIME_IN_TIME_CATEGORY_BARRIER_LABEL";
    String TIME_INSTANT = "timeInstant";
    String START_TIME_OFFSET = "startTimeOffset";
    String STOP_TIME_OFFSET = "stopTimeOffset";
    String START_TIME_OF_DAY = "startTimeOfDay";
    String STOP_TIME_OF_DAY = "stopTimeOfDay";
    String START_TIME_STAMP = "startTimeStamp";
    String STOP_TIME_STAMP = "stopTimeStamp";
    String DAY_OF_WEEK = "dayOfWeek";
    String START_TIME_OF_SPECIFIED_DAY = "startTimeOfSpecifiedDay";
    String STOP_TIME_OF_SPECIFIED_DAY = "stopTimeOfSpecifiedDay";
    String IN_TIME_CATEGORY = "inTimeCategory";

    // WiFi Barrier
    String WIFI_BARRIER_RECEIVER_ACTION = "WIFI_BARRIER_RECEIVER_ACTION";
    String WIFI_KEEPING_BARRIER = "WIFI_KEEPING_BARRIER_LABEL";
    String WIFI_CONNECTING_BARRIER = "WIFI_CONNECTING_BARRIER_LABEL";
    String WIFI_DISCONNECTING_BARRIER = "WIFI_DISCONNECTING_BARRIER_LABEL";
    String WIFI_ENABLING_BARRIER = "WIFI_ENABLING_BARRIER_LABEL";
    String WIFI_DISABLING_BARRIER = "WIFI_DISABLING_BARRIER_LABEL";
    String WIFI_STATUS = "wifiStatus";

    // Aqi Parameters
    String CO = "co";
    String NO2 = "no2";
    String O3 = "o3";
    String PM10 = "pm10";
    String PM25 = "pm25";
    String SO2 = "so2";

    // City Parameters
    String CITY_CODE = "cityCode";
    String NAME = "name";
    String PROVINCE_NAME = "provinceName";

    // Daily Live Info Parameters
    String LEVEL = "level";

    // Daily Weather Parameters
    String MAX_TEMP_C = "maxTempC";
    String MAX_TEMP_F = "maxTempF";
    String MIN_TEMP_C = "minTempC";
    String MIN_TEMP_F = "minTempF";
    String MOON_RISE = "moonRise";
    String MOON_SET = "moonSet";
    String MOON_PHASE = "moonPhase";
    String SITUATION_DAY = "situationDay";
    String SITUATION_NIGHT = "situationNight";
    String SUN_RISE = "sunRise";
    String SUN_SET = "sunSet";

    // Hourly Weather Parameters
    String IS_DAY_NIGHT = "isDayNight";
    String RAIN_PROBABILITY = "rainProbability";
    String TEMP_C = "tempC";
    String TEMP_F = "tempF";

    // Live Info Parameters
    String CODE = "code";
    String DAILY_LIVE_INFO = "dailyLiveInfo";

    // Situation Parameters
    String HUMIDITY = "humidity";
    String PRESSURE = "pressure";
    String REAL_FEEL_C = "realFeelC";
    String REAL_FEEL_F = "realFeelF";
    String TEMPERATURE_C = "temperatureC";
    String TEMPERATURE_F = "temperatureF";
    String UPDATE_TIME = "updateTime";
    String UV_INDEX = "uvIndex";

    // Weather Situation Parameters
    String SITUATION = "situation";

    // Application Response Parameters
    String APPLICATION_STATUS = "applicationStatus";

    // Beacon Response Parameters
    String BEACONS = "beacons";

    // Behavior Response Parameters
    String ELAPSED_REALTIME_MILLIS = "elapsedRealtimeMillis";
    String MOST_LIKELY_BEHAVIOR = "mostLikelyBehavior";
    String PROBABLE_BEHAVIOR = "probableBehavior";

    // Capability Response Parameters
    String DEVICE_SUPPORT_CAPABILITIES = "deviceSupportCapabilities";

    // Dark Mode Response Parameters
    String IS_DARK_MODE_ON = "isDarkModeOn";

    // Detected Behavior Parameters
    String CONFIDENCE = "confidence";
    String TYPE = "type";

    // Light Intensity Response Parameters
    String LIGHT_INTENSITY = "lightIntensity";

    // Location Response Parameters
    String ALTITUDE = "altitude";
    String SPEED = "speed";
    String BEARING = "bearing";
    String ACCURACY = "accuracy";
    String VERTICAL_ACCURACY_METERS = "verticalAccuracyMeters";
    String BEARING_ACCURACY_DEGREES = "bearingAccuracyDegrees";
    String SPEED_ACCURACY_METERS_PER_SECOND = "speedAccuracyMetersPerSecond";
    String FROM_MOCK_PROVIDER = "fromMockProvider";

    // Time Categories Parameters
    String TIME_CATEGORIES = "timeCategories";

    // Weather Position Parameters
    String LOCALE = "locale";
    String COUNTRY = "country";
    String PROVINCE = "province";
    String DISTRICT = "district";
    String COUNTY = "county";

    // Weather Response Parameters
    String DAILY_WEATHER = "dailyWeather";
    String HOURLY_WEATHER = "hourlyWeather";
    String LIVE_INFO = "liveInfo";
    String AQI = "aqi";
    String WEATHER_SITUATION = "weatherSituation";

    // Beacon Filter Parameters
    String MATCH_BY_NAME_TYPE = "matchByNameType";
    String MATCH_BY_BEACON_CONTENT = "matchByBeaconContent";
    String MATCH_BY_BEACON_ID = "matchByBeaconId";
    String FILTER_TYPE = "filterType";

    // Update Barrier Parameters
    String AUTO_REMOVE = "autoRemove";
    String REQUEST = "request";
}
