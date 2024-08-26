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

import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.RemoteMessageAttributes;
import com.huawei.hms.push.RemoteMessage;

import io.flutter.plugin.common.MethodCall;

import org.json.JSONObject;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class RemoteMessageUtils {

    private RemoteMessageUtils() {
        throw new IllegalStateException("Utility class");
    }

    public static Map<String, Object> toMap(RemoteMessage message) {
        Map<String, Object> content = new HashMap<>();
        Map<String, Object> notificationContent = new HashMap<>();

        content.put(RemoteMessageAttributes.COLLAPSE_KEY, message.getCollapseKey());
        content.put(RemoteMessageAttributes.DATA, message.getData());
        content.put(RemoteMessageAttributes.DATA_OF_MAP, new JSONObject(message.getDataOfMap()).toString());
        content.put(RemoteMessageAttributes.MESSAGE_ID, message.getMessageId());
        content.put(RemoteMessageAttributes.MESSAGE_TYPE, message.getMessageType());
        content.put(RemoteMessageAttributes.ORIGINAL_URGENCY, message.getOriginalUrgency());
        content.put(RemoteMessageAttributes.URGENCY, message.getUrgency());
        content.put(RemoteMessageAttributes.TTL, message.getTtl());
        content.put(RemoteMessageAttributes.SENT_TIME, message.getSentTime());
        content.put(RemoteMessageAttributes.TO, message.getTo());
        content.put(RemoteMessageAttributes.FROM, message.getFrom());
        content.put(RemoteMessageAttributes.TOKEN, message.getToken());
        content.put(RemoteMessageAttributes.RECEIPT_MODE, message.getReceiptMode());
        content.put(RemoteMessageAttributes.SEND_MODE, message.getSendMode());
        content.put(RemoteMessageAttributes.CONTENTS, message.describeContents());
        content.put(RemoteMessageAttributes.ANALYTIC_INFO, message.getAnalyticInfo());
        content.put(RemoteMessageAttributes.ANALYTIC_INFO_MAP, message.getAnalyticInfoMap());

        if (message.getNotification() != null) {
            RemoteMessage.Notification notification = message.getNotification();
            notificationContent.put(RemoteMessageAttributes.TITLE, notification.getTitle());
            notificationContent.put(RemoteMessageAttributes.TITLE_LOCALIZATION_KEY,
                notification.getTitleLocalizationKey());
            notificationContent.put(RemoteMessageAttributes.TITLE_LOCALIZATION_ARGS,
                Arrays.asList(notification.getTitleLocalizationArgs()));
            notificationContent.put(RemoteMessageAttributes.BODY_LOCALIZATION_KEY,
                notification.getBodyLocalizationKey());
            notificationContent.put(RemoteMessageAttributes.BODY_LOCALIZATION_ARGS,
                Arrays.asList(notification.getBodyLocalizationArgs()));
            notificationContent.put(RemoteMessageAttributes.BODY, notification.getBody());
            notificationContent.put(RemoteMessageAttributes.ICON, notification.getIcon());
            notificationContent.put(RemoteMessageAttributes.SOUND, notification.getSound());
            notificationContent.put(RemoteMessageAttributes.TAG, notification.getTag());
            notificationContent.put(RemoteMessageAttributes.COLOR, notification.getColor());
            notificationContent.put(RemoteMessageAttributes.CLICK_ACTION, notification.getClickAction());
            notificationContent.put(RemoteMessageAttributes.CHANNEL_ID, notification.getChannelId());
            notificationContent.put(RemoteMessageAttributes.IMAGE_URL, notification.getImageUrl() + "");
            notificationContent.put(RemoteMessageAttributes.LINK, notification.getLink() + "");
            notificationContent.put(RemoteMessageAttributes.NOTIFY_ID, notification.getNotifyId());
            notificationContent.put(RemoteMessageAttributes.WHEN, notification.getWhen());
            notificationContent.put(RemoteMessageAttributes.LIGHT_SETTINGS, notification.getLightSettings());
            notificationContent.put(RemoteMessageAttributes.BADGE_NUMBER, notification.getBadgeNumber());
            notificationContent.put(RemoteMessageAttributes.IMPORTANCE, notification.getImportance());
            notificationContent.put(RemoteMessageAttributes.TICKER, notification.getTicker());
            notificationContent.put(RemoteMessageAttributes.VIBRATE_CONFIG, notification.getVibrateConfig());
            notificationContent.put(RemoteMessageAttributes.VISIBILITY, notification.getVisibility());
            notificationContent.put(RemoteMessageAttributes.INTENT_URI, notification.getIntentUri());
            notificationContent.put(RemoteMessageAttributes.IS_AUTO_CANCEL, notification.isAutoCancel());
            notificationContent.put(RemoteMessageAttributes.IS_LOCAL_ONLY, notification.isLocalOnly());
            notificationContent.put(RemoteMessageAttributes.IS_DEFAULT_LIGHT, notification.isDefaultLight());
            notificationContent.put(RemoteMessageAttributes.IS_DEFAULT_SOUND, notification.isDefaultSound());
            notificationContent.put(RemoteMessageAttributes.IS_DEFAULT_VIBRATE, notification.isDefaultVibrate());

            content.put(RemoteMessageAttributes.NOTIFICATION, notificationContent);
        }

        return content;
    }

    public static RemoteMessage callArgsToRemoteMsg(MethodCall call) {
        String to = call.argument(RemoteMessageAttributes.TO);
        if (to == null || to.equals("")) {
            to = Core.REMOTE_MESSAGE_UPLINK_TO;
        }

        RemoteMessage.Builder builder = new RemoteMessage.Builder(to);

        String messageId = call.hasArgument(RemoteMessageAttributes.MESSAGE_ID) ? (String) call.argument(
            RemoteMessageAttributes.MESSAGE_ID) : NotificationConfigUtils.generateNotificationId();
        String messageType = call.hasArgument(RemoteMessageAttributes.MESSAGE_TYPE) ? (String) call.argument(
            RemoteMessageAttributes.MESSAGE_TYPE) : "hms";
        int ttl = call.hasArgument(RemoteMessageAttributes.TTL)
            ? (int) call.argument(RemoteMessageAttributes.TTL)
            : 120;
        String collapseKey = call.hasArgument(RemoteMessageAttributes.COLLAPSE_KEY) ? (String) call.argument(
            RemoteMessageAttributes.COLLAPSE_KEY) : "-1";
        int receiptMode = call.hasArgument(RemoteMessageAttributes.RECEIPT_MODE) ? (int) call.argument(
            RemoteMessageAttributes.RECEIPT_MODE) : 1; // Default Mode is 0
        int sendMode = call.hasArgument(RemoteMessageAttributes.SEND_MODE) ? (int) call.argument(
            RemoteMessageAttributes.SEND_MODE) : 1; // Default Mode is 0

        HashMap<String, String> map = null;
        if (call.hasArgument(RemoteMessageAttributes.DATA) && call.argument(
            RemoteMessageAttributes.DATA) instanceof HashMap) {
            map = call.argument(RemoteMessageAttributes.DATA);
        }
        if (map != null) {
            builder.setData(map);
        }

        builder.setCollapseKey(collapseKey);
        builder.setMessageId(messageId);
        builder.setReceiptMode(receiptMode);
        builder.setSendMode(sendMode);
        builder.setMessageType(messageType);
        builder.setTtl(ttl);

        return builder.build();
    }

}
