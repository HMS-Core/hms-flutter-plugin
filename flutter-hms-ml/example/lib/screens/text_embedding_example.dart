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

class TextEmbeddingExample extends StatefulWidget {
  @override
  _TextEmbeddingExampleState createState() => _TextEmbeddingExampleState();
}

class _TextEmbeddingExampleState extends State<TextEmbeddingExample> {
  MLTextEmbeddingAnalyzer analyzer;
  MLTextEmbeddingAnalyzerSetting setting;

  List<String> _list = [" "];

  @override
  void initState() {
    analyzer = new MLTextEmbeddingAnalyzer();
    setting = new MLTextEmbeddingAnalyzerSetting();
    _setApiKey();
    super.initState();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Text Embedding Example")),
        body: Column(
          children: [
            SizedBox(height: 15),
            Text(
                "Create the analyzer then get the similar words with 'spectacular' ",
                textAlign: TextAlign.center),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_list[index]),
                  );
                },
              ),
            ),
            detectionButton(
                onPressed: _createAnalyzer, label: "CREATE ANALYZER"),
            detectionButton(
                onPressed: _getSimilarWords, label: "GET SIMILAR WORDS"),
            SizedBox(height: 20)
          ],
        ));
  }

  _createAnalyzer() async {
    try {
      bool isAnalyzerCreated =
          await analyzer.createTextEmbeddingAnalyzer(setting: setting);
      setState(
          () => _list.add("Analyzer created: " + isAnalyzerCreated.toString()));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _getSimilarWords() async {
    try {
      final List<dynamic> res =
          await analyzer.analyseSimilarWords(word: "spectacular", number: 5);
      for (String s in res) {
        setState(() => _list.add(s));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
