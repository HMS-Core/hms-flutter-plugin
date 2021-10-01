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
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:huawei_push_example/multi_sender_page.dart';

import 'custom_intent_page.dart';
import 'local_notification_page.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

void backgroundMessageCallback(RemoteMessage remoteMessage) async {
  String? data = remoteMessage.data;
  if (data != null) {
    print("Background message is received, sending local notification.");
    Push.localNotification({
      HMSLocalNotificationAttr.TITLE: '[Headless] DataMessage Received',
      HMSLocalNotificationAttr.MESSAGE: data
    });
  } else {
    print("Background message is received. There is no data in the message.");
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController logTextController;
  late TextEditingController topicTextController;

  final padding = EdgeInsets.symmetric(vertical: 1.0, horizontal: 16);

  String _token = '';

  void _onTokenEvent(String event) {
    _token = event;
    showResult("TokenEvent", _token);
  }

  void _onTokenError(Object error) {
    PlatformException e = error as PlatformException;
    showResult("TokenErrorEvent", e.message!);
  }

  void _onMessageReceived(RemoteMessage remoteMessage) {
    String? data = remoteMessage.data;
    if (data != null) {
      Push.localNotification({
        HMSLocalNotificationAttr.TITLE: 'DataMessage Received',
        HMSLocalNotificationAttr.MESSAGE: data
      });
      showResult("onMessageReceived", "Data: " + data);
    } else {
      showResult("onMessageReceived", "No data is present.");
    }
  }

  void _onMessageReceiveError(Object error) {
    showResult("onMessageReceiveError", error.toString());
  }

  void _onRemoteMessageSendStatus(String event) {
    showResult("RemoteMessageSendStatus", "Status: " + event.toString());
  }

  void _onRemoteMessageSendError(Object error) {
    PlatformException e = error as PlatformException;
    showResult("RemoteMessageSendError", "Error: " + e.toString());
  }

  void _onNewIntent(String? intentString) {
    // For navigating to the custom intent page (deep link) the custom
    // intent that sent from the push kit console is:
    // app://app2
    intentString = intentString ?? '';
    if (intentString != '') {
      showResult('CustomIntentEvent: ', intentString);
      List parsedString = intentString.split("://");
      if (parsedString[1] == "app2") {
        SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CustomIntentPage()));
        });
      }
    }
  }

  void _onIntentError(Object err) {
    PlatformException e = err as PlatformException;
    print("Error on intent stream: " + e.toString());
  }

  void _onNotificationOpenedApp(dynamic initialNotification) {
    if (initialNotification != null) {
      showResult("onNotificationOpenedApp", initialNotification.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Push.enableLogger();
    logTextController = new TextEditingController();
    topicTextController = new TextEditingController();
    Push.disableLogger();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
    Push.getIntentStream.listen(_onNewIntent, onError: _onIntentError);
    Push.onNotificationOpenedApp.listen(_onNotificationOpenedApp);
    var initialNotification = await Push.getInitialNotification();
    _onNotificationOpenedApp(initialNotification);
    String? intent = await Push.getInitialIntent();
    _onNewIntent(intent);
    Push.onMessageReceivedStream
        .listen(_onMessageReceived, onError: _onMessageReceiveError);
    Push.getRemoteMsgSendStatusStream
        .listen(_onRemoteMessageSendStatus, onError: _onRemoteMessageSendError);
    bool backgroundMessageHandler =
        await Push.registerBackgroundMessageHandler(backgroundMessageCallback);
    print("backgroundMessageHandler registered: $backgroundMessageHandler");
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
    showResult("turnOnPush", result);
  }

  void turnOffPush() async {
    String result = await Push.turnOffPush();
    showResult("turnOffPush", result);
  }

  void getId() async {
    String? result = await Push.getId();
    showResult("getId", result);
  }

  void getAAID() async {
    String? result = await Push.getAAID();
    showResult("getAAID", result);
  }

  void getAppId() async {
    String result = await Push.getAppId();
    showResult("getAppId", result);
  }

  void getOdid() async {
    String? result = await Push.getOdid();
    showResult("getOdid", result);
  }

  void getCreationTime() async {
    String result = await Push.getCreationTime();
    showResult("getCreationTime", result);
  }

  void deleteToken() async {
    String result = await Push.deleteToken("");
    showResult("deleteToken", result);
  }

  void deleteAAID() async {
    String result = await Push.deleteAAID();
    showResult("deleteAAID", result);
  }

  void sendRemoteMsg() async {
    RemoteMessageBuilder remoteMsg = RemoteMessageBuilder(
        to: '',
        data: {"Data": "test"},
        messageType: "my_type",
        ttl: 120,
        messageId: Random().nextInt(10000).toString(),
        collapseKey: '-1',
        sendMode: 1,
        receiptMode: 1);
    String result = await Push.sendRemoteMessage(remoteMsg);
    showResult("sendRemoteMessage", result);
  }

  void subscribe() async {
    String topic = topicTextController.text;
    String result = await Push.subscribe(topic);
    showResult("subscribe", result);
  }

  void unsubscribe() async {
    String topic = topicTextController.text;
    String result = await Push.unsubscribe(topic);
    showResult("unsubscribe", result);
  }

  void enableAutoInit() async {
    String result = await Push.setAutoInitEnabled(true);
    showResult("enableAutoInit", result);
  }

  void disableAutoInit() async {
    String result = await Push.setAutoInitEnabled(false);
    showResult("disableAutoInit", result);
  }

  void isAutoInitEnabled() async {
    bool result = await Push.isAutoInitEnabled();
    showResult("isAutoInitEnabled", result.toString());
  }

  void getInitialNotification() async {
    final dynamic initialNotification = await Push.getInitialNotification();
    showResult("getInitialNotification", initialNotification.toString());
  }

  void getInitialIntent() async {
    final String? initialIntent = await Push.getInitialIntent();
    showResult("getInitialIntent", initialIntent);
  }

  void getAgConnectValues() async {
    String result = await Push.getAgConnectValues();
    showResult("getAgConnectValues", result);
  }

  void clearLog() {
    setState(() {
      logTextController.text = "";
    });
  }

  void showResult(String name, [String? msg = "Button pressed."]) {
    if (msg == null) {
      msg = "";
    }
    appendLog("[" + name + "]" + ": " + msg);
    print("[" + name + "]" + ": " + msg);
    Push.showToast("[" + name + "]: " + msg);
  }

  void appendLog([String msg = "Button pressed."]) {
    setState(() {
      logTextController.text = msg + "\n" + logTextController.text;
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
            primary: color ?? Colors.grey.shade300,
          ),
          child: Text(
            txt,
            style: TextStyle(fontSize: fontSize, color: Colors.black87),
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
          shrinkWrap: true,
          children: <Widget>[
            Row(
              children: <Widget>[
                expandedButton(
                    5,
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomIntentPage())),
                    "Open Custom Intent URI Page",
                    color: Colors.deepOrangeAccent),
              ],
            ),
            Row(children: <Widget>[
              expandedButton(
                  5,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocalNotificationPage())),
                  'Local Notification',
                  color: Colors.blue),
            ]),
            Row(children: <Widget>[
              expandedButton(
                  5,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MultiSenderPage())),
                  'Multi Sender Page',
                  color: Colors.yellow),
            ]),
            Row(children: <Widget>[
              expandedButton(5, () => turnOnPush(), 'TurnOnPush', fontSize: 20),
              expandedButton(5, () => turnOffPush(), 'TurnOffPush',
                  fontSize: 20)
            ]),
            Row(children: <Widget>[
              expandedButton(4, () => getId(), 'GetID', fontSize: 14),
              expandedButton(4, () => getAAID(), 'GetAAID', fontSize: 14),
              expandedButton(4, () => getOdid(), 'GetODID', fontSize: 14),
            ]),
            Row(children: <Widget>[
              expandedButton(5, () => Push.getToken(""), 'GetToken',
                  fontSize: 20),
              expandedButton(5, () => getCreationTime(), 'GetCreationTime',
                  fontSize: 20)
            ]),
            Row(children: <Widget>[
              expandedButton(5, () => deleteToken(), 'DeleteToken',
                  fontSize: 20),
              expandedButton(5, () => deleteAAID(), 'DeleteAAID', fontSize: 20)
            ]),
            Padding(
              padding: padding,
              child: TextField(
                controller: topicTextController,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3.0),
                  ),
                  hintText: 'Topic Name',
                ),
              ),
            ),
            Row(children: <Widget>[
              expandedButton(5, () => subscribe(), 'Subscribe', fontSize: 20),
              expandedButton(5, () => unsubscribe(), 'UnSubscribe',
                  fontSize: 20),
            ]),
            Row(children: <Widget>[
              expandedButton(5, () => disableAutoInit(), 'Disable AutoInit',
                  fontSize: 20),
              expandedButton(5, () => enableAutoInit(), 'Enable AutoInit',
                  fontSize: 20)
            ]),
            Row(children: <Widget>[
              expandedButton(5, () => isAutoInitEnabled(), 'IsAutoInitEnabled',
                  fontSize: 20),
              expandedButton(5, () => sendRemoteMsg(), 'sendRemoteMessage',
                  fontSize: 20)
            ]),
            Row(children: <Widget>[
              expandedButton(
                  6, () => getInitialNotification(), 'getInitialNotification',
                  fontSize: 16),
              expandedButton(6, () => getInitialIntent(), 'getInitialIntent',
                  fontSize: 16)
            ]),
            Row(children: [
              expandedButton(5, () => clearLog(), 'Clear Log', fontSize: 20)
            ]),
            Row(children: [
              expandedButton(
                  5, () => getAgConnectValues(), 'Get agconnect values',
                  fontSize: 20)
            ]),
            Padding(
              padding: padding,
              child: TextField(
                controller: logTextController,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                readOnly: true,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3.0),
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
