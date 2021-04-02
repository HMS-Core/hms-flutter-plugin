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

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int analyzerType;
  int scene;
  bool exactMode;

  MLImageSegmentationAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    analyzerType = IMAGE_SEG;
    scene = ALL;
    exactMode = true;
  }

  int get getAnalyzerType => analyzerType;

  int get getScene => scene;

  bool get isExact => exactMode;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "scene": scene,
      "analyzerType": analyzerType,
      "exactMode": exactMode
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLImageSegmentationAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.analyzerType == analyzerType &&
        o.exactMode == exactMode &&
        o.scene == scene;
  }

  @override
  int get hashCode {
    return hashList([path, frameType, scene, analyzerType, exactMode]);
  }
}
