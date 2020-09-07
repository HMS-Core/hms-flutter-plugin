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

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:huawei_ml/text/model/ml_text.dart';
import 'package:huawei_ml/text/model/ml_text_analyzer.dart';
import 'package:huawei_ml/text/ml_text_settings.dart';

class MlTextClient {
  static const MethodChannel _channel = const MethodChannel("text");

  static _createMlTextFromResponse(String response) {
    Map<String, dynamic> textObject = json.decode(response);
    final MlText mlText = new MlText.fromJson(textObject);
    return mlText;
  }

  static Future<MlText> analyzeLocally(MlTextSettings settings) async {
    return _createMlTextFromResponse(
        await _channel.invokeMethod('analyzeLocally', settings.toMap()));
  }

  static Future<MlText> analyzeRemotely(MlTextSettings settings) async {
    return _createMlTextFromResponse(
        await _channel.invokeMethod('analyzeRemotely', settings.toMap()));
  }

  static Future<List<MlTextBlock>> analyzeWithSparseArray(
      MlTextSettings settings) async {
    List<MlTextBlock> textBlocks = [];
    final String response =
        await _channel.invokeMethod("analyzeWithSparseArray", settings.toMap());
    Map<String, dynamic> sparseTextInfo = json.decode(response);
    for (int i = 0; i < sparseTextInfo.length; i++) {
      textBlocks.add(new MlTextBlock.fromJson(sparseTextInfo['$i']));
    }
    return textBlocks;
  }

  static Future<String> stopAnalyzer() async {
    final String response = await _channel.invokeMethod("stopAnalyzer");
    return response;
  }

  static Future<MlTextAnalyzer> getAnalyzerInfo() async {
    final String response = await _channel.invokeMethod("getAnalyzerInfo");
    Map<String, dynamic> analyzerObject = json.decode(response);
    final MlTextAnalyzer analyzer = new MlTextAnalyzer.fromJson(analyzerObject);
    return analyzer;
  }
}
