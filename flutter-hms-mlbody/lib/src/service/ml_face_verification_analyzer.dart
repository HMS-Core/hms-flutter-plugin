/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLFaceVerificationAnalyzer {
  late MethodChannel _channel;

  MLFaceVerificationAnalyzer() {
    _channel = const MethodChannel('$baseChannel.verification');
  }

  Future<List<MLFaceTemplateResult>> setTemplateFace(
    String path,
    int? maxFace,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      'faceVer#setTemplateFace',
      <String, dynamic>{
        'path': path,
        'maxFaceNum': maxFace,
      },
    );
    return res.map((dynamic e) => MLFaceTemplateResult.fromMap(e)).toList();
  }

  Future<List<MLFaceVerificationResult>> asyncAnalyseFrame(
    String path,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      'faceVer#asyncAnalyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res.map((dynamic e) => MLFaceVerificationResult.fromMap(e)).toList();
  }

  Future<List<MLFaceVerificationResult>> analyseFrame(
    String path,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      'faceVer#analyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res.map((dynamic e) => MLFaceVerificationResult.fromMap(e)).toList();
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod(
      'faceVer#stop',
    );
  }
}
