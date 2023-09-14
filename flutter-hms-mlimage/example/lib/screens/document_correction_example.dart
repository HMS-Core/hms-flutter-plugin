/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class DocumentCorrectionExample extends StatefulWidget {
  const DocumentCorrectionExample({Key? key}) : super(key: key);

  @override
  State<DocumentCorrectionExample> createState() =>
      _DocumentCorrectionExampleState();
}

class _DocumentCorrectionExampleState extends State<DocumentCorrectionExample> {
  final MLDocumentSkewCorrectionAnalyzer _analyzer =
      MLDocumentSkewCorrectionAnalyzer();
  int? _detectionResultCode;
  Image? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Doc. Skew Correction Demo'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              resultBox(
                detectionResultCode,
                _detectionResultCode,
                context,
              ),
              Container(
                color: kGrayColor,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: context.width,
                height: context.width,
                child: _image ?? Image.asset(tisImage),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _startDetection,
                  child: const Text(startDocumentDetection),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _startCorrection,
                  child: const Text(startDocumentCorrection),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _startAsyncDetection,
                  child: const Text(startAsyncDocumentDetection),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _startAsyncCorrection,
                  child: const Text(startAsyncDocumentCorrection),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: _stopRecognition,
                  child: const Text(stopText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startDetection() async {
    try {
      final String? pickedImagePath = await getImage(ImageSource.gallery);

      if (pickedImagePath != null) {
        final MLDocumentSkewDetectResult result =
            await _analyzer.analyseFrame(pickedImagePath);
        setState(() {
          _detectionResultCode = result.resultCode;
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  Future<void> _startCorrection() async {
    try {
      final MLDocumentSkewCorrectionResult result =
          await _analyzer.syncDocumentSkewCorrect();
      if (result.bytes != null) {
        setState(() {
          _image = Image.memory(result.bytes!);
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  Future<void> _startAsyncDetection() async {
    try {
      final String? pickedImagePath = await getImage(ImageSource.gallery);

      if (pickedImagePath != null) {
        final MLDocumentSkewDetectResult result =
            await _analyzer.asyncDocumentSkewDetect(pickedImagePath);
        setState(() {
          _detectionResultCode = result.resultCode;
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  Future<void> _startAsyncCorrection() async {
    try {
      final MLDocumentSkewCorrectionResult result =
          await _analyzer.asyncDocumentSkewCorrect();
      if (result.bytes != null) {
        setState(() {
          _image = Image.memory(result.bytes!);
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  Future<void> _stopRecognition() async {
    try {
      await _analyzer.stop();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}
