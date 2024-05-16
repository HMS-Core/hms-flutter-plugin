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

public enum Error {
    LOCATION_SETTINGS_NOT_AVAILABLE("Unable to get location settings"),
    NON_EXISTING_REQUEST_ID("Request ID does not exists"),
    SEND_INTENT_EXCEPTION("Unable to send intent"),
    FUSED_LOCATION_NOT_INITIALIZED("FusedLocationService is not initialized."),
    ACTIVITY_IDENTIFICATION_NOT_INITIALIZED("ActivityIdentificationService is not initialized."),
    GEOFENCE_SERVICE_NOT_INITIALIZED("GeofenceService is not initialized."),
    GEOCODER_SERVICE_NOT_INITIALIZED("GeocoderService is not initialized.");

    private final String message;

    Error(final String message) {
        this.message = message;
    }

    public String message() {
        return message;
    }
}
