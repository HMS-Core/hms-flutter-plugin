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

package com.huawei.hms.flutter.analytics.utils;

import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public final class MapUtils {

    private MapUtils() {
    }

    private static final String TAG = "MapUtils";

    /**
     * Converts an Object into a String.
     *
     * @param key: String key.
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
     * @param key: String key.
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
     * @param key: String key.
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
            for (Map.Entry<?, ?> entry : ((Map<?, ?>) args).entrySet()) {
                if (entry != null) {
                    resMap.put(entry.getKey().toString(), entry.getValue());
                }
            }
        }
        return resMap;
    }

    public static Bundle mapToBundle(@Nullable Map<String, Object> map, boolean isNested) {
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
            } else if (val instanceof Integer) {
                bundle.putInt(key, (Integer) val);
            } else if (val instanceof Long) {
                bundle.putLong(key, (Long) val);
            } else if (val instanceof Double) {
                bundle.putDouble(key, (Double) val);
            } else if (val instanceof Boolean) {
                bundle.putBoolean(key, (Boolean) val);
            } else if (val instanceof Map) {
                if (!isNested) {
                    bundle.putBundle(key, mapToBundle(MapUtils.objectToMap(val), true));
                } else {
                    Log.e(TAG, "Illegal value type. Key :" + key + ", only one nested bundle structure is allowed.");
                }
            } else if (val instanceof List) {
                if(((List<?>) val).size() != 0) {
                    handleList(bundle, key, (List<?>) val);
                } else {
                    Log.e(TAG, "Illegal value type. Key:" + key + ", must not be empty.");
                }
            } else {
                throw new IllegalArgumentException(
                    "Illegal value type. Key :" + key + ", valueType : " + val.getClass().getSimpleName());
            }
        }
        return bundle;
    }

    private static <T> ArrayList<T> toArrayList(List<T> list) {
        return new ArrayList<>(list);
    }

    public static List<Integer> toIntegerList(Object value) {
        ArrayList<Integer> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList<?>) value).toArray();
            for (Object o : objArr) {
                if (o instanceof Integer) {
                    arrList.add((Integer) o);
                } else {
                    Log.w(TAG, "toIntegerList | Unexpected type in list");
                }
            }

        } else {
            Log.w(TAG, "toIntegerList | A list was expected");
        }
        return arrList;
    }

    public static List<String> toStringList(Object value) {
        ArrayList<String> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList<?>) value).toArray();
            for (Object o : objArr) {
                if (o instanceof String) {
                    arrList.add(o.toString());
                } else {
                    Log.w(TAG, "toStringList |  Unexpected type in list");
                }
            }

        } else {
            Log.w(TAG, "toStringList | A list was expected");
        }
        return arrList;
    }

    private static void handleList(Bundle bundle, String key, List<?> val) {
        switch (val.get(0).getClass().getSimpleName()) {
            case "String":
                bundle.putStringArrayList(key, toArrayList(toStringList(val)));
                break;
            case "Integer":
                bundle.putIntegerArrayList(key, toArrayList(toIntegerList(val)));
                break;
            case "HashMap":
                ArrayList<Bundle> bundles = new ArrayList<>();
                for (int i = 0; i < val.size(); i++) {
                    bundles.add(mapToBundle(objectToMap(val.get(i)), true));
                }
                bundle.putParcelableArrayList(key, bundles);
                break;
            default:
                throw new IllegalArgumentException(
                    "inner Illegal value type. Key :" + key + ", valueType : " + val.getClass().getSimpleName());
        }
    }
}
