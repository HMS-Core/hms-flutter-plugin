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

package com.huawei.hms.flutter.push.utils;

import android.content.Intent;
import android.util.Log;

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.constants.PushIntent;

import java.io.InvalidClassException;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;

/**
 * class Utils
 *
 * @since 4.0.4
 */
public class Utils {

    private Utils() {
        throw new IllegalStateException("Utility class");
    }

    private static String TAG = "FlutterHmsUtils";

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

    public static void sendIntent(PushIntent action, PushIntent extraName, String result) {
        Intent intent = new Intent();
        intent.setPackage(PushPlugin.getContext().getPackageName());
        intent.setAction(action.id());
        intent.putExtra(extraName.id(), result);
        PushPlugin.getContext().sendBroadcast(intent);
    }

}
