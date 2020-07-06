/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'dart:async';
//import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_push/push.dart';
import 'package:huawei_push/constants/channel.dart' as Channel;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController logTextController;
  TextEditingController topicTextController;

  String _token = '';
  static const EventChannel TokenEventChannel =
      EventChannel(Channel.TOKEN_CHANNEL);
  static const EventChannel DataMessageEventChannel =
      EventChannel(Channel.DATA_MESSAGE_CHANNEL);

  void _onTokenEvent(Object event) {
    setState(() {
      _token = event;
    });
    showResult("TokenEvent", event);
  }

  void _onTokenError(Object error) {
    setState(() {
      _token = error;
    });
    showResult("TokenEvent", error);
  }

  void _onDataMessageEvent(Object event) {
    showResult("DataMessageEvent", event);
//    Map dataMessageMap = json.decode(event);
//    showResult("DataMessageEvent", dataMessageMap["key"]);
  }

  void _onDataMessageError(Object error) {
    showResult("DataMessageEvent", error);
  }

  final padding = EdgeInsets.symmetric(vertical: 1.0, horizontal: 16);

  @override
  void initState() {
    super.initState();
    logTextController = new TextEditingController();
    topicTextController = new TextEditingController();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    TokenEventChannel.receiveBroadcastStream()
        .listen(_onTokenEvent, onError: _onTokenError);
    DataMessageEventChannel.receiveBroadcastStream()
        .listen(_onDataMessageEvent, onError: _onDataMessageError);
  }

  @override
  void dispose() {
    logTextController?.dispose();
    topicTextController?.dispose();
    super.dispose();
  }

  void turnOnPush() async {
    dynamic result = await Push.turnOnPush();
    showResult("turnOnPush", result);
  }

  void turnOffPush() async {
    dynamic result = await Push.turnOffPush();
    showResult("turnOffPush", result);
  }

  void getId() async {
    dynamic result = await Push.getId();
    showResult("getId", result);
  }

  void getAAID() async {
    dynamic result = await Push.getAAID();
    showResult("getAAID", result);
  }

  void getAppId() async {
    dynamic result = await Push.getAppId();
    showResult("getAppId", result);
  }

  void getToken() async {
    dynamic result = await Push.getToken();
    showResult("getToken", result);
  }

  void getCreationTime() async {
    dynamic result = await Push.getCreationTime();
    showResult("getCreationTime", result);
  }

  void deleteAAID() async {
    dynamic result = await Push.deleteAAID();
    showResult("deleteAAID", result);
  }

  void deleteToken() async {
    dynamic result = await Push.deleteToken();
    showResult("deleteToken", result);
  }

  void subscribe() async {
    String topic = topicTextController.text;
    dynamic result = await Push.subscribe(topic);
    showResult("subscribe", result);
  }

  void unsubscribe() async {
    String topic = topicTextController.text;
    dynamic result = await Push.unsubscribe(topic);
    showResult("unsubscribe", result);
  }

  void enableAutoInit() async {
    dynamic result = await Push.setAutoInitEnabled(true);
    showResult("enableAutoInit", result);
  }

  void disableAutoInit() async {
    dynamic result = await Push.setAutoInitEnabled(false);
    showResult("disableAutoInit", result);
  }

  void isAutoInitEnabled() async {
    dynamic result = await Push.isAutoInitEnabled();
    showResult("isAutoInitEnabled", result ? "Enabled" : "Disabled");
  }

  void getAgConnectValues() async {
    dynamic result = await Push.getAgConnectValues();
    showResult("getAgConnectValues", result);
  }

  void clearLog() {
    setState(() {
      logTextController.text = "";
    });
  }

  void showResult(String name, [String msg = "Button pressed."]) {
    appendLog(name + ": " + msg);
    Push.showToast(msg);
  }

  void appendLog([String msg = "Button pressed."]) {
    setState(() {
      logTextController.text = msg + "\n" + logTextController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('🔔 HMS Push Kit Demo'),
        ),
        body: Center(
            child: ListView(shrinkWrap: true, children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => turnOnPush(),
                    child: Text('TurnOnPush', style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => turnOffPush(),
                    child: Text('TurnOffPush', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => getId(),
                    child: Text('GetID', style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => getAAID(),
                    child: Text('GetAAID', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => getToken(),
                    child: Text('GetToken', style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => deleteToken(),
                    child: Text('DeleteToken', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => getCreationTime(),
                    child:
                        Text('GetCreationTime', style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => deleteAAID(),
                    child: Text('DeleteAAID', style: TextStyle(fontSize: 20)),
                  )),
            ),
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
              )),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => subscribe(),
                    child: Text('Subsribe', style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => unsubscribe(),
                    child: Text('UnSubscribe', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => disableAutoInit(),
                    child: Text('Disable AutoInit',
                        style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => enableAutoInit(),
                    child:
                        Text('Enable AutoInit', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Row(children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => isAutoInitEnabled(),
                    child: Text('IsAutoInitEnabled',
                        style: TextStyle(fontSize: 20)),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: padding,
                  child: RaisedButton(
                    onPressed: () => clearLog(),
                    child: Text('ClearLog', style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
          Padding(
              padding: padding,
              child: RaisedButton(
                onPressed: () => getAgConnectValues(),
                child: Text('Get agconnect values',
                    style: TextStyle(fontSize: 20)),
              )),
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
              )),
        ])),
      ),
    );
  }
}
