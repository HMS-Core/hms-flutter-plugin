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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.location.LocationUtils;
import com.huawei.hms.support.api.entity.location.coordinate.LonLat;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocationUtilsMethodHandler implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public LocationUtilsMethodHandler(final Activity activity) {
        this.activity = activity;
    }

    private void convertCoord(final MethodCall call, final MethodChannel.Result result) {
        double latitude = call.argument("latitude");
        double longitude = call.argument("longitude");
        int coordType = call.argument("coordType");

        LonLat convertLonlat = LocationUtils.convertCoord(latitude, longitude, coordType);
        result.success(com.huawei.hms.flutter.location.utils.LocationUtils.fromLonLatToMap(convertLonlat));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "convertCoord":
                convertCoord(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
