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

package com.huawei.hms.flutter.location.listeners;

import android.content.Context;
import android.location.Location;

import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.LocationUtils;
import com.huawei.hms.flutter.location.utils.ObjectUtils;
import com.huawei.hms.location.HWLocation;
import com.huawei.hms.location.LocationAvailability;
import com.huawei.hms.location.LocationSettingsResponse;
import com.huawei.hms.location.LocationSettingsStates;
import com.huawei.hms.location.NavigationResult;

import io.flutter.plugin.common.MethodChannel.Result;

public class DefaultSuccessListener<T> implements OnSuccessListener<T> {
    private final String methodName;

    private final Context context;

    private final Result result;

    public DefaultSuccessListener(final String methodName, final Context context, final Result result) {
        this.methodName = methodName;
        this.context = context;
        this.result = result;
    }

    @Override
    public void onSuccess(final T o) {
        HMSLogger.getInstance(context).sendSingleEvent(methodName);

        if (o instanceof Void || o == null) {
            result.success(null);
        }

        if (o instanceof Location) {
            final Location location = ObjectUtils.cast(o, Location.class);
            result.success(LocationUtils.fromLocationToMap(location));
        }

        if (o instanceof HWLocation) {
            final HWLocation hwLocation = ObjectUtils.cast(o, HWLocation.class);
            result.success(LocationUtils.fromHWLocationToMap(hwLocation));
        }

        if (o instanceof LocationAvailability) {
            final LocationAvailability locationAvailability = ObjectUtils.cast(o, LocationAvailability.class);
            result.success(LocationUtils.fromLocationAvailabilityToMap(locationAvailability));
        }

        if (o instanceof LocationSettingsResponse) {
            final LocationSettingsResponse response = ObjectUtils.cast(o, LocationSettingsResponse.class);
            final LocationSettingsStates locationSettingsStates = response.getLocationSettingsStates();
            result.success(LocationUtils.fromLocationSettingsStatesToMap(locationSettingsStates));
        }

        if (o instanceof NavigationResult) {
            final NavigationResult navigationResult = ObjectUtils.cast(o, NavigationResult.class);
            result.success(LocationUtils.fromNavigationResultToMap(navigationResult));
        }

    }
}
