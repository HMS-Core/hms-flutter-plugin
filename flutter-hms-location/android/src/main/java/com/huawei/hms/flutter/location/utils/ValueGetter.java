/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.location.utils;

import java.util.Map;
import java.util.Objects;

class ValueGetter {
    static int getInt(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    static long getLong(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof Number) {
            return ((Number) value).longValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    static float getFloat(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof Number) {
            return ((Number) value).floatValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    static double getDouble(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    static boolean getBoolean(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof Boolean) {
            return (boolean) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    static String getString(final String key, final Map map) {
        final Object value = Objects.requireNonNull(map.get(key));
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException();
        }
    }
}
