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

class MLImageSegmentationAnalyzer
    implements BaseImageAnalyzer<dynamic, MLImageSegmentationAnalyzerSetting> {
  static const int TYPE_BACKGROUND = 0;
  static const int TYPE_HUMAN = 1;
  static const int TYPE_SKY = 2;
  static const int TYPE_GRASS = 3;
  static const int TYPE_FOOD = 4;
  static const int TYPE_CAT = 5;
  static const int TYPE_BUILD = 6;
  static const int TYPE_FLOWER = 7;
  static const int TYPE_WATER = 8;
  static const int TYPE_SAND = 9;
  static const int TYPE_MOUNTAIN = 10;

  late MethodChannel _methodChannel;

  MLImageSegmentationAnalyzer() {
    _methodChannel = const MethodChannel('$baseChannel.segmentation');
  }

  @override
  Future<List<MLImageSegmentation>> analyseFrame(
    MLImageSegmentationAnalyzerSetting setting,
  ) async {
    final List<dynamic> res = await _methodChannel.invokeMethod(
      mAnalyzeFrame,
      setting.toMap(),
    );
    return res.map((dynamic e) => MLImageSegmentation.fromMap(e)).toList();
  }

  @override
  Future<MLImageSegmentation> asyncAnalyseFrame(
    MLImageSegmentationAnalyzerSetting setting,
  ) async {
    return MLImageSegmentation.fromMap(
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
