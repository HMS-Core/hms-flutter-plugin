/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.common.utils;

import com.huawei.hms.flutter.drive.common.Constants;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;

public final class ValueGetter {

    private ValueGetter() {
    }

    public static String getString(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException("String argument null or empty");
        }
    }

    public static String getString(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static byte[] arrayListToByteArray(final List<Integer> integers) {
        final byte[] bytes = new byte[integers.size()];
        for (int i = 0; i < integers.size(); i++) {
            bytes[i] = integers.get(i).byteValue();
        }
        return bytes;
    }

    public static Optional<Long> getOptionalLong(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return Optional.of(((Number) value).longValue());
        }
        return Optional.empty();
    }

    public static long getLong(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static Map<String, Object> getMap(Object args) {
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

    public static List<Map<String, Object>> toMapList(String key, final Map<String, Object> value) {
        ArrayList<Map<String, Object>> arrList = new ArrayList<>();
        if (value.get(key) instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value.get(key)).toArray();
            for (Object o : objArr) {
                arrList.add(getMap(o));
            }
        } else {
            Log.w(Constants.TAG, "toMapList | List expected for " + key);
        }
        return arrList;
    }

    public static List<Integer> toIntegerList(final String key, final Map<String, Object> value) {
        ArrayList<Integer> arrList = new ArrayList<>();
        if (value.get(key) instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value.get(key)).toArray();
            for (Object o : objArr) {
                if (o instanceof Integer) {
                    arrList.add((Integer) o);
                } else {
                    Log.w(Constants.TAG, "toIntegerList | String value expected for " + key);
                }
            }

        } else {
            Log.w(Constants.TAG, "toIntegerList | List expected for " + key);
        }
        return arrList;
    }
}
