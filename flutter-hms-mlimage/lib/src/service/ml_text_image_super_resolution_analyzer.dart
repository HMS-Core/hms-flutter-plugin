/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ml_image;

class MLTextImageSuperResolutionAnalyzer
    implements BaseImageAnalyzer<dynamic, String> {
  ///   The service may be abnormal.
  static const int INNER = 2;

  /// The possible causes are as follows:
  ///
  ///   - The parameter settings are incorrect.
  ///   - The input bitmap size exceeds the upper limit
  static const int INACTIVE = 5;

  late MethodChannel _methodChannel;

  MLTextImageSuperResolutionAnalyzer() {
    _methodChannel = const MethodChannel('$baseChannel.text_resolution');
  }

  @override
  Future<List<MLTextImageSuperResolution>> analyseFrame(
    String imagePath,
  ) async {
    final List<dynamic> res = await _methodChannel.invokeMethod(
      mAnalyzeFrame,
      <String, dynamic>{
        'path': imagePath,
      },
    );
    return res
        .map((dynamic e) => MLTextImageSuperResolution.fromMap(e))
        .toList();
  }

  @override
  Future<MLTextImageSuperResolution> asyncAnalyseFrame(
    String imagePath,
  ) async {
    return MLTextImageSuperResolution.fromMap(
      await _methodChannel.invokeMethod(
        mAsyncAnalyzeFrame,
        <String, dynamic>{
          'path': imagePath,
        },
      ),
    );
  }

  @override
  Future<bool> stop() async {
    return await _methodChannel.invokeMethod(
      mStop,
    );
  }
}
