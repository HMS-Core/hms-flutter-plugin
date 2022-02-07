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

import '../utils/constants.dart';
import '../utils/utils.dart';

class ClassificationExample extends StatefulWidget {
  @override
  _ClassificationExampleState createState() => _ClassificationExampleState();
}

class _ClassificationExampleState extends State<ClassificationExample>
    with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLImageClassificationAnalyzer _analyzer;

  List names = [];
  List possibilities = [];

  @override
  void initState() {
    _analyzer = MLImageClassificationAnalyzer();
    _setApiKey();
    super.initState();
  }

  _setApiKey() {
    MLImageApplication().setApiKey(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Classification Demo"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultBox(classificationNames, names, context),
            Container(
              color: kGrayColor,
              margin: context.paddingLow,
              width: context.highValue,
              height: context.highValue,
              child: Image.asset(addImage),
            ),
            resultBox(possibility, possibilities, context),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => pickerDialog(_key, context, analyseFrame),
                  child: Text(startClassificationText),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () =>
                      pickerDialog(_key, context, asyncAnalyseFrame),
                  child: Text(startAsyncClassificationText),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: stop,
                  child: Text(stopText),
                )),
          ],
        ),
      ),
    );
  }

  @override
  analyseFrame(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final setting =
        MLClassificationAnalyzerSetting.create(path: path, isRemote: false);
    try {
      List<MLImageClassification> list = await _analyzer.analyseFrame(setting);
      list.forEach((element) {
        setState(() {
          names.add(element.name);
          possibilities.add(element.possibility);
        });
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void asyncAnalyseFrame(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final setting =
        MLClassificationAnalyzerSetting.create(path: path, isRemote: false);
    try {
      List<MLImageClassification> list =
          await _analyzer.asyncAnalyseFrame(setting);
      list.forEach((element) {
        setState(() {
          names.add(element.name);
          possibilities.add(element.possibility);
        });
      });
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
