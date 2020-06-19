/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.location.constants;

public enum Action {
    PROCESS_LOCATION("com.huawei.hms.flutter.location.ACTION_PROCESS_LOCATION"),
    PROCESS_GEOFENCE("com.huawei.hms.flutter.location.ACTION_PROCESS_GEOFENCE"),
    PROCESS_CONVERSION("com.huawei.hms.flutter.location.ACTION_PROCESS_CONVERSION"),
    PROCESS_IDENTIFICATION("com.huawei.hms.flutter.location.ACTION_PROCESS_IDENTIFICATION");

    private final String id;

    Action(final String id) {
        this.id = id;
    }

    public String id() {
        return id;
    }
}
