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

class MLImageSuperResolutionAnalyzer
    implements
        BaseImageAnalyzer<dynamic, MLImageSuperResolutionAnalyzerSetting> {
  late MethodChannel _methodChannel;

  MLImageSuperResolutionAnalyzer() {
    _methodChannel = const MethodChannel('$baseChannel.image_resolution');
  }

  @override
  Future<List<MLImageSuperResolutionResult>> analyseFrame(
    MLImageSuperResolutionAnalyzerSetting setting,
  ) async {
    final List<dynamic> res = await _methodChannel.invokeMethod(
      mAnalyzeFrame,
      setting.toMap(),
    );
    return res
        .map((dynamic e) => MLImageSuperResolutionResult.fromMap(e))
        .toList();
  }

  @override
  Future<MLImageSuperResolutionResult> asyncAnalyseFrame(
    MLImageSuperResolutionAnalyzerSetting setting,
  ) async {
    return MLImageSuperResolutionResult.fromMap(
      await _methodChannel.invokeMethod(
        mAsyncAnalyzeFrame,
        setting.toMap(),
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
