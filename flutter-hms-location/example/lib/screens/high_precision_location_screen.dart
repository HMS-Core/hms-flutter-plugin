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
import 'package:huawei_location_example/widgets/custom_button.dart';

class HighPrecisionLocationScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'HighPrecisionLocationScreen';

  const HighPrecisionLocationScreen({Key? key}) : super(key: key);

  @override
  State<HighPrecisionLocationScreen> createState() =>
      _HighPrecisionLocationScreenState();
}

class _HighPrecisionLocationScreenState
    extends State<HighPrecisionLocationScreen> {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()
    ..interval = 10000
    ..priority = LocationRequest.PRIORITY_HD_ACCURACY;

  String _topText = '';
  String _bottomText = '';
  int? _callbackId;
  late LocationCallback _locationCallback;

  @override
  void initState() {
    super.initState();

    _locationCallback = LocationCallback(
      onLocationResult: _onCallbackResult,
      onLocationAvailability: _onCallbackResult,
    );

    _requestPermission();
  }

  void _onCallbackResult(dynamic result) {
    _appendToBottomText(result.toString());
  }

  // TODO: Please implement your own 'Permission Handler'.
  void _requestPermission() async {
    // Huawei Location needs some permissions to work properly.
    // You are expected to handle these permissions to use Huawei Location Demo.

    // You can learn more about the required permissions from our official documentations.
    // https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001089376648?ha_source=hms1
  }

  void _reqHighPrecisionLoc() async {
    if (_callbackId == null) {
      try {
        final int callbackId = await _locationService
            .requestLocationUpdatesExCb(_locationRequest, _locationCallback);
        _callbackId = callbackId;
        _setTopText('Location updates are requested successfully.');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText(
        'Already requested location updates. Try removing location updates',
      );
    }
  }

  void _removeHighPrecisionLoc() async {
    _setTopText();
    if (_callbackId != null) {
      try {
        await _locationService.removeLocationUpdatesCb(_callbackId!);
        _callbackId = null;
        _setTopText('Location updates are removed successfully');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('callbackId does not exist. Request location updates first');
    }
  }

  void _setTopText([String text = '']) {
    setState(() {
      _topText = text;
    });
  }

  void _appendToBottomText(String text) {
    setState(() {
      _bottomText = '$_bottomText\n\n$text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Precision Location Service'),
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
            Btn('Request High Precision Location', _reqHighPrecisionLoc),
            Btn('Remove High Precision Location', _removeHighPrecisionLoc),
            Expanded(
              child: SingleChildScrollView(
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
