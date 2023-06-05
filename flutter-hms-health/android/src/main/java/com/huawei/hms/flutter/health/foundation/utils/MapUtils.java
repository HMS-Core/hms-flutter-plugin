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

package com.huawei.hms.flutter.health.foundation.utils;

import static com.huawei.hms.flutter.health.foundation.constants.Constants.IS_SUCCESS_KEY;

import androidx.annotation.Nullable;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public final class MapUtils {
    private static final Gson GSON = createGson();

    private MapUtils() {
    }

    /**
     * Converts Map to a requested generic instance.
     *
     * @return <T> instance.
     */
    public static <T> T toObject(final Map<String, Object> callMap, Class<? extends T> type) {
        T instance;
        JSONObject jsonObject = toJson(callMap);
        instance = fromJson(jsonObject.toString(), type);
        return instance;
    }

    /**
     * Converts an Object to a Map.
     *
     * @param instance T instance.
     * @param <T> Generic class type.
     * @return Result Map for Flutter.
     */
    public static <T> Map<String, Object> toResultMap(final @Nullable T instance, final @Nullable Boolean isSuccess) {
        Map<String, Object> resultMap = new HashMap<>();
        if (instance != null) {
            String jsonStr = GSON.toJson(instance);
            try {
                JSONObject jsonObj = new JSONObject(jsonStr);
                resultMap = toResultMap(jsonObj, isSuccess);
            } catch (Exception exception) {
                ExceptionHandler.INSTANCE.fail(exception);
            }
        }

        return addIsSuccess(resultMap, isSuccess);
    }

    /**
     * Converts an Object to a Map.
     *
     * @param message String instance.
     * @return Result Map to send to Flutter Platform.
     */
    public static Map<String, Object> toResultMapWithMessage(final String message, final @Nullable Boolean isSuccess) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg", message);
        if (isSuccess != null) {
            return addIsSuccess(resultMap, isSuccess);
        }

        return resultMap;
    }

    /**
     * Adds isSuccess value to an empty or already initialized Map instance.
     *
     * @param map Map<String, Object> instance, that can either be null or already initialized.
     * @param isSuccess Boolean Value.
     * @return Map<String, Object> instance.
     */
    public static Map<String, Object> addIsSuccess(@Nullable Map<String, Object> map,
        final @Nullable Boolean isSuccess) {
        if (map == null) {
            map = new HashMap<>();
        }
        if (isSuccess != null) {
            map.put(IS_SUCCESS_KEY, isSuccess);
        }
        return map;
    }

    /**
     * Converts a String formatted JSON to a requested object.
     *
     * @param json String value that represents json object in string format.
     * @param type Requested class type.
     * @param <T> Generic class type.
     * @return Requested Instance.
     */
    public static <T> T fromJson(final String json, final Class<T> type) {
        return GSON.fromJson(json, type);
    }

    /**
     * Converts HashMap<String, Object> instance to a JSONObject.
     *
     * @param map HashMap<String, Object> instance.
     * @return JSONObject.
     */
    public static JSONObject toJson(final Map<String, Object> map) {
        JSONObject object;
        if (map == null) {
            return new JSONObject();
        }
        object = new JSONObject(map);
        return object;
    }

    /**
     * Creates Gson instance.
     *
     * @return Gson
     */
    public static Gson createGson() {
        final GsonBuilder builder = new GsonBuilder();
        builder.serializeNulls();
        return builder.create();
    }

}
