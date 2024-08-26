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

class TextEmbeddingExample extends StatefulWidget {
  const TextEmbeddingExample({Key? key}) : super(key: key);

  @override
  State<TextEmbeddingExample> createState() => _TextEmbeddingExampleState();
}

class _TextEmbeddingExampleState extends State<TextEmbeddingExample> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLTextEmbeddingAnalyzer _analyzer;
  late MLTextEmbeddingAnalyzerSetting _setting;
  double? _wordsSimilarity;
  final List<String> _similarWords = <String>[];

  @override
  void initState() {
    super.initState();
    // Initialize the analyzer.
    _analyzer = MLTextEmbeddingAnalyzer();
    // Create configuration instance and set the language.
    _setting = MLTextEmbeddingAnalyzerSetting(
      language: MLTextEmbeddingAnalyzerSetting.languageEn,
    );
    // Create the actual analyzer before you call other methods.
    _createAnalyzer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(embeddingAppbarText),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: context.paddingLow,
            child: const Text(embeddingTextSimilarity),
          ),
          resultBox(
            embeddingWordsSimilarity,
            _wordsSimilarity,
            context,
          ),
          containerElevatedButton(
            context,
            ElevatedButton(
              style: buttonStyle,
              onPressed: _getWordsSimilarity,
              child: const Text(embeddingGetWordsSimilarity),
            ),
          ),
          Padding(
            padding: context.paddingLow,
            child: const Text(embeddingTextSimilar),
          ),
          resultBox(
            embeddingWordsSimilarity,
            _similarWords,
            context,
          ),
          containerElevatedButton(
            context,
            ElevatedButton(
              style: buttonStyle,
              onPressed: _getSimilarWords,
              child: const Text(embeddingGetSimilarWords),
            ),
          ),
        ],
      ),
    );
  }

  void _createAnalyzer() {
    _analyzer.createTextEmbeddingAnalyzer(
      setting: _setting,
    );
  }

  void _getWordsSimilarity() async {
    final double similarity = await _analyzer.analyseWordsSimilarity(
      word1: spaceText,
      word2: planetsText,
    );
    setState(() => _wordsSimilarity = similarity);
  }

  void _getSimilarWords() async {
    final List<String> list = await _analyzer.analyseSimilarWords(
      word: spaceText,
      number: 10,
    );
    for (String v in list) {
      setState(() => _similarWords.add(v));
    }
  }
}
