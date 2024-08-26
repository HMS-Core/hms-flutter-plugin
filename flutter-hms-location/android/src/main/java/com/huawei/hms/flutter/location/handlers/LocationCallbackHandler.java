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

import android.content.Context;

import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.LocationUtils;
import com.huawei.hms.location.LocationAvailability;
import com.huawei.hms.location.LocationCallback;
import com.huawei.hms.location.LocationResult;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.Map;

public class LocationCallbackHandler extends LocationCallback {
    private final Context context;

    private final String methodName;

    private final int callbackId;

    private final MethodChannel channel;

    LocationCallbackHandler(final Context context, final String methodName, final int callbackId,
        final MethodChannel channel) {
        this.context = context;
        this.methodName = methodName;
        this.callbackId = callbackId;
        this.channel = channel;
    }

    @Override
    public void onLocationResult(final LocationResult locationResult) {
        if (locationResult != null) {
            final Map<String, Object> map = new HashMap<>();

            map.put("callbackId", callbackId);
            map.put("locationResult", LocationUtils.fromLocationResultToMap(locationResult));

            HMSLogger.getInstance(context).sendPeriodicEvent(methodName + ".onLocationResult");
            channel.invokeMethod("onLocationResult", map);
        }
    }

    @Override
    public void onLocationAvailability(final LocationAvailability locationAvailability) {
        if (locationAvailability != null) {
            final Map<String, Object> map = new HashMap<>();

            map.put("callbackId", callbackId);
            map.put("locationAvailability", LocationUtils.fromLocationAvailabilityToMap(locationAvailability));

            HMSLogger.getInstance(context).sendPeriodicEvent(methodName + ".onLocationAvailability");
            channel.invokeMethod("onLocationAvailability", map);
        }
    }
}
