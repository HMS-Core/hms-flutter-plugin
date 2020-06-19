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
import 'package:huawei_location/activity/activity_identification_data.dart';
import 'package:huawei_location/activity/activity_identification_response.dart';
import 'package:huawei_location/activity/activity_identification_service.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_progressbar.dart';

class ActivityIdentificationScreen extends StatefulWidget {
  static const String routeName = "ActivityIdentificationScreen";

  @override
  _ActivityIdentificationScreenState createState() =>
      _ActivityIdentificationScreenState();
}

class _ActivityIdentificationScreenState
    extends State<ActivityIdentificationScreen> {
  String topText;
  String bottomText;
  int requestCode;
  int _vehicle;
  int _bike;
  int _foot;
  int _still;
  int _others;
  int _tilting;
  int _walking;
  int _running;
  ActivityIdentificationService service;
  StreamSubscription<ActivityIdentificationResponse> streamSubscription;

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  void setInitialValues() {
    topText = "";
    bottomText = "";

    _vehicle = 0;
    _bike = 0;
    _foot = 0;
    _still = 0;
    _others = 0;
    _tilting = 0;
    _walking = 0;
    _running = 0;

    service = ActivityIdentificationService();

    streamSubscription =
        service.onActivityIdentification.listen(onIdentificationResponse);
  }

  void resetProgressBars() {
    setState(() {
      _vehicle = 0;
      _bike = 0;
      _foot = 0;
      _still = 0;
      _others = 0;
      _tilting = 0;
      _walking = 0;
      _running = 0;
    });
  }

  void setProgress(int activity, int possibility) {
    switch (activity) {
      case ActivityIdentificationData.VEHICLE:
        setState(() {
          _vehicle = possibility;
        });
        break;
      case ActivityIdentificationData.BIKE:
        setState(() {
          _bike = possibility;
        });
        break;
      case ActivityIdentificationData.FOOT:
        setState(() {
          _foot = possibility;
        });
        break;
      case ActivityIdentificationData.STILL:
        setState(() {
          _still = possibility;
        });
        break;
      case ActivityIdentificationData.OTHERS:
        setState(() {
          _others = possibility;
        });
        break;
      case ActivityIdentificationData.TILTING:
        setState(() {
          _tilting = possibility;
        });
        break;
      case ActivityIdentificationData.WALKING:
        setState(() {
          _walking = possibility;
        });
        break;
      case ActivityIdentificationData.RUNNING:
        setState(() {
          _running = possibility;
        });
        break;
      default:
        break;
    }
  }

  void onIdentificationResponse(ActivityIdentificationResponse response) {
    resetProgressBars();
    appendBottomText(response.toString());
    for (ActivityIdentificationData data
        in response.activityIdentificationDatas) {
      setProgress(data.identificationActivity, data.possibility);
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

  void createActivityIdentificationUpdates() async {
    if (requestCode == null) {
      try {
        int _requestCode =
            await service.createActivityIdentificationUpdates(5000);
        requestCode = _requestCode;
        setTopText("Created Activity Identification Updates successfully.");
      } catch (e) {
        setTopText(e.toString());
      }
    } else {
      setTopText("Already receiving Activity Identification Updates.");
    }
  }

  void deleteActivityIdentificationUpdates() async {
    if (requestCode != null) {
      try {
        await service.deleteActivityIdentificationUpdates(requestCode);
        requestCode = null;
        resetProgressBars();
        clearBottomText();
        setTopText("Deleted Activity Identification Updates successfully.");
      } catch (e) {
        setTopText(e.toString());
      }
    } else {
      setTopText("Create Activity Identification Updates first.");
    }
  }

  void deleteUpdatesOnDispose() async {
    if (requestCode != null) {
      try {
        await service.deleteActivityIdentificationUpdates(requestCode);
        requestCode = null;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Activity Identification'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 6),
                child: Text(topText),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Btn("createActivityIdentificationUpdates",
                        createActivityIdentificationUpdates),
                    Btn("deleteActivityIdentificationUpdates",
                        deleteActivityIdentificationUpdates),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: <Widget>[
                          ProgressBar(
                            label: "VEHICLE[100]",
                            value: _vehicle,
                            color: Colors.redAccent,
                          ),
                          ProgressBar(
                            label: "BIKE[101]",
                            value: _bike,
                            color: Colors.black54,
                          ),
                          ProgressBar(
                            label: "FOOT[102]",
                            value: _foot,
                            color: Colors.pinkAccent,
                          ),
                          ProgressBar(
                            label: "STILL[103]",
                            value: _still,
                            color: Colors.red,
                          ),
                          ProgressBar(
                            label: "OTHERS[104]",
                            value: _others,
                            color: Colors.blueGrey,
                          ),
                          ProgressBar(
                            label: "TILTING[105]",
                            value: _tilting,
                            color: Colors.amber,
                          ),
                          ProgressBar(
                            label: "WALKING[107]",
                            value: _walking,
                            color: Colors.deepPurple,
                          ),
                          ProgressBar(
                            label: "RUNNING[108]",
                            value: _running,
                            color: Colors.lightBlue,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(bottomText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    deleteUpdatesOnDispose();
    streamSubscription.cancel();
  }
}
