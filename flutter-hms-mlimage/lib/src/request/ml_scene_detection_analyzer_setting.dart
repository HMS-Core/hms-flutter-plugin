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

class MLSceneDetectionAnalyzerSetting {
  final String path;

  /// confidence for scene detection.
  final double? confidence;

  const MLSceneDetectionAnalyzerSetting._({
    required this.path,
    this.confidence,
  });

  /// Creates an [MLSceneDetectionAnalyzerSetting] instance.
  ///
  /// [path] local image path.
  ///        This parameter must not be null.
  ///
  /// [confidence] confidence option for scene detection.
  factory MLSceneDetectionAnalyzerSetting.create({
    required String path,
    double? confidence,
  }) {
    return MLSceneDetectionAnalyzerSetting._(
      path: path,
      confidence: confidence,
    );
  }

  /// Returns a map from properties.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'confidence': confidence ?? 0.5,
    };
  }
}
