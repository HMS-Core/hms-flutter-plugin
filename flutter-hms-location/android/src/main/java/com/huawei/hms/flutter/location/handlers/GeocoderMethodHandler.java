/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

import androidx.annotation.NonNull;

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

    private final Activity activity;

    public GeocoderMethodHandler(final Activity activity) {
        this.activity = activity;
    }

    private void getFromLocation(final MethodCall call, final MethodChannel.Result result) {
        Map localeMap = call.argument("locale");
        Locale locale = GeocoderUtils.fromMapToLocale(localeMap);

        Map requestMap = call.argument("getFromLocationRequest");

        GeocoderService geocoderService = LocationServices.getGeocoderService(activity, locale);
        GetFromLocationRequest getFromLocationRequest = GeocoderUtils.fromMapToGetFromLocationRequest(requestMap);
        geocoderService.getFromLocation(getFromLocationRequest)
                .addOnSuccessListener((List<HWLocation> hwLocations) -> {
                    result.success(LocationUtils.fromHWLocationListToMap(hwLocations));
                })
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void getFromLocationName(final MethodCall call, final MethodChannel.Result result) {
        Map localeMap = call.argument("locale");
        Locale locale = GeocoderUtils.fromMapToLocale(localeMap);

        Map requestMap = call.argument("getFromLocationNameRequest");

        GeocoderService geocoderService = LocationServices.getGeocoderService(activity, locale);
        GetFromLocationNameRequest getFromLocationNameRequest = GeocoderUtils.fromMapToGetFromLocationNameRequest(
                requestMap);
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
