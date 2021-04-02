/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.utils;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;

import com.google.gson.Gson;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.LensEngine;
import com.huawei.hms.mlsdk.common.MLException;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import io.flutter.plugin.common.MethodChannel;

public class HmsMlUtils {
    private static final String TAG = HmsMlUtils.class.getSimpleName();

    public static void sendSuccessResult(Activity activity, String loggerTag, MethodChannel.Result result, Object object) {
        Gson gson = new Gson();
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerTag);
        result.success(gson.toJson(object));
    }

    public static void handleException(Activity activity, String tag, Exception e, String loggerTag, MethodChannel.Result result) {
        if (e instanceof MLException) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerTag, String.valueOf(((MLException) e).getErrCode()));
            result.error(tag, e.getMessage(), ((MLException) e).getErrCode());
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerTag, e.getMessage());
            result.error(tag, e.getMessage(), "");
        }
    }

    public static Bitmap getARGB8888(String path) {
        final String encodedImage = pathToBase64(path);
        final byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        final Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        return bitmap.copy(Bitmap.Config.ARGB_8888, true);
    }

    public static String saveBitmapAndGetPath(Context inContext, Bitmap inImage) {
        if (inImage != null) {
            ByteArrayOutputStream bytes = new ByteArrayOutputStream();
            inImage.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
            return MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage, Long.toString(Calendar.getInstance().getTimeInMillis()), null);
        }
        return "No path";
    }

    public static String pathToBase64(String path) {
        Bitmap bt = BitmapFactory.decodeFile(path);
        ByteArrayOutputStream bs = new ByteArrayOutputStream();
        bt.compress(Bitmap.CompressFormat.JPEG, 100, bs);
        byte[] by = bs.toByteArray();
        return Base64.encodeToString(by, Base64.DEFAULT);
    }

    public static Set<String> getStringSet(List<String> stringList) {
        List<String> list = new ArrayList<>(stringList);
        return new HashSet<>(list);
    }

    public static List<Float> getArrayFromFloats(Float[] f) {
        return new ArrayList<>(Arrays.asList(f));
    }

    public static void captureImageFromLens(Activity activity, LensEngine lensEngine, MethodChannel.Result result) {
        if (lensEngine == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureImageFromLens", MlConstants.UNINITIALIZED_ANALYZER);
            result.error(TAG, "Lens engine is null", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        lensEngine.photograph(() -> Log.i(TAG, "clicked"), bytes -> {
            Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureImageFromLens");
            result.success(MediaStore.Images.Media.insertImage(activity.getApplicationContext().getContentResolver(), bitmap, "Title", "Desc"));
        });
    }
}