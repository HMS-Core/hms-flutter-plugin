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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huawei_location/activity/activity_conversion_data.dart';
import 'package:huawei_location/activity/activity_conversion_info.dart';
import 'package:huawei_location/activity/activity_conversion_response.dart';
import 'package:huawei_location/activity/activity_identification_data.dart';
import 'package:huawei_location/activity/activity_identification_service.dart';

import '../widgets/custom_button.dart';

class ActivityConversionScreen extends StatefulWidget {
  static const String routeName = "ActivityRecognitionScreen";

  @override
  _ActivityConversionScreenState createState() =>
      _ActivityConversionScreenState();
}

class _ActivityConversionScreenState extends State<ActivityConversionScreen> {
  static const int NUM_OF_ACTIVITY = 6;
  static const double CONT_WIDTH1 = 100;
  static const double CONT_WIDTH2 = 100;
  static const double CONT_WIDTH3 = 100;

  static const List<int> _validTypes = <int>[
    ActivityIdentificationData.VEHICLE,
    ActivityIdentificationData.BIKE,
    ActivityIdentificationData.FOOT,
    ActivityIdentificationData.STILL,
    ActivityIdentificationData.WALKING,
    ActivityIdentificationData.RUNNING
  ];

  String topText;
  String bottomText;
  int requestCode;
  List<String> _activityTypes;
  List<bool> _inStates;
  List<bool> _outStates;

  ActivityIdentificationService service;
  StreamSubscription<ActivityConversionResponse> streamSubscription;

  void initServices() {
    topText = "";
    bottomText = "";
    _activityTypes = <String>[
      "VEHICLE[100]",
      "BIKE[101]",
      "FOOT[102]",
      "STILL[103]",
      "WALKING[107]",
      "RUNNING[108]"
    ];
    _inStates = List.filled(NUM_OF_ACTIVITY, false);
    _outStates = List.filled(NUM_OF_ACTIVITY, false);
    service = ActivityIdentificationService();
    streamSubscription = service.onActivityConversion.listen(onConversionData);
  }

  void onConversionData(ActivityConversionResponse response) {
    for (ActivityConversionData data in response.activityConversionDatas) {
      appendBottomText(data.toString());
    }
  }

  List<ActivityConversionInfo> getConversionList() {
    List<ActivityConversionInfo> conversions = <ActivityConversionInfo>[];

    for (int i = 0; i < NUM_OF_ACTIVITY; i++) {
      if (_inStates[i]) {
        conversions.add(ActivityConversionInfo(
            activityType: _validTypes[i], conversionType: 0));
      }
      if (_outStates[i]) {
        conversions.add(ActivityConversionInfo(
            activityType: _validTypes[i], conversionType: 1));
      }
    }
    return conversions;
  }

  void createActivityConversionUpdates() async {
    if (requestCode == null) {
      try {
        int _requestCode =
            await service.createActivityConversionUpdates(getConversionList());
        requestCode = _requestCode;
        setTopText("Created Activity Conversion Updates successfully.");
      } catch (e) {
        setTopText(e.toString());
      }
    } else {
      setTopText("Already receiving Activity Conversion Updates.");
    }
  }

  void deleteActivityConversionUpdates() async {
    if (requestCode != null) {
      try {
        await service.deleteActivityConversionUpdates(requestCode);
        requestCode = null;
        clearBottomText();
        setTopText("Deleted Activity Conversion Updates successfully.");
      } catch (e) {
        setTopText(e.toString());
      }
    } else {
      setTopText("Create Activity Conversion Updates first.");
    }
  }

  void deleteUpdatesOnDispose() async {
    if (requestCode != null) {
      try {
        await service.deleteActivityConversionUpdates(requestCode);
        requestCode = null;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void setTopText(String text) {
    setState(() {
      topText = text;
    });
  }

  void setBottomText(String text) {
    setState(() {
      bottomText = text;
    });
  }

  void appendBottomText(String text) {
    setState(() {
      bottomText = "$bottomText\n\n$text";
    });
  }

  void clearTopText() {
    setState(() {
      topText = "";
    });
  }

  void clearBottomText() {
    setState(() {
      bottomText = "";
    });
  }

  @override
  void initState() {
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Conversion"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 6),
              child: Text(topText),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(width: CONT_WIDTH1, child: Text("Activity")),
                Container(width: CONT_WIDTH2, child: Text("Transition")),
                Container(width: CONT_WIDTH3, child: Text("Transition")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(width: CONT_WIDTH1),
                Container(width: CONT_WIDTH2, child: Text("IN(0)")),
                Container(width: CONT_WIDTH3, child: Text("OUT(1)")),
              ],
            ),
            Container(
              child: Column(
                children: List.generate(NUM_OF_ACTIVITY, (i) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: CONT_WIDTH1,
                          child: Text(_activityTypes[i]),
                        ),
                        Container(
                          width: CONT_WIDTH2,
                          child: Checkbox(
                            value: _inStates[i],
                            onChanged: (bool value) => setState(() {
                              _inStates[i] = value;
                            }),
                          ),
                        ),
                        Container(
                          width: CONT_WIDTH3,
                          child: Checkbox(
                            value: _outStates[i],
                            onChanged: (bool value) => setState(() {
                              _outStates[i] = value;
                            }),
                          ),
                        ),
                      ]);
                }),
              ),
            ),
            Btn("createActivityConversionUpdates",
                createActivityConversionUpdates),
            Btn("deleteActivityConversionUpdates",
                deleteActivityConversionUpdates),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(bottomText),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    deleteUpdatesOnDispose();
    streamSubscription.cancel();
  }
}
