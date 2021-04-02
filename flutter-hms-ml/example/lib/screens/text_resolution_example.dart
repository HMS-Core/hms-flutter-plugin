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

class TextResolutionExample extends StatefulWidget {
  @override
  _TextResolutionExampleState createState() => _TextResolutionExampleState();
}

class _TextResolutionExampleState extends State<TextResolutionExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLTextImageSuperResolutionAnalyzer analyzer;
  MLTextImageSuperResolution result;

  String _resultBitmap = " ";

  @override
  void initState() {
    analyzer = new MLTextImageSuperResolutionAnalyzer();
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
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Text Image Super Resolution Page"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            detectionResultBox("Result", _resultBitmap),
            SizedBox(height: 10),
            detectionButton(
                onPressed: _showImagePickingOptions, label: "START DETECTION")
          ],
        ));
  }

  _startDetection(String path) async {
    try {
      MLTextImageSuperResolution results =
          await analyzer.asyncAnalyzeFrame(path);
      setState(() => _resultBitmap = results.bitmap);
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
                        _startDetection(path);
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        _startDetection(path);
                      })),
            ],
          ),
        ));
  }
}
