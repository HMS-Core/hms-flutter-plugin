/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/services.dart';
import 'package:huawei_ml_body/src/common/constants.dart';
import 'package:huawei_ml_body/src/request/ml_hand_keypoint_analyzer_setting.dart';
import 'package:huawei_ml_body/src/result/ml_hand_keypoints.dart';

import '../common/ml_body_analyzer.dart';

class MLHandKeypointAnalyzer
    implements MLBodyAnalyzer<MLHandKeyPoints, MLHandKeyPointAnalyzerSetting> {
  late MethodChannel _channel;

  MLHandKeypointAnalyzer() {
    _channel = const MethodChannel('$baseChannel.hand');
  }

  @override
  Future<List<MLHandKeyPoints>> asyncAnalyseFrame(
      MLHandKeyPointAnalyzerSetting setting) async {
    List res =
        await _channel.invokeMethod("hand#asyncAnalyseFrame", setting.toMap());
    return res.map((e) => MLHandKeyPoints.fromMap(e)).toList();
  }

  @override
  Future<List<MLHandKeyPoints>> analyseFrame(
      MLHandKeyPointAnalyzerSetting setting) async {
    List res =
        await _channel.invokeMethod("hand#analyseFrame", setting.toMap());
    return res.map((e) => MLHandKeyPoints.fromMap(e)).toList();
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod('hand#destroy');
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod('hand#isAvailable');
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod('hand#stop');
  }
}
