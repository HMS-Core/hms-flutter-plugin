/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class DocumentCorrectionExample extends StatefulWidget {
  @override
  _DocumentCorrectionExampleState createState() =>
      _DocumentCorrectionExampleState();
}

class _DocumentCorrectionExampleState extends State<DocumentCorrectionExample> {
  late MLDocumentSkewCorrectionAnalyzer _analyzer;

  int? _detectionResultCode;
  Image? _image;

  @override
  void initState() {
    _analyzer = MLDocumentSkewCorrectionAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar("Doc. Skew Correction Demo"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              resultBox(detectionResultCode, _detectionResultCode, context),
              Container(
                color: kGrayColor,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: context.width,
                height: context.width,
                child: _image != null ? _image : Image.asset(tisImage),
              ),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _startDetection,
                    child: Text(startDocumentDetection),
                  )),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _startCorrection,
                    child: Text(startDocumentCorrection),
                  )),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _startAsyncDetection,
                    child: Text(startAsyncDocumentDetection),
                  )),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _startAsyncCorrection,
                    child: Text(startAsyncDocumentCorrection),
                  )),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: dangerbuttonStyle,
                    onPressed: _stopRecognition,
                    child: Text(stopText),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _startDetection() async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      try {
        MLDocumentSkewDetectResult result =
            await _analyzer.analyseFrame(pickedImagePath);
        setState(() => _detectionResultCode = result.resultCode);
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  _startCorrection() async {
    try {
      MLDocumentSkewCorrectionResult result =
          await _analyzer.syncDocumentSkewCorrect();
      if (result.bytes != null)
        setState(() => _image = Image.memory(result.bytes!));
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _startAsyncDetection() async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      try {
        MLDocumentSkewDetectResult result =
            await _analyzer.asyncDocumentSkewDetect(pickedImagePath);
        setState(() => _detectionResultCode = result.resultCode);
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  _startAsyncCorrection() async {
    try {
      MLDocumentSkewCorrectionResult result =
          await _analyzer.asyncDocumentSkewCorrect();
      if (result.bytes != null)
        setState(() => _image = Image.memory(result.bytes!));
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _stopRecognition() async {
    try {
      await _analyzer.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
