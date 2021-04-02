/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ml/models/ml_frame_property.dart';
import 'package:huawei_ml/utils/ml_utils.dart';

class MLFaceAnalyzerSetting {
  /// Detects all facial features and expressions.
  static const int TYPE_FEATURES = 1;

  /// Detects the age.
  static const int TYPE_FEATURE_AGE = 256;

  /// Detects whether a person has a beard.
  static const int TYPE_FEATURE_BEARD = 32;

  /// Detects facial expressions.
  static const int TYPE_FEATURE_EMOTION = 4;

  /// Detects whether a person wears glasses.
  static const int TYPE_FEATURE_EYEGLASS = 8;

  /// Detects the gender.
  static const int TYPE_FEATURE_GENDER = 128;

  /// Detects whether a person wears a hat.
  static const int TYPE_FEATURE_HAT = 16;

  /// Detects eye opening and eye closing.
  static const int TYPE_FEATURE_OPEN_CLOSE_EYE = 64;

  /// Detects only basic data: including contours, key points,
  /// and three-dimensional rotation angles; does not detect facial features or expressions.
  static const int TYPE_UNSUPPORTED_FEATURES = 2;

  /// Precision preference mode. This mode will detect more faces and be
  /// more precise in detecting key points and contours, but will run slower.
  static const int TYPE_KEY_POINTS = 1;

  /// Does not detect key face points.
  static const int TYPE_UNSUPPORTED_KEY_POINTS = 0;

  /// Precision preference mode. This mode will detect more faces
  /// and be more precise in detecting key points and contours, but will run slower.
  static const int TYPE_PRECISION = 1;

  /// Speed preference mode. This mode will detect fewer faces
  /// and be less precise in detecting key points and contours, but will run faster.
  static const int TYPE_SPEED = 2;

  /// Detects facial contours.
  static const int TYPE_SHAPES = 2;

  /// Does not detect facial contours.
  static const int TYPE_UNSUPPORTED_SHAPES = 3;

  /// Common tracking mode. In this mode, initial detection is fast,
  /// but the performance of detection during tracking will be affected by
  /// face re-detection every several frames. The detection result in this mode is stable.
  static const int MODE_TRACING_ROBUST = 2;

  /// Fast tracking mode. In this mode, detection and tracking are performed at the same time.
  /// Initial detection has a delay, but the detection during tracking is fast.
  /// When used together with the speed preference mode,
  /// this mode can make the greatest improvements to the detection performance.
  static const int MODE_TRACING_FAST = 1;

  String path;
  MLFrameProperty property;
  MLFrameType frameType;
  int featureType;
  int keyPointType;
  bool maxSizeFaceOnly;
  double minFaceProportion;
  int performanceType;
  bool poseDisabled;
  int shapeType;
  bool tracingAllowed;
  int tracingMode;

  MLFaceAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    featureType = TYPE_FEATURES;
    keyPointType = TYPE_KEY_POINTS;
    maxSizeFaceOnly = true;
    minFaceProportion = 0.5;
    performanceType = TYPE_PRECISION;
    poseDisabled = false;
    shapeType = TYPE_SHAPES;
    tracingAllowed = false;
    tracingMode = MODE_TRACING_ROBUST;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "featureType": featureType,
      "keyPointType": keyPointType,
      "maxSizeFaceOnly": maxSizeFaceOnly,
      "minFaceProportion": minFaceProportion,
      "performanceType": performanceType,
      "poseDisabled": poseDisabled,
      "shapeType": shapeType,
      "tracingAllowed": tracingAllowed,
      "tracingMode": tracingMode
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLFaceAnalyzerSetting &&
        o.featureType == featureType &&
        o.keyPointType == keyPointType &&
        o.maxSizeFaceOnly == maxSizeFaceOnly &&
        o.minFaceProportion == minFaceProportion &&
        o.performanceType == performanceType &&
        o.poseDisabled == poseDisabled &&
        o.shapeType == shapeType &&
        o.tracingAllowed == tracingAllowed &&
        o.tracingMode == tracingMode;
  }

  @override
  int get hashCode {
    return hashList([
      featureType,
      keyPointType,
      maxSizeFaceOnly,
      minFaceProportion,
      performanceType,
      poseDisabled,
      shapeType,
      tracingAllowed,
      tracingMode
    ]);
  }

  int get getFeatureType => featureType;

  int get getKeyPointType => keyPointType;

  double get getMinFaceProportion => minFaceProportion;

  int get getPerformanceType => performanceType;

  int get getShapeType => shapeType;

  int get getTracingMode => tracingMode;

  bool get isMaxSizeFaceOnly => maxSizeFaceOnly;

  bool get isPoseDisabled => poseDisabled;

  bool get isTracingAllowed => tracingAllowed;

  String toString() =>
      'MLFaceAnalyzerSetting(featureType: $featureType, keyPointType: $keyPointType, maxSizeFaceOnly: $maxSizeFaceOnly, minFaceProportion: $minFaceProportion, performanceType: $performanceType, poseDisabled: $poseDisabled, shapeType: $shapeType, tracingAllowed: $tracingAllowed, tracingMode: $tracingMode)';
}
