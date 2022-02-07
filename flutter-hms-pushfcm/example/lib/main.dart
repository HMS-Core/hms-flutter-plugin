/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:huawei_push_fcm/huawei_push_fcm.dart';

import 'widgets/button.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late var subscription;

  @override
  void initState() {
    super.initState();
    _setCountryCode();
    _fcmInit();
    subscription = Push.getMultiSenderTokenStream.listen((event) {
      print("Token: " + event["multiSenderToken"]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("HMS Push-FCM Proxy Flutter Plugin"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(child: Btn("Get Token", _getToken)),
        ),
      ),
    );
  }

  _setCountryCode() {
    PushFcm.setCountryCode("DE");
  }

  _fcmInit() async {
    await PushFcm.init();
  }

  _getToken() async {
    await Push.getToken("HCM");
  }
}
