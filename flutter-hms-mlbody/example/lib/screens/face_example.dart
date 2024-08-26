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

class FaceExample extends StatefulWidget {
  const FaceExample({Key? key}) : super(key: key);

  @override
  State<FaceExample> createState() => _FaceExampleState();
}

class _FaceExampleState extends State<FaceExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLFaceAnalyzer _analyzer;
  double? _neutralProbability;
  double? _angryProbability;
  double? _sadProbability;
  double? _smilingProbability;

  @override
  void initState() {
    super.initState();
    _analyzer = MLFaceAnalyzer();
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final MLFaceAnalyzerSetting setting = MLFaceAnalyzerSetting(
      path: path,
    );
    try {
      final List<MLFace> faces = await _analyzer.asyncAnalyseFrame(setting);
      if (faces.isNotEmpty) {
        setState(() {
          _angryProbability = faces.first.emotions?.angryProbability;
          _sadProbability = faces.first.emotions?.sadProbability;
          _neutralProbability = faces.first.emotions?.neutralProbability;
          _smilingProbability = faces.first.emotions?.smilingProbability;
        });
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void destroy() async {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      final bool res = await _analyzer.isAvailable();
      debugPrint(res.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void stop() async {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Face Detection Demo'),
      body: Column(
        children: <Widget>[
          resultBox('Smiling possibility', _smilingProbability),
          resultBox('Neutral possibility', _neutralProbability),
          resultBox('Angry possibility', _angryProbability),
          resultBox('Sad possibility', _sadProbability),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: () => pickerDialog(_key, context, analyze),
              child: const Text('Start Recognition'),
            ),
          ),
        ],
      ),
    );
  }
}
