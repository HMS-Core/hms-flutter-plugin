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

package com.huawei.hms.flutter.ads.utils;

import android.os.Bundle;
import android.util.Log;

import com.huawei.hms.ads.BiddingParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class FromMap {
    private static final String TAG = "FromMap";

    private static final String INT = "int";

    private static final String INT_LIST = "intList";

    private static final String STRING = "String";

    private static final String STRING_LIST = "StringList";

    private static final String BOOL = "bool";

    private static final String BOOL_LIST = "boolList";

    public static String toString(String key, Object value) {
        if (!(value instanceof String) || ((String) value).isEmpty()) {
            Log.w(TAG, "toString | Non-empty String expected for " + key);
            return null;
        }
        return (String) value;
    }

    public static ArrayList<String> toStringArrayList(String key, Object value) {
        ArrayList<String> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value).toArray();
            if (objArr != null) {
                for (Object o : objArr) {
                    if (o instanceof String) {
                        arrList.add(o.toString());
                    } else {
                        Log.w(TAG, "toStringArrayList | String value expected for " + key);
                    }
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

    private static boolean[] toBooleanArray(String key, Object value) {
        if (value == null) {
            return new boolean[0];
        }
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value).toArray();
            if (objArr != null) {
                boolean[] boolArr = new boolean[objArr.length];
                for (int i = 0; i < objArr.length; i++) {
                    if (objArr[i] instanceof Boolean) {
                        boolArr[i] = (Boolean) objArr[i];
                    } else {
                        Log.w(TAG, "toBooleanArray | Boolean value expected for " + key);
                    }
                }
                return boolArr;
            }
        }
        Log.w(TAG, "getBooleanArray | List expected for " + key);
        return new boolean[0];
    }

    public static Long toLong(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w(TAG, "toLong | Long value expected for " + key);
            return null;
        }
        return ((Integer) value).longValue();
    }

    public static Integer toInteger(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w(TAG, "toInteger | Integer value expected for " + key);
            return null;
        }
        return (Integer) value;
    }

    public static ArrayList<Integer> toIntegerArrayList(String key, Object value) {
        ArrayList<Integer> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value).toArray();
            if (objArr != null) {
                for (Object o : objArr) {
                    if (o instanceof Integer) {
                        arrList.add((Integer) o);
                    } else {
                        Log.w(TAG, "toIntegerArrayList | Integer value expected for " + key);
                    }
                }
            }
        } else {
            Log.w(TAG, "toIntegerArrayList | List expected for " + key);
        }
        return arrList;
    }

    public static Double toDouble(String key, Object value) {
        if (!(value instanceof Double)) {
            Log.w(TAG, "toDouble | Float value expected for " + key);
            return null;
        }
        return (Double) value;
    }

    public static Bundle toBundle(Object args) {
        Map<String, Object> bundleMap = ToMap.fromObject(args);
        Bundle bundle = new Bundle();
        if (bundleMap.isEmpty()) {
            return null;
        }
        for (Map.Entry<String, Object> entry : bundleMap.entrySet()) {
            Map<String, Object> item = ToMap.fromObject(entry.getValue());
            if (item.isEmpty()) {
                Log.w(TAG, "toBundle | Non-empty item expected.");
                continue;
            }

            String type = FromMap.toString("type", item.get("type"));
            if (type == null) {
                Log.w(TAG, "toBundle | Non-null item expected.");
                continue;
            }

            if (!type.contains("List")) {
                addSingle(type, item, entry, bundle);
            } else {
                addList(type, item, entry, bundle);
            }
        }
        return bundle;
    }

    public static HashMap<String, Object> toHashMap(String key, Object value) {
        if (!(value instanceof HashMap)) {
            Log.w(TAG, "toMap | HashMap<String, Object> value expected for " + key);
            return null;
        }
        return (HashMap<String, Object>) value;
    }

    private static void addSingle(String type, Map<String, Object> item, Map.Entry<String, Object> entry,
        Bundle bundle) {
        Integer i;
        String s;
        Boolean b;

        switch (type) {
            case INT:
                i = FromMap.toInteger("val", item.get("val"));
                if (i != null) {
                    bundle.putInt(entry.getKey(), i);
                }
                break;
            case STRING:
                s = FromMap.toString("val", item.get("val"));
                if (s != null && !s.isEmpty()) {
                    bundle.putString(entry.getKey(), s);
                }
                break;
            case BOOL:
                b = FromMap.toBoolean("val", item.get("val"));
                bundle.putBoolean(entry.getKey(), b);
                break;
            default:
                Log.w(TAG, "addSingle | int, string, or bool expected.");
                break;
        }
    }

    private static void addList(String type, Map<String, Object> item, Map.Entry<String, Object> entry, Bundle bundle) {
        ArrayList<Integer> il;
        ArrayList<String> sl;
        boolean[] ba;
        switch (type) {
            case INT_LIST:
                il = FromMap.toIntegerArrayList("val", item.get("val"));
                if (!il.isEmpty()) {
                    bundle.putIntegerArrayList(entry.getKey(), il);
                }
                break;
            case STRING_LIST:
                sl = FromMap.toStringArrayList("val", item.get("val"));
                if (!sl.isEmpty()) {
                    bundle.putStringArrayList(entry.getKey(), sl);
                }
                break;
            case BOOL_LIST:
                ba = FromMap.toBooleanArray("val", item.get("val"));
                if (ba.length != 0) {
                    bundle.putBooleanArray(entry.getKey(), ba);
                }
                break;
            default:
                Log.w(TAG, "addList | int, string, or bool expected.");
                break;
        }
    }

    public static BiddingParam toBiddingParam(Map<String, Object> map) {
        if (map == null) {
            return null;
        }

        BiddingParam.Builder builder = new BiddingParam.Builder();
        builder.setBidFloor(FromMap.toDouble("bidFloor", map.get("bidFloor")) == null
                ? null
                : FromMap.toDouble("bidFloor", map.get("bidFloor")).floatValue())
            .setBidFloorCur(FromMap.toString("bidFloorCur", map.get("bidFloorCur")))
            .setBpkgName(FromMap.toStringArrayList("bpkgName", map.get("bpkgName")));

        return builder.build();

    }
}
