/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mlbody.data;

import android.util.Log;

import java.util.ArrayList;

public class FromMap {
    private static final String TAG = "FromMap";

    public static String toString(String key, Object value, boolean canBeEmpty) {
        if (!(value instanceof String) || ((String) value).isEmpty() && !canBeEmpty) {
            Log.w(TAG, "toString | Non-empty String expected for " + key);
            return null;
        }
        return (String) value;
    }

    public static ArrayList<String> toStringArrayList(String key, Object value) {
        ArrayList<String> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value).toArray();
            for (Object o : objArr) {
                if (o instanceof String) {
                    arrList.add(o.toString());
                } else {
                    Log.w(TAG, "toStringArrayList | String value expected for " + key);
                }
            }
        } else {
            Log.w(TAG, "toStringArrayList | List expected for " + key);
        }
        return arrList;
    }

    public static Boolean toBoolean(String key, Object value) {
        if (!(value instanceof Boolean)) {
            Log.w(TAG, "toBoolean | Boolean value expected for " + key + ". Returning false as default.");
            return false;
        }
        return (Boolean) value;
    }

    public static Long toLong(String key, Object value) {
        if (value instanceof Long) {
            return (Long) value;
        } else if (value instanceof Integer) {
            return ((Integer) value).longValue();
        } else if (value instanceof Double) {
            return ((Double) value).longValue();
        } else {
            Log.w(TAG, "toLong | Long value expected for " + key);
            return null;
        }
    }

    public static Integer toInteger(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w(TAG, "toInteger | Integer value expected for " + key);
            return null;
        }
        return (Integer) value;
    }
}
