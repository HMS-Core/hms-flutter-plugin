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
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';

class HandExample extends StatefulWidget {
  @override
  _HandExampleState createState() => _HandExampleState();
}

class _HandExampleState extends State<HandExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLHandKeypointAnalyzer analyzer;
  MLHandKeypointAnalyzerSetting setting;
  List<MLHandKeypoints> keypoints;

  double _x = 0;
  double _y = 0;
  double _score = 0;
  int _type = 0;

  @override
  void initState() {
    analyzer = new MLHandKeypointAnalyzer();
    setting = new MLHandKeypointAnalyzerSetting();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    await MLPermissionClient()
        .requestPermission([MLPermission.camera]).then((v) {
      if (!v) {
        _checkPermissions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Hand Keypoints")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              detectionResultBox("x", _x),
              detectionResultBox("y", _y),
              detectionResultBox("score", _score),
              detectionResultBox("type", _type),
              SizedBox(height: 20),
              detectionButton(onPressed: _showImagePickingOptions)
            ],
          ),
        ),
      ),
    );
  }

  _startRecognition(String path) async {
    setting.path = path;
    try {
      keypoints = await analyzer.asyncHandDetection(setting);
      _updateHandExample(keypoints.first.handKeypoints.elementAt(2));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _updateHandExample(MLHandKeypoint keypoint) {
    setState(() {
      _x = keypoint.pointX;
      _y = keypoint.pointY;
      _score = keypoint.score;
      _type = keypoint.type;
    });
  }

  _showImagePickingOptions() async {
    scaffoldKey.currentState.showBottomSheet((context) => Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("USE CAMERA"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.camera);
                        _startRecognition(path);
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        _startRecognition(path);
                      })),
            ],
          ),
        ));
  }
}
