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

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_push/src/constants/constants_export.dart';
import 'package:huawei_push/src/model/remote_message.dart';

import 'package:huawei_push/src/constants/channel.dart';
import 'package:huawei_push/src/constants/method.dart' as Method;

class Push {
  /// Enables the function of receiving notification messages.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOnPush() async {
    final String result =
        await methodChannel.invokeMethod(Method.turnOnPush) ?? '-1';
    return ResultCodes[result];
  }

  /// Disables the function of receiving notification messages.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOffPush() async {
    final String result =
        await methodChannel.invokeMethod(Method.turnOffPush) ?? '-1';
    return ResultCodes[result];
  }

  /// Before applying for a token, an app calls this method to obtain its unique AAID.
  ///
  /// The HUAWEI Push server generates a token for the app based on the AAID.
  /// If the AAID of the app changes, a new token will be generated next time when
  /// the app applies for a token. If an app needs to report statistics events,
  /// it must carry the AAID as its unique ID.
  static Future<String?> getId() async {
    final String? result = await methodChannel.invokeMethod(Method.getId);
    return result;
  }

  /// Obtains an AAID of Push SDK
  static Future<String?> getAAID() async {
    final String? result = await methodChannel.invokeMethod(Method.getAAID);
    return result;
  }

  /// Obtains the Application ID from the **agconnect-services.json** file
  static Future<String> getAppId() async {
    final String result = await methodChannel.invokeMethod(Method.getAppId);
    return result;
  }

  /// Obtains an open device ID (ODID) in asynchronous mode.
  static Future<String?> getOdid() async {
    final String? result = await methodChannel.invokeMethod(Method.getOdid);
    return result;
  }

  /// Requests a token that is required for accessing HUAWEI Push Kit.
  ///
  /// If there is no local AAID, this method will automatically generate an AAID
  /// when it is called because the HUAWEI Push Kit server needs to generate a token
  /// based on the AAID.
  ///
  /// The requested token will be emitted to the token stream. Listen for the stream
  /// from [getTokenStream] to obtain the token.
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
    return ResultCodes[result];
  }

  /// Deletes the push token.
  static Future<String> deleteToken(String scope) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("scope", () => scope);
    String result = await methodChannel.invokeMethod(Method.deleteToken, args);
    return ResultCodes[result];
  }

  /// Deletes a token that a target app developer applies for a sender to integrate
  /// Push Kit in the multi-sender scenario.
  static Future<String> deleteMultiSenderToken(String subjectId) async {
    String result = await methodChannel
        .invokeMethod(Method.deleteToken, {'subjectId': subjectId});
    return ResultCodes[result];
  }

  /// Obtains the stream of [tokenEventChannel].
  ///
  /// The stream emits the requested push token and errors thrown with the Push
  /// SDK [Code] values.
  static Stream<String> get getTokenStream =>
      tokenEventChannel.receiveBroadcastStream().cast<String>();

  /// Obtains the stream of [multiSenderTokenEventChannel].
  ///
  /// The stream emits the requested push token and errors thrown with the Push
  /// SDK [Code] values in the multi-sender scenario.
  static Stream<Map<String, dynamic>> get getMultiSenderTokenStream =>
      multiSenderTokenEventChannel
          .receiveBroadcastStream()
          .map((event) => jsonDecode(event));

  /// Obtains the stream of [remoteMessageReceiveEventChannel].
  ///
  /// The stream emits the remote message object of received data messages from
  /// the Push Kit API.
  static Stream<RemoteMessage> get onMessageReceivedStream =>
      remoteMessageReceiveEventChannel
          .receiveBroadcastStream()
          .map((event) => RemoteMessage.fromMap(json.decode(event)));

  /// Obtains the stream of [remoteMessageSendStatusEventChannel].
  ///
  /// This stream emits the responses from following events from the Native
  /// Push SDK
  /// [onMessageSent] is triggered after an uplink message is successfully sent.
  /// [onSendError]  is triggered after an uplink message fails to be sent.
  /// [onMessageDelivered] sends a response from the app server to the app after
  /// an uplink message reaches to the app server if the receipt is enabled.
  ///
  /// Errors can be listened from the **onError** callback of the Stream.
  static Stream<String> get getRemoteMsgSendStatusStream =>
      remoteMessageSendStatusEventChannel
          .receiveBroadcastStream()
          .cast<String>();

  /// Sends an uplink message to the app server.
  ///
  /// After an uplink message is sent, the sent and delivered events and any errors
  /// involved will be emitted to [getRemoteMsgSendStatusStream].
  static Future<String> sendRemoteMessage(
      RemoteMessageBuilder remoteMsg) async {
    final String result =
        await methodChannel.invokeMethod(Method.send, remoteMsg.toMap());
    return ResultCodes[result];
  }

  /// Subscribes to topics.
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
    return ResultCodes[result];
  }

  /// Unsubscribes from topics that are subscribed to.
  ///
  /// When a topic is unsubscribed from, the user will not receive a notification
  /// from that topic.
  static Future<String> unsubscribe(String topic) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("topic", () => topic);

    final String result =
        await methodChannel.invokeMethod(Method.unsubscribe, args);
    return ResultCodes[result];
  }

  /// Determines whether to enable automatic initialization.
  ///
  /// If this parameter is set to true, the Push SDK automatically generates an
  /// AAID and applies for a token.
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
    return ResultCodes[result];
  }

  /// Checks whether automatic initialization is enabled.
  static Future<bool> isAutoInitEnabled() async {
    final bool result =
        await methodChannel.invokeMethod(Method.isAutoInitEnabled);
    return result;
  }

  /// Obtains values from the **agconnect-services.json** file.
  static Future<String> getAgConnectValues() async {
    final String result =
        await methodChannel.invokeMethod(Method.getAgConnectValues);
    return result;
  }

  /// Utility for showing an Android Toast Message
  static Future<void> showToast(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    await methodChannel.invokeMethod(Method.showToast, args);
  }

  /// Obtains the custom intent URI of the notification message which launches the app.
  ///
  /// If another notification message with a custom intent is selected, the return
  /// value will be updated.
  static Future<String?> getInitialIntent() async {
    final String? result =
        await methodChannel.invokeMethod(Method.getInitialIntent);
    return result;
  }

  /// Obtains the intent stream that emits custom notification intents from remote messages.
  ///
  /// The first custom intent that launches the app will not be emitted on this
  /// stream. Use the [getInitialIntent] method instead to obtain the initial intent
  /// that launches the app.
  static Stream<String> get getIntentStream =>
      remoteMessageNotificationIntentEventChannel
          .receiveBroadcastStream()
          .cast<String>();

  /// Obtains the object that includes **remoteMessage**, **extras** and **uriPage**
  /// of the notification message which launches the app after being tapped.
  static Future<dynamic> getInitialNotification() async {
    final result =
        await methodChannel.invokeMethod(Method.getInitialNotification);
    if (result != null) {
      return result;
    }
    return null;
  }

  /// Obtains the stream of [notificationOpenEventChannel].
  ///
  /// The stream emits an object representing the selected notification message
  /// that launches the app.
  static Stream<dynamic> get onNotificationOpenedApp =>
      notificationOpenEventChannel
          .receiveBroadcastStream()
          .map((event) => json.decode(event))
          .cast<Map<String, dynamic>>();

  /// Obtains the stream of [localNotificationClickEventChannel].
  ///
  /// This stream emits the local notification message payload when a user taps to
  /// an action button.
  static Stream<Map<String, dynamic>> get onLocalNotificationClick =>
      localNotificationClickEventChannel
          .receiveBroadcastStream()
          .map((event) => json.decode(event))
          .cast<Map<String, dynamic>>();

  /// Pushes a local notification message instantly.
  static Future<Map<String, dynamic>> localNotification(
      Map<String, dynamic> localNotification) async {
    final result = await methodChannel.invokeMethod(
        Method.localNotification, localNotification);
    Map<String, dynamic> resultMap = json.decode(result);
    return resultMap;
  }

  /// Schedules a local notification message to be pushed at a future time.
  static Future<Map<String, dynamic>> localNotificationSchedule(
      Map<String, dynamic> localNotification) async {
    final result = await methodChannel.invokeMethod(
        Method.localNotificationSchedule, localNotification);
    Map<String, dynamic> resultMap = json.decode(result);
    return resultMap;
  }

  /// Obtains the list of all active notification messages.
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final List<dynamic>? notifications =
        await methodChannel.invokeMethod(Method.getNotifications);
    List<Map<String, dynamic>> result = [];
    notifications?.forEach((element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Obtains the list of all pending scheduled notification messages.
  static Future<List<Map<String, dynamic>>> getScheduledNotifications() async {
    final List<dynamic>? scheduledNotifications =
        await methodChannel.invokeMethod(Method.getScheduledNotifications);
    List<Map<String, dynamic>> result = [];
    scheduledNotifications?.forEach((element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Obtains the list of all notification channels.
  static Future<List<String>> getChannels() async {
    final List result =
        await methodChannel.invokeMethod(Method.getChannels) ?? [];
    List<String> strList = result.cast<String>();
    return strList;
  }

  /// Deletes a notification channel with the given ID.
  static Future<String> deleteChannel(String channelId) async {
    final String result =
        await methodChannel.invokeMethod(Method.deleteChannel, channelId) ??
            '-1';
    return ResultCodes[result];
  }

  /// Checks whether a notification channel with the given ID exists.
  static Future<bool> channelExists(String channelId) async {
    final result =
        await methodChannel.invokeMethod(Method.channelExists, channelId);
    return result;
  }

  /// Checks whether a notification channel with the given ID is blocked.
  static Future<bool> channelBlocked(String channelId) async {
    final result =
        await methodChannel.invokeMethod(Method.channelBlocked, channelId);
    return result;
  }

  /// Cancels all pending notification messages registered in the notification manager.
  static Future<void> cancelNotifications() async {
    methodChannel.invokeMethod(Method.cancelNotifications);
  }

  /// Cancels all pending scheduled notifications and the ones registered in the
  /// notification manager
  static Future<void> cancelAllNotifications() async {
    methodChannel.invokeMethod(Method.cancelAllNotifications);
  }

  /// Cancels all pending scheduled notification messages.
  static Future<void> cancelScheduledNotifications() async {
    methodChannel.invokeMethod(Method.cancelScheduledNotifications);
  }

  /// Cancels all notification messages with the specified tag.
  static Future<void> cancelNotificationsWithTag(String tag) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithTag, tag);
  }

  /// Cancels all pending notification messages by a list of IDs.
  static Future<void> cancelNotificationsWithId(List<int> ids) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithId, ids);
  }

  /// Cancels all pending notification messages by a Map of keys as IDs and values
  /// as tags.
  ///
  /// Types are integer and String respectively.
  static Future<void> cancelNotificationsWithIdTag(
      Map<int, String> idTags) async {
    methodChannel.invokeMethod(Method.cancelNotificationsWithIdTag, idTags);
  }

  /// Obtains a token that a target app developer applies for a sender to integrate
  /// Push Kit in the multi-sender scenario.
  ///
  /// The requested token will be emitted to the multi sender token stream. Listen for the stream
  /// from [getMultiSenderTokenStream] to obtain the token.
  static Future<void> getMultiSenderToken(String subjectId) async {
    methodChannel
        .invokeMethod(Method.getMultiSenderToken, {"subjectId": subjectId});
  }

  /// Enables HMS Plugin Method Analytics
  static Future<void> enableLogger() async {
    methodChannel.invokeMethod(Method.enableLogger);
  }

  /// Disables HMS Plugin Method Analytics
  static Future<void> disableLogger() async {
    methodChannel.invokeMethod(Method.disableLogger);
  }

  /// Defines a function to handle background messages.
  static Future<bool> registerBackgroundMessageHandler(
      void Function(RemoteMessage remoteMessage) callback) async {
    int rawHandle =
        PluginUtilities.getCallbackHandle(callbackDispatcher)!.toRawHandle();
    print("rawHandle $rawHandle");
    int rawCallback =
        PluginUtilities.getCallbackHandle(callback)!.toRawHandle();
    print("rawCallback $rawCallback");
    return await methodChannel.invokeMethod('registerBackgroundMessageHandler',
        {"rawHandle": rawHandle, "rawCallback": rawCallback});
  }

  /// Revokes the background message handler.
  static Future<bool> removeBackgroundMessageHandler() async {
    return await methodChannel.invokeMethod('removeBackgroundMessageHandler');
  }
}

/// Callback function for handling received [RemoteMessage] objects in the background.
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  backgroundMessageChannel.setMethodCallHandler((MethodCall call) async {
    final Map<String, dynamic> args =
        Map<String, dynamic>.from(call.arguments[1]);
    RemoteMessage remoteMessage = RemoteMessage.fromMap(args);
    final Function rawHandler = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(call.arguments[0]))!;
    rawHandler(remoteMessage);
  });
  backgroundMessageChannel.invokeMethod<void>("BackgroundRunner.initialize");
}
