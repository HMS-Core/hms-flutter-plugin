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

import 'package:flutter/material.dart';
import 'package:huawei_ml/asr/ml_asr_client.dart';
import 'package:huawei_ml/asr/ml_asr_settings.dart';
import 'package:huawei_ml/helpers/asr_aft_helpers.dart';
import 'package:huawei_ml/permissions/permission_client.dart';

class AsrPage extends StatefulWidget {
  @override
  _AsrPageState createState() => _AsrPageState();
}

class _AsrPageState extends State<AsrPage> {
  MLAsrSettings settings;

  double _bottom = -125;
  String _recognitionResult = "Recognition result will be here";

  @override
  void initState() {
    settings = new MLAsrSettings();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    if (await MlPermissionClient.checkRecordAudioPermission()) {
      print("Permissions are granted");
    } else {
      await MlPermissionClient.checkRecordAudioPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Asr"),
          titleSpacing: 0,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: .5,
                      color: Colors.black.withOpacity(.5),
                      style: BorderStyle.solid)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "When recognition starts, you can speak for 60 seconds. And when you're done speaking, the recognition result will be shown below.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(_recognitionResult),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Start Analyze"),
                    onPressed: _startRecognition,
                  )),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              bottom: _bottom,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.greenAccent),
                width: 100,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text("Listening...",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _startRecognition() async {
    setState(() {
      _bottom = MediaQuery.of(context).size.height / 3.5;
    });
    settings.language = MLAsrLanguage.english;
    settings.feature = MLAsrFeature.FEATURE_WORD_FLUX;
    try {
      final String result = await MlAsrClient.getTextFromSpeech(settings);
      setState(() {
        _recognitionResult = result;
        _bottom = -125;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
