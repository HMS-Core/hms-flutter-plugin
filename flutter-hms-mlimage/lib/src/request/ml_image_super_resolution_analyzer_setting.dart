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

class MLImageSuperResolutionAnalyzerSetting {
  /// 1x super-resolution, which is used to remove the blocking artifact caused by image compression.
  /// In this scenario, the maximum size of an input image is 1024 x 768 px or 768 x 1024 px.
  /// The long edge of an input image should contain at least 64 px.
  static const double ISR_SCALE_1X = 1.0;

  /// 3x super-resolution, which suppresses some compressed noises,
  /// improves the detail texture effect, and provides the 3x enlargement capability.
  /// In this scenario, the maximum size of an input image is 800 x 800 px.
  /// The long edge of an input image should contain at least 64 px.
  static const double ISR_SCALE_3X = 3.0;

  /// Local image path obtained from device.
  final String path;

  /// Scale for resolution.
  final double? scale;

  const MLImageSuperResolutionAnalyzerSetting._({
    required this.path,
    this.scale,
  });

  /// Creates an [MLImageSuperResolutionAnalyzerSetting] instance.
  ///
  /// [path] local image path.
  ///        This parameter must not be null.
  ///
  /// [scale] scale option for resolution.
  factory MLImageSuperResolutionAnalyzerSetting.create({
    required String path,
    double? scale,
  }) {
    return MLImageSuperResolutionAnalyzerSetting._(
      path: path,
      scale: scale,
    );
  }

  /// Returns a map from properties.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'scale': scale ?? ISR_SCALE_3X,
    };
  }
}
