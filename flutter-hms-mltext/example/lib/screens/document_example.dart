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
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:huawei_ml_text_example/utils/utils.dart';

class DocumentExample extends StatefulWidget {
  const DocumentExample({
    Key? key,
  }) : super(key: key);

  @override
  State<DocumentExample> createState() => _DocumentExampleState();
}

class _DocumentExampleState extends State<DocumentExample> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLDocumentAnalyzer _analyzer;
  String? _res;

  @override
  void initState() {
    super.initState();
    _analyzer = MLDocumentAnalyzer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(documentAppbarText),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            resultBoxWidget(context, resultBoxText, _res),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  pickerDialog(_key, context, _startRecognition);
                },
                child: const Text(startRecognitionText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRecognition(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final MLDocumentAnalyzerSetting setting = MLDocumentAnalyzerSetting.create(
      path: path,
    );
    try {
      final MLDocument document = await _analyzer.asyncAnalyzeFrame(setting);
      setState(() => _res = document.stringValue);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
