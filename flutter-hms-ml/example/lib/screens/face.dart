/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ml/face/ml_face_settings.dart';
import 'package:huawei_ml/face/ml_face_client.dart';
import 'package:huawei_ml/face/model/ml_face.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:image_picker/image_picker.dart';

class FaceRecognitionPage extends StatefulWidget {
  @override
  _FaceRecognitionPageState createState() => _FaceRecognitionPageState();
}

class _FaceRecognitionPageState extends State<FaceRecognitionPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MlFaceSettings settings;

  dynamic _angryPossibility = 0;
  dynamic _disgustPossibility = 0;
  dynamic _fearPossibility = 0;
  dynamic _neutralPossibility = 0;
  dynamic _sadPossibility = 0;
  dynamic _smilingPossibility = 0;
  dynamic _surprisePossibility = 0;

  @override
  void initState() {
    settings = new MlFaceSettings();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    if (await MlPermissionClient.checkCameraPermission()) {
      print("Permissions are granted");
    } else {
      await MlPermissionClient.requestCameraPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Face Recognition"),
            titleSpacing: 0,
          ),
          body: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        _emotionBox("ANGRY POSSIBILITY", _angryPossibility),
                        _emotionBox("DISGUST POSSIBILITY", _disgustPossibility),
                        _emotionBox("FEAR POSSIBILITY", _fearPossibility),
                        _emotionBox("NEUTRAL POSSIBILITY", _neutralPossibility),
                        _emotionBox("SAD POSSIBILITY", _sadPossibility),
                        _emotionBox("SMILING POSSIBILITY", _smilingPossibility),
                        _emotionBox(
                            "SURPRISE POSSIBILITY", _surprisePossibility)
                      ],
                    )),
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Start Analyze"),
                      onPressed: _showImagePickingOptions,
                    )),
              )
            ],
          )),
    );
  }

  _startRecognition() async {
    try {
      final MlFace mlFace =
          await MlFaceClient.getAsyncAnalyzeInformation(settings);
      setState(() {
        _angryPossibility = mlFace.emotions.angryProbability;
        _disgustPossibility = mlFace.emotions.disgustProbability;
        _fearPossibility = mlFace.emotions.fearProbability;
        _neutralPossibility = mlFace.emotions.neutralProbability;
        _sadPossibility = mlFace.emotions.sadProbability;
        _smilingPossibility = mlFace.emotions.smilingProbability;
        _surprisePossibility = mlFace.emotions.surpriseProbability;
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
                        settings.path = path;
                        _startRecognition();
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        settings.path = path;
                        _startRecognition();
                      })),
            ],
          ),
        ));
  }

  Widget _emotionBox(String name, dynamic value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: .5,
                color: Colors.black.withOpacity(.5),
                style: BorderStyle.solid)),
        child: Text(value.toString()),
      )
    ]);
  }
}
