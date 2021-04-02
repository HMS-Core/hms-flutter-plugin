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

package com.huawei.hms.flutter.health.modules.blecontroller.utils;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class BleControllerConstants {
    private BleControllerConstants() {
    }

    public static final String BLE_MODULE_NAME = "HMSBleController";

    /**
     * Keys that are used while serialize/deserialize scenarios.
     */
    public static final String DATA_TYPES_KEY = "dataTypes";
    public static final String DEVICE_ADDRESS_KEY = "deviceAddress";
    public static final String DEVICE_NAME_KEY = "deviceName";
    public static final String AVAILABLE_PROFILES_KEY = "availableProfiles";
    public static final String TIMEOUT_SECS_KEY = "timeoutSecs";

    /**
     * Intent Action for the broadcast receiver that will emit the ble device scan callbacks.
     */
    public static final String BLE_SCAN_INTENT_ACTION = "hms.intent.action.auto_recorder_intent";

    public enum BleControllerMethods {
        BEGIN_SCAN("beginScan"),
        DELETE_DEVICE_BY_INFO("deleteDeviceByInfo"),
        DELETE_DEVICE_BY_ADDRESS("deleteDeviceByAddress"),
        END_SCAN("endScan"),
        GET_SAVED_DEVICES("getSavedDevices"),
        SAVE_DEVICE_BY_INFO("saveDeviceByInfo"),
        SAVE_DEVICE_BY_ADDRESS("saveDeviceByAddress");

        private String name;
        private static final Map<String, BleControllerMethods> ENUM_MAP;

        BleControllerMethods(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        static {
            Map<String, BleControllerMethods> map = new HashMap<>();
            for (BleControllerMethods instance : BleControllerMethods.values()) {
                map.put(instance.getName(), instance);
            }
            ENUM_MAP = Collections.unmodifiableMap(map);
        }

        public static BleControllerMethods get(String name) {
            return ENUM_MAP.get(name);
        }
    }
}
