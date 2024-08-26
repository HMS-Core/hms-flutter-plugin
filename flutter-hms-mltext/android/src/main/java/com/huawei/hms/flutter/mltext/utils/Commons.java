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

package com.huawei.hms.flutter.mltext.utils;

import android.app.Activity;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Rect;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.text.TextLanguage;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.plugin.common.MethodChannel;

public class Commons {
    public static Bitmap bitmapFromPath(String path) {
        return BitmapFactory.decodeFile(path);
    }

    public static byte[] bitmapToByteArray(Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

    public static Set<String> getStringSet(List<String> stringList) {
        List<String> list = new ArrayList<>(stringList);
        return new HashSet<>(list);
    }

    public static List<Float> getArrayFromFloats(Float[] f) {
        return new ArrayList<>(Arrays.asList(f));
    }

    public static Map<String, Object> createBorderMap(@NonNull Rect rect) {
        Map<String, Object> map = new HashMap<>();
        map.put(Param.TOP, rect.top);
        map.put(Param.LEFT, rect.left);
        map.put(Param.RIGHT, rect.right);
        map.put(Param.BOTTOM, rect.bottom);
        return map;
    }

    public static ArrayList<Map<String, Object>> textLanguagesToMap(@NonNull List<TextLanguage> languages) {
        ArrayList<Map<String, Object>> langList = new ArrayList<>();
        for (int i = 0; i < languages.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            TextLanguage language = languages.get(i);
            map.put(Param.LANGUAGE, language.getLanguage());
            langList.add(map);
        }
        return langList;
    }

    public static void captureImageFromLens(Activity activity, LensEngine lensEngine, MethodChannel.Result result) {
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(Method.LENS_CAPTURE,
                    CallbackTypes.NOT_INITIALIZED);
            result.error(CallbackTypes.LENS_CAPTURE, CallbackTypes.LENS_IS_NULL, CallbackTypes.NOT_INITIALIZED);
            return;
        }
        lensEngine.photograph(() -> Log.i(CallbackTypes.LENS_CAPTURE, Param.CLICKED), bytes -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(Method.LENS_CAPTURE);
            result.success(bytes);
        });
    }
}