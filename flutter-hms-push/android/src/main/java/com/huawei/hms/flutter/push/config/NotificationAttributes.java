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

package com.huawei.hms.flutter.push.config;

import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.LocalNotification;
import com.huawei.hms.flutter.push.constants.NotificationConstants;
import com.huawei.hms.flutter.push.utils.BundleUtils;
import com.huawei.hms.flutter.push.utils.Utils;

import io.flutter.plugin.common.MethodCall;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class NotificationAttributes {
    private final String id;

    private final String message;

    private final double fireDate;

    private final String importance;

    private final String title;

    private final String ticker;

    private final boolean showWhen;

    private final boolean autoCancel;

    private final String largeIcon;

    private final String largeIconUrl;

    private final String smallIcon;

    private final String bigText;

    private final String subText;

    private final String bigPictureUrl;

    private final String shortcutId;

    private final String number;

    private final String channelId;

    private final String channelName;

    private final String channelDescription;

    private final String sound;

    private final String soundName;

    private final String color;

    private final String group;

    private final boolean groupSummary;

    private final boolean userInteraction;

    private final boolean playSound;

    private final boolean vibrate;

    private final double vibrateDuration;

    private final String actions;

    private final boolean invokeApp;

    private final String tag;

    private final String repeatType;

    private final double repeatTime;

    private final boolean ongoing;

    private final boolean allowWhileIdle;

    private final boolean dontNotifyInForeground;

    private final String data;

    public NotificationAttributes(Bundle bundle) {
        id = BundleUtils.get(bundle, NotificationConstants.ID);
        message = BundleUtils.get(bundle, NotificationConstants.MESSAGE);
        fireDate = BundleUtils.getD(bundle, NotificationConstants.FIRE_DATE);
        importance = BundleUtils.get(bundle, NotificationConstants.IMPORTANCE);
        title = BundleUtils.get(bundle, NotificationConstants.TITLE);
        ticker = BundleUtils.get(bundle, NotificationConstants.TICKER);
        showWhen = BundleUtils.getB(bundle, NotificationConstants.SHOW_WHEN);
        autoCancel = BundleUtils.getB(bundle, NotificationConstants.AUTO_CANCEL);
        largeIcon = BundleUtils.get(bundle, NotificationConstants.LARGE_ICON);
        largeIconUrl = BundleUtils.get(bundle, NotificationConstants.LARGE_ICON_URL);
        smallIcon = BundleUtils.get(bundle, NotificationConstants.SMALL_ICON);
        bigText = BundleUtils.get(bundle, NotificationConstants.BIG_TEXT);
        subText = BundleUtils.get(bundle, NotificationConstants.SUB_TEXT);
        bigPictureUrl = BundleUtils.get(bundle, NotificationConstants.BIG_PICTURE_URL);
        shortcutId = BundleUtils.get(bundle, NotificationConstants.SHORTCUT_ID);
        number = BundleUtils.get(bundle, NotificationConstants.NUMBER);
        channelId = BundleUtils.get(bundle, NotificationConstants.CHANNEL_ID);
        channelName = BundleUtils.get(bundle, NotificationConstants.CHANNEL_NAME);
        channelDescription = BundleUtils.get(bundle, NotificationConstants.CHANNEL_DESCRIPTION);
        sound = BundleUtils.get(bundle, NotificationConstants.SOUND);
        soundName = BundleUtils.get(bundle, NotificationConstants.SOUND_NAME);
        color = BundleUtils.get(bundle, NotificationConstants.COLOR);
        group = BundleUtils.get(bundle, NotificationConstants.GROUP);
        groupSummary = BundleUtils.getB(bundle, NotificationConstants.GROUP_SUMMARY);
        userInteraction = BundleUtils.getB(bundle, NotificationConstants.USER_INTERACTION);
        playSound = BundleUtils.getB(bundle, NotificationConstants.PLAY_SOUND);
        vibrate = BundleUtils.getB(bundle, NotificationConstants.VIBRATE);
        vibrateDuration = BundleUtils.getD(bundle, NotificationConstants.VIBRATE_DURATION);
        actions = BundleUtils.get(bundle, NotificationConstants.ACTIONS);
        invokeApp = BundleUtils.getB(bundle, NotificationConstants.INVOKE_APP);
        tag = BundleUtils.get(bundle, NotificationConstants.TAG);
        repeatType = BundleUtils.get(bundle, NotificationConstants.REPEAT_TYPE);
        repeatTime = BundleUtils.getD(bundle, NotificationConstants.REPEAT_TIME);
        ongoing = BundleUtils.getB(bundle, NotificationConstants.ONGOING);
        allowWhileIdle = BundleUtils.getB(bundle, NotificationConstants.ALLOW_WHILE_IDLE);
        dontNotifyInForeground = BundleUtils.getB(bundle, NotificationConstants.DONT_NOTIFY_IN_FOREGROUND);
        data = BundleUtils.get(bundle, NotificationConstants.DATA);
    }

    private NotificationAttributes(JSONObject json) {
        try {
            id = json.has(NotificationConstants.ID) ? json.getString(NotificationConstants.ID) : null;
            message = json.has(NotificationConstants.MESSAGE)
                ? json.getString(NotificationConstants.MESSAGE)
                : Core.DEFAULT_MESSAGE;
            fireDate = json.has(NotificationConstants.FIRE_DATE)
                ? json.getDouble(NotificationConstants.FIRE_DATE)
                : 0.0;
            importance = json.has(NotificationConstants.IMPORTANCE)
                ? json.getString(NotificationConstants.IMPORTANCE)
                : LocalNotification.Importance.MAX;
            title = json.has(NotificationConstants.TITLE) ? json.getString(NotificationConstants.TITLE) : null;
            ticker = json.has(NotificationConstants.TICKER) ? json.getString(NotificationConstants.TICKER) : null;
            showWhen = !json.has(NotificationConstants.SHOW_WHEN) || json.getBoolean(NotificationConstants.SHOW_WHEN);
            autoCancel = !json.has(NotificationConstants.AUTO_CANCEL) || json.getBoolean(
                NotificationConstants.AUTO_CANCEL);
            largeIcon = json.has(NotificationConstants.LARGE_ICON)
                ? json.getString(NotificationConstants.LARGE_ICON)
                : null;
            largeIconUrl = json.has(NotificationConstants.LARGE_ICON_URL) ? json.getString(
                NotificationConstants.LARGE_ICON_URL) : null;
            smallIcon = json.has(NotificationConstants.SMALL_ICON)
                ? json.getString(NotificationConstants.SMALL_ICON)
                : null;
            bigText = json.has(NotificationConstants.BIG_TEXT) ? json.getString(NotificationConstants.BIG_TEXT) : null;
            subText = json.has(NotificationConstants.SUB_TEXT) ? json.getString(NotificationConstants.SUB_TEXT) : null;
            bigPictureUrl = json.has(NotificationConstants.BIG_PICTURE_URL) ? json.getString(
                NotificationConstants.BIG_PICTURE_URL) : null;
            shortcutId = json.has(NotificationConstants.SHORTCUT_ID)
                ? json.getString(NotificationConstants.SHORTCUT_ID)
                : null;
            number = json.has(NotificationConstants.NUMBER) ? json.getString(NotificationConstants.NUMBER) : null;
            channelId = json.has(NotificationConstants.CHANNEL_ID)
                ? json.getString(NotificationConstants.CHANNEL_ID)
                : null;
            channelName = json.has(NotificationConstants.CHANNEL_NAME) ? json.getString(
                NotificationConstants.CHANNEL_NAME) : null;
            channelDescription = json.has(NotificationConstants.CHANNEL_DESCRIPTION) ? json.getString(
                NotificationConstants.CHANNEL_DESCRIPTION) : null;
            sound = json.has(NotificationConstants.SOUND) ? json.getString(NotificationConstants.SOUND) : null;
            soundName = json.has(NotificationConstants.SOUND_NAME)
                ? json.getString(NotificationConstants.SOUND_NAME)
                : null;
            color = json.has(NotificationConstants.COLOR) ? json.getString(NotificationConstants.COLOR) : null;
            group = json.has(NotificationConstants.GROUP) ? json.getString(NotificationConstants.GROUP) : null;
            groupSummary = json.has(NotificationConstants.GROUP_SUMMARY) && json.getBoolean(
                NotificationConstants.GROUP_SUMMARY);
            userInteraction = json.has(NotificationConstants.USER_INTERACTION) && json.getBoolean(
                NotificationConstants.USER_INTERACTION);
            playSound = !json.has(NotificationConstants.PLAY_SOUND) || json.getBoolean(
                NotificationConstants.PLAY_SOUND);
            vibrate = !json.has(NotificationConstants.VIBRATE) || json.getBoolean(NotificationConstants.VIBRATE);
            vibrateDuration = json.has(NotificationConstants.VIBRATE_DURATION) ? json.getDouble(
                NotificationConstants.VIBRATE_DURATION) : 1000;
            actions = json.has(NotificationConstants.ACTIONS) ? json.getString(NotificationConstants.ACTIONS) : null;
            invokeApp = !json.has(NotificationConstants.INVOKE_APP) || json.getBoolean(
                NotificationConstants.INVOKE_APP);
            tag = json.has(NotificationConstants.TAG) ? json.getString(NotificationConstants.TAG) : null;
            repeatType = json.has(NotificationConstants.REPEAT_TYPE)
                ? json.getString(NotificationConstants.REPEAT_TYPE)
                : null;
            repeatTime = json.has(NotificationConstants.REPEAT_TIME)
                ? json.getDouble(NotificationConstants.REPEAT_TIME)
                : 0.0;
            ongoing = json.has(NotificationConstants.ONGOING) && json.getBoolean(NotificationConstants.ONGOING);
            allowWhileIdle = json.has(NotificationConstants.ALLOW_WHILE_IDLE) && json.getBoolean(
                NotificationConstants.ALLOW_WHILE_IDLE);
            dontNotifyInForeground = json.has(NotificationConstants.DONT_NOTIFY_IN_FOREGROUND) && json.getBoolean(
                NotificationConstants.DONT_NOTIFY_IN_FOREGROUND);
            data = json.has(NotificationConstants.DATA) ? json.get(NotificationConstants.DATA).toString() : null;
        } catch (IllegalStateException | JSONException | NumberFormatException | NullPointerException e) {
            throw new IllegalStateException(Code.RESULT_ERROR.code(), e);
        }
    }

    @NonNull
    public static NotificationAttributes fromJson(String json) throws JSONException {
        JSONObject jsonObject = new JSONObject(json);
        return new NotificationAttributes(jsonObject);
    }

    public NotificationAttributes(MethodCall call) {
        id = call.hasArgument(NotificationConstants.ID) ? (String) call.argument(NotificationConstants.ID) : null;
        message = call.hasArgument(NotificationConstants.MESSAGE) ? (String) call.argument(
            NotificationConstants.MESSAGE) : Core.DEFAULT_MESSAGE;
        fireDate = call.hasArgument(NotificationConstants.FIRE_DATE) ? Utils.getDoubleArgument(call,
            NotificationConstants.FIRE_DATE) : 0.0;
        importance = call.hasArgument(NotificationConstants.IMPORTANCE) ? (String) call.argument(
            NotificationConstants.IMPORTANCE) : LocalNotification.Importance.MAX;
        title = call.hasArgument(NotificationConstants.TITLE)
            ? (String) call.argument(NotificationConstants.TITLE)
            : null;
        ticker = call.hasArgument(NotificationConstants.TICKER)
            ? (String) call.argument(NotificationConstants.TICKER)
            : null;
        showWhen = !call.hasArgument(NotificationConstants.SHOW_WHEN) || Utils.getBoolArgument(call,
            NotificationConstants.SHOW_WHEN);
        autoCancel = !call.hasArgument(NotificationConstants.AUTO_CANCEL) || Utils.getBoolArgument(call,
            NotificationConstants.AUTO_CANCEL);
        largeIcon = call.hasArgument(NotificationConstants.LARGE_ICON) ? (String) call.argument(
            NotificationConstants.LARGE_ICON) : null;
        largeIconUrl = call.hasArgument(NotificationConstants.LARGE_ICON_URL) ? (String) call.argument(
            NotificationConstants.LARGE_ICON_URL) : null;
        smallIcon = call.hasArgument(NotificationConstants.SMALL_ICON) ? (String) call.argument(
            NotificationConstants.SMALL_ICON) : null;
        bigText = call.hasArgument(NotificationConstants.BIG_TEXT) ? (String) call.argument(
            NotificationConstants.BIG_TEXT) : null;
        subText = call.hasArgument(NotificationConstants.SUB_TEXT) ? (String) call.argument(
            NotificationConstants.SUB_TEXT) : null;
        bigPictureUrl = call.hasArgument(NotificationConstants.BIG_PICTURE_URL) ? (String) call.argument(
            NotificationConstants.BIG_PICTURE_URL) : null;
        shortcutId = call.hasArgument(NotificationConstants.SHORTCUT_ID) ? (String) call.argument(
            NotificationConstants.SHORTCUT_ID) : null;
        number = call.hasArgument(NotificationConstants.NUMBER)
            ? (String) call.argument(NotificationConstants.NUMBER)
            : null;
        channelId = call.hasArgument(NotificationConstants.CHANNEL_ID) ? (String) call.argument(
            NotificationConstants.CHANNEL_ID) : null;
        channelName = call.hasArgument(NotificationConstants.CHANNEL_NAME) ? (String) call.argument(
            NotificationConstants.CHANNEL_NAME) : null;
        channelDescription = call.hasArgument(NotificationConstants.CHANNEL_DESCRIPTION) ? (String) call.argument(
            NotificationConstants.CHANNEL_DESCRIPTION) : null;
        sound = call.hasArgument(NotificationConstants.SOUND)
            ? (String) call.argument(NotificationConstants.SOUND)
            : null;
        soundName = call.hasArgument(NotificationConstants.SOUND_NAME) ? (String) call.argument(
            NotificationConstants.SOUND_NAME) : null;
        color = call.hasArgument(NotificationConstants.COLOR)
            ? (String) call.argument(NotificationConstants.COLOR)
            : null;
        group = call.hasArgument(NotificationConstants.GROUP)
            ? (String) call.argument(NotificationConstants.GROUP)
            : null;
        groupSummary = call.hasArgument(NotificationConstants.GROUP_SUMMARY) && Utils.getBoolArgument(call,
            NotificationConstants.GROUP_SUMMARY);
        userInteraction = call.hasArgument(NotificationConstants.USER_INTERACTION) && Utils.getBoolArgument(call,
            NotificationConstants.USER_INTERACTION);
        playSound = !call.hasArgument(NotificationConstants.PLAY_SOUND) || Utils.getBoolArgument(call,
            NotificationConstants.PLAY_SOUND);
        vibrate = !call.hasArgument(NotificationConstants.VIBRATE) || Utils.getBoolArgument(call,
            NotificationConstants.VIBRATE);
        vibrateDuration = call.hasArgument(NotificationConstants.VIBRATE_DURATION) ? Utils.getDoubleArgument(call,
            NotificationConstants.VIBRATE_DURATION) : 1000;
        actions = call.hasArgument(NotificationConstants.ACTIONS) ? new JSONArray(
            (ArrayList<?>) call.argument(NotificationConstants.ACTIONS)).toString() : null;
        invokeApp = !call.hasArgument(NotificationConstants.INVOKE_APP) || Utils.getBoolArgument(call,
            NotificationConstants.INVOKE_APP);
        tag = call.hasArgument(NotificationConstants.TAG) ? (String) call.argument(NotificationConstants.TAG) : null;
        repeatType = call.hasArgument(NotificationConstants.REPEAT_TYPE) ? (String) call.argument(
            NotificationConstants.REPEAT_TYPE) : null;
        repeatTime = call.hasArgument(NotificationConstants.REPEAT_TIME) ? Utils.getDoubleArgument(call,
            NotificationConstants.REPEAT_TIME) : 0.0;
        ongoing = call.hasArgument(NotificationConstants.ONGOING) && Utils.getBoolArgument(call,
            NotificationConstants.ONGOING);
        allowWhileIdle = call.hasArgument(NotificationConstants.ALLOW_WHILE_IDLE) && Utils.getBoolArgument(call,
            NotificationConstants.ALLOW_WHILE_IDLE);
        dontNotifyInForeground = call.hasArgument(NotificationConstants.DONT_NOTIFY_IN_FOREGROUND)
            && Utils.getBoolArgument(call, NotificationConstants.DONT_NOTIFY_IN_FOREGROUND);
        data = call.hasArgument(NotificationConstants.DATA) ? BundleUtils.convertJSON(
            Utils.getMapArgument(call, NotificationConstants.DATA)) : null;
    }

    public Bundle toBundle() {
        Bundle bundle = new Bundle();
        BundleUtils.set(bundle, NotificationConstants.ID, id);
        BundleUtils.set(bundle, NotificationConstants.MESSAGE, message);
        BundleUtils.setD(bundle, NotificationConstants.FIRE_DATE, fireDate);
        BundleUtils.set(bundle, NotificationConstants.IMPORTANCE, importance);
        BundleUtils.set(bundle, NotificationConstants.TITLE, title);
        BundleUtils.set(bundle, NotificationConstants.TICKER, ticker);
        BundleUtils.setB(bundle, NotificationConstants.SHOW_WHEN, showWhen);
        BundleUtils.setB(bundle, NotificationConstants.AUTO_CANCEL, autoCancel);
        BundleUtils.set(bundle, NotificationConstants.LARGE_ICON, largeIcon);
        BundleUtils.set(bundle, NotificationConstants.LARGE_ICON_URL, largeIconUrl);
        BundleUtils.set(bundle, NotificationConstants.SMALL_ICON, smallIcon);
        BundleUtils.set(bundle, NotificationConstants.BIG_TEXT, bigText);
        BundleUtils.set(bundle, NotificationConstants.SUB_TEXT, subText);
        BundleUtils.set(bundle, NotificationConstants.BIG_PICTURE_URL, bigPictureUrl);
        BundleUtils.set(bundle, NotificationConstants.SHORTCUT_ID, shortcutId);
        BundleUtils.set(bundle, NotificationConstants.NUMBER, number);
        BundleUtils.set(bundle, NotificationConstants.CHANNEL_ID, channelId);
        BundleUtils.set(bundle, NotificationConstants.CHANNEL_NAME, channelName);
        BundleUtils.set(bundle, NotificationConstants.CHANNEL_DESCRIPTION, channelDescription);
        BundleUtils.set(bundle, NotificationConstants.SOUND, sound);
        BundleUtils.set(bundle, NotificationConstants.SOUND_NAME, soundName);
        BundleUtils.set(bundle, NotificationConstants.COLOR, color);
        BundleUtils.set(bundle, NotificationConstants.GROUP, group);
        BundleUtils.setB(bundle, NotificationConstants.GROUP_SUMMARY, groupSummary);
        BundleUtils.setB(bundle, NotificationConstants.USER_INTERACTION, userInteraction);
        BundleUtils.setB(bundle, NotificationConstants.PLAY_SOUND, playSound);
        BundleUtils.setB(bundle, NotificationConstants.VIBRATE, vibrate);
        BundleUtils.setD(bundle, NotificationConstants.VIBRATE_DURATION, vibrateDuration);
        BundleUtils.set(bundle, NotificationConstants.ACTIONS, actions);
        BundleUtils.setB(bundle, NotificationConstants.INVOKE_APP, invokeApp);
        BundleUtils.set(bundle, NotificationConstants.TAG, tag);
        BundleUtils.set(bundle, NotificationConstants.REPEAT_TYPE, repeatType);
        BundleUtils.setD(bundle, NotificationConstants.REPEAT_TIME, repeatTime);
        BundleUtils.setB(bundle, NotificationConstants.ONGOING, ongoing);
        BundleUtils.setB(bundle, NotificationConstants.ALLOW_WHILE_IDLE, allowWhileIdle);
        BundleUtils.setB(bundle, NotificationConstants.DONT_NOTIFY_IN_FOREGROUND, dontNotifyInForeground);
        BundleUtils.set(bundle, NotificationConstants.DATA, data);
        return bundle;
    }

    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        try {
            json.put(NotificationConstants.ID, id);
            json.put(NotificationConstants.MESSAGE, message);
            json.put(NotificationConstants.FIRE_DATE, fireDate);
            json.put(NotificationConstants.IMPORTANCE, importance);
            json.put(NotificationConstants.TITLE, title);
            json.put(NotificationConstants.TICKER, ticker);
            json.put(NotificationConstants.SHOW_WHEN, showWhen);
            json.put(NotificationConstants.AUTO_CANCEL, autoCancel);
            json.put(NotificationConstants.LARGE_ICON, largeIcon);
            json.put(NotificationConstants.LARGE_ICON_URL, largeIconUrl);
            json.put(NotificationConstants.SMALL_ICON, smallIcon);
            json.put(NotificationConstants.BIG_TEXT, bigText);
            json.put(NotificationConstants.BIG_PICTURE_URL, bigPictureUrl);
            json.put(NotificationConstants.SUB_TEXT, subText);
            json.put(NotificationConstants.SHORTCUT_ID, shortcutId);
            json.put(NotificationConstants.NUMBER, number);
            json.put(NotificationConstants.CHANNEL_ID, channelId);
            json.put(NotificationConstants.CHANNEL_NAME, channelName);
            json.put(NotificationConstants.CHANNEL_DESCRIPTION, channelDescription);
            json.put(NotificationConstants.SOUND, sound);
            json.put(NotificationConstants.SOUND_NAME, soundName);
            json.put(NotificationConstants.COLOR, color);
            json.put(NotificationConstants.GROUP, group);
            json.put(NotificationConstants.GROUP_SUMMARY, groupSummary);
            json.put(NotificationConstants.USER_INTERACTION, userInteraction);
            json.put(NotificationConstants.PLAY_SOUND, playSound);
            json.put(NotificationConstants.VIBRATE, vibrate);
            json.put(NotificationConstants.VIBRATE_DURATION, vibrateDuration);
            json.put(NotificationConstants.ACTIONS, actions);
            json.put(NotificationConstants.INVOKE_APP, invokeApp);
            json.put(NotificationConstants.TAG, tag);
            json.put(NotificationConstants.REPEAT_TYPE, repeatType);
            json.put(NotificationConstants.REPEAT_TIME, repeatTime);
            json.put(NotificationConstants.ONGOING, ongoing);
            json.put(NotificationConstants.ALLOW_WHILE_IDLE, allowWhileIdle);
            json.put(NotificationConstants.DONT_NOTIFY_IN_FOREGROUND, dontNotifyInForeground);
            json.put(NotificationConstants.DATA, data);
        } catch (JSONException e) {
            Log.e("NotificationAttributes", Code.RESULT_ERROR.code(), e);
            return new JSONObject();
        }
        return json;
    }

    public String getId() {
        return id;
    }

    public String getSound() {
        return sound;
    }

    public String getMessage() {
        return message;
    }

    public String getTitle() {
        return title;
    }

    public String getNumber() {
        return number;
    }

    public String getRepeatType() {
        return repeatType;
    }

    public double getFireDate() {
        return fireDate;
    }

    public String getImportance() {
        return importance;
    }

    public String getTicker() {
        return ticker;
    }

    public boolean isShowWhen() {
        return showWhen;
    }

    public boolean isAutoCancel() {
        return autoCancel;
    }

    public String getLargeIcon() {
        return largeIcon;
    }

    public String getLargeIconUrl() {
        return largeIconUrl;
    }

    public String getSmallIcon() {
        return smallIcon;
    }

    public String getBigText() {
        return bigText;
    }

    public String getSubText() {
        return subText;
    }

    public String getBigPictureUrl() {
        return bigPictureUrl;
    }

    public String getShortcutId() {
        return shortcutId;
    }

    public String getChannelId() {
        return channelId;
    }

    public String getChannelName() {
        return channelName;
    }

    public String getChannelDescription() {
        return channelDescription;
    }

    public String getSoundName() {
        return soundName;
    }

    public String getColor() {
        return color;
    }

    public String getGroup() {
        return group;
    }

    public boolean isGroupSummary() {
        return groupSummary;
    }

    public boolean isUserInteraction() {
        return userInteraction;
    }

    public boolean isPlaySound() {
        return playSound;
    }

    public boolean isVibrate() {
        return vibrate;
    }

    public double getVibrateDuration() {
        return vibrateDuration;
    }

    public String getActions() {
        return actions;
    }

    public boolean isInvokeApp() {
        return invokeApp;
    }

    public String getTag() {
        return tag;
    }

    public double getRepeatTime() {
        return repeatTime;
    }

    public boolean isOngoing() {
        return ongoing;
    }

    public boolean isAllowWhileIdle() {
        return allowWhileIdle;
    }

    public boolean isDontNotifyInForeground() {
        return dontNotifyInForeground;
    }

}
