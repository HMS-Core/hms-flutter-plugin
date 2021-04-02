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

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLFormRecognitionAnalyzer analyzer;

  int resultCode = 0;
  int tableCount = 0;
  String textInfo = "";

  @override
  void initState() {
    analyzer = new MLFormRecognitionAnalyzer();
    _checkPermissions();
    _setApiKey();
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

  _setApiKey() async {
    await MLApplication().setApiKey(
        apiKey:
            "CgB6e3x98nL7VwNEe2dcioYnjrhJWLVkw26yO/UZXp0d0mTxwjn2MGPvAcNswUxj1kL+JhMrWliKywqhMVBkVkSu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Form Recognition")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          detectionResultBox("resultCode", resultCode),
          detectionResultBox("tableCount", tableCount),
          detectionResultBox("textInfo", textInfo),
          SizedBox(height: 20),
          detectionButton(
              onPressed: _showImagePickingOptions, label: "START RECOGNITION")
        ],
      ),
    );
  }

  _startDetection(String path) async {
    final MLTable table = await analyzer.syncFormDetection(path);
    setState(() {
      resultCode = table.retCode;
      tableCount = table.tableContent.tableCount;
      textInfo = table.tableContent.tables.first.tableBody.first.textInfo;
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
