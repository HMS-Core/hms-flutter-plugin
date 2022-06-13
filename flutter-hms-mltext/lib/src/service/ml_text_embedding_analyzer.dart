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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_ml_text/src/common/constants.dart';
import 'package:huawei_ml_text/src/request/ml_text_embedding_analyzer_setting.dart';
import 'package:huawei_ml_text/src/result/ml_vocabulary_version.dart';

class MLTextEmbeddingAnalyzer {
  static const int errServiceIsUnavailable = 12199;

  static const int errNetUnavailable = 12198;

  static const int errInner = 12101;

  static const int errAuthFailed = 12102;

  static const int errParamIllegal = 12103;

  static const int errAnalyzeFailed = 12104;

  static const int errAuthTokenInvalid = 12105;

  late MethodChannel _channel;

  MLTextEmbeddingAnalyzer() {
    _channel = const MethodChannel("$baseChannel.text_embedding");
  }

  Future<bool> createTextEmbeddingAnalyzer(
      {required MLTextEmbeddingAnalyzerSetting setting}) async {
    return await _channel.invokeMethod(
        "createTextEmbeddingAnalyzer", setting.toMap());
  }

  Future<List<dynamic>> analyzeSentenceVector(
      {required String sentence}) async {
    return await _channel
        .invokeMethod("analyseSentenceVector", {'sentence': sentence});
  }

  Future<double> analyseSentencesSimilarity(
      {required String sentence1, required String sentence2}) async {
    return await _channel.invokeMethod("analyseSentencesSimilarity",
        {'sentence1': sentence1, 'sentence2': sentence2});
  }

  Future<List<dynamic>> analyseWordVector({required String word}) async {
    return await _channel.invokeMethod("analyseWordVector", {'word': word});
  }

  Future<double> analyseWordsSimilarity(
      {required String word1, required String word2}) async {
    return await _channel.invokeMethod(
        "analyseWordsSimilarity", {'word1': word1, 'word2': word2});
  }

  Future<List<dynamic>> analyseSimilarWords(
      {required String word, required int number}) async {
    return await _channel
        .invokeMethod("analyseSimilarWords", {'word': word, 'number': number});
  }

  Future<MlVocabularyVersion> getVocabularyVersion() async {
    return MlVocabularyVersion.fromJson(
        json.decode(await _channel.invokeMethod("getVocabularyVersion")));
  }

  Future<dynamic> analyseWordVectorBatch(List<String> words) async {
    return await _channel
        .invokeMethod("analyseWordVectorBatch", {'words': words});
  }
}
