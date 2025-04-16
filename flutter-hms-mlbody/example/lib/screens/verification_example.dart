/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_body/huawei_ml_body.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';
import 'package:image_picker/image_picker.dart';

class VerificationExample extends StatefulWidget {
  const VerificationExample({Key? key}) : super(key: key);

  @override
  State<VerificationExample> createState() => _VerificationExampleState();
}

class _VerificationExampleState extends State<VerificationExample> {
  late MLFaceVerificationAnalyzer _analyzer;
  int? templateId;
  dynamic similarity;

  @override
  void initState() {
    super.initState();
    _analyzer = MLFaceVerificationAnalyzer();
  }

  void _setTemplateFace() async {
    final String? pickedImagePath = await getImage(ImageSource.camera);
    if (pickedImagePath != null) {
      try {
        final List<MLFaceTemplateResult> list = await _analyzer.setTemplateFace(
          pickedImagePath,
          1,
        );
        setState(() => templateId = list.first.templateId);
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  void _verifyFace() async {
    final String? pickedImagePath = await getImage(ImageSource.camera);
    if (pickedImagePath != null) {
      try {
        final List<MLFaceVerificationResult> list =
            await _analyzer.asyncAnalyseFrame(
          pickedImagePath,
        );
        setState(() => similarity = list.first.similarity);
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Face Verification Demo'),
      body: Column(
        children: <Widget>[
          resultBox('Template Id', templateId),
          resultBox('Similarity', similarity),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: _setTemplateFace,
              child: const Text('Set Template Face'),
            ),
          ),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: _verifyFace,
              child: const Text('Verify Face'),
            ),
          ),
        ],
      ),
    );
  }
}
