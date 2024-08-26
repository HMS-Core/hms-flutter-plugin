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

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';

import 'package:huawei_location_example/widgets/custom_button.dart' show Btn;

class LocationUpdatesScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'LocationUpdatesScreen';

  const LocationUpdatesScreen({Key? key}) : super(key: key);

  @override
  State<LocationUpdatesScreen> createState() => _LocationUpdatesScreenState();
}

class _LocationUpdatesScreenState extends State<LocationUpdatesScreen> {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;

  String _topText = '';
  String _bottomText = '';
  int? _requestCode;
  late StreamSubscription<Location> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = _locationService.onLocationData!.listen(
      (Location location) {
        _appendToBottomText(
          location.toString(),
        );
      },
    );
  }

  void _requestLocationUpdates() async {
    if (_requestCode == null) {
      try {
        final int requestCode = (await (_locationService
            .requestLocationUpdates(_locationRequest)))!;
        _requestCode = requestCode;
        _setTopText('Location updates requested successfully');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText(
        'Already requested location updates. Try removing location updates',
      );
    }
  }

  void _removeLocationUpdates() async {
    if (_requestCode != null) {
      try {
        await _locationService.removeLocationUpdates(_requestCode!);
        _requestCode = null;
        _setTopText('Location updates are removed successfully');
        _setBottomText();
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('requestCode does not exist. Request location updates first');
    }
  }

  void _removeLocationUpdatesOnDispose() async {
    if (_requestCode != null) {
      try {
        await _locationService.removeLocationUpdates(_requestCode!);
        _requestCode = null;
      } on PlatformException catch (e) {
        log(e.toString());
      }
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

  void _appendToBottomText(String text) {
    setState(() {
      _bottomText = '$_bottomText\n\n$text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Updates'),
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
            Btn('Request Location Updates', _requestLocationUpdates),
            Btn('Remove Location Updates', _removeLocationUpdates),
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

  @override
  void dispose() {
    super.dispose();
    _removeLocationUpdatesOnDispose();
    _streamSubscription.cancel();
  }
}
