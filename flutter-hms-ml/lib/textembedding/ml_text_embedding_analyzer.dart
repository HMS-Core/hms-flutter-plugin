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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/textembedding/ml_text_embedding_analyzer_setting.dart';
import 'package:huawei_ml/utils/channels.dart';

import '../models/ml_vocabulary_version.dart';

class MLTextEmbeddingAnalyzer {
  static const int ERR_SERVICE_IS_UNAVAILABLE = 12199;
  static const int ERR_NET_UNAVAILABLE = 12198;
  static const int ERR_INNER = 12101;
  static const int ERR_AUTH_FAILED = 12102;
  static const int ERR_PARAM_ILLEGAL = 12103;
  static const int ERR_ANALYZE_FAILED = 12104;
  static const int ERR_AUTH_TOKEN_INVALID = 12105;

  final MethodChannel _channel = Channels.textEmbeddingMethodChannel;

  Future<bool> createTextEmbeddingAnalyzer(
      {@required MLTextEmbeddingAnalyzerSetting setting}) async {
    return await _channel.invokeMethod(
        "createTextEmbeddingAnalyzer", setting.toMap());
  }

  Future<List<dynamic>> analyzeSentenceVector(
      {@required String sentence}) async {
    return await _channel.invokeMethod(
        "analyseSentenceVector", <String, dynamic>{'sentence': sentence});
  }

  Future<double> analyseSentencesSimilarity(
      {@required String sentence1, @required String sentence2}) async {
    return await _channel.invokeMethod("analyseSentencesSimilarity",
        <String, dynamic>{'sentence1': sentence1, 'sentence2': sentence2});
  }

  Future<List<dynamic>> analyseWordVector({@required String word}) async {
    return await _channel
        .invokeMethod("analyseWordVector", <String, dynamic>{'word': word});
  }

  Future<double> analyseWordsSimilarity(
      {@required String word1, @required String word2}) async {
    return await _channel.invokeMethod("analyseWordsSimilarity",
        <String, dynamic>{'word1': word1, 'word2': word2});
  }

  Future<List<dynamic>> analyseSimilarWords(
      {@required String word, @required int number}) async {
    return await _channel.invokeMethod("analyseSimilarWords",
        <String, dynamic>{'word': word, 'number': number});
  }

  Future<MlVocabularyVersion> getVocabularyVersion() async {
    return new MlVocabularyVersion.fromJson(
        json.decode(await _channel.invokeMethod("getVocabularyVersion")));
  }

  Future<dynamic> analyseWordVectorBatch(List<String> words) async {
    return await _channel.invokeMethod(
        "analyseWordVectorBatch", <String, dynamic>{'words': words});
  }
}
