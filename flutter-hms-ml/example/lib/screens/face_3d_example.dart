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

class Face3DExample extends StatefulWidget {
  @override
  _Face3DExampleState createState() => _Face3DExampleState();
}

class _Face3DExampleState extends State<Face3DExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ML3DFaceAnalyzer _analyzer;
  ML3DFaceAnalyzerSetting _setting;

  dynamic _eulerX = "";
  dynamic _eulerY = "";
  dynamic _eulerZ = "";

  @override
  void initState() {
    _analyzer = new ML3DFaceAnalyzer();
    _setting = new ML3DFaceAnalyzerSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("3D Face Recognition Demo")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          detectionResultBox("eulerX", _eulerX),
          detectionResultBox("eulerY", _eulerY),
          detectionResultBox("eulerZ", _eulerZ),
          SizedBox(height: 20),
          detectionButton(
              onPressed: _showImagePickingOptions, label: "START RECOGNITION")
        ],
      ),
    );
  }

  _startRecognition(String path) async {
    _setting.path = path;
    try {
      final List<ML3DFace> faces = await _analyzer.asyncAnalyzeFrame(_setting);
      setState(() {
        _eulerX = faces.first.eulerX;
        _eulerY = faces.first.eulerY;
        _eulerZ = faces.first.eulerZ;
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
