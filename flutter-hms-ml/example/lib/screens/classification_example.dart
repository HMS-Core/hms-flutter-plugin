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
import 'package:huawei_ml_example/widgets/detection_result_box.dart';
import 'package:image_picker/image_picker.dart';

class ClassificationExample extends StatefulWidget {
  @override
  _ClassificationExampleState createState() => _ClassificationExampleState();
}

class _ClassificationExampleState extends State<ClassificationExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLClassificationAnalyzer analyzer;
  MLClassificationAnalyzerSetting setting;

  String _name = " ";
  dynamic _possibility = 0;

  @override
  void initState() {
    analyzer = new MLClassificationAnalyzer();
    setting = new MLClassificationAnalyzerSetting();
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
            title: Text("Image Classification"),
            titleSpacing: 0,
          ),
          body: Column(
            children: [
              SizedBox(height: 20),
              detectionResultBox("NAME", _name),
              detectionResultBox("POSSIBILITY", _possibility),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Start Analyze"),
                  onPressed: _showImagePickingOptions,
                ),
              )
            ],
          )),
    );
  }

  _startRecognition(String path) async {
    setting.path = path;
    setting.isRemote = true;
    setting.largestNumberOfReturns = 6;
    setting.minAcceptablePossibility = 0.5;
    try {
      List<MLImageClassification> list =
          await analyzer.asyncAnalyzeFrame(setting);
      if (list.length > 0) {
        setState(() {
          _name = list.first.name;
          _possibility = list.first.possibility;
        });
      }
    } on Exception catch (er) {
      print(er.toString());
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
