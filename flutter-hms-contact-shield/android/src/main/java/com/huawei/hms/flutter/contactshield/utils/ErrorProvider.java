/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.contactshield.utils;

import com.huawei.hms.flutter.contactshield.constants.Method;

import java.util.HashMap;
import java.util.Map;

public final class ErrorProvider {
    private static final Map<String, String> ERROR_MAP = new HashMap<>();

    static {
        ERROR_MAP.put(Method.IS_CONTACT_SHIELD_RUNNING, "IS_CONTACT_SHIELD_RUNNING_ERROR");
        ERROR_MAP.put(Method.START_CONTACT_SHIELD_OLD, "START_CONTACT_SHIELD_OLD_ERROR");
        ERROR_MAP.put(Method.START_CONTACT_SHIELD, "START_CONTACT_SHIELD_ERROR");
        ERROR_MAP.put(Method.START_CONTACT_SHIELD_NON_PERSISTENT, "START_CONTACT_SHIELD_NO_PERSISTENT_ERROR");
        ERROR_MAP.put(Method.GET_PERIODIC_KEY, "GET_PERIODIC_KEY_ERROR");
        ERROR_MAP.put(Method.PUT_SHARED_KEY_FILES_OLD, "PUT_SHARED_KEY_FILES_OLD_ERROR");
        ERROR_MAP.put(Method.PUT_SHARED_KEY_FILES, "PUT_SHARED_KEY_FILES_ERROR");
        ERROR_MAP.put(Method.GET_CONTACT_DETAIL, "GET_CONTACT_DETAIL_ERROR");
        ERROR_MAP.put(Method.GET_CONTACT_SKETCH, "GET_CONTACT_SKETCH_ERROR");
        ERROR_MAP.put(Method.GET_CONTACT_WINDOW, "GET_CONTACT_WINDOW_ERROR");
        ERROR_MAP.put(Method.CLEAR_DATA, "CLEAR_DATA_ERROR");
        ERROR_MAP.put(Method.STOP_CONTACT_SHIELD, "STOP_CONTACT_SHIELD_ERROR");
    }

    private ErrorProvider() {
    }

    public static String getErrorCode(final String methodName) {
        return ERROR_MAP.get(methodName);
    }
}
