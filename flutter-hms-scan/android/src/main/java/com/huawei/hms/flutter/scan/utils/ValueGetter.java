/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.scan.utils;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.ml.scan.HmsScanAnalyzer;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;

import java.util.List;

public class ValueGetter {
    public static int getInt(String key, MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static float getFloat(String key, MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Number) {
            return ((Number) value).floatValue();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static String getString(String key, MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static Boolean getBoolean(String key, MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Boolean) {
            return (Boolean) value;
        } else {
            throw new IllegalArgumentException();
        }
    }

    public static int[] scanTypesListToArray(List<Integer> additionalScanTypes) {
        int[] scanTypesIntArray = new int[additionalScanTypes.size()];
        for (int i = 0; i < additionalScanTypes.size(); i++) {
            scanTypesIntArray[i] = additionalScanTypes.get(i);
        }
        return scanTypesIntArray;
    }

    public static HmsScanAnalyzer analyzerForMultiDecoders(MethodCall call, Activity mActivity) {
        // Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int[] scanTypesIntArray = null;

        // List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        // Analyzer options
        return new HmsScanAnalyzer.Creator(mActivity).setHmsScanTypes(scanType, scanTypesIntArray).create();
    }

    public static Bitmap bitmapForDecoders(MethodCall call, String key) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String data = ValueGetter.getString(key, call);

        // Build bitmap from data
        byte[] parsed = gson.fromJson(data, byte[].class);
        return BitmapFactory.decodeByteArray(parsed, 0, parsed.length);
    }

    public static boolean analyzerIsAvailableWithLogger(Context context, HmsScanAnalyzer analyzer, String className) {
        HMSLogger mHmsLogger = HMSLogger.getInstance(context);
        mHmsLogger.startMethodExecutionTimer(className + ".analyzer.isAvailable");
        boolean status = analyzer.isAvailable();
        mHmsLogger.sendSingleEvent(className + ".analyzer.isAvailable");
        return status;
    }

    public static void analyzerDestroyWithLogger(Context context, HmsScanAnalyzer analyzer, String className) {
        HMSLogger mHmsLogger = HMSLogger.getInstance(context);
        mHmsLogger.startMethodExecutionTimer(className + ".analyzer.destroy");
        analyzer.destroy();
        mHmsLogger.sendSingleEvent(className + ".analyzer.destroy");
    }
}
