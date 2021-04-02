/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';

class LangDetectionExample extends StatefulWidget {
  @override
  _LangDetectionExampleState createState() => _LangDetectionExampleState();
}

class _LangDetectionExampleState extends State<LangDetectionExample> {
  TextEditingController controller = TextEditingController();

  MLLangDetector detector;
  MLLangDetectorSetting setting;

  dynamic _languageCode = "Language code";
  dynamic _probability = "Probability";

  String _firstDetectResult = "First detect result";

  @override
  void initState() {
    detector = new MLLangDetector();
    setting = new MLLangDetectorSetting();
    _setApiKey();
    super.initState();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Language Detection"),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: .5,
                        color: Colors.black.withOpacity(.5),
                        style: BorderStyle.solid),
                    color: Colors.white),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: "Source text goes here",
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Probability Detect Results",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              detectionResultBox("", _languageCode),
              detectionResultBox("", _probability),
              detectionButton(
                  onPressed: _getProbabilityDetectResult,
                  label: "Probability Detect"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("First Best Detect Result",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              detectionResultBox("", _firstDetectResult),
              detectionButton(
                  onPressed: _getFirstDetectResult, label: "First Best Detect"),
            ],
          ),
        ),
      ),
    );
  }

  _getProbabilityDetectResult() async {
    setting.sourceText = controller.text;
    setting.isRemote = false;
    try {
      final List<MLDetectedLang> detectedLanguage =
          await detector.probabilityDetect(setting: setting);
      print(detectedLanguage.length);
      setState(() {
        _probability = detectedLanguage.first.probability;
        _languageCode = detectedLanguage.first.langCode;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _getFirstDetectResult() async {
    setting.sourceText = controller.text;
    try {
      final String firstBestDetection =
          await detector.firstBestDetect(setting: setting);
      setState(() {
        _firstDetectResult = firstBestDetection;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
