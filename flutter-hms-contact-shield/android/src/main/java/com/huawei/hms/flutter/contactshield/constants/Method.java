/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.contactshield.constants;

public final class Method {
    public static final String GET_CONTACT_DETAIL = "getContactDetail";
    public static final String GET_CONTACT_SKETCH = "getContactSketch";
    public static final String GET_CONTACT_WINDOW = "getContactWindow";
    public static final String GET_PERIODIC_KEY = "getPeriodicKey";
    public static final String IS_CONTACT_SHIELD_RUNNING = "isContactShieldRunning";
    public static final String PUT_SHARED_KEY_FILES = "putSharedKeyFiles";
    public static final String PUT_SHARED_KEY_FILES_CB = "putSharedKeyFilesCb";
    public static final String PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER = "putSharedKeyFilesCbWithProvider";
    public static final String PUT_SHARED_KEY_FILES_CB_WITH_KEYS = "putSharedKeyFilesCbWithKeys";
    public static final String SET_SHARED_KEYS_DATA_MAPPING = "setSharedKeysDataMapping";
    public static final String GET_SHARED_KEYS_DATA_MAPPING = "getSharedKeysDataMapping";
    public static final String GET_DAILY_SKETCH = "getDailySketch";
    public static final String START_CONTACT_SHIELD_CB = "startContactShieldCb";
    public static final String START_CONTACT_SHIELD = "startContactShield";
    public static final String START_CONTACT_SHIELD_NON_PERSISTENT = "startContactShieldNonPersistent";
    public static final String STOP_CONTACT_SHIELD = "stopContactShield";
    public static final String ON_HAS_CONTACT = "onHasContact";
    public static final String ON_NO_CONTACT = "onNoContact";
    public static final String GET_CONTACT_SHIELD_VERSION = "getContactShieldVersion";
    public static final String GET_DEVICE_CALIBRATION_CONFIDENCE = "getDeviceCalibrationConfidence";
    public static final String IS_SUPPORT_SCANNING_WITHOUT_LOCATION = "isSupportScanningWithoutLocation";
    public static final String GET_STATUS = "getStatus";
    public static final String CLEAR_DATA = "clearData";
    public static final String ENABLE_LOGGER = "enableLogger";
    public static final String DISABLE_LOGGER = "disableLogger";

    private Method() {
    }
}
