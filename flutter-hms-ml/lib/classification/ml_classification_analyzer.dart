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

import 'package:flutter/services.dart';
import 'package:huawei_ml/classification/ml_classification_analyzer_setting.dart';
import 'package:huawei_ml/models/ml_image_classification.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLClassificationAnalyzer {
  static const int TYPE_LOCAL = 0;
  static const int TYPE_REMOTE = 1;

  final MethodChannel _channel = Channels.classificationMethodChannel;

  Future<List<MLImageClassification>> asyncAnalyzeFrame(
      MLClassificationAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("asyncClassification", setting.toMap()));
    return (res as List).map((e) => MLImageClassification.fromJson(e)).toList();
  }

  Future<List<MLImageClassification>> analyzeFrame(
      MLClassificationAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("syncClassification", setting.toMap()));
    return (res as List).map((e) => MLImageClassification.fromJson(e)).toList();
  }

  Future<int> getAnalyzerType() async {
    return await _channel.invokeMethod("getAnalyzerType");
  }

  Future<bool> stopClassification() async {
    return await _channel.invokeMethod("stop");
  }
}
