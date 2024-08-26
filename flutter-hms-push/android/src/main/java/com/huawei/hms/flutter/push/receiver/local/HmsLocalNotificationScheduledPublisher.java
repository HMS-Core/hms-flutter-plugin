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
import android.os.Bundle;

import com.huawei.hms.flutter.push.localnotification.HmsLocalNotificationController;
import com.huawei.hms.flutter.push.utils.NotificationConfigUtils;

public class HmsLocalNotificationScheduledPublisher extends BroadcastReceiver {
    @Override
    public void onReceive(final Context context, Intent intent) {
        final Bundle bundle = intent.getExtras();
        handleLocalNotification(context, bundle);
    }

    private void handleLocalNotification(Context context, Bundle bundle) {
        NotificationConfigUtils.configId(bundle);
        Application applicationContext = (Application) context.getApplicationContext();
        HmsLocalNotificationController hmsLocalNotificationController = new HmsLocalNotificationController(
            applicationContext);
        hmsLocalNotificationController.localNotificationNow(bundle, null);
    }
}

