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

import 'package:flutter/services.dart';
import 'package:huawei_ml/landmark/ml_land_mark_settings.dart';
import 'package:huawei_ml/landmark/model/ml_land_mark.dart';
import 'dart:convert';

class MlLandMarkClient {
  static const MethodChannel _channel = const MethodChannel("land_mark");

  static _createLandmarkFromResponse(String response) {
    Map<String, dynamic> landmarkObject = json.decode(response);
    final MlLandmark landmark = new MlLandmark.fromJson(landmarkObject);
    return landmark;
  }

  static Future<MlLandmark> getDefaultLandmarkAnalyzeInformation(
      String path) async {
    Map<String, dynamic> args = {"path": path};
    return _createLandmarkFromResponse(
        await _channel.invokeMethod("defaultLandmarkAnalyze", args));
  }

  static Future<MlLandmark> getLandmarkAnalyzeInformation(
      MlLandMarkSettings settings) async {
    return _createLandmarkFromResponse(
        await _channel.invokeMethod("analyzeLandmark", settings.toMap()));
  }

  static Future<String> stopAnalyzer() async {
    final String response = await _channel.invokeMethod("stopAnalyzer");
    return response;
  }
}
