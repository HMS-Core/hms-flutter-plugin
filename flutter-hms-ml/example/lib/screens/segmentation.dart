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

import 'package:flutter/material.dart';
import 'package:huawei_ml/helpers/img_seg_helpers.dart';
import 'package:huawei_ml/imgseg/ml_image_segmentation_client.dart';
import 'package:huawei_ml/imgseg/ml_image_segmentation_settings.dart';
import 'package:huawei_ml/imgseg/model/ml_image_segmentation_result.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:image_picker/image_picker.dart';

class SegmentationPage extends StatefulWidget {
  @override
  _SegmentationPageState createState() => _SegmentationPageState();
}

class _SegmentationPageState extends State<SegmentationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MlImageSegmentationSettings settings;

  String _foregroundUri = "Forground Uri";
  String _grayscaleUri = "Grayscale Uri";
  String _originalUri = "Original Uri";

  @override
  void initState() {
    settings = new MlImageSegmentationSettings();
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
          title: Text("Image Segmentation"),
          titleSpacing: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 10, right: 10, bottom: 50),
              child: Text("Check Your Gallery After Segmentation Complete",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
            _segmentationBox("FOREGROUND URI", _foregroundUri),
            _segmentationBox("GRAYSCALE URI", _grayscaleUri),
            _segmentationBox("ORIGINAL URI", _originalUri),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                color: Colors.lightBlue,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Start analyze"),
                onPressed: _showImagePickingOptions,
              ),
            )
          ],
        ),
      ),
    );
  }

  _startRecognition() async {
    try {
      settings.analyzerType = ImgSegmentationAnalyzerType.IMAGE_SEG;
      settings.scene = ImgSegmentationScene.ALL;
      settings.exactMode = true;
      final MlImageSegmentationResult result =
          await MlImageSegmentationClient.getSegmentation(settings);
      setState(() {
        _foregroundUri = result.foregroundUri;
        _grayscaleUri = result.grayscaleUri;
        _originalUri = result.originalUri;
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

  Widget _segmentationBox(String name, dynamic value) {
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
