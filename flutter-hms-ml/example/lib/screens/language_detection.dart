/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ml/langdetection/ml_lang_detection_client.dart';
import 'package:huawei_ml/langdetection/ml_lang_detection_settings.dart';
import 'package:huawei_ml/langdetection/model/ml_detected_language.dart';

class LanguageDetectionPage extends StatefulWidget {
  @override
  _LanguageDetectionPageState createState() => _LanguageDetectionPageState();
}

class _LanguageDetectionPageState extends State<LanguageDetectionPage> {
  TextEditingController controller = TextEditingController();

  MlLangDetectionSettings settings;

  dynamic _languageCode = "Language code";
  dynamic _probability = "Probability";
  dynamic _hashcode = "Hascode";

  String _firstDetectResult = "First detect result";

  @override
  void initState() {
    settings = new MlLangDetectionSettings();
    super.initState();
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
              _langDetectionBox("", _languageCode),
              _langDetectionBox("", _probability),
              _langDetectionBox("", _hashcode),
              _langDetectionButton(
                  "Probability Detect", _getProbabilityDetectResult),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("First Best Detect Result",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              _langDetectionBox("", _firstDetectResult),
              _langDetectionButton("First Best Detect", _getFirstDetectResult),
            ],
          ),
        ),
      ),
    );
  }

  _getProbabilityDetectResult() async {
    settings.sourceText = controller.text;
    try {
      final MlDetectedLanguage detectedLanguage =
          await MlLangDetectionClient.getProbabilityDetect(settings);
      setState(() {
        _probability = detectedLanguage.probability;
        _languageCode = detectedLanguage.langCode;
        _hashcode = detectedLanguage.hashcode;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _getFirstDetectResult() async {
    settings.sourceText = controller.text;
    try {
      final String firstBestDetection =
          await MlLangDetectionClient.getFirstBestDetect(settings);
      setState(() {
        _firstDetectResult = firstBestDetection;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Widget _langDetectionBox(String name, dynamic value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: .5,
                color: Colors.black.withOpacity(.5),
                style: BorderStyle.solid)),
        child: Text(value.toString()),
      )
    ]);
  }

  Widget _langDetectionButton(String label, Function function) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: RaisedButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(label),
          onPressed: function,
        ));
  }
}
