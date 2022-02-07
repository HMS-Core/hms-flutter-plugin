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
import 'package:huawei_ml_image/src/common/xport.dart';
import 'package:huawei_ml_image/src/request/xport.dart';
import 'package:huawei_ml_image/src/result/ml_scene_detection.dart';

class MLSceneDetectionAnalyzer
    implements
        BaseImageAnalyzer<List<MLSceneDetection>,
            MLSceneDetectionAnalyzerSetting> {
  late MethodChannel _methodChannel;

  MLSceneDetectionAnalyzer() {
    _methodChannel = MethodChannel("$baseChannel.scene");
  }

  @override
  Future<List<MLSceneDetection>> analyseFrame(
      MLSceneDetectionAnalyzerSetting setting) async {
    List res =
        await _methodChannel.invokeMethod(mAnalyzeFrame, setting.toMap());
    return res.map((e) => MLSceneDetection.fromJson(e)).toList();
  }

  @override
  Future<List<MLSceneDetection>> asyncAnalyseFrame(
      MLSceneDetectionAnalyzerSetting setting) async {
    List res =
        await _methodChannel.invokeMethod(mAsyncAnalyzeFrame, setting.toMap());
    return res.map((e) => MLSceneDetection.fromJson(e)).toList();
  }

  @override
  Future<bool> stop() async {
    return await _methodChannel.invokeMethod(mStop);
  }
}
