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

package com.huawei.hms.flutter.location.handlers;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Error;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.GeocoderUtils;
import com.huawei.hms.flutter.location.utils.LocationUtils;
import com.huawei.hms.location.GeocoderService;
import com.huawei.hms.location.GetFromLocationNameRequest;
import com.huawei.hms.location.GetFromLocationRequest;
import com.huawei.hms.location.HWLocation;
import com.huawei.hms.location.LocationServices;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

import java.util.List;
import java.util.Locale;
import java.util.Map;

public class GeocoderMethodHandler implements MethodCallHandler {
    private static final String TAG = GeocoderMethodHandler.class.getSimpleName();

    private final Activity activity;

    private GeocoderService geocoderService;

    public GeocoderMethodHandler(final Activity activity) {
        this.activity = activity;
    }

    private void initGeocoderService(final MethodCall call, final MethodChannel.Result result) {
        Map localeMap = call.argument("locale");
        Locale locale = GeocoderUtils.fromMapToLocale(localeMap);
        geocoderService = LocationServices.getGeocoderService(activity, locale);
        Log.i(TAG, "Geocoder Service has been initialized.");
        result.success(null);
    }

    private void getFromLocation(final MethodCall call, final MethodChannel.Result result) {

        Map requestMap = call.argument("getFromLocationRequest");
        GetFromLocationRequest getFromLocationRequest = GeocoderUtils.fromMapToGetFromLocationRequest(requestMap);

        if (geocoderService == null) {
            result.error("-1", Error.GEOCODER_SERVICE_NOT_INITIALIZED.message(), null);
            return;
        }

        geocoderService.getFromLocation(getFromLocationRequest).addOnSuccessListener((List<HWLocation> hwLocations) -> {
            result.success(LocationUtils.fromHWLocationListToMap(hwLocations));
        }).addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void getFromLocationName(final MethodCall call, final MethodChannel.Result result) {
        Map requestMap = call.argument("getFromLocationNameRequest");
        GetFromLocationNameRequest getFromLocationNameRequest = GeocoderUtils.fromMapToGetFromLocationNameRequest(
            requestMap);

        if (geocoderService == null) {
            result.error("-1", Error.GEOCODER_SERVICE_NOT_INITIALIZED.message(), null);
            return;
        }
        geocoderService.getFromLocationName(getFromLocationNameRequest)
            .addOnSuccessListener((List<HWLocation> hwLocations) -> {
                result.success(LocationUtils.fromHWLocationListToMap(hwLocations));
            })
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "initGeocoderService":
                initGeocoderService(call, result);
                break;
            case "getFromLocation":
                getFromLocation(call, result);
                break;
            case "getFromLocationName":
                getFromLocationName(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
