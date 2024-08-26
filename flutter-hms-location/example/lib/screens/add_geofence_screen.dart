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

import 'package:huawei_location_example/widgets/custom_button.dart';
import 'package:huawei_location_example/widgets/custom_textinput.dart';

class AddGeofenceScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'AddGeofenceScreen';

  const AddGeofenceScreen({Key? key}) : super(key: key);

  @override
  State<AddGeofenceScreen> createState() => _AddGeofenceScreenState();
}

class _AddGeofenceScreenState extends State<AddGeofenceScreen> {
  String _topText = '';
  String _bottomText = '';
  int _fenceCount = 0;
  int? _requestCode;
  late List<Geofence> _geofenceList;
  late List<String> _geofenceIdList;

  final TextEditingController _lat = TextEditingController();
  final TextEditingController _lng = TextEditingController();
  final TextEditingController _rad = TextEditingController(text: '60');
  final TextEditingController _uid = TextEditingController();
  final TextEditingController _conversions = TextEditingController(text: '5');
  final TextEditingController _validTime =
      TextEditingController(text: '1000000');
  final TextEditingController _dwellTime = TextEditingController(text: '10000');
  final TextEditingController _notifInterval =
      TextEditingController(text: '100');

  final List<FilteringTextInputFormatter> _numWithDecimalFormatter =
      <FilteringTextInputFormatter>[
    FilteringTextInputFormatter.allow(
      RegExp(r'[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)'),
    ),
  ];

  final List<FilteringTextInputFormatter> _digitsOnlyFormatter =
      <FilteringTextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ];

  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  late StreamSubscription<Location> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _getGeofenceListFromRoute();
    _subscribeLocationUpdates();
  }

  void _getGeofenceListFromRoute() {
    Future<void>.delayed(Duration.zero, () {
      Map<String, Object> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      _geofenceList = args['geofenceList'] as List<Geofence>;
      _geofenceIdList = args['geofenceIdList'] as List<String>;
      setState(() {
        _bottomText = _geofenceIdList.toString();
        _fenceCount = _geofenceIdList.length;
      });
    });
  }

  void _subscribeLocationUpdates() {
    _streamSubscription = _locationService.onLocationData!.listen(
      (Location location) {
        setState(() {
          _lat.text = location.latitude.toString();
          _lng.text = location.longitude.toString();
        });
        _removeLocationUpdates(_requestCode!);
      },
    );
  }

  void _addGeofence() {
    try {
      final String uniqueId = _uid.text;

      if (uniqueId == '') {
        _setTopText('UniqueId cannot be empty.');
      } else if (_geofenceIdList.contains(uniqueId)) {
        _setTopText('Geofence with this UniqueId already exists.');
      } else {
        final int conversions = int.parse(_conversions.text);
        final int validDuration = int.parse(_validTime.text);
        final double latitude = double.parse(_lat.text);
        final double longitude = double.parse(_lng.text);
        final double radius = double.parse(_rad.text);
        final int notificationInterval = int.parse(_notifInterval.text);
        final int dwellDelayTime = int.parse(_dwellTime.text);

        Geofence geofence = Geofence(
          uniqueId: uniqueId,
          conversions: conversions,
          validDuration: validDuration,
          latitude: latitude,
          longitude: longitude,
          radius: radius,
          notificationInterval: notificationInterval,
          dwellDelayTime: dwellDelayTime,
        );

        _geofenceList.add(geofence);
        _geofenceIdList.add(geofence.uniqueId);

        setState(() {
          _fenceCount++;
          _bottomText = _geofenceIdList.toString();
          _topText = 'Geofence added successfully.';
        });
      }
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _requestLocationUpdates() async {
    final LocationRequest locationRequest = LocationRequest()..interval = 500;
    try {
      _requestCode =
          await _locationService.requestLocationUpdates(locationRequest);
      log('Requested location updates with request code: $_requestCode');
      log('Now removing location updates');
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _removeLocationUpdates(int requestCode) async {
    try {
      await _locationService.removeLocationUpdates(requestCode);
      log('Removed location updates with request code: $requestCode');
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  void _setTopText([String text = '']) {
    setState(() {
      _topText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pop(
            context,
            <String, List<Object>>{
              'geofenceList': _geofenceList,
              'geofenceIdList': _geofenceIdList,
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Geofence Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(_topText),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CustomTextInput(
                      controller: _lat,
                      labelText: 'Latitude',
                      hintText: '[-90,90]',
                      inputFormatters: _numWithDecimalFormatter,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                    ),
                    CustomTextInput(
                      controller: _lng,
                      labelText: 'Longitude',
                      hintText: '[-180,180]',
                      inputFormatters: _numWithDecimalFormatter,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                    ),
                    CustomTextInput(
                      controller: _rad,
                      labelText: 'Radius',
                      hintText: 'in meters',
                      inputFormatters: _numWithDecimalFormatter,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                    ),
                    CustomTextInput(
                      controller: _uid,
                      labelText: 'UniqueId',
                      keyboardType: TextInputType.text,
                    ),
                    CustomTextInput(
                      controller: _conversions,
                      labelText: 'Conversions',
                      inputFormatters: _digitsOnlyFormatter,
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextInput(
                      controller: _validTime,
                      labelText: 'ValidTime',
                      inputFormatters: _digitsOnlyFormatter,
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextInput(
                      controller: _dwellTime,
                      labelText: 'DwellDelayTime',
                      inputFormatters: _digitsOnlyFormatter,
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextInput(
                      controller: _notifInterval,
                      labelText: 'NotificationInterval',
                      inputFormatters: _digitsOnlyFormatter,
                      keyboardType: TextInputType.number,
                    ),
                    Btn('Get Current Location', _requestLocationUpdates),
                    Btn('Add Geofence', () {
                      _addGeofence();
                    }),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text('Geofences: $_fenceCount'),
                            const SizedBox(height: 15),
                            Text(_bottomText),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    _removeLocationUpdates(_requestCode!);
  }
}
