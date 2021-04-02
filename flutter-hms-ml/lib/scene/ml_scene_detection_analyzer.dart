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
import 'package:huawei_ml/scene/ml_scene_detection_analyzer_setting.dart';
import 'package:huawei_ml/models/ml_scene_detection.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLSceneDetectionAnalyzer {
  final MethodChannel _channel = Channels.sceneDetectionMethodChannel;

  Future<List<MLSceneDetection>> asyncSceneDetection(
      MLSceneDetectionAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("asyncSceneDetection", setting.toMap()));
    return (res as List).map((e) => MLSceneDetection.fromJson(e)).toList();
  }

  Future<List<MLSceneDetection>> syncSceneDetection(
      MLSceneDetectionAnalyzerSetting setting) async {
    var res = json.decode(await _channel.invokeMethod(
        "analyzeFrameSceneDetection", setting.toMap()));
    return (res as List).map((e) => MLSceneDetection.fromJson(e)).toList();
  }

  Future<bool> stopSceneDetection() async {
    return await _channel.invokeMethod("stopSceneDetection");
  }
}
