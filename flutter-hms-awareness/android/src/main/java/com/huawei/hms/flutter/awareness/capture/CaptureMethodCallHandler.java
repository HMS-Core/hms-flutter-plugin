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

package com.huawei.hms.flutter.awareness.capture;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.awareness.constants.Method;
import com.huawei.hms.flutter.awareness.constants.Param;
import com.huawei.hms.flutter.awareness.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.awareness.logger.HMSLogger;
import com.huawei.hms.flutter.awareness.utils.Convert;
import com.huawei.hms.flutter.awareness.utils.ValueGetter;
import com.huawei.hms.kit.awareness.Awareness;
import com.huawei.hms.kit.awareness.CaptureClient;
import com.huawei.hms.kit.awareness.capture.WeatherPosition;
import com.huawei.hms.kit.awareness.status.BeaconStatus.Filter;
import com.huawei.hms.kit.awareness.status.BehaviorStatus;

import java.util.Collection;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class CaptureMethodCallHandler implements MethodCallHandler {
    private final CaptureClient captureClient;
    private final HMSLogger logger;

    public CaptureMethodCallHandler(final Context mContext) {
        captureClient = Awareness.getCaptureClient(mContext);
        logger = HMSLogger.getInstance(mContext);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case Method.GET_BEACON_STATUS:
                getBeaconStatus(call, result);
                break;
            case Method.GET_BEHAVIOR:
                getBehavior(result);
                break;
            case Method.GET_HEADSET_STATUS:
                getHeadsetStatus(result);
                break;
            case Method.GET_LOCATION:
                getLocation(result);
                break;
            case Method.GET_CURRENT_LOCATION:
                getCurrentLocation(result);
                break;
            case Method.GET_TIME_CATEGORIES:
                getTimeCategories(result);
                break;
            case Method.GET_TIME_CATEGORIES_BY_USER:
                getTimeCategoriesByUser(call, result);
                break;
            case Method.GET_TIME_CATEGORIES_BY_COUNTRY_CODE:
                getTimeCategoriesByCountryCode(call, result);
                break;
            case Method.GET_TIME_CATEGORIES_BY_IP:
                getTimeCategoriesByIP(result);
                break;
            case Method.GET_TIME_CATEGORIES_FOR_FUTURE:
                getTimeCategoriesForFuture(call, result);
                break;
            case Method.GET_LIGHT_INTENSITY:
                getLightIntensity(result);
                break;
            case Method.GET_WEATHER_BY_DEVICE:
                getWeatherByDevice(result);
                break;
            case Method.GET_WEATHER_BY_POSITION:
                getWeatherByPosition(call, result);
                break;
            case Method.GET_BLUETOOTH_STATUS:
                getBluetoothStatus(call, result);
                break;
            case Method.QUERY_SUPPORTING_CAPABILITIES:
                querySupportingCapabilities(result);
                break;
            case Method.ENABLE_UPDATE_WINDOW:
                enableUpdateWindow(call);
                break;
            case Method.GET_SCREEN_STATUS:
                getScreenStatus(result);
                break;
            case Method.GET_WIFI_STATUS:
                getWifiStatus(result);
                break;
            case Method.GET_APPLICATION_STATUS:
                getApplicationStatus(call, result);
                break;
            case Method.GET_DARK_MODE_STATUS:
                getDarkModeStatus(result);
                break;
            default:
                result.notImplemented();
        }
    }

    @SuppressLint("MissingPermission")
    private void getBeaconStatus(final MethodCall call, final Result result) {
        final String getBeaconStatusMethodName = "getBeaconStatus";
        final Map<String, Object> args = (Map<String, Object>) call.arguments;
        final Collection<Filter> beaconFilters = Convert.createBeaconFilters(args);

        logger.startMethodExecutionTimer(getBeaconStatusMethodName);
        captureClient.getBeaconStatus(beaconFilters).addOnSuccessListener(beaconStatusResponse -> {
            result.success(Convert.beaconStatusToJson(beaconStatusResponse).toString());
            logger.sendSingleEvent(getBeaconStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getBeaconStatusMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getBehavior(final Result result) {
        final String getBehaviorMethodName = "getBehavior";

        logger.startMethodExecutionTimer(getBehaviorMethodName);
        captureClient.getBehavior().addOnSuccessListener(behaviorResponse -> {
            final BehaviorStatus behaviorStatus = behaviorResponse.getBehaviorStatus();
            result.success(Convert.behaviorStatusToJson(behaviorStatus).toString());
            logger.sendSingleEvent(getBehaviorMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getBehaviorMethodName));
    }

    private void getHeadsetStatus(final Result result) {
        final String getHeadsetStatusMethodName = "getHeadsetStatus";

        logger.startMethodExecutionTimer(getHeadsetStatusMethodName);
        captureClient.getHeadsetStatus().addOnSuccessListener(headsetStatusResponse -> {
            result.success(Convert.statusToJson(headsetStatusResponse).toString());
            logger.sendSingleEvent(getHeadsetStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getHeadsetStatusMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getLocation(final Result result) {
        final String getLocationMethodName = "getLocation";

        logger.startMethodExecutionTimer(getLocationMethodName);
        captureClient.getLocation().addOnSuccessListener(locationResponse -> {
            result.success(Convert.locationToJson(locationResponse).toString());
            logger.sendSingleEvent(getLocationMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getLocationMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getCurrentLocation(final Result result) {
        final String getCurrentLocationMethodName = "getCurrentLocation";

        logger.startMethodExecutionTimer(getCurrentLocationMethodName);
        captureClient.getCurrentLocation().addOnSuccessListener(locationResponse -> {
            result.success(Convert.locationToJson(locationResponse).toString());
            logger.sendSingleEvent(getCurrentLocationMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getCurrentLocationMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getTimeCategories(final Result result) {
        final String getTimeCategoriesMethodName = "getTimeCategories";

        logger.startMethodExecutionTimer(getTimeCategoriesMethodName);
        captureClient.getTimeCategories().addOnSuccessListener(timeCategoriesResponse -> {
            result.success(Convert.statusToJson(timeCategoriesResponse).toString());
            logger.sendSingleEvent(getTimeCategoriesMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getTimeCategoriesMethodName));
    }

    private void getTimeCategoriesByUser(final MethodCall call, final Result result) {
        final String getTimeCategoriesByUserMethodName = "getTimeCategoriesByUser";
        final double lat = ValueGetter.getDouble(Param.LATITUDE, call);
        final double lng = ValueGetter.getDouble(Param.LONGITUDE, call);

        logger.startMethodExecutionTimer(getTimeCategoriesByUserMethodName);
        captureClient.getTimeCategoriesByUser(lat, lng).addOnSuccessListener(timeCategoriesResponse -> {
            result.success(Convert.statusToJson(timeCategoriesResponse).toString());
            logger.sendSingleEvent(getTimeCategoriesByUserMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getTimeCategoriesByUserMethodName));
    }

    private void getTimeCategoriesByCountryCode(final MethodCall call, final Result result) {
        final String getTimeCategoriesByCountryCodeMethodName = "getTimeCategoriesByCountryCode";
        final String countryCode = ValueGetter.getString(Param.COUNTRY_CODE, call);

        logger.startMethodExecutionTimer(getTimeCategoriesByCountryCodeMethodName);
        captureClient.getTimeCategoriesByCountryCode(countryCode).addOnSuccessListener(timeCategoriesResponse -> {
            result.success(Convert.statusToJson(timeCategoriesResponse).toString());
            logger.sendSingleEvent(getTimeCategoriesByCountryCodeMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getTimeCategoriesByCountryCodeMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getTimeCategoriesByIP(final Result result) {
        final String getTimeCategoriesByIPMethodName = "getTimeCategoriesByIP";

        logger.startMethodExecutionTimer(getTimeCategoriesByIPMethodName);
        captureClient.getTimeCategoriesByIP().addOnSuccessListener(timeCategoriesResponse -> {
            result.success(Convert.statusToJson(timeCategoriesResponse).toString());
            logger.sendSingleEvent(getTimeCategoriesByIPMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getTimeCategoriesByIPMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getTimeCategoriesForFuture(final MethodCall call, final Result result) {
        final String getTimeCategoriesForFutureMethodName = "getTimeCategoriesForFuture";
        final long futureTimestamp = ValueGetter.getLong(Param.FUTURE_TIMESTAMP, call);

        logger.startMethodExecutionTimer(getTimeCategoriesForFutureMethodName);
        captureClient.getTimeCategoriesForFuture(futureTimestamp).addOnSuccessListener(timeCategoriesResponse -> {
            result.success(Convert.statusToJson(timeCategoriesResponse).toString());
            logger.sendSingleEvent(getTimeCategoriesForFutureMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getTimeCategoriesForFutureMethodName));
    }

    private void getLightIntensity(final Result result) {
        final String getLightIntensityMethodName = "getLightIntensity";

        logger.startMethodExecutionTimer(getLightIntensityMethodName);
        captureClient.getLightIntensity().addOnSuccessListener(ambientLightResponse -> {
            result.success(Convert.statusToJson(ambientLightResponse).toString());
            logger.sendSingleEvent(getLightIntensityMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getLightIntensityMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getWeatherByDevice(final Result result) {
        final String getWeatherByDeviceMethodName = "getWeatherByDevice";

        logger.startMethodExecutionTimer(getWeatherByDeviceMethodName);
        captureClient.getWeatherByDevice().addOnSuccessListener(weatherStatusResponse -> {
            result.success(Convert.weatherStatusToJson(weatherStatusResponse).toString());
            logger.sendSingleEvent(getWeatherByDeviceMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getWeatherByDeviceMethodName));
    }

    private void getWeatherByPosition(final MethodCall call, final Result result) {
        final String getWeatherByPositionMethodName = "getWeatherByPosition";
        final WeatherPosition position = new WeatherPosition();
        position.setCity(ValueGetter.getString(Param.CITY, call));
        position.setLocale(ValueGetter.getString(Param.LOCALE, call));
        if (call.argument(Param.COUNTRY) != null) {
            position.setCountry(ValueGetter.getString(Param.COUNTRY, call));
        }
        if (call.argument(Param.PROVINCE) != null) {
            position.setProvince(ValueGetter.getString(Param.PROVINCE, call));
        }
        if (call.argument(Param.DISTRICT) != null) {
            position.setDistrict(ValueGetter.getString(Param.DISTRICT, call));
        }
        if (call.argument(Param.COUNTY) != null) {
            position.setCounty(ValueGetter.getString(Param.COUNTY, call));
        }

        logger.startMethodExecutionTimer(getWeatherByPositionMethodName);
        captureClient.getWeatherByPosition(position).addOnSuccessListener(weatherStatusResponse -> {
            result.success(Convert.weatherStatusToJson(weatherStatusResponse).toString());
            logger.sendSingleEvent(getWeatherByPositionMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getWeatherByPositionMethodName));
    }

    @SuppressLint("MissingPermission")
    private void getBluetoothStatus(final MethodCall call, final Result result) {
        final String getBluetoothStatusMethodName = "getBluetoothStatus";
        final int deviceType = ValueGetter.getInt(Param.DEVICE_TYPE, call);

        logger.startMethodExecutionTimer(getBluetoothStatusMethodName);
        captureClient.getBluetoothStatus(deviceType).addOnSuccessListener(bluetoothStatusResponse -> {
            result.success(Convert.statusToJson(bluetoothStatusResponse).toString());
            logger.sendSingleEvent(getBluetoothStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getBluetoothStatusMethodName));
    }

    private void querySupportingCapabilities(final Result result) {
        final String querySupportingCapabilitiesMethodName = "querySupportingCapabilities";

        logger.startMethodExecutionTimer(querySupportingCapabilitiesMethodName);
        captureClient.querySupportingCapabilities().addOnSuccessListener(capabilityResponse -> {
            result.success(Convert.statusToJson(capabilityResponse).toString());
            logger.sendSingleEvent(querySupportingCapabilitiesMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, querySupportingCapabilitiesMethodName));
    }

    private void enableUpdateWindow(final MethodCall call) {
        final String enableUpdateWindowMethodName = "enableUpdateWindow";
        final boolean updateWindow = ValueGetter.getBoolean(Param.STATUS, call);
        logger.startMethodExecutionTimer(enableUpdateWindowMethodName);
        captureClient.enableUpdateWindow(updateWindow);
        logger.sendSingleEvent(enableUpdateWindowMethodName);
    }

    private void getScreenStatus(final Result result) {
        final String getScreenStatusMethodName = "getScreenStatus";

        logger.startMethodExecutionTimer(getScreenStatusMethodName);
        captureClient.getScreenStatus().addOnSuccessListener(screenStatusResponse -> {
            result.success(Convert.statusToJson(screenStatusResponse).toString());
            logger.sendSingleEvent(getScreenStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getScreenStatusMethodName));
    }

    private void getWifiStatus(final Result result) {
        final String getWifiStatusMethodName = "getWifiStatus";

        logger.startMethodExecutionTimer("getWifiStatus");
        captureClient.getWifiStatus().addOnSuccessListener(wifiStatusResponse -> {
            result.success(Convert.statusToJson(wifiStatusResponse).toString());
            logger.sendSingleEvent(getWifiStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getWifiStatusMethodName));
    }

    private void getApplicationStatus(final MethodCall call, final Result result) {
        final String getApplicationStatusMethodName = "getApplicationStatus";
        final String packageName = ValueGetter.getString(Param.PACKAGE_NAME, call);

        logger.startMethodExecutionTimer(getApplicationStatusMethodName);
        captureClient.getApplicationStatus(packageName).addOnSuccessListener(applicationStatusResponse -> {
            result.success(Convert.statusToJson(applicationStatusResponse).toString());
            logger.sendSingleEvent(getApplicationStatusMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, getApplicationStatusMethodName));
    }

    private void getDarkModeStatus(final Result result) {
        final String getDarkModeStatusMethodName = "getDarkModeStatus";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            logger.startMethodExecutionTimer(getDarkModeStatusMethodName);
            captureClient.getDarkModeStatus().addOnSuccessListener(darkModeStatusResponse -> {
                result.success(Convert.statusToJson(darkModeStatusResponse).toString());
                logger.sendSingleEvent(getDarkModeStatusMethodName);
            }).addOnFailureListener(new DefaultFailureListener(result, logger, getDarkModeStatusMethodName));
        } else {
            result.error("getDarkModeStatusError", "Dark Mode Status requires API Level 29", null);
        }
    }
}