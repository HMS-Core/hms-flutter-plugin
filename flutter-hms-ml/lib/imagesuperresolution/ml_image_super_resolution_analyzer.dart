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
import 'package:huawei_ml/utils/channels.dart';
import 'ml_image_super_resolution_analyzer_setting.dart';
import '../models/ml_image_resolution_result.dart';

class MLImageSuperResolutionAnalyzer {
  final MethodChannel _channel = Channels.imageResolutionMethodChannel;

  Future<MLImageSuperResolutionResult> asyncImageResolution(
      MLImageSuperResolutionAnalyzerSetting setting) async {
    return new MLImageSuperResolutionResult.fromJson(json.decode(
        await _channel.invokeMethod("asyncImageResolution", setting.toMap())));
  }

  Future<List<MLImageSuperResolutionResult>> syncImageResolution(
      MLImageSuperResolutionAnalyzerSetting setting) async {
    var res = json.decode(
        await _channel.invokeMethod("syncImageResolution", setting.toMap()));
    return (res as List)
        .map((e) => MLImageSuperResolutionResult.fromJson(e))
        .toList();
  }

  Future<bool> stopImageSuperResolution() async {
    return await _channel.invokeMethod("stopImageResolutionAnalyzer");
  }
}
