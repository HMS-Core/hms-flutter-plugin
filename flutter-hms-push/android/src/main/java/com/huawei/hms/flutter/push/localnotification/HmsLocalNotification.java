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

package com.huawei.hms.flutter.push.localnotification;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;

import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.receiver.common.NotificationIntentListener;
import com.huawei.hms.flutter.push.utils.LocalNotificationUtils;
import com.huawei.hms.flutter.push.utils.NotificationConfigUtils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.ArrayList;
import java.util.HashMap;

public class HmsLocalNotification {
    private static final String TAG = HmsLocalNotification.class.getSimpleName();

    private final HmsLocalNotificationController hmsLocalNotificationController;

    public HmsLocalNotification(Context context) {
        this.hmsLocalNotificationController = new HmsLocalNotificationController(context);
    }

    public void localNotification(MethodCall call, final Result result) {
        Bundle bundle = LocalNotificationUtils.callArgsToBundle(call);
        if (bundle == null) {
            result.error(Code.NULL_BUNDLE.code(), "Arguments are wrong or empty", "");
            return;
        }
        NotificationConfigUtils.configId(bundle);
        hmsLocalNotificationController.localNotificationNow(bundle, result);
    }

    public void localNotificationSchedule(MethodCall call, final Result result) {
        Bundle bundle = LocalNotificationUtils.callArgsToBundle(call);
        if (bundle == null) {
            result.error(Code.NULL_BUNDLE.code(), "Arguments are wrong or empty", "");
            return;
        }
        NotificationConfigUtils.configId(bundle);
        String localNotif = hmsLocalNotificationController.localNotificationSchedule(bundle, result);
        if (localNotif.isEmpty()) {
            return;
        }
        result.success(localNotif);
    }

    public void getInitialNotification(final Result result) {
        result.success(NotificationIntentListener.getInitialNotification());
    }

    public void getNotifications(final Result result) {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            ArrayList<String> notifications = hmsLocalNotificationController.getNotifications(result);
            result.success(notifications);
        } else {
            result.error("UNKNOWN", "API Level must be over 23 to use getNotifications method", "");
        }
    }

    public void getScheduledNotifications(final Result result) {
        ArrayList<String> scheduledNotifications = hmsLocalNotificationController.getScheduledNotifications();
        result.success(scheduledNotifications);
    }

    public void getChannels(final Result result) {
        ArrayList<String> channelList = hmsLocalNotificationController.listChannels();
        result.success(channelList);
    }

    public void deleteChannel(MethodCall call, final Result result) {
        String channelId = call.arguments();
        hmsLocalNotificationController.deleteChannel(channelId, result);
    }

    public void channelExists(MethodCall call, final Result result) {
        String channelId = call.arguments();
        boolean exists = hmsLocalNotificationController.channelExists(channelId);
        result.success(exists);
    }

    public void channelBlocked(MethodCall call, final Result result) {
        String channelId = call.arguments();
        boolean blocked = hmsLocalNotificationController.isChannelBlocked(channelId);
        result.success(blocked);
    }

    public void cancelNotifications(final Result result) {
        hmsLocalNotificationController.cancelNotifications();
        result.success(true);
    }

    public void cancelAllNotifications(final Result result) {
        hmsLocalNotificationController.cancelScheduledNotifications();
        hmsLocalNotificationController.cancelNotifications();
        result.success(true);
    }

    public void cancelScheduledNotifications(final Result result) {
        hmsLocalNotificationController.cancelScheduledNotifications();
        result.success(true);
    }

    public void cancelNotificationsWithTag(MethodCall call, final Result result) {
        String tag = call.arguments();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            hmsLocalNotificationController.cancelNotificationsWithTag(tag);
            result.success(null);
        } else {
            result.error("UNKNOWN", "API Level must be over 23 to use cancelNotificationsWithTag method", "");
        }
    }

    public void cancelNotificationsWithId(MethodCall call, final Result result) {
        ArrayList<Integer> ids = call.arguments();
        if (ids != null) {
            hmsLocalNotificationController.cancelNotificationsWithId(ids);
            result.success(null);
        } else {
            result.error(Code.ERROR_PARAMETER_INVALID.code(), "Invalid parameter.", "");
        }
    }

    public void cancelNotificationsWithIdTag(MethodCall call, final Result result) {
        HashMap<Integer, String> idTags = call.arguments();
        if (idTags != null) {
            hmsLocalNotificationController.cancelNotificationsWithIdTag(idTags);
            result.success(null);
        } else {
            result.error(Code.ERROR_PARAMETER_INVALID.code(), "Invalid parameter.", "");
        }
    }
}
