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
import 'package:huawei_ml/classification/ml_image_classification_settings.dart';
import 'model/ml_image_classification.dart';

class MlImageClassificationClient {
  static const MethodChannel _channel =
      const MethodChannel("image_classification");

  static _createClassificationList(String response) {
    List<MlImageClassification> classifications = [];
    Map<String, dynamic> object = json.decode(response);
    for (int i = 0; i < object.length; i++) {
      classifications.add(new MlImageClassification.fromJson(object['$i']));
    }
    return classifications;
  }

  static Future<List<MlImageClassification>> getDefaultClassificationResult(
      String path) async {
    Map<String, dynamic> args = {"path": path};
    return _createClassificationList(
        await _channel.invokeMethod("defaultAnalyze", args));
  }

  static Future<List<MlImageClassification>> getLocalClassificationResult(
      MlImageClassificationSettings settings) async {
    return _createClassificationList(
        await _channel.invokeMethod("analyzeLocally", settings.toMap()));
  }

  static Future<List<MlImageClassification>> getRemoteClassificationResult(
      MlImageClassificationSettings settings) async {
    return _createClassificationList(
        await _channel.invokeMethod("analyzeRemotely", settings.toMap()));
  }

  static Future<List<MlImageClassification>>
      getAnalyzeFrameClassificationResult(
          MlImageClassificationSettings settings) async {
    return _createClassificationList(
        await _channel.invokeMethod("sparseAnalyze", settings.toMap()));
  }

  static Future<String> closeAnalyzer() async {
    return await _channel.invokeMethod("closeAnalyzer");
  }
}
