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
import 'package:huawei_ml/imgseg/ml_image_segmentation_settings.dart';
import 'model/ml_image_segmentation_result.dart';

class MlImageSegmentationClient {
  static const MethodChannel _channel =
      const MethodChannel("image_segmentation");

  static _createSegmentationFromResponse(String response) {
    Map<String, dynamic> result = json.decode(response);
    final MlImageSegmentationResult imgSegmentationResult =
        new MlImageSegmentationResult.fromJson(result);
    return imgSegmentationResult;
  }

  static Future<MlImageSegmentationResult> getDefaultSegmentation(
      String path) async {
    Map<String, dynamic> args = {"path": path};
    return _createSegmentationFromResponse(
        await _channel.invokeMethod("getDefaultSegmentation", args));
  }

  static Future<MlImageSegmentationResult> getSegmentation(
      MlImageSegmentationSettings settings) async {
    return _createSegmentationFromResponse(
        await _channel.invokeMethod("getImageSegmentation", settings.toMap()));
  }

  static Future<List<MlImageSegmentationResult>> getSparseSegmentation(
      MlImageSegmentationSettings settings) async {
    List<MlImageSegmentationResult> results = [];
    final String response = await _channel.invokeMethod(
        "getSparseImageSegmentation", settings.toMap());
    Map<String, dynamic> result = json.decode(response);
    for (int i = 0; i < result.length; i++) {
      results.add(new MlImageSegmentationResult.fromJson(result['$i']));
    }
    return results;
  }

  static Future<String> stopSegmentation() async {
    final String response = await _channel.invokeMethod("stopSegmentation");
    return response;
  }
}
