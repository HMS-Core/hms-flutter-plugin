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

class MLProductVisionSearchAnalyzer {
  late MethodChannel _channel;

  MLProductVisionSearchAnalyzer() {
    _channel = const MethodChannel('$baseChannel.product');
  }

  Future<List<MlProductVisualSearch?>> searchProduct(
    MLProductVisionSearchAnalyzerSetting setting,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      mAnalyzeProduct,
      setting.toMap(),
    );
    return res.map((dynamic e) => MlProductVisualSearch.fromMap(e)).toList();
  }

  Future<List<MLProductCaptureResult?>> searchProductWithPlugin(
    MLProductVisionSearchAnalyzerSetting setting,
  ) async {
    final List<dynamic> res = json.decode(
      await _channel.invokeMethod(
        mAnalyzeProductWithPlugin,
        setting.toMap(),
      ),
    );
    return res.map((dynamic e) => MLProductCaptureResult.fromJson(e)).toList();
  }

  Future<bool> stopProductAnalyzer() async {
    return await _channel.invokeMethod(
      mStopProductAnalyzer,
    );
  }
}
