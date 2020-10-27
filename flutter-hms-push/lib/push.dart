/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_push/model/remote_message.dart';

import './constants/Channel.dart' as Channel;
import './constants/Method.dart' as Method;
import 'constants/Code.dart';

class Push {
  /// Constant Method and Event Channel definitions for communicating with native platform
  static const MethodChannel methodChannel =
      const MethodChannel(Channel.METHOD_CHANNEL);
  static const EventChannel tokenEventChannel =
      EventChannel(Channel.TOKEN_CHANNEL);
  static const EventChannel remoteMessageReceiveEventChannel =
      EventChannel(Channel.REMOTE_MESSAGE_RECEIVE_CHANNEL);
  static const EventChannel remoteMessageSendStatusEventChannel =
      EventChannel(Channel.REMOTE_MESSAGE_SEND_STATUS_CHANNEL);
  static const EventChannel remoteMessageNotificationIntentEventChannel =
      EventChannel(Channel.REMOTE_MESSAGE_NOTIFICATION_INTENT_CHANNEL);
  static const EventChannel notificationOpenEventChannel =
      EventChannel(Channel.NOTIFICATION_OPEN_CHANNEL);
  static const EventChannel localNotificationClickEventChannel =
      EventChannel(Channel.LOCAL_NOTIFICATION_CLICK_CHANNEL);

  /// Enables the function of receiving notification messages in asynchronous mode.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOnPush() async {
    final String result = await methodChannel.invokeMethod(Method.turnOnPush);
    return Code[result];
  }

  /// Disables the function of receiving notification messages in asynchronous mode.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOffPush() async {
    final String result = await methodChannel.invokeMethod(Method.turnOffPush);
    return Code[result];
  }

  /// Obtains an AAID in synchronous mode of Push SDK
  static Future<String> getId() async {
    final String result = await methodChannel.invokeMethod(Method.getId);
    return result;
  }

  /// Obtains an AAID in asynchronous mode of Push SDK
  static Future<String> getAAID() async {
    final String result = await methodChannel.invokeMethod(Method.getAAID);
    return result;
  }

  /// Obtains the Application ID from the *agconnect-services.json* file
  static Future<String> getAppId() async {
    final String result = await methodChannel.invokeMethod(Method.getAppId);
    return result;
  }

  /// Obtains an ODID
  static Future<String> getOdid() async {
    final String result = await methodChannel.invokeMethod(Method.getOdid);
    return result;
  }

  /// Requests a token to be returned from the token event channel
  ///
  /// To obtain the push token one must listen the token stream. Token Stream
  /// can be obtained by [getTokenStream] method
  static Future<void> getToken(String scope) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("scope", () => scope);

    methodChannel.invokeMethod<String>(Method.getToken, args);
  }

  /// Obtains the generation timestamp of an AAID.
  static Future<String> getCreationTime() async {
    final String result =
        await methodChannel.invokeMethod(Method.getCreationTime);
    return result;
  }

  /// Deletes a local AAID and its generation timestamp.
  static Future<String> deleteAAID() async {
    final String result = await methodChannel.invokeMethod(Method.deleteAAID);
    return Code[result];
  }

  /// Deletes the push token.
  ///
  /// Native Push SDK doesn't allow this operation on main thread which doesn't
  /// comply with method channels’ UI thread requirement of Flutter, so the result
  /// string and errors will be returned on TokenEventChannel's [onError] callback.
  static Future<void> deleteToken(String scope) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("scope", () => scope);

    methodChannel.invokeMethod(Method.deleteToken, args);
  }

  /// Getter for TokenEventChannel's Stream, which emits the requested push token
  /// and errors thrown with the Push SDK [Code] values.
  static Stream<String> get getTokenStream =>
      tokenEventChannel.receiveBroadcastStream().cast<String>();

  /// Getter for remoteMessageReceiveEventChannel's Stream, which emits the remote
  /// message object of received data messages from the Push Kit API
  static Stream<RemoteMessage> get onMessageReceivedStream =>
      remoteMessageReceiveEventChannel
          .receiveBroadcastStream()
          .map((event) => RemoteMessage.fromMap(json.decode(event)));

  /// Getter for RemoteMessageSendStatusEventChannel's Stream.
  ///
  /// This stream will emit the responses from following events from the Native
  /// Push SDK
  /// [onMessageSent] which fires after an uplink message is successfully sent.
  /// [onSendError] which fires after an uplink message fails to be sent.
  /// [onMessageDelivered] which sends the response from the app server to the app
  /// after an uplink message reaches to the app server if the receipt is enabled.
  ///
  /// Errors can be listened from the [onError] callback of the Stream.
  static Stream<String> get getRemoteMsgSendStatusStream =>
      remoteMessageSendStatusEventChannel
          .receiveBroadcastStream()
          .cast<String>();

  /// Sends uplink messages
  static Future<String> sendRemoteMessage(
      RemoteMessageBuilder remoteMsg) async {
    final String result =
        await methodChannel.invokeMethod(Method.send, remoteMsg.toMap());
    return Code[result];
  }

  /// Subscribes to topics
  ///
  /// The topic name must match the following regular expression:
  /// `[\u4e00-\u9fa5\w-_.~%]{1,900}`
  ///
  /// The HUAWEI Push Kit topic messaging function allows you to send messages to
  /// multiple devices whose users have subscribed to a specific topic.
  /// You can write messages about the topic as required, and HUAWEI Push Kit
  /// determines the release path and sends messages to the correct devices in a
  /// reliable manner.
  static Future<String> subscribe(String topic) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("topic", () => topic);

    final String result =
        await methodChannel.invokeMethod(Method.subscribe, args);
    return Code[result];
  }

  /// Unsubscribes from topics in asynchronous mode.
  static Future<String> unsubscribe(String topic) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("topic", () => topic);

    final String result =
        await methodChannel.invokeMethod(Method.unsubscribe, args);
    return Code[result];
  }

  /// Sets whether to enable automatic initialization.
  ///
  /// Auto Initialization can also be enabled by adding the meta-data under below
  /// to project's AndroidManifest.xml file, inside the <application> tag
  ///
  /// ```
  /// <meta-data
  ///   android:name="push_kit_auto_init_enabled"
  ///   android:value="true" />
  /// ```
  ///
  static Future<String> setAutoInitEnabled(bool enabled) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("enabled", () => enabled);

    final String result =
        await methodChannel.invokeMethod(Method.setAutoInitEnabled, args);
    return Code[result];
  }

  /// Checks whether automatic initialization is enabled.
  static Future<bool> isAutoInitEnabled() async {
    final bool result =
        await methodChannel.invokeMethod(Method.isAutoInitEnabled);
    return result;
  }

  /// Gets the values of the **agconnect-services.json** file
  static Future<String> getAgConnectValues() async {
    final String result =
        await methodChannel.invokeMethod<String>(Method.getAgConnectValues);
    return result;
  }

  /// Utility for showing an Android Toast Message
  static Future<Null> showToast(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    await methodChannel.invokeMethod(Method.showToast, args);
    return null;
  }

  /// Returns the initial custom intent of Remote Notification Message that starts the app
  /// Updates itself with the latest custom intent value if another Remote Notification Message
  /// with custom intent is tapped.
  static Future<String> getInitialIntent() async {
    final String result =
        await methodChannel.invokeMethod(Method.getInitialIntent);
    return result;
  }

  /// Returns the intent stream that emits custom notification intents from remote messages.
  ///
  /// The first custom intent that started the app will not be emitted on this
  /// stream use [getInitialIntent] method instead to obtain the initial intent
  /// that opened the app.
  static Stream<String> get getIntentStream =>
      remoteMessageNotificationIntentEventChannel
          .receiveBroadcastStream()
          .cast<String>();

  /// Returns a Map object representing the notification which opened the app.
  static Future<dynamic> getInitialNotification() async {
    final result =
        await methodChannel.invokeMethod(Method.getInitialNotification);
    if (result != null) {
      return result;
    }
    return null;
  }

  /// Getter for the NotificationOpenEventChannel's Stream.
  ///
  /// This stream emits a remote message object representing the clicked notification which opened the app.
  static Stream<dynamic> get onNotificationOpenedApp =>
      notificationOpenEventChannel
          .receiveBroadcastStream()
          .map((event) => json.decode(event))
          .cast<Map<String, dynamic>>();

  /// Getter for the LocalNotificationClickEventChannel's Stream
  ///
  /// After clicking the local notification button action, this stream will emit
  /// a remote message object that represents the clicked local notification
  static Stream<Map<String, dynamic>> get onLocalNotificationClick =>
      localNotificationClickEventChannel
          .receiveBroadcastStream()
          .map((event) => json.decode(event))
          .cast<Map<String, dynamic>>();

  /// Pushes a local notification instantly
  static Future<Map<String, dynamic>> localNotification(
      Map<String, dynamic> localNotification) async {
    final result = await methodChannel.invokeMethod(
        Method.localNotification, localNotification);
    Map<String, dynamic> resultMap = json.decode(result);
    return resultMap;
  }

  /// Schedules a local notification
  static Future<Map<String, dynamic>> localNotificationSchedule(
      Map<String, dynamic> localNotification) async {
    final result = await methodChannel.invokeMethod(
        Method.localNotificationSchedule, localNotification);
    Map<String, dynamic> resultMap = json.decode(result);
    return resultMap;
  }

  /// Returns the list of all active notifications
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final List<dynamic> notifications =
        await methodChannel.invokeMethod(Method.getNotifications);
    List<Map<String, dynamic>> result = [];
    notifications.forEach((element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Returns a list of all pending scheduled notifications
  static Future<List<Map<String, dynamic>>> getScheduledNotifications() async {
    final List<dynamic> scheduledNotifications =
        await methodChannel.invokeMethod(Method.getScheduledNotifications);
    List<Map<String, dynamic>> result = [];
    scheduledNotifications.forEach((element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Returns the list of all notification channels.
  static Future<List<String>> getChannels() async {
    final List result = await methodChannel.invokeMethod(Method.getChannels);
    List<String> strList = result.cast<String>();
    return strList;
  }

  /// Deletes a notification channel with the specified ID
  static Future<String> deleteChannel(String channelId) async {
    final String result =
        await methodChannel.invokeMethod(Method.deleteChannel, channelId);
    return Code[result];
  }

  /// Checks if the channel with the specified ID exists
  static Future<bool> channelExists(String channelId) async {
    final result =
        await methodChannel.invokeMethod(Method.channelExists, channelId);
    return result;
  }

  /// Checks if the notification channel with the specified ID is blocked
  static Future<bool> channelBlocked(String channelId) async {
    final result =
        await methodChannel.invokeMethod(Method.channelBlocked, channelId);
    return result;
  }

  /// Cancels all pending notifications registered in the notification manager
  static Future<void> cancelNotifications() async {
    methodChannel.invokeMethod(Method.cancelNotifications);
  }

  /// Cancels all pending scheduled notifications and the ones registered in the
  /// notification manager
  static Future<void> cancelAllNotifications() async {
    methodChannel.invokeMethod(Method.cancelAllNotifications);
  }

  /// Cancels all pending scheduled notifications
  static Future<void> cancelScheduledNotifications() async {
    methodChannel.invokeMethod(Method.cancelScheduledNotifications);
  }

  /// Cancels all active notifications with the specified tag
  static Future<void> cancelNotificationsWithTag(String tag) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithTag, tag);
  }

  /// Cancels all notification with the list of specified ID
  static Future<void> cancelNotificationsWithId(List<int> ids) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithId, ids);
  }

  /// Cancels all notifications with specified ID-Tag Map
  static Future<void> cancelNotificationsWithIdTag(
      Map<int, String> idTags) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithIdTag, idTags);
  }

  /// Enables HMS Plugin Method Analytics
  static Future<void> enableLogger() async {
    methodChannel.invokeMethod(Method.enableLogger);
  }

  /// Disables HMS Plugin Method Analytics
  static Future<void> disableLogger() async {
    methodChannel.invokeMethod(Method.disableLogger);
  }

  static Future<bool> registerBackgroundMessageHandler(
      void Function(RemoteMessage remoteMessage) callback) {
    int rawHandle =
        PluginUtilities.getCallbackHandle(callbackDispatcher).toRawHandle();
    print("rawHandle $rawHandle");
    int rawCallback = PluginUtilities.getCallbackHandle(callback).toRawHandle();
    print("rawCallback $rawCallback");
    return methodChannel.invokeMethod('registerBackgroundMessageHandler', {
      "rawHandle": rawHandle,
      "rawCallback": rawCallback
    }).then((result) => result == 1);
  }

  static Future<bool> removeBackgroundMessageHandler() {
    return methodChannel
        .invokeMethod('removeBackgroundMessageHandler')
        .then((result) => result == 1);
  }
}

void callbackDispatcher() {
  const MethodChannel backgroundMessageChannel =
      MethodChannel(Channel.BACKGROUND_MESSAGE_CHANNEL);
  WidgetsFlutterBinding.ensureInitialized();

  backgroundMessageChannel.setMethodCallHandler((MethodCall call) async {
    final Map<String, dynamic> args =
        Map<String, dynamic>.from(call.arguments[1]);
    RemoteMessage remoteMessage = RemoteMessage.fromMap(args);
    final Function rawHandler = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(call.arguments[0]));

    rawHandler(remoteMessage);
  });
}
