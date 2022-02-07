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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_ml_body/src/common/constants.dart';
import 'package:huawei_ml_body/src/request/ml_skeleton_analyzer_setting.dart';
import 'package:huawei_ml_body/src/result/ml_skeleton.dart';

import '../common/ml_body_analyzer.dart';

class MLSkeletonAnalyzer
    implements MLBodyAnalyzer<MLSkeleton, MLSkeletonAnalyzerSetting> {
  late MethodChannel _channel;

  MLSkeletonAnalyzer() {
    _channel = const MethodChannel('$baseChannel.skeleton');
  }

  @override
  Future<List<MLSkeleton>> asyncAnalyseFrame(
      MLSkeletonAnalyzerSetting setting) async {
    List res = await _channel.invokeMethod(
        "skeleton#asyncAnalyseFrame", setting.toMap());
    return (res).map((e) => MLSkeleton.fromMap(e)).toList();
  }

  @override
  Future<List<MLSkeleton>> analyseFrame(
      MLSkeletonAnalyzerSetting setting) async {
    List res =
        await _channel.invokeMethod("skeleton#analyseFrame", setting.toMap());
    return (res).map((e) => MLSkeleton.fromMap(e)).toList();
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod('skeleton#destroy');
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod('skeleton#isAvailable');
  }

  Future<double> calculateSimilarity(
      List<MLSkeleton> list1, List<MLSkeleton> list2) async {
    return await _channel.invokeMethod("skeleton#similarity",
        {'list1': json.encode(list1), 'list2': json.encode(list2)});
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod('skeleton#stop');
  }
}
