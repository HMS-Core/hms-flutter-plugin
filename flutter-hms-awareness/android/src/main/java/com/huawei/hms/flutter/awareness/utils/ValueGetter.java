/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.awareness.utils;

import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import io.flutter.plugin.common.MethodCall;

public class ValueGetter {
    public static int getInt(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static int getInt(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static String getString(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException();
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

    public static Boolean getBoolean(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Boolean) {
            return (Boolean) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static Boolean getBoolean(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Boolean) {
            return (Boolean) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static double getDouble(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static double getDouble(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static long getLong(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static long getLong(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static float getFloat(final String key, final Map<String, Object> args) {
        final Object value = args.get(key);
        if (value instanceof Number) {
            return ((Number) value).floatValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static int[] behaviorTypesListToArray(final List<Integer> behaviorTypesIntList) {
        final int[] behaviorTypesIntArray = new int[behaviorTypesIntList.size()];
        for (int i = 0; i < behaviorTypesIntList.size(); i++) {
            behaviorTypesIntArray[i] = behaviorTypesIntList.get(i);
        }
        return behaviorTypesIntArray;
    }

    public static TimeZone getTimeZone(final String key, final Map<String, Object> args) {
        final TimeZone preferredTimeZone;
        final String timeZone = (String) args.get(key);
        if (timeZone != null) {
            preferredTimeZone = TimeZone.getTimeZone(timeZone);
        } else {
            preferredTimeZone = TimeZone.getDefault();
        }
        return preferredTimeZone;
    }
}
