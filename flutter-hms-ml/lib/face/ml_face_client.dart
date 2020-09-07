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
import 'package:huawei_ml/face/ml_face_settings.dart';
import 'package:huawei_ml/face/model/ml_face.dart';
import 'package:huawei_ml/face/model/ml_face_analyzer.dart';

class MlFaceClient {
  static const MethodChannel _channel = const MethodChannel("face_analyzer");

  static _createMlFaceFromResponse(String response) {
    Map<String, dynamic> faceObject = json.decode(response);
    final MlFace face = new MlFace.fromJson(faceObject);
    return face;
  }

  static Future<MlFace> getDefaultFaceAnalyzeInformation(String path) async {
    Map<String, dynamic> args = {"path": path};
    return _createMlFaceFromResponse(
        await _channel.invokeMethod("defaultFaceAnalyze", args));
  }

  static Future<MlFace> getAsyncAnalyzeInformation(
      MlFaceSettings settings) async {
    return _createMlFaceFromResponse(
        await _channel.invokeMethod("asyncAnalyzeFrame", settings.toMap()));
  }

  static Future<List<MlFace>> getAnalyzeFrameInformation(String path) async {
    List<MlFace> faces = [];
    Map<String, dynamic> args = {"path": path};
    final String response = await _channel.invokeMethod("analyzeFrame", args);
    Map<String, dynamic> sparseFaceObject = json.decode(response);
    for (int i = 0; i < sparseFaceObject.length; i++) {
      faces.add(new MlFace.fromJson(sparseFaceObject['$i']));
    }
    return faces;
  }

  static Future<String> closeAnalyzer() async {
    final String response = await _channel.invokeMethod("closeAnalyzer");
    return response;
  }

  static Future<MlFaceAnalyzer> getAnalyzerInfo() async {
    final String response = await _channel.invokeMethod("getAnalyzerInfo");
    Map<String, dynamic> analyzerObject = json.decode(response);
    final MlFaceAnalyzer analyzer = new MlFaceAnalyzer.fromJson(analyzerObject);
    return analyzer;
  }
}
