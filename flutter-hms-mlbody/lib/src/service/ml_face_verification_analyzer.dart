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
import 'package:huawei_ml_body/src/result/ml_face_info.dart';

class MLFaceVerificationAnalyzer {
  late MethodChannel _channel;

  MLFaceVerificationAnalyzer() {
    _channel = const MethodChannel('$baseChannel.verification');
  }

  Future<List<MLFaceTemplateResult>> setTemplateFace(
      String path, int? maxFace) async {
    List res = await _channel.invokeMethod(
        "faceVer#setTemplateFace", {'path': path, 'maxFaceNum': maxFace});
    return res.map((e) => MLFaceTemplateResult.fromMap(e)).toList();
  }

  Future<List<MLFaceVerificationResult>> asyncAnalyseFrame(String path) async {
    List res = await _channel
        .invokeMethod("faceVer#asyncAnalyseFrame", {'path': path});
    return res.map((e) => MLFaceVerificationResult.fromMap(e)).toList();
  }

  Future<List<MLFaceVerificationResult>> analyseFrame(String path) async {
    List res =
        await _channel.invokeMethod("faceVer#analyseFrame", {'path': path});
    return res.map((e) => MLFaceVerificationResult.fromMap(e)).toList();
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod("faceVer#stop");
  }
}
