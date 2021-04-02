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

class DocumentCorrectionExample extends StatefulWidget {
  @override
  _DocumentCorrectionExampleState createState() =>
      _DocumentCorrectionExampleState();
}

class _DocumentCorrectionExampleState extends State<DocumentCorrectionExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLDocumentSkewCorrectionAnalyzer analyzer;
  MLDocumentSkewDetectResult detectionResult;
  MLDocumentSkewCorrectionResult correctionResult;

  dynamic _leftTopX = 0;
  dynamic _leftTopY = 0;
  String _bitmapPath = "";
  int _resultCode = 0;

  String _imagePath = "";

  @override
  void initState() {
    analyzer = new MLDocumentSkewCorrectionAnalyzer();
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
      appBar: AppBar(title: Text("Document Skew Correction")),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            detectionResultBox("leftTopX", _leftTopX),
            detectionResultBox("leftTopY", _leftTopY),
            detectionButton(
                onPressed: _showImagePickingOptions,
                label: "DETECT DOCUMENT SKEW"),
            Divider(),
            detectionResultBox("bitmapPath", _bitmapPath),
            detectionResultBox("resultCode", _resultCode),
            detectionButton(onPressed: _getCorrected, label: "GET CORRECTED")
          ],
        )),
      ),
    );
  }

  _startDetection() async {
    try {
      detectionResult = await analyzer.syncDocumentSkewDetect(_imagePath);
      if (detectionResult != null) {
        setState(() {
          _leftTopX = detectionResult.leftTop.x;
          _leftTopY = detectionResult.leftTop.y;
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _getCorrected() async {
    try {
      correctionResult = await analyzer.syncDocumentSkewResult();
      if (correctionResult != null) {
        setState(() {
          _bitmapPath = correctionResult.imagePath;
          _resultCode = correctionResult.resultCode;
        });
      }
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
                        setState(() => _imagePath = path);
                        _startDetection();
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        setState(() => _imagePath = path);
                        _startDetection();
                      })),
            ],
          ),
        ));
  }
}
