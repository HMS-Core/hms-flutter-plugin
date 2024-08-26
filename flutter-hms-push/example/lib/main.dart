/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:huawei_push/huawei_push.dart';

void main() {
  runApp(const PushKitDemoApp());
}

class PushKitDemoApp extends StatelessWidget {
  const PushKitDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController logTextController;
  late TextEditingController topicTextController;

  final EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 5,
    horizontal: 16,
  );

  String _token = '';

  void _onTokenEvent(String event) {
    _token = event;
    showResult('TokenEvent', _token);
  }

  void _onTokenError(Object error) {
    PlatformException e = error as PlatformException;
    showResult('TokenErrorEvent', e.message!);
  }

  void _onMessageReceived(RemoteMessage remoteMessage) {
    String? data = remoteMessage.data;
    if (data != null) {
      Push.localNotification(
        <String, String>{
          HMSLocalNotificationAttr.TITLE: 'DataMessage Received',
          HMSLocalNotificationAttr.MESSAGE: data,
        },
      );
      showResult('onMessageReceived', 'Data: $data');
    } else {
      showResult('onMessageReceived', 'No data is present.');
    }
  }

  void _onMessageReceiveError(Object error) {
    showResult('onMessageReceiveError', error.toString());
  }

  void _onRemoteMessageSendStatus(String event) {
    showResult('RemoteMessageSendStatus', 'Status: $event');
  }

  void _onRemoteMessageSendError(Object error) {
    PlatformException e = error as PlatformException;
    showResult('RemoteMessageSendError', 'Error: $e');
  }

  void _onNewIntent(String? intentString) {
    // For navigating to the custom intent page (deep link) the custom
    // intent that sent from the push kit console is:
    // app://app2
    intentString = intentString ?? '';
    if (intentString != '') {
      showResult('CustomIntentEvent: ', intentString);
      List<String> parsedString = intentString.split('://');
      if (parsedString[1] == 'app2') {
        SchedulerBinding.instance.addPostFrameCallback(
          (Duration timeStamp) {
            Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const CustomIntentPage(),
              ),
            );
          },
        );
      }
    }
  }

  void _onIntentError(Object err) {
    PlatformException e = err as PlatformException;
    debugPrint('Error on intent stream: $e');
  }

  void _onNotificationOpenedApp(dynamic initialNotification) {
    if (initialNotification != null) {
      showResult('onNotificationOpenedApp', initialNotification.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Push.enableLogger();
    logTextController = TextEditingController();
    topicTextController = TextEditingController();
    Push.disableLogger();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    // If you want auto init enabled, after getting user agreement call this method.
    await Push.setAutoInitEnabled(true);

    Push.getTokenStream.listen(
      _onTokenEvent,
      onError: _onTokenError,
    );
    Push.getIntentStream.listen(
      _onNewIntent,
      onError: _onIntentError,
    );
    Push.onNotificationOpenedApp.listen(
      _onNotificationOpenedApp,
    );

    final dynamic initialNotification = await Push.getInitialNotification();
    _onNotificationOpenedApp(initialNotification);

    final String? intent = await Push.getInitialIntent();
    _onNewIntent(intent);

    Push.onMessageReceivedStream.listen(
      _onMessageReceived,
      onError: _onMessageReceiveError,
    );
    Push.getRemoteMsgSendStatusStream.listen(
      _onRemoteMessageSendStatus,
      onError: _onRemoteMessageSendError,
    );

    bool backgroundMessageHandler = await Push.registerBackgroundMessageHandler(
      backgroundMessageCallback,
    );
    debugPrint(
      'backgroundMessageHandler registered: $backgroundMessageHandler',
    );
  }

  void removeBackgroundMessageHandler() async {
    await Push.removeBackgroundMessageHandler();
  }

  @override
  void dispose() {
    logTextController.dispose();
    topicTextController.dispose();
    super.dispose();
  }

  void turnOnPush() async {
    String result = await Push.turnOnPush();
    showResult('turnOnPush', result);
  }

  void turnOffPush() async {
    String result = await Push.turnOffPush();
    showResult('turnOffPush', result);
  }

  void getId() async {
    String? result = await Push.getId();
    showResult('getId', result);
  }

  void getAAID() async {
    String? result = await Push.getAAID();
    showResult('getAAID', result);
  }

  void getAppId() async {
    String result = await Push.getAppId();
    showResult('getAppId', result);
  }

  void getOdid() async {
    String? result = await Push.getOdid();
    showResult('getOdid', result);
  }

  void getCreationTime() async {
    String result = await Push.getCreationTime();
    showResult('getCreationTime', result);
  }

  void deleteToken() async {
    String result = await Push.deleteToken('');
    showResult('deleteToken', result);
  }

  void deleteAAID() async {
    String result = await Push.deleteAAID();
    showResult('deleteAAID', result);
  }

  void sendRemoteMsg() async {
    RemoteMessageBuilder remoteMsg = RemoteMessageBuilder(
      to: '',
      data: <String, String>{'Data': 'test'},
      messageType: 'my_type',
      ttl: 120,
      messageId: Random().nextInt(10000).toString(),
      collapseKey: '-1',
      sendMode: 1,
      receiptMode: 1,
    );
    String result = await Push.sendRemoteMessage(remoteMsg);
    showResult('sendRemoteMessage', result);
  }

  void subscribe() async {
    try {
      String topic = topicTextController.text;
      String result = await Push.subscribe(topic);
      showResult('subscribe', result);
    } catch (e) {
      showResult('subscribe', '$e');
    }
  }

  void unsubscribe() async {
    try {
      String topic = topicTextController.text;
      String result = await Push.unsubscribe(topic);
      showResult('unsubscribe', result);
    } catch (e) {
      showResult('unsubscribe', '$e');
    }
  }

  void enableAutoInit() async {
    String result = await Push.setAutoInitEnabled(true);
    showResult('enableAutoInit', result);
  }

  void disableAutoInit() async {
    String result = await Push.setAutoInitEnabled(false);
    showResult('disableAutoInit', result);
  }

  void isAutoInitEnabled() async {
    bool result = await Push.isAutoInitEnabled();
    showResult('isAutoInitEnabled', result.toString());
  }

  void getInitialNotification() async {
    final dynamic initialNotification = await Push.getInitialNotification();
    showResult('getInitialNotification', initialNotification.toString());
  }

  void getInitialIntent() async {
    final String? initialIntent = await Push.getInitialIntent();
    showResult('getInitialIntent', initialIntent);
  }

  void getAgConnectValues() async {
    String result = await Push.getAgConnectValues();
    showResult('getAgConnectValues', result);
  }

  void clearLog() {
    setState(() {
      logTextController.text = '';
    });
  }

  void consentOn() async {
    try {
      String? result = await Push.consentOn();
      showResult('consentOn', result);
    } catch (e) {
      showResult('consentOn', '$e');
    }
  }

  void consentOff() async {
    try {
      String? result = await Push.consentOff();
      showResult('consentOff', result);
    } catch (e) {
      showResult('consentOff', '$e');
    }
  }

  void showResult(
    String name, [
    String? msg = 'Button pressed.',
  ]) {
    msg ??= '';
    appendLog('[$name]: $msg');
    debugPrint('[$name]: $msg');
    Push.showToast('[$name]: $msg');
  }

  void appendLog([
    String msg = 'Button pressed.',
  ]) {
    setState(() {
      logTextController.text = '$msg\n${logTextController.text}';
    });
  }

  Widget expandedButton(
    int flex,
    Function func,
    String txt, {
    double fontSize = 16.0,
    Color? color,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding,
        child: ElevatedButton(
          onPressed: () {
            func();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey.shade300,
          ),
          child: Text(
            txt,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔔 HMS Push Kit Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: <Widget>[
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          const CustomIntentPage(),
                    ),
                  ),
                  'Open Custom Intent URI Page',
                  color: Colors.deepOrangeAccent,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          const LocalNotificationPage(),
                    ),
                  ),
                  'Local Notification',
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          const MultiSenderPage(),
                    ),
                  ),
                  'Multi Sender Page',
                  color: Colors.yellow,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => turnOnPush(),
                  'TurnOnPush',
                ),
                expandedButton(
                  5,
                  () => turnOffPush(),
                  'TurnOffPush',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  4,
                  () => getId(),
                  'GetID',
                  fontSize: 14,
                ),
                expandedButton(
                  4,
                  () => getAAID(),
                  'GetAAID',
                  fontSize: 14,
                ),
                expandedButton(
                  4,
                  () => getOdid(),
                  'GetODID',
                  fontSize: 14,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => Push.getToken(''),
                  'GetToken',
                ),
                expandedButton(
                  5,
                  () => getCreationTime(),
                  'GetCreationTime',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => deleteToken(),
                  'DeleteToken',
                ),
                expandedButton(
                  5,
                  () => deleteAAID(),
                  'DeleteAAID',
                ),
              ],
            ),
            const Divider(thickness: .5),
            Padding(
              padding: padding,
              child: TextField(
                controller: topicTextController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Topic Name',
                ),
              ),
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => subscribe(),
                  'Subscribe',
                ),
                expandedButton(
                  5,
                  () => unsubscribe(),
                  'UnSubscribe',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => disableAutoInit(),
                  'Disable AutoInit',
                ),
                expandedButton(
                  5,
                  () => enableAutoInit(),
                  'Enable AutoInit',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => isAutoInitEnabled(),
                  'IsAutoInitEnabled',
                ),
                expandedButton(
                  5,
                  () => sendRemoteMsg(),
                  'sendRemoteMessage',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  6,
                  () => getInitialNotification(),
                  'getInitialNotification',
                ),
                expandedButton(
                  6,
                  () => getInitialIntent(),
                  'getInitialIntent',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => consentOn(),
                  'consentOn',
                ),
                expandedButton(
                  5,
                  () => consentOff(),
                  'consentOff',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => clearLog(),
                  'Clear Log',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                expandedButton(
                  5,
                  () => getAgConnectValues(),
                  'Get agconnect values',
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: padding,
              child: TextField(
                controller: logTextController,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                readOnly: true,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void backgroundMessageCallback(RemoteMessage remoteMessage) async {
  String? data = remoteMessage.data;
  if (data != null) {
    debugPrint(
      'Background message is received, sending local notification.',
    );
    Push.localNotification(
      <String, String>{
        HMSLocalNotificationAttr.TITLE: '[Headless] DataMessage Received',
        HMSLocalNotificationAttr.MESSAGE: data,
      },
    );
  } else {
    debugPrint(
      'Background message is received. There is no data in the message.',
    );
  }
}

class CustomIntentPage extends StatelessWidget {
  const CustomIntentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Push Kit Demo - Custom Intent URI Page',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://developer.huawei.com/dev_index/img/bbs_en_logo.png?v=123',
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Page to be opened with Custom Intent URI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocalNotificationPage extends StatefulWidget {
  const LocalNotificationPage({Key? key}) : super(key: key);

  @override
  State<LocalNotificationPage> createState() => _LocalNotificationPageState();
}

class _LocalNotificationPageState extends State<LocalNotificationPage> {
  final EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 1.0,
    horizontal: 10,
  );
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  TextEditingController titleTextController = TextEditingController(
    text: 'HMS PUSH',
  );
  TextEditingController msgTextController = TextEditingController(
    text: 'This is local notification',
  );
  TextEditingController bigTextController = TextEditingController(
    text: 'This is a big text',
  );
  TextEditingController subTextController = TextEditingController(
    text: 'This is a sub text',
  );
  TextEditingController tagTextController = TextEditingController();
  TextEditingController logTextController = TextEditingController();

  late Map<String, dynamic> receivedNotification;
  Map<String, dynamic> defaultNotification = <String, dynamic>{
    HMSLocalNotificationAttr.TITLE: 'Notification Title',
    HMSLocalNotificationAttr.MESSAGE: 'Notification Message',
    HMSLocalNotificationAttr.TICKER: 'Optional Ticker',
    HMSLocalNotificationAttr.SHOW_WHEN: true,
    // HMSLocalNotificationAttr.LARGE_ICON_URL: 'https://developer.huawei.com/Enexport/sites/default/images/en/Develop/hms/push/push2-tuidedao.png',
    HMSLocalNotificationAttr.LARGE_ICON: 'ic_launcher',
    // The notification small icon should be put under `android/app/res/mipmap` directory.
    HMSLocalNotificationAttr.SMALL_ICON: 'ic_notification',
    HMSLocalNotificationAttr.BIG_TEXT: 'This is a bigText',
    HMSLocalNotificationAttr.SUB_TEXT: 'This is a subText',
    HMSLocalNotificationAttr.COLOR: 'white',
    HMSLocalNotificationAttr.VIBRATE: false,
    HMSLocalNotificationAttr.VIBRATE_DURATION: 1000,
    HMSLocalNotificationAttr.TAG: 'hms_tag',
    HMSLocalNotificationAttr.GROUP_SUMMARY: false,
    HMSLocalNotificationAttr.ONGOING: false,
    HMSLocalNotificationAttr.IMPORTANCE: Importance.MAX,
    HMSLocalNotificationAttr.DONT_NOTIFY_IN_FOREGROUND: false,
    HMSLocalNotificationAttr.AUTO_CANCEL: false,
    HMSLocalNotificationAttr.ACTIONS: <String>[
      'Yes',
      'No',
    ],
    HMSLocalNotificationAttr.INVOKE_APP: false,
    HMSLocalNotificationAttr.DATA: Map<String, dynamic>.from(
      <String, dynamic>{
        'string_val': 'pushkit',
        'int_val': 15,
      },
    ),
    // HMSLocalNotificationAttr.CHANNEL_ID: 'huawei-hms-flutter-push-channel-id', // Please read the Android Documentation before using this param
  };

  Map<String, dynamic> _constructNotificationMap() {
    Map<String, dynamic> notification = Map<String, dynamic>.from(
      defaultNotification,
    );
    notification[HMSLocalNotificationAttr.TAG] = tagTextController.text;
    notification[HMSLocalNotificationAttr.TITLE] = titleTextController.text;
    notification[HMSLocalNotificationAttr.BIG_TEXT] = bigTextController.text;
    notification[HMSLocalNotificationAttr.SUB_TEXT] = subTextController.text;
    notification[HMSLocalNotificationAttr.MESSAGE] = msgTextController.text;
    return notification;
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    Push.onLocalNotificationClick.listen(
      _onLocalNotificationClickEvent,
      onError: _onLocalNotificationClickErr,
    );
  }

  void _onLocalNotificationClickEvent(Map<String, dynamic> event) {
    receivedNotification = event;
    if (mounted) {
      // Check if widget is still mounted to call setState
      showResult(
        'onLocalNotificationClickEvent',
        receivedNotification.toString(),
      );
    }
    Push.showToast('Clicked: ${receivedNotification['action']}');
    if (receivedNotification[HMSLocalNotificationAttr.ACTION] == 'Yes') {
      int id = int.parse(receivedNotification[HMSLocalNotificationAttr.ID]);
      String? tag = receivedNotification[HMSLocalNotificationAttr.TAG];
      if (tag != null) {
        Push.cancelNotificationsWithIdTag(
          <int, String>{id: tag},
        ).then(
          (_) => showResult(
            'cancelNotificationsWithIdTag',
            'Cancelled, Notification with id: $id, and tag: $tag',
          ),
        );
      } else {
        Push.cancelNotificationsWithId(
          <int>[id],
        ).then(
          (_) => showResult(
            'cancelNotificationsWithId',
            'Cancelled, Notification with id: $id',
          ),
        );
      }
    }
  }

  void _onLocalNotificationClickErr(dynamic err) => showResult(
        'onLocalNotificationClickError',
        err.toString(),
      );

  void _clearLog() {
    setState(() {
      logTextController.text = '';
    });
  }

  void _localNotification() async {
    try {
      Map<String, dynamic> notification = _constructNotificationMap();
      Map<String, dynamic> response = await Push.localNotification(
        notification,
      );
      showResult(
        'localNotification',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationError',
        e.toString(),
      );
    }
  }

  void _localNotificationOngoing() async {
    try {
      Map<String, dynamic> ongoingNotification = _constructNotificationMap();
      ongoingNotification[HMSLocalNotificationAttr.ONGOING] = true;
      Map<String, dynamic> response = await Push.localNotification(
        ongoingNotification,
      );
      showResult(
        'localNotificationOngoing',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationOngoingError',
        e.toString(),
      );
    }
  }

  void _localNotificationSound() async {
    try {
      Map<String, dynamic> soundNotification = _constructNotificationMap();
      soundNotification[HMSLocalNotificationAttr.PLAY_SOUND] = true;
      soundNotification[HMSLocalNotificationAttr.SOUND_NAME] =
          'huawei_bounce.mp3';
      Map<String, dynamic> response = await Push.localNotification(
        soundNotification,
      );
      showResult(
        'localNotificationSound',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationSoundError',
        e.toString(),
      );
    }
  }

  void _localNotificationVibrate() async {
    try {
      Map<String, dynamic> vibrateNotification = _constructNotificationMap();
      vibrateNotification[HMSLocalNotificationAttr.VIBRATE] = true;
      vibrateNotification[HMSLocalNotificationAttr.VIBRATE_DURATION] = 5000.0;
      Map<String, dynamic> response = await Push.localNotification(
        vibrateNotification,
      );
      showResult(
        'localNotificationVibrate',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationVibrateError',
        e.toString(),
      );
    }
  }

  void _localNotificationBigImage() async {
    try {
      Map<String, dynamic> bigImgNotification = _constructNotificationMap();
      bigImgNotification[HMSLocalNotificationAttr.BIG_PICTURE_URL] =
          'https://www-file.huawei.com/-/media/corp/home/image/logo_400x200.png';
      Map<String, dynamic> response = await Push.localNotification(
        bigImgNotification,
      );
      showResult(
        'localNotificationBigImage',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationBigImageError',
        e.toString(),
      );
    }
  }

  void _localNotificationRepeat() async {
    try {
      Map<String, dynamic> repeatedNotification = _constructNotificationMap();
      repeatedNotification[HMSLocalNotificationAttr.REPEAT_TYPE] =
          RepeatType.MINUTE;
      Map<String, dynamic> response = await Push.localNotification(
        repeatedNotification,
      );
      showResult(
        'localNotificationRepeat',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationRepeatError',
        e.toString(),
      );
    }
  }

  void _localNotificationScheduled() async {
    try {
      Map<String, dynamic> scheduledNotification = _constructNotificationMap();
      scheduledNotification[HMSLocalNotificationAttr.FIRE_DATE] =
          DateTime.now().add(const Duration(minutes: 2)).millisecondsSinceEpoch;
      scheduledNotification[HMSLocalNotificationAttr.ALLOW_WHILE_IDLE] = true;
      Map<String, dynamic> response = await Push.localNotificationSchedule(
        scheduledNotification,
      );
      showResult(
        'localNotificationScheduled',
        response.toString(),
      );
    } catch (e) {
      showResult(
        'localNotificationScheduledError',
        e.toString(),
      );
    }
  }

  void _channelBlocked() async {
    bool blocked = await Push.channelBlocked(
      'huawei-hms-flutter-push-channel-id-4-default',
    );
    showResult(
      'channelBlocked',
      blocked.toString(),
    );
  }

  void _channelExists() async {
    bool exists = await Push.channelExists(
      'huawei-hms-flutter-push-channel-id-4-default',
    );
    showResult(
      'channelExists',
      exists.toString(),
    );
  }

  void _getChannels() async {
    List<String> channels = await Push.getChannels();
    showResult(
      'getChannels',
      channels.toString(),
    );
  }

  void _deleteChannel() async {
    String result = await Push.deleteChannel(
      'huawei-hms-flutter-push-channel-id-4-default',
    );
    showResult(
      'deleteChannel',
      result,
    );
  }

  void _getNotifications() async {
    List<Map<String, dynamic>> notifications = await Push.getNotifications();
    showResult(
      'getNotifications',
      'Active Notifications: ${notifications.length} notifications',
    );
    debugPrint(
      'getNotification result: $notifications',
    );
  }

  void _getScheduledNotifications() async {
    List<Map<String, dynamic>> scheduledNotifications =
        await Push.getScheduledNotifications();
    showResult(
      'getScheduledNotifications',
      '${scheduledNotifications.length} scheduled notifications',
    );
    debugPrint(
      'getScheduledNotification result: $scheduledNotifications',
    );
  }

  void showResult(
    String name, [
    String msg = 'Button pressed.',
  ]) {
    appendLog('[$name]: $msg');
    debugPrint('[$name]: $msg');
    if (msg.isNotEmpty) Push.showToast(msg);
  }

  void appendLog([
    String msg = 'Button pressed.',
  ]) {
    setState(() {
      logTextController.text = '$msg\n${logTextController.text}';
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Widget customTextField(
    TextEditingController controller,
    String hintText, {
    EdgeInsets? customPadding,
  }) {
    return Padding(
      padding: customPadding ?? padding,
      child: SizedBox(
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: _textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget customButton(
    String label,
    Function() callback, {
    Color? color,
  }) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: padding.copyWith(top: 0.0, bottom: 0.0),
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey.shade300,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Push Kit Demo - LocalNotification',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: <Widget>[
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              labelText('Title: '),
              Expanded(
                flex: 5,
                child: customTextField(
                  titleTextController,
                  'Title',
                  customPadding: const EdgeInsets.fromLTRB(0.0, 1.0, 1.0, 1.0),
                ),
              ),
              Expanded(
                flex: 5,
                child: customTextField(
                  tagTextController,
                  'Tag',
                  customPadding: const EdgeInsets.fromLTRB(0.0, 1.0, 10.0, 1.0),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              labelText('Message: '),
              Expanded(
                flex: 5,
                child: customTextField(
                  msgTextController,
                  'Message',
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              labelText('BigText: '),
              Expanded(
                flex: 5,
                child: customTextField(
                  bigTextController,
                  'Big Text',
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              labelText('SubText: '),
              Expanded(
                flex: 5,
                child: customTextField(
                  subTextController,
                  'Sub Text',
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'Local Notification (Default)',
                () => _localNotification(),
                color: Colors.blue,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                '+ Ongoing',
                () => _localNotificationOngoing(),
                color: Colors.blue,
              ),
              customButton(
                '+ Sound',
                () => _localNotificationSound(),
                color: Colors.blue,
              ),
              customButton(
                '+ Vibrate',
                () => _localNotificationVibrate(),
                color: Colors.blue,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                '+ BigImage',
                () => _localNotificationBigImage(),
                color: Colors.blue,
              ),
              customButton(
                '+ Repeat',
                () => _localNotificationRepeat(),
                color: Colors.blue,
              ),
              customButton(
                '+ Scheduled',
                () => _localNotificationScheduled(),
                color: Colors.blue,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'cancelAllNotifications',
                () => Push.cancelAllNotifications().then(
                  (_) => showResult(
                    'cancelAllNotifications',
                    'Success',
                  ),
                ),
              ),
              customButton(
                'getNotifications',
                () => _getNotifications(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'cancelScheduledNotifications',
                () => Push.cancelScheduledNotifications().then(
                  (_) => showResult(
                    'cancelScheduledNotifications',
                    'Success',
                  ),
                ),
              ),
              customButton(
                'getScheduledNotifications',
                () => _getScheduledNotifications(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'cancelNotificationsWithTag',
                () => Push.cancelNotificationsWithTag(
                  'hms_tag',
                ).then(
                  (_) => showResult(
                    'cancelNotificationsWithTag',
                    'Success',
                  ),
                ),
              ),
              customButton(
                'getChannels',
                () => _getChannels(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'cancelNotifications',
                () => Push.cancelNotifications().then(
                  (_) => showResult(
                    'cancelNotifications',
                    'Success',
                  ),
                ),
              ),
              customButton(
                'deleteChannel',
                () => _deleteChannel(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'channelBlocked',
                () => _channelBlocked(),
              ),
              customButton(
                'channelExists',
                () => _channelExists(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'clearLog',
                () => _clearLog(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Divider(height: 1.0, thickness: 1.0),
          ),
          Padding(
            padding: padding,
            child: TextField(
              controller: logTextController,
              keyboardType: TextInputType.multiline,
              readOnly: true,
              maxLines: 15,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class MultiSenderPage extends StatefulWidget {
  const MultiSenderPage({Key? key}) : super(key: key);

  @override
  State<MultiSenderPage> createState() => _MultiSenderPageState();
}

class _MultiSenderPageState extends State<MultiSenderPage> {
  @override
  void initState() {
    super.initState();
    Push.getMultiSenderTokenStream.listen(
      _onMultiSenderTokenReceived,
      onError: _onMultiSenderTokenError,
    );
  }

  void _onMultiSenderTokenReceived(Map<String, dynamic> multiSenderTokenEvent) {
    showResult(
      '[onMultiSenderTokenReceived]$multiSenderTokenEvent',
    );
  }

  void _onMultiSenderTokenError(dynamic error) {
    showResult(
      '[onMultiSenderTokenError]$error',
    );
  }

  TextEditingController logTextController = TextEditingController();
  final EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 1.0,
    horizontal: 10,
  );
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  Widget customTextField(
    TextEditingController controller,
    String hintText, {
    EdgeInsets? customPadding,
  }) {
    return Padding(
      padding: customPadding ?? padding,
      child: SizedBox(
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: _textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _clearLog() {
    setState(() {
      logTextController.text = '';
    });
  }

  Widget customButton(
    String label,
    Function() callback, {
    Color? color,
  }) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: padding.copyWith(top: 0.0, bottom: 0.0),
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey.shade300,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  void showResult(
    String name, [
    String? msg = 'Button pressed.',
  ]) {
    msg ??= '';
    appendLog('[$name]: $msg');
    debugPrint('[$name]: $msg');
    Push.showToast('[$name]: $msg');
  }

  void appendLog([
    String msg = 'Button pressed.',
  ]) {
    setState(() {
      logTextController.text = '$msg\n${logTextController.text}';
    });
  }

  void isSupportProfile() async {
    showResult(
      'isSupportProfile',
      (await HmsProfile.isSupportProfile()).toString(),
    );
  }

  void getMultiSenderToken() {
    Push.getMultiSenderToken(
      '<subjectId>',
    ).then(
      (_) => debugPrint(
        '[getMultiSenderToken] Success',
      ),
      onError: (dynamic e) => debugPrint(
        '[getMultiSenderToken] Error: $e',
      ),
    );
  }

  void addProfile() async {
    HmsProfile.addProfile(
      HmsProfile.HUAWEI_PROFILE,
      '<profileId>',
    ).then(
      (_) => debugPrint(
        '[addProfile] + Success',
      ),
      onError: (dynamic e) => debugPrint(
        '[addProfile] Error:$e',
      ),
    );
    ProxySettings.setCountryCode('<countryCode>');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Push Kit Demo - Multi-Sender',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: <Widget>[
          Row(
            children: <Widget>[
              customButton(
                'isSupportProfile',
                () => isSupportProfile(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'addProfile',
                () => HmsProfile.addProfile(
                  HmsProfile.HUAWEI_PROFILE,
                  'profile001',
                ).then(
                  (_) => showResult(
                    'addProfile',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'addProfile Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'addMultiSenderProfile',
                () => HmsProfile.addMultiSenderProfile(
                  '<subjectId>',
                  HmsProfile.HUAWEI_PROFILE,
                  'multiSenderProfile001',
                ).then(
                  (_) => showResult(
                    'addMultiSenderProfile',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'addMultiSenderProfile Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'deleteProfile',
                () => HmsProfile.deleteProfile(
                  'profile001',
                ).then(
                  (_) => showResult(
                    'deleteProfile',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'deleteProfile Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'deleteMultiSenderProfile',
                () => HmsProfile.deleteMultiSenderProfile(
                  '<subjectId>',
                  'multiSenderProfile001',
                ).then(
                  (_) => showResult(
                    'deleteMultiSenderProfile',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'deleteMultiSenderProfile Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),

          // Enter the sender app's project id to the subjectId parameter to get the Multi-Sender push token.
          Row(
            children: <Widget>[
              customButton(
                'getMultiSenderToken',
                () => Push.getMultiSenderToken(
                  '<subjectId>',
                ).then(
                  (_) => showResult(
                    'getMultiSenderToken',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'getMultiSenderToken Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),

          // Enter the sender app's project id to the subjectId parameter to delete the obtained Multi-Sender push token.
          Row(
            children: <Widget>[
              customButton(
                'deleteMultiSenderToken',
                () => Push.deleteMultiSenderToken(
                  '<subjectId>',
                ).then(
                  (_) => showResult(
                    'deleteMultiSenderToken',
                    'Success',
                  ),
                  onError: (dynamic e) => showResult(
                    'deleteMultiSenderToken Error:',
                    e.toString(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              customButton(
                'clearLog',
                () => _clearLog(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: logTextController,
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              readOnly: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
