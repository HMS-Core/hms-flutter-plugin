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
import 'package:huawei_ml/models/ml_text_image_super_resolution.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLTextImageSuperResolutionAnalyzer {
  ///   The service may be abnormal.
  static const int INNER = 2;

  /// The possible causes are as follows:
  ///
  ///   - The parameter settings are incorrect.
  ///   - The input bitmap size exceeds the upper limit.
  static const int INACTIVE = 5;

  final MethodChannel _channel = Channels.textResolutionMethodChannel;

  Future<MLTextImageSuperResolution> asyncAnalyzeFrame(String imagePath) async {
    return new MLTextImageSuperResolution.fromJson(json.decode(await _channel
        .invokeMethod(
            "asyncTextResolution", <String, dynamic>{'path': imagePath})));
  }

  Future<List<MLTextImageSuperResolution>> analyzeFrame(
      String imagePath) async {
    var res = json.decode(await _channel.invokeMethod(
        "syncTextResolution", <String, dynamic>{'path': imagePath}));
    return (res as List)
        .map((e) => MLTextImageSuperResolution.fromJson(e))
        .toList();
  }

  Future<bool> stopTextResolution() async {
    return await _channel.invokeMethod("stopTextResolution");
  }
}
