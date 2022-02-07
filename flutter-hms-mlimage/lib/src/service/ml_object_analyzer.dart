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
import 'package:huawei_ml_image/src/common/base_image_analyzer.dart';
import 'package:huawei_ml_image/src/common/constants.dart';
import 'package:huawei_ml_image/src/common/method.dart';
import 'package:huawei_ml_image/src/request/ml_object_analyzer_setting.dart';
import 'package:huawei_ml_image/src/result/ml_object.dart';

class MLObjectAnalyzer
    implements BaseImageAnalyzer<List<MLObject>, MLObjectAnalyzerSetting> {
  late MethodChannel _channel;

  MLObjectAnalyzer() {
    _channel = MethodChannel("$baseChannel.object");
  }
  @override
  Future<List<MLObject>> analyseFrame(MLObjectAnalyzerSetting setting) async {
    List res = await _channel.invokeMethod(mAnalyzeFrame, setting.toMap());
    return res.map((e) => MLObject.fromMap(e)).toList();
  }

  @override
  Future<List<MLObject>> asyncAnalyseFrame(
      MLObjectAnalyzerSetting setting) async {
    List res = await _channel.invokeMethod(mAsyncAnalyzeFrame, setting.toMap());
    return res.map((e) => MLObject.fromMap(e)).toList();
  }

  @override
  Future<bool> stop() async {
    return await _channel.invokeMethod(stopObject);
  }
}
