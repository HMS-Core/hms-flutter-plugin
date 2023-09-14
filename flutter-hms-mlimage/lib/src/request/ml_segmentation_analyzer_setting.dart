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

class MLImageSegmentationAnalyzerSetting {
  /// Obtains all segmentation results by default.
  static const int ALL = 0;

  /// Obtains the pixel-level label information.
  static const int MASK_ONLY = 1;

  /// Obtains the human body image with a transparent background.
  static const int FOREGROUND_ONLY = 2;

  /// Obtains the gray-scale image with a white human body and black background.
  static const int GRAYSCALE_ONLY = 3;

  /// Detection mode 0: detection based on the portrait model
  static const int BODY_SEG = 0;

  /// Detection mode 1: detection based on the multi class image mode
  static const int IMAGE_SEG = 1;

  /// Detection mode 2: detection based on the hair model
  static const int HAIR_SEG = 2;

  final String path;
  final int? analyzerType;
  final int? scene;
  final bool? exactMode;

  const MLImageSegmentationAnalyzerSetting._({
    required this.path,
    this.analyzerType,
    this.exactMode,
    this.scene,
  });

  factory MLImageSegmentationAnalyzerSetting.create({
    required String path,
    int? analyzerType,
    int? scene,
    bool? exactMode,
  }) {
    return MLImageSegmentationAnalyzerSetting._(
      path: path,
      analyzerType: analyzerType,
      scene: scene,
      exactMode: exactMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'scene': scene ?? ALL,
      'analyzerType': analyzerType ?? IMAGE_SEG,
      'exactMode': exactMode ?? true,
    };
  }
}
