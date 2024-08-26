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

package com.huawei.hms.flutter.push.receiver.local;

import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import com.huawei.hms.flutter.push.config.NotificationAttributes;
import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.localnotification.HmsLocalNotificationController;

import java.util.Set;

public class HmsLocalNotificationBootEventReceiver extends BroadcastReceiver {
    private static final String TAG = HmsLocalNotificationBootEventReceiver.class.getSimpleName();

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction() == null) {
            return;
        }
        if (!intent.getAction().equals(Core.ScheduledPublisher.BOOT_EVENT)) {
            return;
        }

        Log.i(TAG, "Loading scheduled notifications....");

        SharedPreferences sharedPreferences = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        Set<String> ids = sharedPreferences.getAll().keySet();

        Application applicationContext = (Application) context.getApplicationContext();
        HmsLocalNotificationController hmsLocalNotificationController = new HmsLocalNotificationController(
            applicationContext);

        for (String id : ids) {
            try {
                String notificationAttributesJson = sharedPreferences.getString(id, null);
                if (notificationAttributesJson != null) {
                    NotificationAttributes notificationAttributes = NotificationAttributes.fromJson(
                        notificationAttributesJson);

                    if (notificationAttributes.getFireDate() < System.currentTimeMillis()) {
                        hmsLocalNotificationController.localNotificationNow(notificationAttributes.toBundle(), null);
                    } else {
                        hmsLocalNotificationController.localNotificationScheduleSetAlarm(
                            notificationAttributes.toBundle());
                    }
                }
            } catch (Exception e) {
                Log.e(TAG, Code.RESULT_ERROR.code(), e);
            }
        }
    }
}

