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
import 'package:flutter/services.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/hwlocation.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_availability.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/location/location_settings_request.dart';
import 'package:huawei_location/location/location_settings_states.dart';
import 'package:huawei_location/permission/permission_handler.dart';

import '../widgets/custom_button.dart' show Btn;
import '../widgets/custom_row.dart' show CRow;
import 'location_enhance_screen.dart';
import 'location_updates_cb_screen.dart';
import 'location_updates_ex_cb_screen.dart';
import 'location_updates_screen.dart';

class FusedLocationScreen extends StatefulWidget {
  static const String ROUTE_NAME = "FusedLocationScreen";

  @override
  _FusedLocationScreenState createState() => _FusedLocationScreenState();
}

class _FusedLocationScreenState extends State<FusedLocationScreen> {
  final PermissionHandler _permissionHandler = PermissionHandler();
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;
  final Location _mockLocation = Location(latitude: 48.8583, longitude: 2.2945);

  String _topText = "";
  String _bottomText = "";
  LocationSettingsRequest _locationSettingsRequest;

  @override
  void initState() {
    super.initState();
    _locationSettingsRequest =
        LocationSettingsRequest(requests: <LocationRequest>[_locationRequest]);
  }

  void _hasPermission() async {
    try {
      final bool status = await _permissionHandler.hasLocationPermission();
      _setTopText("Has permission: $status");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _requestPermission() async {
    try {
      final bool status = await _permissionHandler.requestLocationPermission();
      _setTopText("Is permission granted $status");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _checkLocationSettings() async {
    try {
      final LocationSettingsStates states = await _locationService
          .checkLocationSettings(_locationSettingsRequest);
      _setBottomText(states.toString());
      print(states.toString());
    } on PlatformException catch (e) {
      _setBottomText(e.toString());
    }
  }

  void _getLastLocation() async {
    _setTopText();
    try {
      final Location location = await _locationService.getLastLocation();
      _setBottomText(location.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _getLastLocationWithAddress() async {
    _setTopText();
    try {
      final HWLocation location =
          await _locationService.getLastLocationWithAddress(_locationRequest);
      _setBottomText(location.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _getLocationAvailability() async {
    _setTopText();
    try {
      final LocationAvailability availability =
          await _locationService.getLocationAvailability();

      final result = StringBuffer();
      result.writeln("Location available: ${availability.isLocationAvailable}");
      result.write("Details: ${availability.toString()}");

      _setBottomText(result.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setMockModeTrue() async {
    _setTopText();
    try {
      await _locationService.setMockMode(true);
      _setTopText("Mock mode set to 'true'");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setMockModeFalse() async {
    _setTopText();
    try {
      await _locationService.setMockMode(false);
      _setTopText("Mock mode set to 'false'");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setMockLocation() async {
    _setTopText();
    _setBottomText();
    try {
      await _locationService.setMockLocation(_mockLocation);

      final result = StringBuffer();
      result.write("Mock Location has set to -> ");
      result.write("lat:${_mockLocation.latitude} ");
      result.write("lng:${_mockLocation.longitude}");

      _setBottomText(result.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setTopText([String text = ""]) {
    setState(() {
      _topText = text;
    });
  }

  void _setBottomText([String text = ""]) {
    setState(() {
      _bottomText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fused Location Service'),
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
              child: Text(_topText),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CRow(
              children: <Widget>[
                Btn("hasPermission", _hasPermission),
                Btn("requestPermission", this._requestPermission),
              ],
            ),
            Btn("checkLocationSettings", _checkLocationSettings),
            CRow(
              children: <Widget>[
                Btn("getLastLocation", this._getLastLocation),
                Btn("getLastLocationWithAddress",
                    this._getLastLocationWithAddress)
              ],
            ),
            CRow(children: <Widget>[
              Btn("getLocationAvailability", _getLocationAvailability),
              Btn("setMockModeTrue", _setMockModeTrue)
            ]),
            CRow(children: <Widget>[
              Btn("setMockModeFalse", _setMockModeFalse),
              Btn("setMockLocation", _setMockLocation)
            ]),
            Btn("Location Updates", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesScreen.ROUTE_NAME,
              );
            }),
            Btn("Location Updates with Callback", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesCbScreen.ROUTE_NAME,
              );
            }),
            Btn("Location Updates Ex with Callback", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesExCbScreen.ROUTE_NAME,
              );
            }),
            Btn("Location Enhance Service", () {
              Navigator.pushNamed(
                context,
                LocationEnhanceScreen.ROUTE_NAME,
              );
            }),
            Expanded(
              child: new SingleChildScrollView(
                child: Text(
                  _bottomText,
                  style: const TextStyle(
                    fontSize: 12.0,
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
