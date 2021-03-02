/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.gameservice.common.utils;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Pair;

import io.flutter.plugin.common.MethodCall;

import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

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
            throw new IllegalArgumentException("String argument " + key + " is null or empty.");
        }
    }

    public static boolean getBoolean(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Boolean) {
            return (Boolean) value;
        }
        return false;
    }

    public static Integer getInteger(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        throw new IllegalArgumentException("Integer argument " + key + " is null or empty.");
    }

    public static Integer getOptionalInteger(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        return null;
    }

    public static long getLong(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException("Long argument " + key + " is null or empty.");
        }
    }

    public static long getLong(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException("Long argument " + key + " is null or empty.");
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

    public static Pair<String, String> methodNameExtractor(final MethodCall call) {
        final String[] methodCallParts = call.method.split(Pattern.quote("."));
        if (methodCallParts.length > 0) {
            // First is module name second is method name.
            return new Pair<>(methodCallParts[0], methodCallParts[1]);
        }
        return new Pair<>("", "");
    }

    public static Pair<String, String> methodNameExtractor(final String methodName) {
        final String[] methodCallParts = methodName.split(Pattern.quote("."));
        if (methodCallParts.length > 0) {
            // First is module name second is method name.
            return new Pair<>(methodCallParts[0], methodCallParts[1]);
        }
        return new Pair<>("", "");
    }

    public static int getInt(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static boolean hasKey(final Map<String, Object> map, final String key) {
        if (map == null) {
            return false;
        }
        return map.containsKey(key);
    }

    public static Bitmap getBitmapFromBytes(final Map<String, Object> map, final String key) {
        byte[] parsed = (byte[]) map.get(key);
        if (parsed != null) {
            return BitmapFactory.decodeByteArray(parsed, 0, parsed.length);
        }
        throw new InvalidParameterException("Invalid byte array for bitmap");
    }
}