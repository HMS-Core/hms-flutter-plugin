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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:huawei_ml/handkeypoint/ml_hand_keypoint_analyzer_setting.dart';
import 'package:huawei_ml/models/ml_hand_keypoint.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLHandKeypointAnalyzer {
  final MethodChannel _channel = Channels.handAnalyzerMethodChannel;

  Future<List<MLHandKeyPoints>> asyncHandDetection(
      MLHandKeypointAnalyzerSetting setting) async {
    var res = json.decode(await _channel.invokeMethod(
        "asyncHandKeyPointAnalyze", setting.toMap()));
    return (res as List).map((e) => MLHandKeyPoints.fromJson(e)).toList();
  }

  Future<List<MLHandKeyPoints>> syncHandDetection(
      MLHandKeypointAnalyzerSetting setting) async {
    var res = json.decode(await _channel.invokeMethod(
        "syncHandKeyPointAnalyze", setting.toMap()));
    return (res as List).map((e) => MLHandKeyPoints.fromJson(e)).toList();
  }

  Future<bool> stopHandDetection() async {
    return await _channel.invokeMethod("stopHandKeyPointAnalyzer");
  }
}
