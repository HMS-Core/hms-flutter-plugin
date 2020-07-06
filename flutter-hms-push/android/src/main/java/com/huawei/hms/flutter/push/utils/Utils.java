/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.push.utils;

import android.content.Intent;

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.constants.PushIntent;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;

/**
 * class Utils
 *
 * @since 4.0.4
 */
public class Utils {

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

    public static void sendIntent(PushIntent action, PushIntent extraName, String result) {
        Intent intent = new Intent();
        intent.setAction(action.id());
        intent.putExtra(extraName.id(), result);
        PushPlugin.getContext().sendBroadcast(intent);
    }
}
