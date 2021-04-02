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

class MLHandKeypointAnalyzerSetting {
  /// Maximum number of returned hand regions.
  static const int MAX_HANDS_NUM = 10;

  /// Recognition result return mode. TYPE_ALL indicates that all results are returned.
  static const int TYPE_ALL = 0;

  /// Recognition result return mode. TYPE_KEYPOINT_ONLY indicates that only hand keypoint information is returned.
  static const int TYPE_KEY_POINT_ONLY = 1;

  /// Recognition result return mode. TYPE_RECT_ONLY indicates that only palm information is returned.
  static const int TYPE_RECT_ONLY = 2;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int sceneType;
  int maxHandResults;

  MLHandKeypointAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    sceneType = TYPE_ALL;
    maxHandResults = MAX_HANDS_NUM;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "sceneType": sceneType,
      "maxHandResults": maxHandResults
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLHandKeypointAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.sceneType == sceneType &&
        o.maxHandResults == maxHandResults;
  }

  @override
  int get hashCode {
    return hashList([path, frameType, sceneType, maxHandResults]);
  }

  int get getSceneType => sceneType;

  int get getMaxHandResults => maxHandResults;
}
