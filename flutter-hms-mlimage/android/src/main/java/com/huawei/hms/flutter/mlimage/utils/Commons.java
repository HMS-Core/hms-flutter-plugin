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

package com.huawei.hms.flutter.mlimage.utils;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Rect;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.LensEngine;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class Commons {
    private static final String TAG = Commons.class.getSimpleName();

    public static Bitmap bitmapFromPath(String path) {
        return BitmapFactory.decodeFile(path);
    }

    public static int[] convertIntegers(List<Integer> integers) {
        int[] ret = new int[integers.size()];
        for (int i = 0; i < ret.length; i++) {
            ret[i] = integers.get(i);
        }
        return ret;
    }

    public static byte[] bitmapToByteArray(Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

    public static void success(Activity activity, String loggerTag, MethodChannel.Result result, Object object) {
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerTag);
        result.success(object);
    }

    public static void captureImageFromLens(Activity activity, LensEngine lensEngine, MethodChannel.Result result) {
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureImageFromLens", "-1");
            result.error(TAG, "Lens engine is null", "-1");
            return;
        }
        lensEngine.photograph(() -> Log.i(TAG, "clicked"), bytes -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureImageFromLens");
            result.success(bytes);
        });
    }

    public static Map<String, Object> createBorderMap(@NonNull Rect rect) {
        Map<String, Object> map = new HashMap<>();
        map.put("top", rect.top);
        map.put("left", rect.left);
        map.put("right", rect.right);
        map.put("bottom", rect.bottom);
        return map;
    }
}