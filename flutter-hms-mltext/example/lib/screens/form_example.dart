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
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';

import '../utils/utils.dart';

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLFormRecognitionAnalyzer _analyzer;

  List _texts = [];

  @override
  void initState() {
    _analyzer = MLFormRecognitionAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(formAppbarText),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultBox(resultBoxTextsDetected, _texts, context),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, analyze),
                child: Text(startRecognitionText),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    try {
      MLFormRecognitionTablesAttribute res =
          await _analyzer.asyncAnalyseFrame(path);
      res.tablesContent?.tableAttributes.forEach((e1) {
        e1?.tableCellAttributes.forEach((e2) {
          setState(() => _texts.add(e2?.textInfo));
        });
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void destroy() {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      print(await _analyzer.isAvailable());
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void stop() {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
