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

import 'package:flutter/material.dart';

import 'package:huawei_location_example/screens/activity_conversion_screen.dart';
import 'package:huawei_location_example/screens/activity_identification_screen.dart';
import 'package:huawei_location_example/widgets/custom_button.dart';

class ActivityScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'ActivityScreen';

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _topText = '';

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  // TODO: Please implement your own 'Permission Handler'.
  void _requestPermission() async {
    // Huawei Location needs some permissions to work properly.
    // You are expected to handle these permissions to use Huawei Location Demo.

    // You can learn more about the required permissions from our official documentations.
    // https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001089376648?ha_source=hms1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Identification and Conversion'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              height: 90,
              child: Text(_topText),
            ),
            const Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Btn('Activity Identification', () {
              Navigator.pushNamed(
                context,
                ActivityIdentificationScreen.ROUTE_NAME,
              );
            }),
            Btn('Activity Conversion', () {
              Navigator.pushNamed(
                context,
                ActivityConversionScreen.ROUTE_NAME,
              );
            }),
          ],
        ),
      ),
    );
  }
}
