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
import 'package:huawei_ml/models/ml_3d_face.dart';
import 'package:huawei_ml/utils/channels.dart';

import 'ml_3d_face_analyzer_setting.dart';

class ML3DFaceAnalyzer {
  final MethodChannel _channel = Channels.face3dMethodChannel;

  Future<List<ML3DFace>> asyncAnalyzeFrame(
      ML3DFaceAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("async3dFaceAnalyze", setting.toMap()));
    return (res as List).map((e) => ML3DFace.fromJson(e)).toList();
  }

  Future<List<ML3DFace>> analyzeFrame(ML3DFaceAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("sync3dFaceAnalyze", setting.toMap()));
    return (res as List).map((e) => ML3DFace.fromJson(e)).toList();
  }

  Future<bool> isAvailable() async {
    return await _channel.invokeMethod("isAvailable");
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod("stop");
  }
}
