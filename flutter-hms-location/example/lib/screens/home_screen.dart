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

import '../widgets/custom_button.dart';
import 'activity_screen.dart';
import 'fusedlocation_screen.dart';
import 'geofence_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HMS Location Kit Flutter Demo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Btn("Fused Location Service", () {
              Navigator.pushNamed(
                context,
                FusedLocationScreen.ROUTE_NAME,
              );
            }),
            Btn("Activity Identification/Recognition Service", () {
              Navigator.pushNamed(
                context,
                ActivityScreen.ROUTE_NAME,
              );
            }),
            Btn("Geofence Service", () {
              Navigator.pushNamed(
                context,
                GeofenceScreen.ROUTE_NAME,
              );
            }),
          ],
        ),
      ),
    );
  }
}
