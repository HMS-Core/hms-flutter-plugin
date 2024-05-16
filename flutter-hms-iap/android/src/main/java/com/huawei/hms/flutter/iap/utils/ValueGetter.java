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

package com.huawei.hms.flutter.iap.utils;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;

public class ValueGetter {
    private ValueGetter() {
    }

    public static int getInt(final String key, final MethodCall call) {
        final Object value = Objects.requireNonNull(call.argument(key));
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

    public static Boolean getBoolean(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Boolean) {
            return (Boolean) value;
        } else {
            throw new IllegalArgumentException();
        }
    }
}
