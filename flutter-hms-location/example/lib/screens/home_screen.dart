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
import 'package:huawei_location_example/screens/geocoder_screen.dart';
import 'package:huawei_location_example/screens/high_precision_location_screen.dart';

import 'package:huawei_location_example/widgets/custom_button.dart';
import 'package:huawei_location_example/screens/activity_screen.dart';
import 'package:huawei_location_example/screens/fusedlocation_screen.dart';
import 'package:huawei_location_example/screens/geofence_screen.dart';
import 'package:huawei_location_example/screens/location_utils_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermissions();
    });
  }

  void requestPermissions() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'About Permissions',
          ),
          content: Text(
            'Huawei Location needs some permissions to work properly.\n\n'
            'You are expected to handle these permissions to use Huawei Location Demo.',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HMS Location Kit Flutter Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Btn('Fused Location Service', () {
              Navigator.pushNamed(
                context,
                FusedLocationScreen.ROUTE_NAME,
              );
            }),
            Btn('Activity Identification/Recognition Service', () {
              Navigator.pushNamed(
                context,
                ActivityScreen.ROUTE_NAME,
              );
            }),
            Btn('Geofence Service', () {
              Navigator.pushNamed(
                context,
                GeofenceScreen.ROUTE_NAME,
              );
            }),
            Btn('High Precision Location Service', () {
              Navigator.pushNamed(
                context,
                HighPrecisionLocationScreen.ROUTE_NAME,
              );
            }),
            Btn('Geocoder Service', () {
              Navigator.pushNamed(
                context,
                GeocoderScreen.ROUTE_NAME,
              );
            }),
            Btn('Location Utils', () {
              Navigator.pushNamed(
                context,
                LocationUtilsScreen.ROUTE_NAME,
              );
            }),
          ],
        ),
      ),
    );
  }
}
