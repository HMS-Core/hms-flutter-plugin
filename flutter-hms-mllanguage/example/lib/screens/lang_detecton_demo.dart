/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_language/huawei_ml_language.dart';

import '../utils/demo_utils.dart';

class LangDetectionDemo extends StatefulWidget {
  const LangDetectionDemo({Key? key}) : super(key: key);

  @override
  _LangDetectionDemoState createState() => _LangDetectionDemoState();
}

class _LangDetectionDemoState extends State<LangDetectionDemo> {
  late MLLangDetector _detector;

  String? _res;
  List _list = [];

  @override
  void initState() {
    _detector = MLLangDetector();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lang Detection Demo")),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "We'll use ",
                      style: TextStyle(color: Colors.black.withOpacity(.5))),
                  TextSpan(
                      text: "il fait si froid aujourd'hui",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " for this demo",
                      style: TextStyle(color: Colors.black.withOpacity(.5))),
                ]),
              ),
            ),
            resultBox("First best detection", _res),
            recognitionButton(_firstBestDetect, text: "Get First Best"),
            resultBox("Lang probabilities", _list),
            recognitionButton(_probabilityDetect, text: "Get Probabilities"),
            recognitionButton(_stop,
                text: "Stop Detector", color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  _firstBestDetect() async {
    final setting = MLLangDetectorSetting.create(
        sourceText: "il fait si froid aujourd'hui", isRemote: false);
    try {
      final String? res = await _detector.firstBestDetect(setting: setting);
      if (res != null) {
        setState(() => _res = res);
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _probabilityDetect() async {
    final setting = MLLangDetectorSetting.create(
        sourceText: "il fait si froid aujourd'hui", isRemote: false);
    try {
      List<MLDetectedLang> res =
          await _detector.probabilityDetect(setting: setting);
      res.forEach((element) {
        setState(() => _list.add(element.langCode));
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _stop() async {
    try {
      await _detector.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
