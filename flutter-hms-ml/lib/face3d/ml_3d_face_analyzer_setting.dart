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

class ML3DFaceAnalyzerSetting {
  /// Precision preference mode.
  /// This mode will detect more faces and be more precise in detecting key points and contours, but will run slower.
  static const int TYPE_PRECISION = 1;

  /// Speed preference mode.
  /// Compared with the precision preference mode,
  /// this mode will detect fewer faces and be less precise in detecting key points and contours, but will run faster.
  static const int TYPE_SPEED = 2;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int performanceType;
  bool tracingAllowed;

  ML3DFaceAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    performanceType = TYPE_PRECISION;
    tracingAllowed = false;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "performanceType": performanceType,
      "tracingAllowed": tracingAllowed
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ML3DFaceAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.performanceType == performanceType &&
        o.tracingAllowed == tracingAllowed;
  }

  @override
  int get hashCode {
    return hashList([path, frameType, performanceType, tracingAllowed]);
  }

  @override
  String toString() {
    return 'ML3DFaceAnalyzerSetting(path: $path, frameType: $frameType, performanceType: $performanceType, tracingAllowed: $tracingAllowed)';
  }

  int get getPerformanceType => performanceType;

  bool get isTracingAllowed => tracingAllowed;
}
