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

import 'screens/activity_conversion_screen.dart';
import 'screens/activity_identification_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/add_geofence_screen.dart';
import 'screens/fusedlocation_screen.dart';
import 'screens/geofence_screen.dart';
import 'screens/home_screen.dart';
import 'screens/location_updates_cb_screen.dart';
import 'screens/location_updates_ex_cb_screen.dart';
import 'screens/location_updates_screen.dart';

void main() => runApp(LocationKitDemoApp());

class LocationKitDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        FusedLocationScreen.routeName: (context) => FusedLocationScreen(),
        ActivityScreen.routeName: (context) => ActivityScreen(),
        GeofenceScreen.routeName: (context) => GeofenceScreen(),
        AddGeofenceScreen.routeName: (context) => AddGeofenceScreen(),
        ActivityIdentificationScreen.routeName: (context) =>
            ActivityIdentificationScreen(),
        ActivityConversionScreen.routeName: (context) =>
            ActivityConversionScreen(),
        LocationUpdatesScreen.routeName: (context) => LocationUpdatesScreen(),
        LocationUpdatesCbScreen.routeName: (context) =>
            LocationUpdatesCbScreen(),
        LocationUpdatesExCbScreen.routeName: (context) =>
            LocationUpdatesExCbScreen(),
      },
    );
  }
}
