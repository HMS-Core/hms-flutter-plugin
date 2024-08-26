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

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Rect;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.constant.Constants;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLFrame;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class Commons {
    public static Map<String, Object> createBorderMap(@NonNull Rect rect) {
        Map<String, Object> map = new HashMap<>();
        map.put("top", rect.top);
        map.put("left", rect.left);
        map.put("right", rect.right);
        map.put("bottom", rect.bottom);
        return map;
    }

    public static byte[] bitmapToByteArray(Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

    public static Bitmap bitmapFromPath(String path) {
        return BitmapFactory.decodeFile(path);
    }

    public static MLFrame frameFromBitmap(String path) {
        Bitmap bt = bitmapFromPath(path);
        return MLFrame.fromBitmap(bt);
    }

    public static void captureImageFromLens(Activity activity, LensEngine lensEngine, MethodChannel.Result result) {
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("lens#capture", Constants.NOT_INITIALIZED);
            result.error("Lens capture", "Lens engine is null", Constants.NOT_INITIALIZED);
            return;
        }
        lensEngine.photograph(() -> Log.i("Lens capture", "clicked"), bytes -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("lens#capture");
            result.success(bytes);
        });
    }
}
