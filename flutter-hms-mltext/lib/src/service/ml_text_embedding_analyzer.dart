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

part of '../../huawei_ml_text.dart';

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
    _channel = const MethodChannel('$baseChannel.text_embedding');
  }

  Future<bool> createTextEmbeddingAnalyzer({
    required MLTextEmbeddingAnalyzerSetting setting,
  }) async {
    return await _channel.invokeMethod(
      'createTextEmbeddingAnalyzer',
      setting.toMap(),
    );
  }

  Future<List<double>> analyzeSentenceVector({
    required String sentence,
  }) async {
    final List<dynamic> result = await _channel.invokeMethod(
      'analyseSentenceVector',
      <String, dynamic>{
        'sentence': sentence,
      },
    );
    return List<double>.from(result);
  }

  Future<double> analyseSentencesSimilarity({
    required String sentence1,
    required String sentence2,
  }) async {
    return await _channel.invokeMethod(
      'analyseSentencesSimilarity',
      <String, dynamic>{
        'sentence1': sentence1,
        'sentence2': sentence2,
      },
    );
  }

  Future<List<double>> analyseWordVector({
    required String word,
  }) async {
    final List<dynamic> result = await _channel.invokeMethod(
      'analyseWordVector',
      <String, dynamic>{
        'word': word,
      },
    );
    return List<double>.from(result);
  }

  Future<double> analyseWordsSimilarity({
    required String word1,
    required String word2,
  }) async {
    return await _channel.invokeMethod(
      'analyseWordsSimilarity',
      <String, dynamic>{
        'word1': word1,
        'word2': word2,
      },
    );
  }

  Future<List<String>> analyseSimilarWords({
    required String word,
    required int number,
  }) async {
    final List<dynamic> result = await _channel.invokeMethod(
      'analyseSimilarWords',
      <String, dynamic>{
        'word': word,
        'number': number,
      },
    );
    return List<String>.from(result);
  }

  Future<MlVocabularyVersion> getVocabularyVersion() async {
    return MlVocabularyVersion.fromJson(
      json.decode(
        await _channel.invokeMethod(
          'getVocabularyVersion',
        ),
      ),
    );
  }

  Future<Map<String, List<double>>> analyseWordVectorBatch(
    List<String> words,
  ) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'analyseWordVectorBatch',
      <String, dynamic>{
        'words': words,
      },
    );
    return result.map((dynamic key, dynamic value) {
      return MapEntry(key as String, List<double>.from(value));
    });
  }
}
