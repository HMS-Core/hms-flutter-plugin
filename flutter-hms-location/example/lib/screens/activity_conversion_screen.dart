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

class ActivityConversionScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'ActivityRecognitionScreen';

  const ActivityConversionScreen({Key? key}) : super(key: key);

  @override
  State<ActivityConversionScreen> createState() =>
      _ActivityConversionScreenState();
}

class _ActivityConversionScreenState extends State<ActivityConversionScreen> {
  static const int _NUM_OF_ACTIVITY = 6;
  static const double _CONT_WIDTH1 = 100;
  static const double _CONT_WIDTH2 = 100;
  static const double _CONT_WIDTH3 = 100;

  static const List<int> _VALID_TYPES = <int>[
    ActivityIdentificationData.VEHICLE,
    ActivityIdentificationData.BIKE,
    ActivityIdentificationData.FOOT,
    ActivityIdentificationData.STILL,
    ActivityIdentificationData.WALKING,
    ActivityIdentificationData.RUNNING
  ];

  static const List<String> _ACTIVITY_TYPES = <String>[
    'VEHICLE[100]',
    'BIKE[101]',
    'FOOT[102]',
    'STILL[103]',
    'WALKING[107]',
    'RUNNING[108]'
  ];

  final ActivityIdentificationService _service =
      ActivityIdentificationService();
  final List<bool> _inStates = List<bool>.filled(_NUM_OF_ACTIVITY, false);
  final List<bool> _outStates = List<bool>.filled(_NUM_OF_ACTIVITY, false);

  String _topText = '';
  String _bottomText = '';
  int? _requestCode;
  late StreamSubscription<ActivityConversionResponse> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        _service.onActivityConversion.listen(_onConversionData);
  }

  void _onConversionData(ActivityConversionResponse response) {
    for (ActivityConversionData? data in response.activityConversionDatas!) {
      _appendToBottomText(data.toString());
    }
  }

  List<ActivityConversionInfo> _getConversionList() {
    List<ActivityConversionInfo> conversions = <ActivityConversionInfo>[];

    for (int i = 0; i < _NUM_OF_ACTIVITY; i++) {
      if (_inStates[i]) {
        conversions.add(
          ActivityConversionInfo(
            activityType: _VALID_TYPES[i],
            conversionType: 0,
          ),
        );
      }
      if (_outStates[i]) {
        conversions.add(
          ActivityConversionInfo(
            activityType: _VALID_TYPES[i],
            conversionType: 1,
          ),
        );
      }
    }
    return conversions;
  }

  void _createActivityConversionUpdates() async {
    if (_requestCode == null) {
      try {
        final int requestCode = await _service
            .createActivityConversionUpdates(_getConversionList());
        _requestCode = requestCode;
        _setTopText('Created Activity Conversion Updates successfully.');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('Already receiving Activity Conversion Updates.');
    }
  }

  void _deleteActivityConversionUpdates() async {
    if (_requestCode != null) {
      try {
        await _service.deleteActivityConversionUpdates(_requestCode!);
        _requestCode = null;
        _setBottomText();
        _setTopText('Deleted Activity Conversion Updates successfully.');
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText('Create Activity Conversion Updates first.');
    }
  }

  void _deleteUpdatesOnDispose() async {
    if (_requestCode != null) {
      try {
        await _service.deleteActivityConversionUpdates(_requestCode!);
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
        title: const Text('Activity Conversion'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 6),
              child: Text(_topText),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                SizedBox(width: _CONT_WIDTH1, child: Text('Activity')),
                SizedBox(width: _CONT_WIDTH2, child: Text('Transition')),
                SizedBox(width: _CONT_WIDTH3, child: Text('Transition')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(width: _CONT_WIDTH1),
                const SizedBox(width: _CONT_WIDTH2, child: Text('IN(0)')),
                const SizedBox(width: _CONT_WIDTH3, child: Text('OUT(1)')),
              ],
            ),
            Column(
              children: List<Widget>.generate(_NUM_OF_ACTIVITY, (int i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: _CONT_WIDTH1,
                      child: Text(_ACTIVITY_TYPES[i]),
                    ),
                    SizedBox(
                      width: _CONT_WIDTH2,
                      child: Checkbox(
                        value: _inStates[i],
                        onChanged: (bool? value) => setState(() {
                          _inStates[i] = value!;
                        }),
                      ),
                    ),
                    SizedBox(
                      width: _CONT_WIDTH3,
                      child: Checkbox(
                        value: _outStates[i],
                        onChanged: (bool? value) => setState(() {
                          _outStates[i] = value!;
                        }),
                      ),
                    ),
                  ],
                );
              }),
            ),
            Btn(
              'createActivityConversionUpdates',
              _createActivityConversionUpdates,
            ),
            Btn(
              'deleteActivityConversionUpdates',
              _deleteActivityConversionUpdates,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(_bottomText),
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
