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
import 'package:image_picker/image_picker.dart';

class DocumentExample extends StatefulWidget {
  @override
  _DocumentExampleState createState() => _DocumentExampleState();
}

class _DocumentExampleState extends State<DocumentExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLDocumentAnalyzer analyzer;
  MLDocumentAnalyzerSetting setting;

  String _recognitionResult = "Result will be shown here.";

  @override
  void initState() {
    analyzer = new MLDocumentAnalyzer();
    setting = new MLDocumentAnalyzerSetting();
    _setApiKey();
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

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text("Document Recognition"),
              titleSpacing: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: .5,
                            color: Colors.black.withOpacity(.5),
                            style: BorderStyle.solid)),
                    child: Text(_recognitionResult),
                  ),
                ),
                detectionButton(
                    onPressed: _showImagePickingOptions,
                    label: "START ANALYSING")
              ],
            )));
  }

  _startRecognition(String path) async {
    setting.path = path;
    try {
      final MLDocument document = await analyzer.asyncAnalyzeFrame(setting);
      setState(() => _recognitionResult = document.stringValue);
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
