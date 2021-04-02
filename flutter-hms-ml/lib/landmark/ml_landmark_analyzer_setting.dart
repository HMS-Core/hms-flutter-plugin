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

class MLLandmarkAnalyzerSetting {
  static const int STEADY_PATTERN = 1;
  static const int NEWEST_PATTERN = 2;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int patternType;
  int largestNumberOfReturns;

  MLLandmarkAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    largestNumberOfReturns = 10;
    patternType = STEADY_PATTERN;
  }

  int get getPatternType => patternType;

  int get getLargestNumberOfReturns => largestNumberOfReturns;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "largestNumberOfReturns": largestNumberOfReturns,
      "patternType": patternType
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLLandmarkAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.patternType == patternType &&
        o.largestNumberOfReturns == largestNumberOfReturns;
  }

  @override
  int get hashCode {
    return hashList([path, frameType, patternType, largestNumberOfReturns]);
  }
}
