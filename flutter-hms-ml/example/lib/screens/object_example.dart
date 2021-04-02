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

class ObjectExample extends StatefulWidget {
  @override
  _ObjectExampleState createState() => _ObjectExampleState();
}

class _ObjectExampleState extends State<ObjectExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLObjectAnalyzer analyzer;
  MLObjectAnalyzerSetting setting;

  int _typeIdentity = 0;
  dynamic _typePossibility = 0;
  dynamic _bottomBorder = 0;
  dynamic _topBorder = 0;
  dynamic _leftBorder = 0;
  dynamic _rightBorder = 0;

  @override
  void initState() {
    analyzer = new MLObjectAnalyzer();
    setting = new MLObjectAnalyzerSetting();
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
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Object Recognition"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          detectionResultBox("TYPE IDENTITY", _typeIdentity),
          detectionResultBox("TYPE POSSIBILITY", _typePossibility),
          detectionResultBox("BOTTOM BORDER", _bottomBorder),
          detectionResultBox("TOP BORDER", _topBorder),
          detectionResultBox("LEFT BORDER", _leftBorder),
          detectionResultBox("RIGHT BORDER", _rightBorder),
          SizedBox(height: 20),
          detectionButton(
              onPressed: _showImagePickingOptions, label: "START ANALYZING")
        ],
      )),
    ));
  }

  _startRecognition(String path) async {
    setting.path = path;
    try {
      final List<MLObject> list = await analyzer.analyzeFrame(setting);
      setState(() {
        _typeIdentity = list.first.type;
        _typePossibility = list.first.possibility;
        _bottomBorder = list.first.border.bottom;
        _topBorder = list.first.border.top;
        _leftBorder = list.first.border.left;
        _rightBorder = list.first.border.right;
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
