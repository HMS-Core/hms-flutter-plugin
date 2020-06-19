/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_location/activity/activity_identification_service.dart';
import 'package:huawei_location/permission/permission_handler.dart';

import '../screens/activity_conversion_screen.dart';
import '../screens/activity_identification_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_row.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = "ActivityScreen";

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String topText;
  PermissionHandler permissionHandler;
  ActivityIdentificationService service;

  void initServices() {
    topText = "";
    permissionHandler = PermissionHandler();
    service = ActivityIdentificationService();
  }

  @override
  void initState() {
    super.initState();
    initServices();
  }

  void hasPermission() async {
    bool status = await permissionHandler.hasActivityRecognitionPermission();
    setState(() {
      topText = "Has permission: $status";
    });
  }

  void requestPermission() async {
    bool status =
        await permissionHandler.requestActivityRecognitionPermission();
    setState(() {
      topText = "Is permission granted: $status";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Identification and Conversion'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              height: 90,
              child: Text(topText),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CRow(children: <Widget>[
              Btn("hasPermission", hasPermission),
              Btn("requestPermission", requestPermission),
            ]),
            Btn("Activity Identification", () {
              Navigator.pushNamed(
                context,
                ActivityIdentificationScreen.routeName,
              );
            }),
            Btn("Activity Conversion", () {
              Navigator.pushNamed(
                context,
                ActivityConversionScreen.routeName,
              );
            }),
          ],
        ),
      ),
    );
  }
}
