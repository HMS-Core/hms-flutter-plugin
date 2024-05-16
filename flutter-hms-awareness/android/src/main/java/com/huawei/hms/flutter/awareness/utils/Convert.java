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

package com.huawei.hms.flutter.awareness.utils;

import android.location.Location;
import android.os.Build;
import android.util.Log;

import com.huawei.hms.flutter.awareness.constants.Param;
import com.huawei.hms.kit.awareness.barrier.BarrierQueryResponse;
import com.huawei.hms.kit.awareness.barrier.BarrierStatus;
import com.huawei.hms.kit.awareness.barrier.BarrierStatusMap;
import com.huawei.hms.kit.awareness.capture.AmbientLightResponse;
import com.huawei.hms.kit.awareness.capture.ApplicationStatusResponse;
import com.huawei.hms.kit.awareness.capture.BeaconStatusResponse;
import com.huawei.hms.kit.awareness.capture.BluetoothStatusResponse;
import com.huawei.hms.kit.awareness.capture.CapabilityResponse;
import com.huawei.hms.kit.awareness.capture.DarkModeStatusResponse;
import com.huawei.hms.kit.awareness.capture.HeadsetStatusResponse;
import com.huawei.hms.kit.awareness.capture.LocationResponse;
import com.huawei.hms.kit.awareness.capture.ScreenStatusResponse;
import com.huawei.hms.kit.awareness.capture.TimeCategoriesResponse;
import com.huawei.hms.kit.awareness.capture.WeatherStatusResponse;
import com.huawei.hms.kit.awareness.capture.WifiStatusResponse;
import com.huawei.hms.kit.awareness.status.AmbientLightStatus;
import com.huawei.hms.kit.awareness.status.ApplicationStatus;
import com.huawei.hms.kit.awareness.status.BeaconStatus;
import com.huawei.hms.kit.awareness.status.BeaconStatus.BeaconData;
import com.huawei.hms.kit.awareness.status.BeaconStatus.Filter;
import com.huawei.hms.kit.awareness.status.BehaviorStatus;
import com.huawei.hms.kit.awareness.status.BluetoothStatus;
import com.huawei.hms.kit.awareness.status.CapabilityStatus;
import com.huawei.hms.kit.awareness.status.DarkModeStatus;
import com.huawei.hms.kit.awareness.status.DetectedBehavior;
import com.huawei.hms.kit.awareness.status.HeadsetStatus;
import com.huawei.hms.kit.awareness.status.ScreenStatus;
import com.huawei.hms.kit.awareness.status.TimeCategories;
import com.huawei.hms.kit.awareness.status.WeatherStatus;
import com.huawei.hms.kit.awareness.status.WifiStatus;
import com.huawei.hms.kit.awareness.status.weather.Aqi;
import com.huawei.hms.kit.awareness.status.weather.City;
import com.huawei.hms.kit.awareness.status.weather.DailyLiveInfo;
import com.huawei.hms.kit.awareness.status.weather.DailySituation;
import com.huawei.hms.kit.awareness.status.weather.DailyWeather;
import com.huawei.hms.kit.awareness.status.weather.HourlyWeather;
import com.huawei.hms.kit.awareness.status.weather.LiveInfo;
import com.huawei.hms.kit.awareness.status.weather.Situation;
import com.huawei.hms.kit.awareness.status.weather.WeatherSituation;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

public class Convert {
    public static JSONObject locationToJson(final LocationResponse locationResponse) {
        final JSONObject map = new JSONObject();
        final Location location = locationResponse.getLocation();
        try {
            map.put(Param.LATITUDE, location.getLatitude());
            map.put(Param.LONGITUDE, location.getLongitude());
            map.put(Param.ALTITUDE, location.getAltitude());
            map.put(Param.SPEED, location.getSpeed());
            map.put(Param.BEARING, location.getBearing());
            map.put(Param.ACCURACY, location.getAccuracy());
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                map.put(Param.VERTICAL_ACCURACY_METERS, location.getVerticalAccuracyMeters());
                map.put(Param.BEARING_ACCURACY_DEGREES, location.getBearingAccuracyDegrees());
                map.put(Param.SPEED_ACCURACY_METERS_PER_SECOND, location.getSpeedAccuracyMetersPerSecond());
            } else {
                map.put(Param.VERTICAL_ACCURACY_METERS, 0.0);
                map.put(Param.BEARING_ACCURACY_DEGREES, 0.0);
                map.put(Param.SPEED_ACCURACY_METERS_PER_SECOND, 0.0);
            }
            map.put(Param.TIME, location.getTime());
            map.put(Param.FROM_MOCK_PROVIDER, location.isFromMockProvider());
        } catch (final JSONException e) {
            Log.e("locationToJson", e.toString());
        }
        return map;
    }

    public static JSONObject statusToJson(final Object statusResponse) {
        final JSONObject map = new JSONObject();
        try {
            if (statusResponse instanceof HeadsetStatusResponse) {
                final HeadsetStatus headsetStatus = ((HeadsetStatusResponse) statusResponse).getHeadsetStatus();
                map.put(Param.HEADSET_STATUS, headsetStatus.getStatus());
            } else if (statusResponse instanceof TimeCategoriesResponse) {
                final TimeCategories timeCategories = ((TimeCategoriesResponse) statusResponse).getTimeCategories();
                final JSONArray timeCategoriesJSON = new JSONArray();
                for (final int timeCode : timeCategories.getTimeCategories()) {
                    timeCategoriesJSON.put(timeCode);
                }
                map.put(Param.TIME_CATEGORIES, timeCategoriesJSON);
            } else if (statusResponse instanceof AmbientLightResponse) {
                final AmbientLightStatus ambientLightStatus
                    = ((AmbientLightResponse) statusResponse).getAmbientLightStatus();
                map.put(Param.LIGHT_INTENSITY, ambientLightStatus.getLightIntensity());
            } else if (statusResponse instanceof BluetoothStatusResponse) {
                final BluetoothStatus bluetoothStatus = ((BluetoothStatusResponse) statusResponse).getBluetoothStatus();
                map.put(Param.BLUETOOTH_STATUS, bluetoothStatus.getStatus());
            } else if (statusResponse instanceof CapabilityResponse) {
                final CapabilityStatus capabilityStatus = ((CapabilityResponse) statusResponse).getCapabilityStatus();
                final JSONArray deviceSupportCapabilitiesJSON = new JSONArray();
                for (final int capability : capabilityStatus.getCapabilities()) {
                    deviceSupportCapabilitiesJSON.put(capability);
                }
                map.put(Param.DEVICE_SUPPORT_CAPABILITIES, deviceSupportCapabilitiesJSON);
            } else if (statusResponse instanceof ScreenStatusResponse) {
                final ScreenStatus screenStatus = ((ScreenStatusResponse) statusResponse).getScreenStatus();
                map.put(Param.SCREEN_STATUS, screenStatus.getStatus());
            } else if (statusResponse instanceof WifiStatusResponse) {
                final WifiStatus wifiStatus = ((WifiStatusResponse) statusResponse).getWifiStatus();
                map.put(Param.STATUS, wifiStatus.getStatus());
                map.put(Param.BSSID, wifiStatus.getBssid());
                map.put(Param.SSID, wifiStatus.getSsid());
            } else if (statusResponse instanceof ApplicationStatusResponse) {
                final ApplicationStatus applicationStatus
                    = ((ApplicationStatusResponse) statusResponse).getApplicationStatus();
                map.put(Param.APPLICATION_STATUS, applicationStatus.getStatus());
            } else if (statusResponse instanceof DarkModeStatusResponse) {
                final DarkModeStatus darkModeStatus = ((DarkModeStatusResponse) statusResponse).getDarkModeStatus();
                map.put(Param.IS_DARK_MODE_ON, darkModeStatus.isDarkModeOn());
            }
        } catch (final JSONException e) {
            Log.e("statusToJson", e.toString());
        }
        return map;
    }

    public static JSONObject beaconStatusToJson(final BeaconStatusResponse beaconStatusResponse) {
        final JSONObject obj = new JSONObject();
        try {
            final JSONArray array = new JSONArray();
            final BeaconStatus beaconStatus = beaconStatusResponse.getBeaconStatus();
            final List<BeaconStatus.BeaconData> beaconDataList = beaconStatus.getBeaconData();
            for (final BeaconData data : beaconDataList) {
                array.put(getBeaconData(data));
            }
            obj.put(Param.BEACONS, array);
        } catch (final JSONException e) {
            Log.e("beaconStatusToJson", e.toString());
        }
        return obj;
    }

    private static JSONObject getBeaconData(final BeaconData data) {
        final JSONObject map = new JSONObject();
        try {
            map.put(Param.BEACON_ID, data.getBeaconId());
            map.put(Param.BEACON_NAMESPACE, data.getNamespace());
            map.put(Param.BEACON_TYPE, data.getType());
            map.put(Param.BEACON_CONTENT, convertBytesToList(data.getContent()));
        } catch (final JSONException e) {
            Log.e("getBeaconData", e.toString());
        }
        return map;
    }

    private static JSONArray convertBytesToList(final byte[] bytes) {
        final JSONArray list = new JSONArray();
        for (final byte b : bytes) {
            list.put(b);
        }
        return list;
    }

    public static JSONObject behaviorStatusToJson(final BehaviorStatus behaviorStatus) {
        final JSONObject map = new JSONObject();
        try {
            map.put(Param.ELAPSED_REALTIME_MILLIS, behaviorStatus.getElapsedRealtimeMillis());
            map.put(Param.TIME, behaviorStatus.getTime());
            map.put(Param.MOST_LIKELY_BEHAVIOR, getMostLikelyBehavior(behaviorStatus.getMostLikelyBehavior()));
            map.put(Param.PROBABLE_BEHAVIOR, probableBehaviorToJson(behaviorStatus.getProbableBehavior()));
        } catch (final JSONException e) {
            Log.e("behaviorStatusToJson", e.toString());
        }
        return map;
    }

    private static JSONArray probableBehaviorToJson(final List<DetectedBehavior> list) {
        final JSONArray array = new JSONArray();
        for (final DetectedBehavior item : list) {
            array.put(getMostLikelyBehavior(item));
        }
        return array;
    }

    private static JSONObject getMostLikelyBehavior(final DetectedBehavior detectedBehavior) {
        final JSONObject mostLikelyBehaviorResult = new JSONObject();
        try {
            mostLikelyBehaviorResult.putOpt(Param.CONFIDENCE, detectedBehavior.getConfidence());
            mostLikelyBehaviorResult.putOpt(Param.TYPE, detectedBehavior.getType());
        } catch (final JSONException e) {
            Log.e("getMostLikelyBehavior", e.toString());
        }
        return mostLikelyBehaviorResult;
    }

    public static JSONObject weatherStatusToJson(final WeatherStatusResponse weatherStatusResponse) {
        final JSONObject map = new JSONObject();
        final WeatherStatus weatherStatus = weatherStatusResponse.getWeatherStatus();
        try {
            map.put(Param.DAILY_WEATHER, dailyWeatherToJson(weatherStatus.getDailyWeather()));
            map.put(Param.HOURLY_WEATHER, getHourlyWeather(weatherStatus.getHourlyWeather()));
            map.put(Param.LIVE_INFO, getLiveInfo(weatherStatus.getLiveInfo()));
            map.put(Param.AQI, getAqi(weatherStatus.getAqi()));
            map.put(Param.WEATHER_SITUATION, getWeatherSituation(weatherStatus.getWeatherSituation()));
        } catch (final JSONException e) {
            Log.e("weatherStatusToJson", e.toString());
        }
        return map;
    }

    private static JSONArray dailyWeatherToJson(final List<DailyWeather> list) throws JSONException {
        final JSONArray array = new JSONArray();
        for (final DailyWeather dailyWeather : list) {
            final JSONObject dailyWeatherJSON = new JSONObject();
            dailyWeatherJSON.put(Param.AQI_VALUE, dailyWeather.getAqiValue());
            dailyWeatherJSON.put(Param.DATE_TIME_STAMP, dailyWeather.getDateTimeStamp());
            dailyWeatherJSON.put(Param.MAX_TEMP_C, dailyWeather.getMaxTempC());
            dailyWeatherJSON.put(Param.MAX_TEMP_F, dailyWeather.getMaxTempF());
            dailyWeatherJSON.put(Param.MIN_TEMP_C, dailyWeather.getMinTempC());
            dailyWeatherJSON.put(Param.MIN_TEMP_F, dailyWeather.getMinTempF());
            dailyWeatherJSON.put(Param.MOON_RISE, dailyWeather.getMoonRise());
            dailyWeatherJSON.put(Param.MOON_SET, dailyWeather.getMoonSet());
            dailyWeatherJSON.put(Param.MOON_PHASE, dailyWeather.getMoonphase());
            dailyWeatherJSON.put(Param.SITUATION_DAY, getSituationDay(dailyWeather.getSituationDay()));
            dailyWeatherJSON.put(Param.SITUATION_NIGHT, getSituationNight(dailyWeather.getSituationNight()));
            dailyWeatherJSON.put(Param.SUN_RISE, dailyWeather.getSunRise());
            dailyWeatherJSON.put(Param.SUN_SET, dailyWeather.getSunSet());
            array.put(dailyWeatherJSON);
        }
        return array;
    }

    private static JSONArray getHourlyWeather(final List<HourlyWeather> list) throws JSONException {
        final JSONArray array = new JSONArray();
        for (final HourlyWeather hourlyWeather : list) {
            final JSONObject hourlyWeatherJSON = new JSONObject();
            hourlyWeatherJSON.put(Param.CN_WEATHER_ID, hourlyWeather.getCnWeatherId());
            hourlyWeatherJSON.put(Param.DATE_TIME_STAMP, hourlyWeather.getDateTimeStamp());
            hourlyWeatherJSON.put(Param.IS_DAY_NIGHT, hourlyWeather.isDayNight());
            hourlyWeatherJSON.put(Param.RAIN_PROBABILITY, hourlyWeather.getRainprobability());
            hourlyWeatherJSON.put(Param.TEMP_C, hourlyWeather.getTempC());
            hourlyWeatherJSON.put(Param.TEMP_F, hourlyWeather.getTempF());
            hourlyWeatherJSON.put(Param.WEATHER_ID, hourlyWeather.getWeatherId());
            array.put(hourlyWeatherJSON);
        }
        return array;
    }

    private static JSONArray getLiveInfo(final List<LiveInfo> list) throws JSONException {
        final JSONArray array = new JSONArray();
        for (final LiveInfo liveInfo : list) {
            final JSONObject liveInfoJSON = new JSONObject();
            liveInfoJSON.put(Param.CODE, liveInfo.getCode());
            liveInfoJSON.put(Param.DAILY_LIVE_INFO, getDailyLiveInfoList(liveInfo.getLevelList()));
            array.put(liveInfoJSON);
        }
        return array;
    }

    private static JSONArray getDailyLiveInfoList(final List<DailyLiveInfo> list) throws JSONException {
        final JSONArray array = new JSONArray();
        for (final DailyLiveInfo dailyLiveInfo : list) {
            final JSONObject dailyLiveInfoToJson = new JSONObject();
            dailyLiveInfoToJson.put(Param.DATE_TIME_STAMP, dailyLiveInfo.getDateTimeStamp());
            dailyLiveInfoToJson.put(Param.LEVEL, dailyLiveInfo.getLevel());
            array.put(dailyLiveInfoToJson);
        }
        return array;
    }

    private static JSONObject getSituationDay(final DailySituation dailySituation) throws JSONException {
        final JSONObject situationDayJSON = new JSONObject();
        situationDayJSON.put(Param.CN_WEATHER_ID, dailySituation.getCnWeatherId());
        situationDayJSON.put(Param.WEATHER_ID, dailySituation.getWeatherId());
        situationDayJSON.put(Param.WIND_DIR, dailySituation.getWindDir());
        situationDayJSON.put(Param.WIND_LEVEL, dailySituation.getWindLevel());
        situationDayJSON.put(Param.WIND_SPEED, dailySituation.getWindSpeed());
        return situationDayJSON;
    }

    private static JSONObject getSituationNight(final DailySituation situationNight) throws JSONException {
        final JSONObject situationNightJSON = new JSONObject();
        situationNightJSON.put(Param.CN_WEATHER_ID, situationNight.getCnWeatherId());
        situationNightJSON.put(Param.WEATHER_ID, situationNight.getWeatherId());
        situationNightJSON.put(Param.WIND_DIR, situationNight.getWindDir());
        situationNightJSON.put(Param.WIND_LEVEL, situationNight.getWindLevel());
        situationNightJSON.put(Param.WIND_SPEED, situationNight.getWindSpeed());
        return situationNightJSON;
    }

    private static JSONObject getAqi(final Aqi aqi) throws JSONException {
        final JSONObject aqiJSON = new JSONObject();
        if (aqi != null) {
            aqiJSON.put(Param.AQI_VALUE, aqi.getAqiValue());
            aqiJSON.put(Param.CO, aqi.getCo());
            aqiJSON.put(Param.NO2, aqi.getNo2());
            aqiJSON.put(Param.O3, aqi.getO3());
            aqiJSON.put(Param.PM10, aqi.getPm10());
            aqiJSON.put(Param.PM25, aqi.getPm25());
            aqiJSON.put(Param.SO2, aqi.getSo2());
        }
        return aqiJSON;
    }

    private static JSONObject getWeatherSituation(final WeatherSituation weatherSituation) throws JSONException {
        final JSONObject weatherSituationJSON = new JSONObject();
        if (weatherSituation != null) {
            weatherSituationJSON.put(Param.CITY, getCity(weatherSituation.getCity()));
            weatherSituationJSON.put(Param.SITUATION, getSituation(weatherSituation.getSituation()));
        }
        return weatherSituationJSON;
    }

    private static JSONObject getCity(final City city) throws JSONException {
        final JSONObject cityJSON = new JSONObject();
        if (city != null) {
            cityJSON.put(Param.CITY_CODE, city.getCityCode());
            cityJSON.put(Param.NAME, city.getName());
            cityJSON.put(Param.PROVINCE_NAME, city.getProvinceName());
            cityJSON.put(Param.TIME_ZONE, city.getTimeZone());
        }
        return cityJSON;
    }

    private static JSONObject getSituation(final Situation situation) throws JSONException {
        final JSONObject situationJSON = new JSONObject();
        if (situation != null) {
            situationJSON.put(Param.CN_WEATHER_ID, situation.getCnWeatherId());
            situationJSON.put(Param.HUMIDITY, situation.getHumidity());
            situationJSON.put(Param.PRESSURE, situation.getPressure());
            situationJSON.put(Param.REAL_FEEL_C, situation.getRealFeelC());
            situationJSON.put(Param.REAL_FEEL_F, situation.getRealFeelF());
            situationJSON.put(Param.TEMPERATURE_C, situation.getTemperatureC());
            situationJSON.put(Param.TEMPERATURE_F, situation.getTemperatureF());
            situationJSON.put(Param.UPDATE_TIME, situation.getUpdateTime());
            situationJSON.put(Param.UV_INDEX, situation.getUvIndex());
            situationJSON.put(Param.WEATHER_ID, situation.getWeatherId());
            situationJSON.put(Param.WIND_DIR, situation.getWindDir());
            situationJSON.put(Param.WIND_SPEED, situation.getWindSpeed());
            situationJSON.put(Param.WIND_LEVEL, situation.getWindLevel());
        }
        return situationJSON;
    }

    public static JSONObject barrierStatusToJson(final BarrierStatus barrierStatus) {
        final JSONObject map = new JSONObject();
        try {
            map.put(Param.BARRIER_LABEL, barrierStatus.getBarrierLabel());
            map.put(Param.LAST_BARRIER_UPDATE_TIME, barrierStatus.getLastBarrierUpdateTime());
            map.put(Param.LAST_STATUS, barrierStatus.getLastStatus());
            map.put(Param.PRESENT_STATUS, barrierStatus.getPresentStatus());
        } catch (final JSONException e) {
            Log.e("barrierStatusToJson", e.toString());
        }
        return map;
    }

    public static JSONObject barrierStatusMapToJson(final BarrierQueryResponse barrierQueryResponse) {
        final BarrierStatusMap obj = barrierQueryResponse.getBarrierStatusMap();
        final JSONObject map = new JSONObject();
        try {
            final Set<String> barrierLabels = obj.getBarrierLabels();
            final JSONArray labelArray = new JSONArray();
            for (final String barrierLabel : barrierLabels) {
                final JSONObject labelObj = new JSONObject();
                final BarrierStatus barrierStatus = obj.getBarrierStatus(barrierLabel);
                final JSONObject barrierStatusObject = barrierStatusToJson(barrierStatus);
                labelObj.put(Param.BARRIER_LABEL, barrierLabel);
                labelObj.put(Param.BARRIER_STATUS, barrierStatusObject);
                labelArray.put(labelObj);
            }
            map.put(Param.BARRIERS, labelArray);
        } catch (final JSONException e) {
            Log.e("barrierStatusMapConvertToJSONObject", e.toString());
        }
        return map;
    }

    public static Collection<BeaconStatus.Filter> createBeaconFilters(final Map<String, Object> args) {
        final Collection<Filter> beaconFilters = new ArrayList<>();
        final List<Map<String, Object>> filters = (List<Map<String, Object>>) args.get(Param.BEACON_FILTER);
        BeaconStatus.Filter innerFilter;
        String beaconNamespace;
        String beaconType;

        for (final Map<String, Object> filter : Objects.requireNonNull(filters)) {
            final String filterType = ValueGetter.getString(Param.FILTER_TYPE, filter);
            switch (filterType) {
                case Param.MATCH_BY_NAME_TYPE:
                    beaconNamespace = ValueGetter.getString(Param.BEACON_NAMESPACE, filter);
                    beaconType = ValueGetter.getString(Param.BEACON_TYPE, filter);
                    innerFilter = BeaconStatus.Filter.match(beaconNamespace, beaconType);
                    beaconFilters.add(innerFilter);
                    break;
                case Param.MATCH_BY_BEACON_CONTENT:
                    beaconNamespace = ValueGetter.getString(Param.BEACON_NAMESPACE, filter);
                    beaconType = ValueGetter.getString(Param.BEACON_TYPE, filter);
                    final byte[] beaconContent = (byte[]) filter.get(Param.BEACON_CONTENT);
                    if (beaconContent != null) {
                        innerFilter = BeaconStatus.Filter.match(beaconNamespace, beaconType, beaconContent);
                        beaconFilters.add(innerFilter);
                    }
                    break;
                case Param.MATCH_BY_BEACON_ID:
                    final String beaconId = ValueGetter.getString(Param.BEACON_ID, filter);
                    innerFilter = BeaconStatus.Filter.match(beaconId);
                    beaconFilters.add(innerFilter);
                    break;
                default:
                    break;
            }
        }
        return beaconFilters;
    }
}
