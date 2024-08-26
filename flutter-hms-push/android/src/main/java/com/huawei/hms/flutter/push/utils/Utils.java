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

package com.huawei.hms.flutter.push.utils;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.Nullable;

import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.NotificationConstants;
import com.huawei.hms.flutter.push.constants.PushIntent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.io.InvalidClassException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * class Utils
 *
 * @since 4.0.4
 */
public class Utils {

    private Utils() {
        throw new IllegalStateException("Utility class");
    }

    private static final String TAG = "FlutterHmsUtils";

    public static boolean isEmpty(Object str) {
        return str == null || str.toString().trim().length() == 0;
    }

    public static String getStringArgument(MethodCall call, String argument) {
        return Utils.isEmpty(call.argument(argument)) ? "" : (String) call.argument(argument);
    }

    public static boolean getBoolArgument(MethodCall call, String argument) {
        try {
            return Objects.requireNonNull(call.argument(argument));
        } catch (Exception e) {
            return false;
        }
    }

    public static double getDoubleArgument(MethodCall call, String argument) {
        try {
            if (call.argument(argument) instanceof Double) {
                return Objects.requireNonNull(call.argument(argument));
            } else if (call.argument(argument) instanceof Long) {
                Long l = Objects.requireNonNull(call.argument(argument));
                return l.doubleValue();
            } else if (call.argument(argument) instanceof Integer) {
                Integer i = (Objects.requireNonNull(call.argument(argument)));
                return i.doubleValue();
            } else if (call.argument(argument) instanceof String) {
                return Double.parseDouble(Objects.requireNonNull(call.argument(argument)));
            } else {
                throw new InvalidClassException("Invalid Type! Valid class types are Double, Int, Long, String");
            }
        } catch (Exception e) {
            Log.d(TAG, "Error while parsing Double: " + e.getMessage() + " ...Returning default value (0.0)");
            return 0.0;
        }
    }

    public static Map<String, Object> getMapArgument(MethodCall call, String argument) {
        if (!call.hasArgument(argument)) {
            return new HashMap<>();
        }
        Map<String, Object> resMap = new HashMap<>();
        if (call.argument(argument) instanceof Map) {
            for (Object entry : ((Map<?, ?>) Objects.requireNonNull(call.argument(argument))).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry<?, ?>) entry).getKey().toString(), ((Map.Entry<?, ?>) entry).getValue());
                }
            }
        }
        return resMap;
    }

    public static void sendIntent(@Nullable Context context, PushIntent action, PushIntent extraName, String result) {
        if (context != null) {
            Intent intent = new Intent();
            intent.setPackage(context.getPackageName());
            intent.setAction(action.id());
            intent.putExtra(extraName.id(), result);
            LocalBrdMnger.getInstance(context).sendBroadcast(intent);
        }
    }

    /**
     * Checks if the intent is a tapped notification.
     *
     * @param intent The intent object to be checked.
     * @return true if the intent is identified as a notification, false otherwise.
     */
    public static boolean checkNotificationFlags(Intent intent) {
        int flagNumber = Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_RECEIVER_REPLACE_PENDING
            | Intent.FLAG_ACTIVITY_REORDER_TO_FRONT;
        int flagNumberAndBroughtToFront = flagNumber | Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT;
        return intent.getFlags() == flagNumber || intent.getFlags() == flagNumberAndBroughtToFront
            || intent.getBundleExtra(NotificationConstants.NOTIFICATION) != null || intent.getDataString() != null;
    }

    public static void handleSuccessOnUIThread(final MethodChannel.Result result) {
        new Handler(Looper.getMainLooper()).post(() -> result.success(Code.RESULT_SUCCESS.code()));
    }

    public static void handleErrorOnUIThread(final MethodChannel.Result result, final String errorCode,
        final String errorMessage, final String errorDetails) {
        new Handler(Looper.getMainLooper()).post(
            () -> result.error(errorCode, errorMessage, errorDetails != null ? errorDetails : ""));
    }
}
