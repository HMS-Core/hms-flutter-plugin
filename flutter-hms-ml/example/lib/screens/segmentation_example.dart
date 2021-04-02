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

class SegmentationExample extends StatefulWidget {
  @override
  _SegmentationExampleState createState() => _SegmentationExampleState();
}

class _SegmentationExampleState extends State<SegmentationExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLImageSegmentationAnalyzer analyzer;
  MLImageSegmentationAnalyzerSetting setting;
  List<MLImageSegmentation> result;

  String _foregroundUri = "Foreground Uri";
  String _grayscaleUri = "Grayscale Uri";
  String _originalUri = "Original Uri";
  List<dynamic> _masks;

  @override
  void initState() {
    analyzer = new MLImageSegmentationAnalyzer();
    setting = new MLImageSegmentationAnalyzerSetting();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    await MLPermissionClient().requestPermission(
        [MLPermission.camera, MLPermission.storage]).then((v) {
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
          title: Text("Image Segmentation Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 10, right: 10, bottom: 50),
                child: Text("Check Your Gallery After Segmentation Complete",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              detectionResultBox("FOREGROUND URI", _foregroundUri),
              detectionResultBox("GRAYSCALE URI", _grayscaleUri),
              detectionResultBox("ORIGINAL URI", _originalUri),
              detectionResultBox("MASKS", _masks),
              SizedBox(height: 20),
              detectionButton(
                  onPressed: _showImagePickingOptions, label: "START ANALYZING")
            ],
          ),
        ),
      ),
    );
  }

  _startRecognition(String path) async {
    setting.path = path;
    setting.analyzerType = MLImageSegmentationAnalyzerSetting.BODY_SEG;
    setting.scene = MLImageSegmentationAnalyzerSetting.ALL;
    try {
      result = await analyzer.analyzeFrame(setting);
      setState(() {
        _foregroundUri = result.first.foregroundUri;
        _grayscaleUri = result.first.grayscaleUri;
        _originalUri = result.first.originalUri;
        //_masks = result.masks;
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
