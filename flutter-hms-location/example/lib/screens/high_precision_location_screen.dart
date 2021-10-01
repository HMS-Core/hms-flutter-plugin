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
import 'package:huawei_location/location/location_callback.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/permission/permission_handler.dart';
import 'package:huawei_location_example/widgets/custom_button.dart';
import 'package:huawei_location_example/widgets/custom_row.dart';

class HighPrecisionLocationScreen extends StatefulWidget {
  static const String ROUTE_NAME = "HighPrecisionLocationScreen";

  @override
  _HighPrecisionLocationScreenState createState() =>
      _HighPrecisionLocationScreenState();
}

class _HighPrecisionLocationScreenState
    extends State<HighPrecisionLocationScreen> {
  final PermissionHandler _permissionHandler = PermissionHandler();
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  LocationRequest _locationRequest = LocationRequest()
    ..interval = 10000
    ..priority = LocationRequest.PRIORITY_HD_ACCURACY;

  String _topText = "";
  String _bottomText = "";
  int? _callbackId;
  late LocationCallback _locationCallback;

  @override
  void initState() {
    super.initState();

    _locationCallback = LocationCallback(
      onLocationResult: _onCallbackResult,
      onLocationAvailability: _onCallbackResult,
    );
  }

  void _onCallbackResult(result) {
    _appendToBottomText(result.toString());
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

  void _reqHighPrecisionLoc() async {
    if (_callbackId == null) {
      try {
        final int callbackId = await _locationService
            .requestLocationUpdatesExCb(_locationRequest, _locationCallback);
        _callbackId = callbackId;
        _setTopText("Location updates are requested successfully.");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText(
          "Already requested location updates. Try removing location updates");
    }
  }

  void _removeHighPrecisionLoc() async {
    _setTopText();
    if (_callbackId != null) {
      try {
        await _locationService.removeLocationUpdatesCb(_callbackId!);
        _callbackId = null;
        _setTopText("Location updates are removed successfully");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText("callbackId does not exist. Request location updates first");
    }
  }

  void _setTopText([String text = ""]) {
    setState(() {
      _topText = text;
    });
  }

  void _appendToBottomText(String text) {
    setState(() {
      _bottomText = "$_bottomText\n\n$text";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Precision Location Service'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            Btn("Request High Precision Location", _reqHighPrecisionLoc),
            Btn("Remove High Precision Location", _removeHighPrecisionLoc),
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
