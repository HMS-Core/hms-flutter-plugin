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

package com.huawei.hms.flutter.push.hms;

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.push.HmsMessaging;
import com.huawei.hms.push.RemoteMessage;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * class FlutterHmsMessaging
 *
 * @since 4.0.4
 */
public class FlutterHmsMessaging {

    private static HMSLogger hmsLogger = HMSLogger.getInstance(PushPlugin.getContext());

    public static void turnOnPush(final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("turnOnPush");
            HmsMessaging.getInstance(PushPlugin.getContext()).turnOnPush().addOnCompleteListener(
                task -> {
                    if (task.isSuccessful()) {
                        hmsLogger.sendSingleEvent("turnOnPush");
                        result.success(Code.RESULT_SUCCESS.code());
                    } else {
                        hmsLogger.sendSingleEvent("turnOnPush", Code.RESULT_UNKNOWN.code());
                        result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                                task.getException().getCause());
                    }
                });
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("turnOnPush", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void turnOffPush(final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("turnOffPush");
            HmsMessaging.getInstance(PushPlugin.getContext()).turnOffPush().addOnCompleteListener(
                task -> {
                    if (task.isSuccessful()) {
                        hmsLogger.sendSingleEvent("turnOffPush");
                        result.success(Code.RESULT_SUCCESS.code());
                    } else {
                        hmsLogger.sendSingleEvent("turnOffPush", Code.RESULT_UNKNOWN.code());
                        result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                                task.getException().getCause());
                    }
                }
            );
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("turnOffPush", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void subscribe(String topic, final Result result) {
        if (Utils.isEmpty(topic)) {
            result.error(Code.ERROR_INVALID_PARAMETERS.code(), "topic is empty!", "topic is empty!");
            return;
        }
        try {
            hmsLogger.startMethodExecutionTimer("subscribe");
            HmsMessaging.getInstance(PushPlugin.getContext()).subscribe(topic).addOnCompleteListener(
                task -> {
                    if (task.isSuccessful()) {
                        hmsLogger.sendSingleEvent("subscribe");
                        result.success(Code.RESULT_SUCCESS.code());
                    } else {
                        hmsLogger.sendSingleEvent("subscribe", Code.RESULT_UNKNOWN.code());
                        result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                                task.getException().getCause());
                    }
                }
            );
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("subscribe", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void unsubscribe(String topic, final Result result) {
        if (Utils.isEmpty(topic)) {
            result.error(Code.ERROR_INVALID_PARAMETERS.code(), "topic is empty!", "topic is empty!");
            return;
        }
        try {
            hmsLogger.startMethodExecutionTimer("unsubscribe");
            HmsMessaging.getInstance(PushPlugin.getContext()).unsubscribe(topic).addOnCompleteListener(
                    task -> {
                        if (task.isSuccessful()) {
                            hmsLogger.sendSingleEvent("unsubscribe");
                            result.success(Code.RESULT_SUCCESS.code());
                        } else {
                            hmsLogger.sendSingleEvent("unsubscribe", Code.RESULT_UNKNOWN.code());
                            result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                                    task.getException().getCause());
                        }
                    }
            );
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("unsubscribe", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void setAutoInitEnabled(boolean enabled, final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("setAutoInitEnabled");
            HmsMessaging.getInstance(PushPlugin.getContext()).setAutoInitEnabled(enabled);
            hmsLogger.sendSingleEvent("setAutoInitEnabled");
            result.success(Code.RESULT_SUCCESS.code());
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("setAutoInitEnabled", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void isAutoInitEnabled(final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("isAutoInitEnabled");
            String autoInit = String.valueOf(HmsMessaging.getInstance(PushPlugin.getContext()).isAutoInitEnabled());
            hmsLogger.sendSingleEvent("isAutoInitEnabled");
            boolean val = Boolean.parseBoolean(autoInit);
            result.success(val);
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("isAutoInitEnabled", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public static void sendRemoteMessage(final Result result, MethodCall call) {
        try {
            hmsLogger.startMethodExecutionTimer("send");
            RemoteMessage remoteMessage = RemoteMessageUtils.callArgsToRemoteMsg(call);
            HmsMessaging.getInstance(PushPlugin.getContext()).send(remoteMessage);
            hmsLogger.sendSingleEvent("send");
            hmsLogger.startMethodExecutionTimer("onMessageSent");
            hmsLogger.startMethodExecutionTimer("onSendError");
            hmsLogger.startMethodExecutionTimer("onMessageDelivered");
            result.success(Code.RESULT_SUCCESS.code());
        } catch (IllegalArgumentException e) {
            hmsLogger.sendSingleEvent("send", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

}
