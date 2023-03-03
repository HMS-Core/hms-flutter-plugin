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

package com.huawei.hms.flutter.dtm.helpers;

import android.os.Bundle;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class MapUtils {
    public static Map<String, Object> objectToMap(final Object args) {
        final Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (final Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Entry) {
                    resMap.put(((Entry) entry).getKey().toString(), ((Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    public static Bundle mapToBundle(final Map<String, Object> map) {
        final Bundle bundle = new Bundle();

        if (map != null) {
            final Set<Entry<String, Object>> entries = map.entrySet();
            for (final Map.Entry<String, Object> entry : entries) {
                final String key = entry.getKey();
                final Object val = entry.getValue();

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
                    throw new IllegalArgumentException("Illegal value type. Key :" + key + ", valueType : " + val.getClass().getSimpleName());
                }
            }
        }
        return bundle;
    }
}
