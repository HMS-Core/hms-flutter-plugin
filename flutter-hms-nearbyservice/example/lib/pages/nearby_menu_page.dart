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
import 'package:flutter/material.dart';
import 'package:huawei_nearbyservice_example/utils/constants.dart';

class NearbyMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            'Huawei Nearby Service Demo',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            child: Text(
              'Discovery and Transfer',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.discoveryAndTransfer);
            },
          ),
          TextButton(
            child: Text(
              'Wifi Sharing',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.wifi);
            },
          ),
          TextButton(
            child: Text(
              'Messaging',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.message);
            },
          ),
        ],
      ),
    );
  }
}
