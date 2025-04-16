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

package com.huawei.hms.flutter.push;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.backgroundmessaging.BackgroundMessagingService;
import com.huawei.hms.flutter.push.backgroundmessaging.FlutterBackgroundRunner;
import com.huawei.hms.flutter.push.constants.Channel;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.Method;
import com.huawei.hms.flutter.push.constants.Param;
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.event.DefaultStreamHandler;
import com.huawei.hms.flutter.push.hms.FlutterHmsConsent;
import com.huawei.hms.flutter.push.hms.FlutterHmsInstanceId;
import com.huawei.hms.flutter.push.hms.FlutterHmsMessaging;
import com.huawei.hms.flutter.push.hms.FlutterHmsOpenDevice;
import com.huawei.hms.flutter.push.hms.FlutterHmsProfile;
import com.huawei.hms.flutter.push.hms.PluginContext;
import com.huawei.hms.flutter.push.localnotification.HmsLocalNotification;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.receiver.MultiSenderTokenReceiver;
import com.huawei.hms.flutter.push.receiver.RemoteDataMessageReceiver;
import com.huawei.hms.flutter.push.receiver.TokenReceiver;
import com.huawei.hms.flutter.push.receiver.common.NotificationIntentListener;
import com.huawei.hms.flutter.push.receiver.common.NotificationOpenEventReceiver;
import com.huawei.hms.flutter.push.receiver.local.LocalNotificationClickEventReceiver;
import com.huawei.hms.flutter.push.receiver.remote.RemoteMessageNotificationIntentReceiver;
import com.huawei.hms.flutter.push.receiver.remote.RemoteMessageSentDeliveredReceiver;
import com.huawei.hms.flutter.push.utils.Utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class PushPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static final String TAG = "HmsFlutterPush";

    private MethodChannel channel;

    private Context context;

    private HmsLocalNotification hmsLocalNotification;

    private NotificationIntentListener notificationIntentListener;

    private FlutterHmsInstanceId hmsInstanceId;

    private FlutterHmsMessaging hmsMessaging;

    private FlutterHmsProfile hmsProfile;

    private FlutterHmsConsent hmsConsent;

    private Activity activity;

    private final List<EventChannel> eventChannels = new ArrayList<>();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), Channel.METHOD_CHANNEL.id());
        channel.setMethodCallHandler(this);
        this.context = flutterPluginBinding.getApplicationContext();
        hmsProfile = new FlutterHmsProfile(context);
        hmsInstanceId = new FlutterHmsInstanceId(context);
        notificationIntentListener = new NotificationIntentListener(context);
        hmsLocalNotification = new HmsLocalNotification(context);
        hmsMessaging = new FlutterHmsMessaging(context);
        hmsConsent = new FlutterHmsConsent(context);
        PluginContext.initialize(context);
        setStreamHandlers(flutterPluginBinding.getBinaryMessenger());
    }

    private void setStreamHandlers(BinaryMessenger messenger) {
        Map<String, EventChannel.StreamHandler> streams = new ConcurrentHashMap<>();
        streams.put(Channel.TOKEN_CHANNEL.id(),
            new DefaultStreamHandler(context, TokenReceiver::new, PushIntent.TOKEN_INTENT_ACTION));

        streams.put(Channel.MULTI_SENDER_TOKEN_CHANNEL.id(),
            new DefaultStreamHandler(context, MultiSenderTokenReceiver::new,
                PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION));

        streams.put(Channel.REMOTE_MESSAGE_RECEIVE_CHANNEL.id(),
            new DefaultStreamHandler(context, RemoteDataMessageReceiver::new,
                PushIntent.REMOTE_DATA_MESSAGE_INTENT_ACTION));

        streams.put(Channel.REMOTE_MESSAGE_SEND_STATUS_CHANNEL.id(),
            new DefaultStreamHandler(context, RemoteMessageSentDeliveredReceiver::new,
                PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION));

        // For sending remote message notification's custom intent Uri events
        streams.put(Channel.REMOTE_MESSAGE_NOTIFICATION_INTENT_CHANNEL.id(),
            new DefaultStreamHandler(context, RemoteMessageNotificationIntentReceiver::new,
                PushIntent.REMOTE_MESSAGE_NOTIFICATION_INTENT_ACTION));

        streams.put(Channel.NOTIFICATION_OPEN_CHANNEL.id(),
            new DefaultStreamHandler(context, NotificationOpenEventReceiver::new, PushIntent.NOTIFICATION_OPEN_ACTION));

        streams.put(Channel.LOCAL_NOTIFICATION_CLICK_CHANNEL.id(),
            new DefaultStreamHandler(context, LocalNotificationClickEventReceiver::new,
                PushIntent.LOCAL_NOTIFICATION_CLICK_ACTION));

        for (Map.Entry<String, EventChannel.StreamHandler> entry : streams.entrySet()) {
            EventChannel eventChannel = new EventChannel(messenger, entry.getKey());
            eventChannel.setStreamHandler(entry.getValue());
            eventChannels.add(eventChannel);
        }
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        binding.addOnNewIntentListener(this.notificationIntentListener);
        Intent startupIntent = activity.getIntent();
        if (Utils.checkNotificationFlags(startupIntent)) {
            this.notificationIntentListener.handleIntent(startupIntent);
        }
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        binding.addOnNewIntentListener(this.notificationIntentListener);
        this.notificationIntentListener.handleIntent(activity.getIntent());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getId:
                hmsInstanceId.getId(result);
                break;
            case getAAID:
                hmsInstanceId.getAAID(result);
                break;
            case getAppId:
                hmsInstanceId.getAppId(result);
                break;
            case getCreationTime:
                hmsInstanceId.getCreationTime(result);
                break;
            case deleteAAID:
                hmsInstanceId.deleteAAID(result);
                break;
            case registerBackgroundMessageHandler:
                registerBackgroundMessageHandler(call, result);
                break;
            case removeBackgroundMessageHandler:
                removeBackgroundMessageHandler(result);
                break;
            case consentOn:
                hmsConsent.consentOn(result);
                break;
            case consentOff:
                hmsConsent.consentOff(result);
                break;
            default:
                onMethodCallToken(call, result);
        }
    }

    private void onMethodCallToken(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getToken:
                hmsInstanceId.getToken(Utils.getStringArgument(call, Param.SCOPE.code()));
                break;
            case deleteToken:
                hmsInstanceId.deleteToken(Utils.getStringArgument(call, Param.SCOPE.code()), result);
                break;
            default:
                onMethodCallOpenDevice(call, result);
        }
    }

    private void onMethodCallOpenDevice(@NonNull MethodCall call, @NonNull Result result) {
        if (Method.valueOf(call.method) == Method.getOdid) {
            FlutterHmsOpenDevice.getOdid(result);
        } else {
            onMethodCallLocalNotification(call, result);
        }
    }

    private void onMethodCallLocalNotification(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case localNotification:
                hmsLocalNotification.localNotification(call, result);
                break;
            case localNotificationSchedule:
                hmsLocalNotification.localNotificationSchedule(call, result);
                break;
            case getInitialNotification:
                hmsLocalNotification.getInitialNotification(result);
                break;
            case getNotifications:
                hmsLocalNotification.getNotifications(result);
                break;
            case getScheduledNotifications:
                hmsLocalNotification.getScheduledNotifications(result);
                break;
            case getChannels:
                hmsLocalNotification.getChannels(result);
                break;
            case deleteChannel:
                hmsLocalNotification.deleteChannel(call, result);
                break;
            case channelExists:
                hmsLocalNotification.channelExists(call, result);
                break;
            case channelBlocked:
                hmsLocalNotification.channelBlocked(call, result);
                break;
            case cancelNotifications:
                hmsLocalNotification.cancelNotifications(result);
                break;
            case cancelAllNotifications:
                hmsLocalNotification.cancelAllNotifications(result);
                break;
            case cancelScheduledNotifications:
                hmsLocalNotification.cancelScheduledNotifications(result);
                break;
            case cancelNotificationsWithTag:
                hmsLocalNotification.cancelNotificationsWithTag(call, result);
                break;
            case cancelNotificationsWithId:
                hmsLocalNotification.cancelNotificationsWithId(call, result);
                break;
            case cancelNotificationsWithIdTag:
                hmsLocalNotification.cancelNotificationsWithIdTag(call, result);
                break;
            case getInitialIntent:
                notificationIntentListener.getInitialIntent(result);
                break;
            default:
                onMethodCallSubscribe(call, result);
        }
    }

    private void onMethodCallSubscribe(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case subscribe:
                hmsMessaging.subscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            case unsubscribe:
                hmsMessaging.unsubscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            default:
                onMethodCallEnable(call, result);
        }
    }

    private void onMethodCallEnable(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case send:
                hmsMessaging.sendRemoteMessage(result, call);
                break;
            case turnOnPush:
                hmsMessaging.turnOnPush(result);
                break;
            case turnOffPush:
                hmsMessaging.turnOffPush(result);
                break;
            case setAutoInitEnabled:
                hmsMessaging.setAutoInitEnabled(Utils.getBoolArgument(call, Param.ENABLED.code()), result);
                break;
            case isAutoInitEnabled:
                hmsMessaging.isAutoInitEnabled(result);
                break;
            case getAgConnectValues:
                hmsInstanceId.getAgConnectValues(result);
                break;
            case showToast:
                Toast.makeText(context, Utils.getStringArgument(call, Param.MESSAGE.code()), Toast.LENGTH_LONG).show();
                break;
            default:
                onMethodCallDotting(call, result);
        }
    }

    private void onMethodCallDotting(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case enableLogger:
                HMSLogger.getInstance(context).enableLogger();
                break;
            case disableLogger:
                HMSLogger.getInstance(context).disableLogger();
                break;
            default:
                onMethodCallHmsProfile(call, result);
        }
    }

    private void onMethodCallHmsProfile(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case isSupportProfile:
                hmsProfile.isSupportProfile(result);
                break;
            case addProfile:
                hmsProfile.addProfile(call, result);
                break;
            case addMultiSenderProfile:
                hmsProfile.addMultiSenderProfile(call, result);
                break;
            case deleteProfile:
                hmsProfile.deleteProfile(call, result);
                break;
            case deleteMultiSenderProfile:
                hmsProfile.deleteMultiSenderProfile(call, result);
                break;
            case getMultiSenderToken:
                hmsInstanceId.getMultiSenderToken(Utils.getStringArgument(call, Param.SUBJECT_ID.code()));
                break;
            case deleteMultiSenderToken:
                hmsInstanceId.deleteMultiSenderToken(Utils.getStringArgument(call, Param.SUBJECT_ID.code()), result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            for (EventChannel e : eventChannels) {
                e.setStreamHandler(null);
            }
            eventChannels.clear();
        }
    }

    private void registerBackgroundMessageHandler(final MethodCall call, final Result result) {
        try {
            long pluginCallbackHandle = Objects.requireNonNull(call.argument("rawHandle"));
            long userCallbackHandle = Objects.requireNonNull(call.argument("rawCallback"));

            SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = prefs.edit();
            editor.putLong(FlutterBackgroundRunner.CALLBACK_DISPATCHER_KEY, pluginCallbackHandle);
            editor.putLong(FlutterBackgroundRunner.USER_CALLBACK_KEY, userCallbackHandle);
            editor.apply();

            BackgroundMessagingService.setCallbackDispatcher(context, pluginCallbackHandle);
            BackgroundMessagingService.setUserCallback(context, userCallbackHandle);
            BackgroundMessagingService.startBgIsolate(context, pluginCallbackHandle);

            result.success(true);
            Log.i(TAG, "BackgroundMessageHandler registered ✔");
        } catch (SecurityException e) {
            Log.i(TAG, "BackgroundMessageHandler could not be registered.");
            result.success(false);
        }
    }

    private void removeBackgroundMessageHandler(Result result) {
        SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putLong(FlutterBackgroundRunner.CALLBACK_DISPATCHER_KEY, -1);
        editor.putLong(FlutterBackgroundRunner.USER_CALLBACK_KEY, -1);
        editor.apply();

        Log.i(TAG, "BackgroundMessageHandler removed ✔");
        result.success(true);
    }
}
