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
import 'package:huawei_location_example/widgets/custom_progressbar.dart';

class ActivityIdentificationScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'ActivityIdentificationScreen';

  const ActivityIdentificationScreen({Key? key}) : super(key: key);

  @override
  State<ActivityIdentificationScreen> createState() =>
      _ActivityIdentificationScreenState();
}

class _ActivityIdentificationScreenState
    extends State<ActivityIdentificationScreen> {
  final ActivityIdentificationService _service =
      ActivityIdentificationService();

  int? _requestCode;

  String _topText = '';
  String _bottomText = '';

  int _progressVehicle = 0;
  int _progressBike = 0;
  int _progressFoot = 0;
  int _progressStill = 0;
  int _progressOthers = 0;
  int _progressTilting = 0;
  int _progressWalking = 0;
  int _progressRunning = 0;

  late StreamSubscription<ActivityIdentificationResponse> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _initFusedLocationService();
    _streamSubscription =
        _service.onActivityIdentification.listen(_onIdentificationResponse);
  }

  void _resetProgressBars() {
    setState(() {
      _progressVehicle = 0;
      _progressBike = 0;
      _progressFoot = 0;
      _progressStill = 0;
      _progressOthers = 0;
      _progressTilting = 0;
      _progressWalking = 0;
      _progressRunning = 0;
    });
  }

  void _setProgress(int? activity, int? possibility) {
    switch (activity) {
      case ActivityIdentificationData.VEHICLE:
        setState(() {
          _progressVehicle = possibility!;
        });
        break;
      case ActivityIdentificationData.BIKE:
        setState(() {
          _progressBike = possibility!;
        });
        break;
      case ActivityIdentificationData.FOOT:
        setState(() {
          _progressFoot = possibility!;
        });
        break;
      case ActivityIdentificationData.STILL:
        setState(() {
          _progressStill = possibility!;
        });
        break;
      case ActivityIdentificationData.OTHERS:
        setState(() {
          _progressOthers = possibility!;
        });
        break;
      case ActivityIdentificationData.TILTING:
        setState(() {
          _progressTilting = possibility!;
        });
        break;
      case ActivityIdentificationData.WALKING:
        setState(() {
          _progressWalking = possibility!;
        });
        break;
      case ActivityIdentificationData.RUNNING:
        setState(() {
          _progressRunning = possibility!;
        });
        break;
      default:
        break;
    }
  }

  void _onIdentificationResponse(ActivityIdentificationResponse response) {
    _resetProgressBars();
    _appendBottomText(response.toString());
    for (ActivityIdentificationData data
        in response.activityIdentificationDatas!) {
      _setProgress(data.identificationActivity, data.possibility);
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

  void _appendBottomText([String text = '']) {
    setState(() {
      _bottomText = '$_bottomText\n\n$text';
    });
  }

  void _initFusedLocationService() async {
    try {
      await _service.initActivityIdentificationService();
      _setTopText('Activity Identification Service has been initialized.');
    } on PlatformException catch (e) {
      _setBottomText(e.toString());
    }
  }

  void _createActivityIdentificationUpdates() async {
    if (_requestCode == null) {
      try {
        final int responseRequestCode =
            await _service.createActivityIdentificationUpdates(1000);
        _requestCode = responseRequestCode;
        _setTopText('Created Activity Identification Updates successfully.');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('Already receiving Activity Identification Updates.');
    }
  }

  void _deleteActivityIdentificationUpdates() async {
    if (_requestCode != null) {
      try {
        await _service.deleteActivityIdentificationUpdates(_requestCode!);
        _requestCode = null;
        _resetProgressBars();
        _setBottomText();
        _setTopText('Deleted Activity Identification Updates successfully.');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('Create Activity Identification Updates first.');
    }
  }

  void _deleteUpdatesOnDispose() async {
    if (_requestCode != null) {
      try {
        await _service.deleteActivityIdentificationUpdates(_requestCode!);
        _requestCode = null;
      } on PlatformException catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Identification'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 6),
              child: Text(_topText),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Btn(
                    'createActivityIdentificationUpdates',
                    _createActivityIdentificationUpdates,
                  ),
                  Btn(
                    'deleteActivityIdentificationUpdates',
                    _deleteActivityIdentificationUpdates,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: <Widget>[
                        ProgressBar(
                          label: 'VEHICLE[100]',
                          value: _progressVehicle,
                          color: Colors.redAccent,
                        ),
                        ProgressBar(
                          label: 'BIKE[101]',
                          value: _progressBike,
                          color: Colors.black54,
                        ),
                        ProgressBar(
                          label: 'FOOT[102]',
                          value: _progressFoot,
                          color: Colors.pinkAccent,
                        ),
                        ProgressBar(
                          label: 'STILL[103]',
                          value: _progressStill,
                          color: Colors.red,
                        ),
                        ProgressBar(
                          label: 'OTHERS[104]',
                          value: _progressOthers,
                          color: Colors.blueGrey,
                        ),
                        ProgressBar(
                          label: 'TILTING[105]',
                          value: _progressTilting,
                          color: Colors.amber,
                        ),
                        ProgressBar(
                          label: 'WALKING[107]',
                          value: _progressWalking,
                          color: Colors.deepPurple,
                        ),
                        ProgressBar(
                          label: 'RUNNING[108]',
                          value: _progressRunning,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(_bottomText),
                  ),
                ],
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
    _deleteUpdatesOnDispose();
    _streamSubscription.cancel();
  }
}
