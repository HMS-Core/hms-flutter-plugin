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
import 'package:huawei_ml/models/ml_document_skew_detect_result.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLDocumentSkewCorrectionAnalyzer {
  /// Text box correction failed.
  static const int CORRECTION_FAILED = 2;

  /// Text box detection failed.
  static const int DETECT_FAILED = 1;

  /// Incorrect input parameter for text box detection/correction.
  static const IMAGE_DATA_ERROR = 3;

  /// Text box detection/correction succeeded.
  static const SUCCESS = 0;

  final MethodChannel _channel = Channels.documentCorrectionMethodChannel;

  Future<MLDocumentSkewDetectResult> asyncDocumentSkewDetect(
      String imagePath) async {
    return new MLDocumentSkewDetectResult.fromJson(json.decode(await _channel
        .invokeMethod(
            "asyncDocumentSkewDetect", <String, dynamic>{"path": imagePath})));
  }

  Future<MLDocumentSkewCorrectionResult> asyncDocumentSkewResult() async {
    return new MLDocumentSkewCorrectionResult.fromJson(
        json.decode(await _channel.invokeMethod("asyncDocumentSkewResult")));
  }

  Future<MLDocumentSkewDetectResult> syncDocumentSkewDetect(
      String imagePath) async {
    return new MLDocumentSkewDetectResult.fromJson(json.decode(await _channel
        .invokeMethod(
            "syncDocumentSkewDetect", <String, dynamic>{"path": imagePath})));
  }

  Future<MLDocumentSkewCorrectionResult> syncDocumentSkewResult() async {
    return new MLDocumentSkewCorrectionResult.fromJson(
        json.decode(await _channel.invokeMethod("syncDocumentSkewResult")));
  }

  Future<bool> stopDocumentSkewCorrection() async {
    return await _channel.invokeMethod("stopDocumentSkewCorrection");
  }
}
