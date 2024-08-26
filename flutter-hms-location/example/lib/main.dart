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
import 'package:huawei_location_example/screens/convert_coordinate_screen.dart';
import 'package:huawei_location_example/screens/geocoder_screen.dart';
import 'package:huawei_location_example/screens/get_from_location_screen.dart';
import 'package:huawei_location_example/screens/high_precision_location_screen.dart';
import 'package:huawei_location_example/screens/location_utils_screen.dart';

import 'package:huawei_location_example/screens/activity_conversion_screen.dart';
import 'package:huawei_location_example/screens/activity_identification_screen.dart';
import 'package:huawei_location_example/screens/activity_screen.dart';
import 'package:huawei_location_example/screens/add_geofence_screen.dart';
import 'package:huawei_location_example/screens/fusedlocation_screen.dart';
import 'package:huawei_location_example/screens/geofence_screen.dart';
import 'package:huawei_location_example/screens/get_from_location_name_screen.dart';
import 'package:huawei_location_example/screens/home_screen.dart';
import 'package:huawei_location_example/screens/location_enhance_screen.dart';
import 'package:huawei_location_example/screens/location_updates_cb_screen.dart';
import 'package:huawei_location_example/screens/location_updates_ex_cb_screen.dart';
import 'package:huawei_location_example/screens/location_updates_screen.dart';

void main() => runApp(const LocationKitDemoApp());

class LocationKitDemoApp extends StatelessWidget {
  const LocationKitDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: <String, Widget Function(BuildContext)>{
        HomeScreen.ROUTE_NAME: (BuildContext context) => const HomeScreen(),
        FusedLocationScreen.ROUTE_NAME: (BuildContext context) =>
            const FusedLocationScreen(),
        ActivityScreen.ROUTE_NAME: (BuildContext context) =>
            const ActivityScreen(),
        GeofenceScreen.ROUTE_NAME: (BuildContext context) =>
            const GeofenceScreen(),
        AddGeofenceScreen.ROUTE_NAME: (BuildContext context) =>
            const AddGeofenceScreen(),
        ActivityIdentificationScreen.ROUTE_NAME: (BuildContext context) =>
            const ActivityIdentificationScreen(),
        ActivityConversionScreen.ROUTE_NAME: (BuildContext context) =>
            const ActivityConversionScreen(),
        LocationUpdatesScreen.ROUTE_NAME: (BuildContext context) =>
            const LocationUpdatesScreen(),
        LocationUpdatesCbScreen.ROUTE_NAME: (BuildContext context) =>
            const LocationUpdatesCbScreen(),
        LocationUpdatesExCbScreen.ROUTE_NAME: (BuildContext context) =>
            const LocationUpdatesExCbScreen(),
        LocationEnhanceScreen.ROUTE_NAME: (BuildContext context) =>
            const LocationEnhanceScreen(),
        HighPrecisionLocationScreen.ROUTE_NAME: (BuildContext context) =>
            const HighPrecisionLocationScreen(),
        GeocoderScreen.ROUTE_NAME: (BuildContext context) =>
            const GeocoderScreen(),
        GetFromLocationScreen.ROUTE_NAME: (BuildContext context) =>
            const GetFromLocationScreen(),
        GetFromLocationNameScreen.ROUTE_NAME: (BuildContext context) =>
            const GetFromLocationNameScreen(),
        LocationUtilsScreen.ROUTE_NAME: (BuildContext context) =>
            const LocationUtilsScreen(),
        ConvertCoordinateScreen.ROUTE_NAME: (BuildContext context) =>
            const ConvertCoordinateScreen(),
      },
    );
  }
}
