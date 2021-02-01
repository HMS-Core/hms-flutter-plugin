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

package com.huawei.hms.flutter.analytics.utils;

import android.os.Bundle;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class MapUtils {
    private static final String TAG = "MapUtils";

    /**
     * Converts a Object into a String.
     *
     * @param key:   String key.
     * @param value: Object value.
     * @return value
     */
    public static String getString(String key, Object value) {
        if (!(value instanceof String)) {
            Log.w(TAG, "toString | String value expected for " + key + ". ");
            return "";
        }
        return (String) value;
    }

    /**
     * Converts a Object into a Boolean.
     *
     * @param key:   String key.
     * @param value: Object value.
     * @return value
     */
    public static Boolean toBoolean(String key, Object value) {
        if (!(value instanceof Boolean)) {
            Log.w(TAG, "toBoolean | Boolean value expected for " + key + ". Returning false as default.");
            return false;
        }
        return (Boolean) value;
    }

    /**
     * Converts a Object into a Long.
     *
     * @param key:   String key.
     * @param value: Object value.
     * @return value
     */
    public static Long toLong(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w(TAG, "toLong | Long value expected for " + key);
            return null;
        }
        return ((Integer) value).longValue();
    }

    public static Map<String, Object> objectToMap(Object args) {
        Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry) entry).getKey().toString(), ((Map.Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    public static Bundle mapToBundle(Map<String, Object> map) {
        Bundle bundle = new Bundle();

        if (map == null) {
            return bundle;
        }

        Set<Map.Entry<String, Object>> entries = map.entrySet();
        for (Map.Entry<String, Object> entry : entries) {
            String key = entry.getKey();
            Object val = entry.getValue();

            if (val instanceof String) {
                bundle.putString(key, (String) val);
            } else if (val instanceof Boolean) {
                bundle.putBoolean(key, (Boolean) val);
            } else if (val instanceof Integer) {
                bundle.putInt(key, (Integer) val);
            } else if (val instanceof Long) {
                bundle.putLong(key, (Long) val);
            } else if (val instanceof Double) {
                bundle.putDouble(key, (Double) val);
            } else {
                throw new IllegalArgumentException(
                    "Illegal value type. Key :" + key + ", valueType : " + val.getClass().getSimpleName());
            }
        }
        return bundle;
    }
}
