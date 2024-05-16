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
import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';

import 'package:huawei_location_example/widgets/custom_button.dart' show Btn;
import 'package:huawei_location_example/widgets/custom_row.dart' show CRow;
import 'package:huawei_location_example/screens/location_enhance_screen.dart';
import 'package:huawei_location_example/screens/location_updates_cb_screen.dart';
import 'package:huawei_location_example/screens/location_updates_ex_cb_screen.dart';
import 'package:huawei_location_example/screens/location_updates_screen.dart';

class FusedLocationScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'FusedLocationScreen';

  const FusedLocationScreen({Key? key}) : super(key: key);

  @override
  State<FusedLocationScreen> createState() => _FusedLocationScreenState();
}

class _FusedLocationScreenState extends State<FusedLocationScreen> {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;
  final Location _mockLocation = Location(latitude: 48.8583, longitude: 2.2945);

  String _topText = '';
  String _bottomText = '';
  late LocationSettingsRequest _locationSettingsRequest;
  late LogConfig _logConfig;
  late BackgroundNotification _notification;

  @override
  void initState() {
    super.initState();
    _locationSettingsRequest =
        LocationSettingsRequest(requests: <LocationRequest>[_locationRequest]);
    _requestPermission();
  }

// TODO: Please implement your own 'Permission Handler'.
  void _requestPermission() async {
    // Huawei Location needs some permissions to work properly.
    // You are expected to handle these permissions to use Huawei Location Demo.

    // You can learn more about the required permissions from our official documentations.
    // https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001089376648?ha_source=hms1
  }

  void _initFusedLocationService() async {
    try {
      await _locationService.initFusedLocationService();
      _setTopText('Fused Location Service has been initialized.');
    } on PlatformException catch (e) {
      _setBottomText(e.toString());
    }
  }

  void _checkLocationSettings() async {
    try {
      final LocationSettingsStates states = await _locationService
          .checkLocationSettings(_locationSettingsRequest);
      _setBottomText(states.toString());
      debugPrint(states.toString());
    } on PlatformException catch (e) {
      _setBottomText(e.toString());
    }
  }

  void _getLastLocation() async {
    _setTopText();
    try {
      final Location location = await _locationService.getLastLocation();
      debugPrint(location.toString());
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

      final StringBuffer result = StringBuffer();
      result.writeln('Location available: ${availability.isLocationAvailable}');
      result.write('Details: ${availability.toString()}');

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

      final StringBuffer result = StringBuffer();
      result.write('Mock Location has set to -> ');
      result.write('lat:${_mockLocation.latitude} ');
      result.write('lng:${_mockLocation.longitude}');

      _setBottomText(result.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _enableBackgroundLocation() async {
    _setTopText();
    int notificationId = 1;
    _notification = BackgroundNotification(
      category: 'service',
      priority: 2,
      channelName: 'MyChannel',
      contentTitle: 'Current Location',
      contentText: 'Location Notification',
    );

    try {
      await _locationService.enableBackgroundLocation(
        notificationId,
        _notification,
      );
      _setTopText('Enabled the background location');
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _disableBackgroundLocation() {
    _setTopText();
    try {
      _locationService.disableBackgroundLocation();
      _setTopText('Disabled the background location');
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setLogConfig() async {
    _setTopText();
    _logConfig = LogConfig(
      fileExpiredTime: 5,
      fileNum: 15,
      fileSize: 2,
      logPath: '/storage/emulated/0/Android/data/log',
    );
    try {
      await _locationService.setLogConfig(_logConfig);
      _setTopText('Enabled the log recording');
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _getLogConfig() async {
    _setTopText();
    _setBottomText();
    try {
      final LogConfig logConfig = await _locationService.getLogConfig();
      _setBottomText(logConfig.toString());
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _setTopText([String text = '']) {
    setState(() {
      _topText = text;
    });
  }

  void _setBottomText([String text = '']) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    height: 80,
                    child: Text(_topText),
                  ),
                  const Divider(
                    thickness: 0.1,
                    color: Colors.black,
                  ),
                  Btn('Init Fused Location', _initFusedLocationService),
                  Btn('checkLocationSettings', _checkLocationSettings),
                  CRow(
                    children: <Widget>[
                      Btn('getLastLocation', _getLastLocation),
                      Btn(
                        'getLastLocation\nWithAddress',
                        _getLastLocationWithAddress,
                      )
                    ],
                  ),
                  CRow(
                    children: <Widget>[
                      Btn('getLocationAvailability', _getLocationAvailability),
                      Btn('setMockModeTrue', _setMockModeTrue)
                    ],
                  ),
                  CRow(
                    children: <Widget>[
                      Btn('setMockModeFalse', _setMockModeFalse),
                      Btn('setMockLocation', _setMockLocation)
                    ],
                  ),
                  Btn('Location Updates', () {
                    Navigator.pushNamed(
                      context,
                      LocationUpdatesScreen.ROUTE_NAME,
                    );
                  }),
                  Btn('Location Updates with Callback', () {
                    Navigator.pushNamed(
                      context,
                      LocationUpdatesCbScreen.ROUTE_NAME,
                    );
                  }),
                  Btn('Location Updates Ex with Callback', () {
                    Navigator.pushNamed(
                      context,
                      LocationUpdatesExCbScreen.ROUTE_NAME,
                    );
                  }),
                  Btn('Location Enhance Service', () {
                    Navigator.pushNamed(
                      context,
                      LocationEnhanceScreen.ROUTE_NAME,
                    );
                  }),
                  CRow(
                    children: <Widget>[
                      Btn('enableBgLocation', _enableBackgroundLocation),
                      Btn('disableBgLocation', _disableBackgroundLocation),
                    ],
                  ),
                  CRow(
                    children: <Widget>[
                      Btn('setLogConfig', _setLogConfig),
                      Btn('getLogConfig', _getLogConfig),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          Text(
                            _bottomText,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
