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

package com.huawei.hms.flutter.push.receiver.common;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.utils.BundleUtils;
import com.huawei.hms.flutter.push.utils.MapUtils;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.push.RemoteMessage;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.NewIntentListener;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * class NotificationIntentListener
 * <p>
 * Description: Listens and Handles Notification Open App Intents and Remote Message Notification Custom Intents
 *
 * @since 5.0.2
 */
public class NotificationIntentListener implements NewIntentListener {
    private static Map<String, Object> initialNotification;

    private String initialIntent;

    private final Context context;

    public NotificationIntentListener(Context context) {
        this.context = context;
    }

    @Override
    public boolean onNewIntent(Intent intent) {
        if (Utils.checkNotificationFlags(intent)) {
            handleIntent(intent);
        }
        return false;
    }

    public static synchronized Map<String, Object> getInitialNotification() {
        return NotificationIntentListener.initialNotification;
    }

    private static synchronized void setInitialNotification(Map<String, Object> initialNotification) {
        NotificationIntentListener.initialNotification = initialNotification;
    }

    public void getInitialIntent(final MethodChannel.Result result) {
        result.success(initialIntent);
    }

    public void handleIntent(Intent intent) {
        String action = intent.getAction();
        String dataString = intent.getDataString();
        Bundle bundleExtras = intent.getExtras();

        Map<String, Object> map = new HashMap<>();
        map.put("uriPage", intent.getDataString());
        if (bundleExtras != null) {
            RemoteMessage remoteMessage = new RemoteMessage(bundleExtras);
            map.put("remoteMessage", RemoteMessageUtils.toMap(remoteMessage));
            Map<String, Object> extras = MapUtils.toMap(BundleUtils.convertJSONObject(bundleExtras));
            map.put("extras", extras);
        }
        if (Intent.ACTION_VIEW.equals(action)) {
            initialIntent = dataString;
            Utils.sendIntent(context, PushIntent.REMOTE_MESSAGE_NOTIFICATION_INTENT_ACTION, PushIntent.CUSTOM_INTENT,
                initialIntent);
            if (bundleExtras != null) {
                sendNotificationOpenedAppEvent(map);
            }
        } else if (Intent.ACTION_MAIN.equals(action) || PushIntent.LOCAL_NOTIFICATION_ACTION.name().equals(action)) {
            if (bundleExtras != null) {
                sendNotificationOpenedAppEvent(map);
            }
        } else {
            Log.i("NotificationIntentListener", "Unsupported action intent:" + action);
        }
    }

    private void sendNotificationOpenedAppEvent(Map<String, Object> initialNotification) {
        setInitialNotification(initialNotification);
        JSONObject jsonObject = new JSONObject(initialNotification);
        Utils.sendIntent(context, PushIntent.NOTIFICATION_OPEN_ACTION, PushIntent.NOTIFICATION_OPEN,
            jsonObject.toString());
    }
}
