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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/models/ml_detected_lang.dart';
import 'package:huawei_ml/utils/channels.dart';
import 'ml_lang_detector_setting.dart';

class MLLangDetector {
  static const double FIRST_BEST_DETECTION_LANGUAGE_TRUSTED_THRESHOLD = 0.5;
  static const double PROBABILITY_DETECTION_LANGUAGE_TRUSTED_THRESHOLD =
      0.009999999776482582;
  static const String UNDETECTED_LANGUAGE_TRUSTED_THRESHOLD = "unknown";

  final MethodChannel _channel = Channels.langDetectionMethodChannel;

  Future<String> firstBestDetect({@required MLLangDetectorSetting setting}) async {
    return await _channel.invokeMethod("firstBestDetect", setting.toMap());
  }

  Future<String> syncFirstBestDetect({@required MLLangDetectorSetting setting}) async {
    return await _channel.invokeMethod("syncFirstBestDetect", setting.toMap());
  }

  Future<List<MLDetectedLang>> probabilityDetect({@required MLLangDetectorSetting setting}) async {
    var res = json.decode(await _channel.invokeMethod("probabilityDetect", setting.toMap()));
    return (res as List).map((e) => MLDetectedLang.fromJson(e)).toList();
  }

  Future<List<MLDetectedLang>> syncProbabilityDetect({@required MLLangDetectorSetting setting}) async {
    var res = json.decode(await _channel.invokeMethod("syncProbabilityDetect", setting.toMap()));
    return (res as List).map((e) => MLDetectedLang.fromJson(e)).toList();
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod("stopLangDetector");
  }
}
