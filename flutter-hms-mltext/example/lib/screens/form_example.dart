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

class FormExample extends StatefulWidget {
  const FormExample({
    Key? key,
  }) : super(key: key);

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLFormRecognitionAnalyzer _analyzer;
  final List<String?> _texts = <String?>[];

  @override
  void initState() {
    super.initState();
    _analyzer = MLFormRecognitionAnalyzer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(formAppbarText),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            resultBox(resultBoxTextsDetected, _texts, context),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, analyze),
                child: const Text(startRecognitionText),
              ),
            ),
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
      final MLFormRecognitionTablesAttribute res =
          await _analyzer.asyncAnalyseFrame(path);
      final TablesContent? tablesContent = res.tablesContent;
      if (tablesContent != null) {
        for (TableAttribute? e1 in tablesContent.tableAttributes) {
          if (e1 != null) {
            for (TableCellAttribute? e2 in e1.tableCellAttributes) {
              setState(() => _texts.add(e2?.textInfo));
            }
          }
        }
      }
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
      final bool res = await _analyzer.isAvailable();
      debugPrint('$res');
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
