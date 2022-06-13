/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_body/src/result/ml_gesture.dart';

import '../common/ml_body_analyzer.dart';

class MLGestureAnalyzer implements MLBodyAnalyzer<MLGesture, String> {
  late MethodChannel _channel;

  MLGestureAnalyzer() {
    _channel = const MethodChannel('$baseChannel.gesture');
  }

  @override
  Future<List<MLGesture>> asyncAnalyseFrame(String path) async {
    if (path.isEmpty) {
      throw ArgumentError('Image path can not be empty!');
    }

    List res = await _channel
        .invokeMethod("gesture#asyncAnalyseFrame", {'path': path});
    return res.map((e) => MLGesture.fromMap(e)).toList();
  }

  @override
  Future<List<MLGesture>> analyseFrame(String path) async {
    if (path.isEmpty) {
      throw ArgumentError('Image path can not be empty!');
    }

    List res =
        await _channel.invokeMethod("gesture#analyseFrame", {'path': path});
    return res.map((e) => MLGesture.fromMap(e)).toList();
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod('gesture#destroy');
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod('gesture#isAvailable');
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod('gesture#stop');
  }
}
