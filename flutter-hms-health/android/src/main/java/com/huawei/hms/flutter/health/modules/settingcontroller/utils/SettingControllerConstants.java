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

package com.huawei.hms.flutter.health.modules.settingcontroller.utils;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class SettingControllerConstants {
    public static final String SETTING_CONTROLLER_MODULE = "HMSSettingController";

    private SettingControllerConstants() {
    }

    public enum SettingControllerMethods {
        ADD_DATA_TYPE("addDataType"),
        READ_DATA_TYPE("readDataType"),
        DISABLE_HI_HEALTH("disableHiHealth"),
        CHECK_HEALTH_APP_AUTHORIZATION("checkHealthAppAuthorization"),
        GET_HEALTH_APP_AUTHORIZATION("getHealthAppAuthorization"),
        // Consents Controller Methods
        GET("get"),
        REVOKE("revoke"),
        REVOKE_WITH_SCOPES("revokeWithScopes"),
        CANCEL_AUTHORIZATION("cancelAuthorization"),
        CANCEL_AUTHORIZATION_WITH_SCOPES("cancelAuthorizationWithScopes"),
        GET_APP_ID("getAppId"),
        // HMSLogger
        ENABLE_LOGGER("enableLogger"),
        DISABLE_LOGGER("disableLogger"),
        REQUEST_AUTHORIZATION_INTENT("requestAuthorizationIntent");

        private static final Map<String, SettingControllerMethods> ENUM_MAP;

        static {
            Map<String, SettingControllerMethods> map = new HashMap<>();
            for (SettingControllerMethods instance : SettingControllerMethods.values()) {
                map.put(instance.getName(), instance);
            }
            ENUM_MAP = Collections.unmodifiableMap(map);
        }

        private String name;

        SettingControllerMethods(String name) {
            this.name = name;
        }

        public static SettingControllerMethods get(String name) {
            return ENUM_MAP.get(name);
        }

        public String getName() {
            return name;
        }
    }
}
