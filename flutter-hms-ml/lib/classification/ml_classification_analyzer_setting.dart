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

class MLClassificationAnalyzerSetting {
  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  double minAcceptablePossibility;
  bool fingerprintVerification;
  bool isRemote;
  int largestNumberOfReturns;

  MLClassificationAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    minAcceptablePossibility = 0.5;
    fingerprintVerification = false;
    isRemote = true;
    largestNumberOfReturns = 10;
  }

  double get getMinAcceptablePossibility => minAcceptablePossibility;

  int get getLargestNumberOfReturns => largestNumberOfReturns;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "fingerprintVerification": fingerprintVerification,
      "isRemote": isRemote,
      "minAcceptablePossibility": minAcceptablePossibility,
      "largestNumberOfReturns": largestNumberOfReturns
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLClassificationAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.minAcceptablePossibility == minAcceptablePossibility &&
        o.largestNumberOfReturns == largestNumberOfReturns;
  }

  @override
  int get hashCode {
    return hashList(
        [path, frameType, minAcceptablePossibility, largestNumberOfReturns]);
  }

  @override
  String toString() =>
      'MlFaceSettings(path: $path, frameType: $frameType, minAcceptablePossibility: $minAcceptablePossibility, largestNumberOfReturns: $largestNumberOfReturns)';
}
