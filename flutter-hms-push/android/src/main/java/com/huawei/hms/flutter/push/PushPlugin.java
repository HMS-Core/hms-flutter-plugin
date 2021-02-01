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

package com.huawei.hms.flutter.push;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.constants.Channel;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.Method;
import com.huawei.hms.flutter.push.constants.Param;
import com.huawei.hms.flutter.push.event.DataMessageStreamHandler;
import com.huawei.hms.flutter.push.event.TokenStreamHandler;
import com.huawei.hms.flutter.push.event.local.LocalNotificationClickStreamHandler;
import com.huawei.hms.flutter.push.event.local.LocalNotificationOpenStreamHandler;
import com.huawei.hms.flutter.push.event.remote.RemoteMessageCustomIntentStreamHandler;
import com.huawei.hms.flutter.push.event.remote.RemoteMessageSentDeliveredStreamHandler;
import com.huawei.hms.flutter.push.hms.FlutterHmsInstanceId;
import com.huawei.hms.flutter.push.hms.FlutterHmsMessaging;
import com.huawei.hms.flutter.push.hms.FlutterHmsOpenDevice;
import com.huawei.hms.flutter.push.localnotification.HmsLocalNotification;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.receiver.common.NotificationIntentListener;
import com.huawei.hms.flutter.push.utils.Utils;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * class PushPlugin
 *
 * @since 4.0.4
 */
public class PushPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static String TAG = "HmsFlutterPush";

    private MethodChannel channel;
    private static volatile Context context;
    private HmsLocalNotification hmsLocalNotification;
    private NotificationIntentListener notificationIntentListener;

    private Activity activity;


    public static Context getContext() {
        return PushPlugin.context;
    }

    public static void setContext(Context context) {
        PushPlugin.context = context;
    }

    private void setStreamHandlers(BinaryMessenger messenger) {
        EventChannel tokenEventChannel = new EventChannel(messenger, Channel.TOKEN_CHANNEL.id());
        tokenEventChannel.setStreamHandler(new TokenStreamHandler(context));

        EventChannel remoteMsgReceiveEventChannel =
                new EventChannel(messenger, Channel.REMOTE_MESSAGE_RECEIVE_CHANNEL.id());
        remoteMsgReceiveEventChannel.setStreamHandler(new DataMessageStreamHandler(context));

        EventChannel remoteMsgSentDeliveredEventChannel =
                new EventChannel(messenger, Channel.REMOTE_MESSAGE_SEND_STATUS_CHANNEL.id());
        remoteMsgSentDeliveredEventChannel.setStreamHandler(new RemoteMessageSentDeliveredStreamHandler(context));

        // For sending remote message notification's custom intent Uri events
        EventChannel remoteMsgCustomIntentEventChannel =
                new EventChannel(messenger, Channel.REMOTE_MESSAGE_NOTIFICATION_INTENT_CHANNEL.id());
        remoteMsgCustomIntentEventChannel.setStreamHandler(new RemoteMessageCustomIntentStreamHandler(context));

        EventChannel notificationOpenEventChannel
                = new EventChannel(messenger, Channel.NOTIFICATION_OPEN_CHANNEL.id());
        notificationOpenEventChannel.setStreamHandler(new LocalNotificationOpenStreamHandler(context));

        EventChannel localNotificationClickEventChannel
                = new EventChannel(messenger, Channel.LOCAL_NOTIFICATION_CLICK_CHANNEL.id());
        localNotificationClickEventChannel.setStreamHandler(new LocalNotificationClickStreamHandler(context));
    }

    public void onAttachedToEngine(BinaryMessenger messenger, Context context) {
        channel = new MethodChannel(messenger, Channel.METHOD_CHANNEL.id());
        channel.setMethodCallHandler(this);
        PushPlugin.setContext(context);
        notificationIntentListener = new NotificationIntentListener();
        hmsLocalNotification = new HmsLocalNotification(context);
        setStreamHandlers(messenger);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
    }

    public static void registerWith(Registrar registrar) {
        PushPlugin instance = new PushPlugin();
        instance.onAttachedToEngine(registrar.messenger(), registrar.context());
        if (registrar.activity() != null) {
            registrar.addNewIntentListener(instance.notificationIntentListener);
            instance.notificationIntentListener.handleIntent(registrar.activity().getIntent());
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        binding.addOnNewIntentListener(this.notificationIntentListener);
        this.notificationIntentListener.handleIntent(activity.getIntent());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        binding.addOnNewIntentListener(this.notificationIntentListener);
        this.notificationIntentListener.handleIntent(activity.getIntent());
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getId:
                FlutterHmsInstanceId.getId(result);
                break;
            case getAAID:
                FlutterHmsInstanceId.getAAID(result);
                break;
            case getAppId:
                FlutterHmsInstanceId.getAppId(result);
                break;
            case getCreationTime:
                FlutterHmsInstanceId.getCreationTime(result);
                break;
            case deleteAAID:
                FlutterHmsInstanceId.deleteAAID(result);
                break;
            case registerBackgroundMessageHandler:
                registerBackgroundMessageHandler((long) call.argument("rawHandle"), (long) call.argument("rawCallback"), result);
                break;
            case removeBackgroundMessageHandler:
                removeBackgroundMessageHandler(result);
                break;
            default:
                onMethodCallToken(call, result);
        }
    }

    private void onMethodCallToken(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getToken:
                FlutterHmsInstanceId.getToken(Utils.getStringArgument(call, Param.SCOPE.code()));
                break;
            case deleteToken:
                FlutterHmsInstanceId.deleteToken(Utils.getStringArgument(call, Param.SCOPE.code()));
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
                hmsLocalNotification.getChannels(call, result);
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
                hmsLocalNotification.cancelNotificationsWithTag(call);
                break;
            case cancelNotificationsWithId:
                hmsLocalNotification.cancelNotificationsWithId(call);
                break;
            case cancelNotificationsWithIdTag:
                hmsLocalNotification.cancelNotificationsWithIdTag(call);
                break;
            default:
                onMethodCallSubscribe(call, result);
        }
    }

    private void onMethodCallSubscribe(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case subscribe:
                FlutterHmsMessaging.subscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            case unsubscribe:
                FlutterHmsMessaging.unsubscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            default:
                onMethodCallEnable(call, result);
        }
    }

    private void onMethodCallEnable(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case send:
                FlutterHmsMessaging.sendRemoteMessage(result, call);
                break;
            case turnOnPush:
                FlutterHmsMessaging.turnOnPush(result);
                break;
            case turnOffPush:
                FlutterHmsMessaging.turnOffPush(result);
                break;
            case setAutoInitEnabled:
                FlutterHmsMessaging.setAutoInitEnabled(Utils.getBoolArgument(call, Param.ENABLED.code()), result);
                break;
            case isAutoInitEnabled:
                FlutterHmsMessaging.isAutoInitEnabled(result);
                break;
            case getAgConnectValues:
                FlutterHmsInstanceId.getAgConnectValues(result);
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
                onMethodCallOther(call, result);
        }
    }

    private void onMethodCallOther(@NonNull MethodCall call, @NonNull Result result) {
        if (Method.valueOf(call.method) == Method.getInitialIntent) {
            notificationIntentListener.getInitialIntent(result);
        } else result.notImplemented();
    }


    private void registerBackgroundMessageHandler(long handlerRaw, long callbackRaw, Result result) {

        try {
            SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = prefs.edit();
            editor.putLong(HeadlessPushPlugin.KEY_HANDLER, handlerRaw);
            editor.putLong(HeadlessPushPlugin.KEY_CALLBACK, callbackRaw);
            editor.apply();

            Log.i(TAG, "BackgroundMessageHandler registered ✔");
            result.success(1);
        } catch (SecurityException e) {
            result.success(0);
        }
    }

    private void removeBackgroundMessageHandler(Result result) {

        SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putLong(HeadlessPushPlugin.KEY_HANDLER, -1);
        editor.putLong(HeadlessPushPlugin.KEY_CALLBACK, -1);

        editor.apply();

        Log.i(TAG, "BackgroundMessageHandler removed ✔");
        result.success(1);
    }

    public static void setPluginRegistrant(PluginRegistry.PluginRegistrantCallback callback) {
        HeadlessPushPlugin.setPluginRegistrant(callback);
    }

}
