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

package com.huawei.hms.flutter.location.constants;

public enum Channel {
    FUSED_LOCATION_METHOD("com.huawei.flutter.location/fusedlocation_methodchannel"),
    FUSED_LOCATION_EVENT("com.huawei.flutter.location/fusedlocation_eventchannel"),
    GEOFENCE_METHOD("com.huawei.flutter.location/geofence_methodchannel"),
    GEOFENCE_EVENT("com.huawei.flutter.location/geofence_eventchannel"),
    ACTIVITY_IDENTIFICATION_METHOD("com.huawei.flutter.location/activityidentification_methodchannel"),
    ACTIVITY_IDENTIFICATION_EVENT("com.huawei.flutter.location/activityidentification_eventchannel"),
    ACTIVITY_CONVERSION_EVENT("com.huawei.flutter.location/activityconversion_eventchannel"),
    LOCATION_ENHANCE_METHOD("com.huawei.flutter.location/locationenhance_methodchannel"),
    HMSLOGGER_METHOD("com.huawei.flutter.location/hmslogger_methodchannel"),
    GEOCODER_METHOD("com.huawei.flutter.location/geocoder_methodchannel"),

    LOCATION_UTILS_METHOD("com.huawei.flutter.location/locationutils_methodchannel");

    private final String id;

    Channel(final String id) {
        this.id = id;
    }

    public String id() {
        return id;
    }
}
