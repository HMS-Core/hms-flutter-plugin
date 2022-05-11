/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_push;

abstract class Push {
  /// Enables the function of receiving notification messages.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOnPush() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'turnOnPush',
    );
    return resultCodes[result] ?? resultCodes['-1']!;
  }

  /// Disables the function of receiving notification messages.
  ///
  /// Returns the corresponding Push SDK Result Code's Description
  static Future<String> turnOffPush() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'turnOffPush',
    );
    return resultCodes[result] ?? resultCodes['-1']!;
  }

  /// Before applying for a token, an app calls this method to obtain its unique AAID.
  ///
  /// The HUAWEI Push server generates a token for the app based on the AAID.
  /// If the AAID of the app changes, a new token will be generated next time when
  /// the app applies for a token. If an app needs to report statistics events,
  /// it must carry the AAID as its unique ID.
  static Future<String?> getId() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getId',
    );
    return result;
  }

  /// Obtains an AAID of Push SDK
  static Future<String?> getAAID() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getAAID',
    );
    return result;
  }

  /// Obtains the Application ID from the **agconnect-services.json** file
  static Future<String> getAppId() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getAppId',
    );
    return result!;
  }

  /// Obtains an open device ID (ODID) in asynchronous mode.
  static Future<String?> getOdid() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getOdid',
    );
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
  static void getToken(String scope) {
    _methodChannel.invokeMethod(
      'getToken',
      <String, String>{
        'scope': scope,
      },
    );
  }

  /// Obtains the generation timestamp of an AAID.
  static Future<String> getCreationTime() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getCreationTime',
    );
    return result!;
  }

  /// Deletes a local AAID and its generation timestamp.
  static Future<String> deleteAAID() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'deleteAAID',
    );
    return resultCodes[result]!;
  }

  /// Deletes the push token.
  static Future<String> deleteToken(String scope) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'deleteToken',
      <String, String>{
        'scope': scope,
      },
    );
    return resultCodes[result]!;
  }

  /// Deletes a token that a target app developer applies for a sender to integrate
  /// Push Kit in the multi-sender scenario.
  static Future<String> deleteMultiSenderToken(String subjectId) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'deleteMultiSenderToken',
      <String, String>{
        'subjectId': subjectId,
      },
    );
    return resultCodes[result]!;
  }

  /// Obtains the stream of [tokenEventChannel].
  ///
  /// The stream emits the requested push token and errors thrown with the Push
  /// SDK [Code] values.
  static Stream<String> get getTokenStream {
    return _tokenEventChannel.receiveBroadcastStream().cast<String>();
  }

  /// Obtains the stream of [multiSenderTokenEventChannel].
  ///
  /// The stream emits the requested push token and errors thrown with the Push
  /// SDK [Code] values in the multi-sender scenario.
  static Stream<Map<String, dynamic>> get getMultiSenderTokenStream {
    return _multiSenderTokenEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => jsonDecode(event));
  }

  /// Obtains the stream of [remoteMessageReceiveEventChannel].
  ///
  /// The stream emits the remote message object of received data messages from
  /// the Push Kit API.
  static Stream<RemoteMessage> get onMessageReceivedStream {
    return _remoteMessageReceiveEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => RemoteMessage.fromMap(json.decode(event)));
  }

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
  static Stream<String> get getRemoteMsgSendStatusStream {
    return _remoteMessageSendStatusEventChannel
        .receiveBroadcastStream()
        .cast<String>();
  }

  /// Sends an uplink message to the app server.
  ///
  /// After an uplink message is sent, the sent and delivered events and any errors
  /// involved will be emitted to [getRemoteMsgSendStatusStream].
  static Future<String> sendRemoteMessage(
    RemoteMessageBuilder remoteMsg,
  ) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'send',
      remoteMsg.toMap(),
    );
    return resultCodes[result]!;
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
    final String? result = await _methodChannel.invokeMethod<String?>(
      'subscribe',
      <String, String>{
        'topic': topic,
      },
    );
    return resultCodes[result]!;
  }

  /// Unsubscribes from topics that are subscribed to.
  ///
  /// When a topic is unsubscribed from, the user will not receive a notification
  /// from that topic.
  static Future<String> unsubscribe(String topic) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'unsubscribe',
      <String, String>{
        'topic': topic,
      },
    );
    return resultCodes[result]!;
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
    final String? result = await _methodChannel.invokeMethod<String?>(
      'setAutoInitEnabled',
      <String, bool>{
        'enabled': enabled,
      },
    );
    return resultCodes[result]!;
  }

  /// Checks whether automatic initialization is enabled.
  static Future<bool> isAutoInitEnabled() async {
    final bool? result = await _methodChannel.invokeMethod<bool?>(
      'isAutoInitEnabled',
    );
    return result!;
  }

  /// Obtains values from the **agconnect-services.json** file.
  static Future<String> getAgConnectValues() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getAgConnectValues',
    );
    return result!;
  }

  /// Utility for showing an Android Toast Message
  static Future<void> showToast(String msg) async {
    await _methodChannel.invokeMethod<void>(
      'showToast',
      <String, String>{
        'msg': msg,
      },
    );
  }

  /// Obtains the custom intent URI of the notification message which launches the app.
  ///
  /// If another notification message with a custom intent is selected, the return
  /// value will be updated.
  static Future<String?> getInitialIntent() async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'getInitialIntent',
    );
    return result;
  }

  /// Obtains the intent stream that emits custom notification intents from remote messages.
  ///
  /// The first custom intent that launches the app will not be emitted on this
  /// stream. Use the [getInitialIntent] method instead to obtain the initial intent
  /// that launches the app.
  static Stream<String> get getIntentStream {
    return _remoteMessageNotificationIntentEventChannel
        .receiveBroadcastStream()
        .cast<String>();
  }

  /// Obtains the object that includes **remoteMessage**, **extras** and **uriPage**
  /// of the notification message which launches the app after being tapped.
  static Future<dynamic> getInitialNotification() async {
    final dynamic result = await _methodChannel.invokeMethod<dynamic>(
      'getInitialNotification',
    );
    return result;
  }

  /// Obtains the stream of [notificationOpenEventChannel].
  ///
  /// The stream emits an object representing the selected notification message
  /// that launches the app.
  static Stream<dynamic> get onNotificationOpenedApp {
    return _notificationOpenEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => json.decode(event))
        .cast<Map<String, dynamic>>();
  }

  /// Obtains the stream of [localNotificationClickEventChannel].
  ///
  /// This stream emits the local notification message payload when a user taps to
  /// an action button.
  static Stream<Map<String, dynamic>> get onLocalNotificationClick {
    return _localNotificationClickEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => json.decode(event))
        .cast<Map<String, dynamic>>();
  }

  /// Pushes a local notification message instantly.
  static Future<Map<String, dynamic>> localNotification(
    Map<String, dynamic> localNotification,
  ) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'localNotification',
      localNotification,
    );
    Map<String, dynamic> resultMap = json.decode(result!);
    return resultMap;
  }

  /// Schedules a local notification message to be pushed at a future time.
  static Future<Map<String, dynamic>> localNotificationSchedule(
    Map<String, dynamic> localNotification,
  ) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'localNotificationSchedule',
      localNotification,
    );
    Map<String, dynamic> resultMap = json.decode(result!);
    return resultMap;
  }

  /// Obtains the list of all active notification messages.
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final List<dynamic>? notifications =
        await _methodChannel.invokeMethod<List<dynamic>?>(
      'getNotifications',
    );
    List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    notifications?.forEach((dynamic element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Obtains the list of all pending scheduled notification messages.
  static Future<List<Map<String, dynamic>>> getScheduledNotifications() async {
    final List<dynamic>? scheduledNotifications =
        await _methodChannel.invokeMethod<List<dynamic>?>(
      'getScheduledNotifications',
    );
    List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    scheduledNotifications?.forEach((dynamic element) {
      result.add(json.decode(element));
    });
    return result;
  }

  /// Obtains the list of all notification channels.
  static Future<List<String>> getChannels() async {
    final List<dynamic>? result =
        await _methodChannel.invokeMethod<List<dynamic>?>(
      'getChannels',
    );
    List<String> strList = (result ?? <dynamic>[]).cast<String>();
    return strList;
  }

  /// Deletes a notification channel with the given ID.
  static Future<String> deleteChannel(String channelId) async {
    final String? result = await _methodChannel.invokeMethod<String?>(
      'deleteChannel',
      channelId,
    );
    return resultCodes[result] ?? resultCodes['-1']!;
  }

  /// Checks whether a notification channel with the given ID exists.
  static Future<bool> channelExists(String channelId) async {
    final bool? result = await _methodChannel.invokeMethod<bool?>(
      'channelExists',
      channelId,
    );
    return result!;
  }

  /// Checks whether a notification channel with the given ID is blocked.
  static Future<bool> channelBlocked(String channelId) async {
    final bool? result = await _methodChannel.invokeMethod<bool?>(
      'channelBlocked',
      channelId,
    );
    return result!;
  }

  /// Cancels all pending notification messages registered in the notification manager.
  static Future<void> cancelNotifications() async {
    await _methodChannel.invokeMethod<void>(
      'cancelNotifications',
    );
  }

  /// Cancels all pending scheduled notifications and the ones registered in the
  /// notification manager
  static Future<void> cancelAllNotifications() async {
    await _methodChannel.invokeMethod<void>(
      'cancelAllNotifications',
    );
  }

  /// Cancels all pending scheduled notification messages.
  static Future<void> cancelScheduledNotifications() async {
    await _methodChannel.invokeMethod<void>(
      'cancelScheduledNotifications',
    );
  }

  /// Cancels all notification messages with the specified tag.
  static Future<void> cancelNotificationsWithTag(String tag) async {
    await _methodChannel.invokeMethod<void>(
      'cancelNotificationsWithTag',
      tag,
    );
  }

  /// Cancels all pending notification messages by a list of IDs.
  static Future<void> cancelNotificationsWithId(List<int> ids) async {
    await _methodChannel.invokeMethod<void>(
      'cancelNotificationsWithId',
      ids,
    );
  }

  /// Cancels all pending notification messages by a Map of keys as IDs and values
  /// as tags.
  ///
  /// Types are integer and String respectively.
  static Future<void> cancelNotificationsWithIdTag(
    Map<int, String> idTags,
  ) async {
    await _methodChannel.invokeMethod<void>(
      'cancelNotificationsWithIdTag',
      idTags,
    );
  }

  /// Obtains a token that a target app developer applies for a sender to integrate
  /// Push Kit in the multi-sender scenario.
  ///
  /// The requested token will be emitted to the multi sender token stream. Listen for the stream
  /// from [getMultiSenderTokenStream] to obtain the token.
  static Future<void> getMultiSenderToken(String subjectId) async {
    await _methodChannel.invokeMethod<void>(
      'getMultiSenderToken',
      <String, String>{
        'subjectId': subjectId,
      },
    );
  }

  /// Enables HMS Plugin Method Analytics
  static Future<void> enableLogger() async {
    await _methodChannel.invokeMethod<void>(
      'enableLogger',
    );
  }

  /// Disables HMS Plugin Method Analytics
  static Future<void> disableLogger() async {
    await _methodChannel.invokeMethod<void>(
      'disableLogger',
    );
  }

  /// Defines a function to handle background messages.
  static Future<bool> registerBackgroundMessageHandler(
    void Function(RemoteMessage remoteMessage) callback,
  ) async {
    int rawHandle =
        PluginUtilities.getCallbackHandle(callbackDispatcher)!.toRawHandle();
    debugPrint('rawHandle $rawHandle');

    int rawCallback =
        PluginUtilities.getCallbackHandle(callback)!.toRawHandle();
    debugPrint('rawCallback $rawCallback');

    final bool? result = await _methodChannel.invokeMethod<bool?>(
      'registerBackgroundMessageHandler',
      <String, int>{
        'rawHandle': rawHandle,
        'rawCallback': rawCallback,
      },
    );
    return result!;
  }

  /// Revokes the background message handler.
  static Future<bool> removeBackgroundMessageHandler() async {
    final bool? result = await _methodChannel.invokeMethod<bool?>(
      'removeBackgroundMessageHandler',
    );
    return result!;
  }
}

/// Callback function for handling received [RemoteMessage] objects in the background.
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  _backgroundMessageMethodChannel.setMethodCallHandler(
    (MethodCall call) async {
      RemoteMessage remoteMessage = RemoteMessage.fromMap(
        Map<String, dynamic>.from(call.arguments[1]),
      );
      final Function rawHandler = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(
          call.arguments[0],
        ),
      )!;
      rawHandler(remoteMessage);
    },
  );

  _backgroundMessageMethodChannel.invokeMethod<void>(
    'BackgroundRunner.initialize',
  );
}
