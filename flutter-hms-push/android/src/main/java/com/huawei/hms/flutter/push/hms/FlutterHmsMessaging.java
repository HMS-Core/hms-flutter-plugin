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

package com.huawei.hms.flutter.push.hms;

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.push.HmsMessaging;

import io.flutter.plugin.common.MethodChannel.Result;

/**
 * class FlutterHmsMessaging
 *
 * @since 4.0.4
 */
public class FlutterHmsMessaging {

    public static void turnOnPush(final Result result) {
        try {
            HmsMessaging.getInstance(PushPlugin.getContext()).turnOnPush().addOnCompleteListener(
                    task -> {
                        if (task.isSuccessful()) {
                            result.success(Code.RESULT_SUCCESS.code());
                        } else {
                            result.error(Code.RESULT_FAIL.code(), task.getException().getMessage(), task.getException().getCause());
                        }
                    });
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

    public static void turnOffPush(final Result result) {
        try {
            HmsMessaging.getInstance(PushPlugin.getContext()).turnOffPush().addOnCompleteListener(
                    task -> {
                        if (task.isSuccessful()) {
                            result.success(Code.RESULT_SUCCESS.code());
                        } else {
                            result.error(Code.RESULT_FAIL.code(), task.getException().getMessage(), task.getException().getCause());
                        }
                    }
            );
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

    public static void subscribe(String topic, final Result result) {
        if (Utils.isEmpty(topic)) {
            result.error(Code.PARAMETER_IS_EMPTY.code(), "topic is empty!", "topic is empty!");
            return;
        }
        try {
            HmsMessaging.getInstance(PushPlugin.getContext()).subscribe(topic).addOnCompleteListener(
                    task -> {
                        if (task.isSuccessful()) {
                            result.success(Code.RESULT_SUCCESS.code());
                        } else {
                            result.error(Code.RESULT_FAIL.code(), task.getException().getMessage(), task.getException().getCause());
                        }
                    }
            );
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

    public static void unsubscribe(String topic, final Result result) {
        if (Utils.isEmpty(topic)) {
            result.error(Code.PARAMETER_IS_EMPTY.code(), "topic is empty!", "topic is empty!");
            return;
        }
        try {
            HmsMessaging.getInstance(PushPlugin.getContext()).unsubscribe(topic).addOnCompleteListener(
                    task -> {
                        if (task.isSuccessful()) {
                            result.success(Code.RESULT_SUCCESS.code());
                        } else {
                            result.error(Code.RESULT_FAIL.code(), task.getException().getMessage(), task.getException().getCause());
                        }
                    }
            );
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

    public static void setAutoInitEnabled(boolean enabled, final Result result) {
        try {
            HmsMessaging.getInstance(PushPlugin.getContext()).setAutoInitEnabled(enabled);
            result.success(Code.RESULT_SUCCESS.code());
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

    public static void isAutoInitEnabled(final Result result) {
        try {
            String autoInit = String.valueOf(HmsMessaging.getInstance(PushPlugin.getContext()).isAutoInitEnabled());
            boolean val = Boolean.parseBoolean(autoInit);
            result.success(val);
        } catch (Exception e) {
            result.error(Code.RESULT_FAIL.code(), e.getMessage(), e.getCause());
        }
    }

}
