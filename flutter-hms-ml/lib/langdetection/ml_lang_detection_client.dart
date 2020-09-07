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
import 'package:huawei_ml/langdetection/ml_lang_detection_settings.dart';
import 'package:huawei_ml/langdetection/model/ml_detected_language.dart';

class MlLangDetectionClient {
  static const MethodChannel _channel = const MethodChannel("lang_detection");

  static Future<String> getFirstBestDetect(
      MlLangDetectionSettings settings) async {
    final String response =
        await _channel.invokeMethod("getFirstBestDetect", settings.toMap());
    return response;
  }

  static Future<MlDetectedLanguage> getProbabilityDetect(
      MlLangDetectionSettings settings) async {
    final String response =
        await _channel.invokeMethod("getProbabilityDetect", settings.toMap());
    Map<String, dynamic> langObject = json.decode(response);
    final MlDetectedLanguage language =
        new MlDetectedLanguage.fromJson(langObject);
    return language;
  }

  static Future<String> stopDetection() async {
    final String response = await _channel.invokeMethod("stopDetection");
    return response;
  }
}
