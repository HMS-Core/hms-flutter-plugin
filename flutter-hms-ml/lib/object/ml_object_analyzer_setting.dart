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

class MLObjectAnalyzerSetting {
  static const int TYPE_PICTURE = 0;
  static const int TYPE_VIDEO = 1;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  bool allowMultiResults;
  bool allowClassification;
  int analyzerType;

  MLObjectAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    analyzerType = TYPE_PICTURE;
    allowMultiResults = true;
    allowClassification = true;
  }

  bool get isMultiResultsAllowed => allowMultiResults;

  bool get isClassificationAllowed => allowClassification;

  int get getAnalyzerType => analyzerType;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "analyzerType": analyzerType,
      "allowMultiResults": allowMultiResults,
      "allowClassification": allowClassification
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLObjectAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.analyzerType == analyzerType &&
        o.allowClassification == allowClassification &&
        o.allowMultiResults == allowMultiResults;
  }

  @override
  int get hashCode {
    return hashList([
      path,
      frameType,
      allowClassification,
      allowMultiResults,
      analyzerType
    ]);
  }
}
