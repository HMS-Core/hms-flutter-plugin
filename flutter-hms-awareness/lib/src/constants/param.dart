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

part of huawei_awareness;

abstract class _Param {
  // Capture Client Parameters
  static const String countryCode = 'countryCode';
  static const String futureTimestamp = 'futureTimestamp';
  static const String packageName = 'packageName';

  // Common Parameters
  static const String barrierEventType = 'barrierEventType';
  static const String barrierType = 'barrierType';
  static const String barrierLabel = 'barrierLabel';
  static const String beaconFilters = 'beaconFilters';
  static const String deviceType = 'deviceType';
  static const String barriers = 'barriers';
  static const String timeZone = 'timeZone';
  static const String aqiValue = 'aqiValue';
  static const String dateTimeStamp = 'dateTimeStamp';
  static const String cnWeatherId = 'cnWeatherId';
  static const String weatherId = 'weatherId';
  static const String windDir = 'windDir';
  static const String windLevel = 'windLevel';
  static const String windSpeed = 'windSpeed';
  static const String beaconId = 'beaconId';
  static const String beaconNamespace = 'beaconNamespace';
  static const String beaconType = 'beaconType';
  static const String beaconContent = 'beaconContent';
  static const String bluetoothStatus = 'bluetoothStatus';
  static const String headsetStatus = 'headsetStatus';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String time = 'time';
  static const String screenStatus = 'screenStatus';
  static const String city = 'city';
  static const String bssid = 'bssid';
  static const String ssid = 'ssid';
  static const String status = 'status';

  // AmbientLight Parameters
  static const String ambientLightBarrierReceiverAction =
      'AMBIENT_LIGHT_BARRIER_RECEIVER_ACTION';
  static const String ambientLightAboveBarrier =
      'AMBIENT_LIGHT_ABOVE_BARRIER_LABEL';
  static const String ambientLightBelowBarrier =
      'AMBIENT_LIGHT_BELOW_BARRIER_LABEL';
  static const String ambientLightRangeBarrier =
      'AMBIENT_LIGHT_RANGE_BARRIER_LABEL';
  static const String minLightIntensity = 'minLightIntensity';
  static const String maxLightIntensity = 'maxLightIntensity';

  // Barrier Parameters
  static const String barrierStatus = 'barrierStatus';

  // Barrier Delete Request Parameters
  static const String deleteType = 'deleteType';
  static const String barrierKey = 'barrierKey';
  static const String deleteAll = 'deleteAll';
  static const String withLabel = 'withLabel';

  // Barrier Query Request Parameters
  static const String queryTypeAll = 'queryTypeAll';
  static const String queryTypeKey = 'queryTypeKey';
  static const String queryType = 'queryType';
  static const String barrierKeys = 'barrierKeys';

  // Barrier Status
  static const String lastBarrierUpdateTime = 'lastBarrierUpdateTime';
  static const String lastStatus = 'lastStatus';
  static const String presentStatus = 'presentStatus';

  // Beacon Barrier
  static const String beaconBarrierReceiverAction =
      'BEACON_BARRIER_RECEIVER_ACTION';
  static const String beaconDiscoverBarrier = 'BEACON_DISCOVER_BARRIER_LABEL';
  static const String beaconMissedBarrier = 'BEACON_MISSED_BARRIER_LABEL';
  static const String beaconKeepBarrier = 'BEACON_KEEP_BARRIER_LABEL';

  // Behavior Barrier
  static const String behaviorBarrierReceiverAction =
      'BEHAVIOR_BARRIER_RECEIVER_ACTION';
  static const String behaviorKeepingBarrier = 'BEHAVIOR_KEEPING_BARRIER_LABEL';
  static const String behaviorBeginningBarrier =
      'BEHAVIOR_BEGINNING_BARRIER_LABEL';
  static const String behaviorEndingBarrier = 'BEHAVIOR_ENDING_BARRIER_LABEL';
  static const String behaviorTypes = 'behaviorTypes';

  // Bluetooth Barrier
  static const String bluetoothBarrierReceiverAction =
      'BLUETOOTH_BARRIER_RECEIVER_ACTION';
  static const String bluetoothKeepBarrier = 'BLUETOOTH_KEEP_BARRIER_LABEL';
  static const String bluetoothConnectingBarrier =
      'BLUETOOTH_CONNECTING_BARRIER_LABEL';
  static const String bluetoothDisconnectingBarrier =
      'BLUETOOTH_DISCONNECTING_BARRIER_LABEL';

  // Combination Barrier
  static const String combinedBarrierReceiverAction =
      'COMBINED_BARRIER_RECEIVER_ACTION';
  static const String combinedNot = 'COMBINED_NOT';
  static const String combinedAnd = 'COMBINED_AND';
  static const String combinedOr = 'COMBINED_OR';
  static const String barrier = 'barrier';

  // Headset Barrier
  static const String headsetBarrierReceiverAction =
      'HEADSET_BARRIER_RECEIVER_ACTION';
  static const String headsetKeepingBarrier = 'HEADSET_KEEPING_BARRIER_LABEL';
  static const String headsetConnectingBarrier =
      'HEADSET_CONNECTING_BARRIER_LABEL';
  static const String headsetDisconnectingBarrier =
      'HEADSET_DISCONNECTING_BARRIER_LABEL';

  // Location Barrier
  static const String locationBarrierReceiverAction =
      'LOCATION_BARRIER_RECEIVER_ACTION';
  static const String locationEnterBarrier = 'LOCATION_ENTER_BARRIER_LABEL';
  static const String locationStayBarrier = 'LOCATION_STAY_BARRIER_LABEL';
  static const String locationExitBarrier = 'LOCATION_EXIT_BARRIER_LABEL';
  static const String radius = 'radius';
  static const String timeOfDuration = 'timeOfDuration';

  // Screen Barrier
  static const String screenBarrierReceiverAction =
      'SCREEN_BARRIER_RECEIVER_ACTION';
  static const String screenKeepingBarrier = 'SCREEN_KEEPING_BARRIER_LABEL';
  static const String screenOnBarrier = 'SCREEN_ON_BARRIER_LABEL';
  static const String screenOffBarrier = 'SCREEN_OFF_BARRIER_LABEL';
  static const String screenUnlockBarrier = 'SCREEN_UNLOCK_BARRIER_LABEL';

  // Time Barrier
  static const String timeBarrierReceiverAction =
      'TIME_BARRIER_RECEIVER_ACTION';
  static const String timeInSunriseOrSunsetPeriodBarrier =
      'TIME_IN_SUNRISE_OR_SUNSET_PERIOD_BARRIER_LABEL';
  static const String timeDuringPeriodOfDayBarrier =
      'TIME_DURING_PERIOD_OF_DAY_BARRIER_LABEL';
  static const String timeDuringTimePeriodBarrier =
      'TIME_DURING_TIME_PERIOD_BARRIER_LABEL';
  static const String timeDuringPeriodOfWeekBarrier =
      'TIME_DURING_PERIOD_OF_WEEK_BARRIER_LABEL';
  static const String timeInTimeCategoryBarrier =
      'TIME_IN_TIME_CATEGORY_BARRIER_LABEL';
  static const String timeInstant = 'timeInstant';
  static const String startTimeOffset = 'startTimeOffset';
  static const String stopTimeOffset = 'stopTimeOffset';
  static const String startTimeOfDay = 'startTimeOfDay';
  static const String stopTimeOfDay = 'stopTimeOfDay';
  static const String startTimeStamp = 'startTimeStamp';
  static const String stopTimeStamp = 'stopTimeStamp';
  static const String dayOfWeek = 'dayOfWeek';
  static const String startTimeOfSpecifiedDay = 'startTimeOfSpecifiedDay';
  static const String stopTimeOfSpecifiedDay = 'stopTimeOfSpecifiedDay';
  static const String inTimeCategory = 'inTimeCategory';

  // WiFi Barrier
  static const String wifiBarrierReceiverAction =
      'WIFI_BARRIER_RECEIVER_ACTION';
  static const String wifiKeepingBarrier = 'WIFI_KEEPING_BARRIER_LABEL';
  static const String wifiConnectingBarrier = 'WIFI_CONNECTING_BARRIER_LABEL';
  static const String wifiDisconnectingBarrier =
      'WIFI_DISCONNECTING_BARRIER_LABEL';
  static const String wifiEnablingBarrier = 'WIFI_ENABLING_BARRIER_LABEL';
  static const String wifiDisabling = 'WIFI_DISABLING_BARRIER_LABEL';
  static const String wifiStatus = 'wifiStatus';

  // Aqi Parameters
  static const String co = 'co';
  static const String no2 = 'no2';
  static const String o3 = 'o3';
  static const String pm10 = 'pm10';
  static const String pm25 = 'pm25';
  static const String so2 = 'so2';

  // City Parameters
  static const String cityCode = 'cityCode';
  static const String name = 'name';
  static const String provinceName = 'provinceName';

  // Daily Live Info Parameters
  static const String level = 'level';

  // Daily Weather Parameters
  static const String maxTempC = 'maxTempC';
  static const String maxTempF = 'maxTempF';
  static const String minTempC = 'minTempC';
  static const String minTempF = 'minTempF';
  static const String moonRise = 'moonRise';
  static const String moonSet = 'moonSet';
  static const String moonPhase = 'moonPhase';
  static const String situationDay = 'situationDay';
  static const String situationNight = 'situationNight';
  static const String sunRise = 'sunRise';
  static const String sunSet = 'sunSet';

  // Hourly Weather Parameters
  static const String isDayNight = 'isDayNight';
  static const String rainProbability = 'rainProbability';
  static const String tempC = 'tempC';
  static const String tempF = 'tempF';

  // Live Info Parameters
  static const String code = 'code';
  static const String dailyLiveInfo = 'dailyLiveInfo';

  // Situation Parameters
  static const String humidity = 'humidity';
  static const String pressure = 'pressure';
  static const String realFeelC = 'realFeelC';
  static const String realFeelF = 'realFeelF';
  static const String temperatureC = 'temperatureC';
  static const String temperatureF = 'temperatureF';
  static const String updateTime = 'updateTime';
  static const String uvIndex = 'uvIndex';

  // Weather Situation Parameters
  static const String situation = 'situation';

  // Application Response Parameters
  static const String applicationStatus = 'applicationStatus';

  // Beacon Response Parameters
  static const String beacons = 'beacons';

  // Behavior Response Parameters
  static const String elapsedRealtimeMillis = 'elapsedRealtimeMillis';
  static const String mostLikelyBehavior = 'mostLikelyBehavior';
  static const String probableBehavior = 'probableBehavior';

  // Capability Response Parameters
  static const String deviceSupportCapabilities = 'deviceSupportCapabilities';

  // Dark Mode Response Parameters
  static const String isDarkModeOn = 'isDarkModeOn';

  // Detected Behavior Parameters
  static const String confidence = 'confidence';
  static const String type = 'type';

  // Light Intensity Response Parameters
  static const String lightIntensity = 'lightIntensity';

  // Location Response Parameters
  static const String altitude = 'altitude';
  static const String speed = 'speed';
  static const String bearing = 'bearing';
  static const String accuracy = 'accuracy';
  static const String verticalAccuracyMeters = 'verticalAccuracyMeters';
  static const String bearingAccuracyDegrees = 'bearingAccuracyDegrees';
  static const String speedAccuracyMetersPerSecond =
      'speedAccuracyMetersPerSecond';
  static const String fromMockProvider = 'fromMockProvider';

  // Time Categories Parameters
  static const String timeCategories = 'timeCategories';

  // Weather Position Parameters
  static const String locale = 'locale';
  static const String country = 'country';
  static const String province = 'province';
  static const String district = 'district';
  static const String county = 'county';

  // Weather Response Parameters
  static const String dailyWeather = 'dailyWeather';
  static const String hourlyWeather = 'hourlyWeather';
  static const String liveInfo = 'liveInfo';
  static const String aqi = 'aqi';
  static const String weatherSituation = 'weatherSituation';

  // Beacon Filter Parameters
  static const String matchByNameType = 'matchByNameType';
  static const String matchByBeaconContent = 'matchByBeaconContent';
  static const String matchByBeaconId = 'matchByBeaconId';
  static const String filterType = 'filterType';

  // Update Barrier Parameters
  static const String autoRemove = 'autoRemove';
  static const String request = 'request';
}
