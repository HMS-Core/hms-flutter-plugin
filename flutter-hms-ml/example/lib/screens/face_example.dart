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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';
import 'package:image_picker/image_picker.dart';

class FaceExample extends StatefulWidget {
  @override
  _FaceExampleState createState() => _FaceExampleState();
}

class _FaceExampleState extends State<FaceExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLFaceAnalyzer analyzer;
  MLFaceAnalyzerSetting setting;

  dynamic _angryPossibility = 0;
  dynamic _disgustPossibility = 0;
  dynamic _fearPossibility = 0;
  dynamic _neutralPossibility = 0;
  dynamic _sadPossibility = 0;
  dynamic _smilingPossibility = 0;
  dynamic _surprisePossibility = 0;

  @override
  void initState() {
    analyzer = new MLFaceAnalyzer();
    setting = new MLFaceAnalyzerSetting();
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
        appBar: AppBar(title: Text("Face Recognition")),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            detectionResultBox("ANGRY POSSIBILITY", _angryPossibility),
            detectionResultBox("DISGUST POSSIBILITY", _disgustPossibility),
            detectionResultBox("FEAR POSSIBILITY", _fearPossibility),
            detectionResultBox("NEUTRAL POSSIBILITY", _neutralPossibility),
            detectionResultBox("SAD POSSIBILITY", _sadPossibility),
            detectionResultBox("SMILING POSSIBILITY", _smilingPossibility),
            detectionResultBox("SURPRISE POSSIBILITY", _surprisePossibility),
            SizedBox(height: 20),
            detectionButton(
                onPressed: _showImagePickingOptions, label: "START RECOGNITION")
          ],
        )),
      ),
    );
  }

  _startRecognition(String path) async {
    setting.path = path;
    try {
      final List<MLFace> list = await analyzer.asyncAnalyzeFrame(setting);
      _updateEmotions(list.first);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _updateEmotions(MLFace mlFace) {
    setState(() {
      _angryPossibility = mlFace.emotions.angryProbability;
      _disgustPossibility = mlFace.emotions.disgustProbability;
      _fearPossibility = mlFace.emotions.fearProbability;
      _neutralPossibility = mlFace.emotions.neutralProbability;
      _sadPossibility = mlFace.emotions.sadProbability;
      _smilingPossibility = mlFace.emotions.smilingProbability;
      _surprisePossibility = mlFace.emotions.surpriseProbability;
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
