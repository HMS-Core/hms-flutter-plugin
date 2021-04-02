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
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';
import 'package:image_picker/image_picker.dart';

class LandmarkExample extends StatefulWidget {
  @override
  _LandmarkExampleState createState() => _LandmarkExampleState();
}

class _LandmarkExampleState extends State<LandmarkExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLLandmarkAnalyzer analyzer;
  MLLandmarkAnalyzerSetting setting;

  String _landmark = "landmark name";
  dynamic _possibility = 0;
  dynamic _bottomCorner = 0;
  dynamic _topCorner = 0;
  dynamic _leftCorner = 0;
  dynamic _rightCorner = 0;

  @override
  void initState() {
    analyzer = new MLLandmarkAnalyzer();
    setting = new MLLandmarkAnalyzerSetting();
    _setApiKey();
    _checkPermissions();
    super.initState();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
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
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Landmark Recognition"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            detectionResultBox("LANDMARK", _landmark),
            detectionResultBox("POSSIBILITY", _possibility),
            detectionResultBox("BOTTOM CORNER", _bottomCorner),
            detectionResultBox("TOP CORNER", _topCorner),
            detectionResultBox("LEFT CORNER", _leftCorner),
            detectionResultBox("RIGHT CORNER", _rightCorner),
            SizedBox(height: 20),
            detectionButton(
                onPressed: _showImagePickingOptions, label: "START ANALYZING")
          ],
        ),
      ),
    ));
  }

  _startRecognition(String path) async {
    setting.path = path;
    try {
      final List<MLLandmark> list = await analyzer.asyncAnalyzeFrame(setting);
      setState(() {
        _landmark = list.first.landmark;
        _possibility = list.first.possibility;
        _bottomCorner = list.first.border.bottom;
        _topCorner = list.first.border.top;
        _leftCorner = list.first.border.left;
        _rightCorner = list.first.border.right;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
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
