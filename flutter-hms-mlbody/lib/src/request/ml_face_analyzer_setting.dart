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

class MLFaceAnalyzerSetting {
  /// Detects all facial features and expressions.
  static const int typeFeatures = 1;

  /// Detects the age.
  static const int typeFeatureAge = 256;

  /// Detects whether a person has a beard.
  static const int typeFeatureBeard = 32;

  /// Detects facial expressions.
  static const int typeFeatureEmotion = 4;

  /// Detects whether a person wears glasses.
  static const int typeFeatureEyeglass = 8;

  /// Detects the gender.
  static const int typeFeatureGender = 128;

  /// Detects whether a person wears a hat.
  static const int typeFeatureHat = 16;

  /// Detects eye opening and eye closing.
  static const int typeFeatureOpenCloseEye = 64;

  /// Detects only basic data: including contours, key points,
  /// and three-dimensional rotation angles; does not detect facial features or expressions.
  static const int typeUnsupportedFeatures = 2;

  /// Precision preference mode. This mode will detect more faces and be
  /// more precise in detecting key points and contours, but will run slower.
  static const int typeKeyPoints = 1;

  /// Does not detect key face points.
  static const int typeUnsupportedKeyPoints = 0;

  /// Precision preference mode. This mode will detect more faces
  /// and be more precise in detecting key points and contours, but will run slower.
  static const int typePrecision = 1;

  /// Speed preference mode. This mode will detect fewer faces
  /// and be less precise in detecting key points and contours, but will run faster.
  static const int typeSpeed = 2;

  /// Detects facial contours.
  static const int typeShapes = 2;

  /// Does not detect facial contours.
  static const int typeUnsupportedShapes = 3;

  /// Common tracking mode. In this mode, initial detection is fast,
  /// but the performance of detection during tracking will be affected by
  /// face re-detection every several frames. The detection result in this mode is stable.
  static const int modeTracingRobust = 2;

  /// Fast tracking mode. In this mode, detection and tracking are performed at the same time.
  /// Initial detection has a delay, but the detection during tracking is fast.
  /// When used together with the speed preference mode,
  /// this mode can make the greatest improvements to the detection performance.
  static const int modeTracingFast = 1;

  String path;
  int? featureType;
  int? keyPointType;
  bool? maxSizeFaceOnly;
  double? minFaceProportion;
  int? performanceType;
  bool? poseDisabled;
  int? shapeType;
  bool? tracingAllowed;
  int? tracingMode;

  MLFaceAnalyzerSetting({
    required this.path,
    this.featureType,
    this.keyPointType,
    this.maxSizeFaceOnly,
    this.minFaceProportion,
    this.performanceType,
    this.poseDisabled,
    this.shapeType,
    this.tracingAllowed,
    this.tracingMode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'featureType': featureType ?? typeFeatures,
      'keyPointType': keyPointType ?? typeKeyPoints,
      'maxSizeFaceOnly': maxSizeFaceOnly ?? true,
      'minFaceProportion': minFaceProportion ?? 0.5,
      'performanceType': performanceType ?? typePrecision,
      'poseDisabled': poseDisabled ?? false,
      'shapeType': shapeType ?? typeShapes,
      'tracingAllowed': tracingAllowed ?? false,
      'tracingMode': tracingMode ?? modeTracingRobust,
    };
  }
}
