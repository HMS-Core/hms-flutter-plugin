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
import 'package:huawei_ml/models/ml_frame_property.dart';
import 'package:huawei_ml/utils/ml_utils.dart';

class MLSkeletonAnalyzerSetting {
  /// Detection mode 0: Detect skeleton points for normal postures.
  static const int TYPE_NORMAL = 0;

  /// Detection mode 1: Detect skeleton points for yoga postures.
  static const int TYPE_YOGA = 1;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int analyzerType;

  MLSkeletonAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    analyzerType = TYPE_NORMAL;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "analyzerType": analyzerType
    };
  }
}
