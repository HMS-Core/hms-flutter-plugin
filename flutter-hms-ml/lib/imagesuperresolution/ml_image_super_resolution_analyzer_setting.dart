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

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  double scale;

  MLImageSuperResolutionAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    scale = ISR_SCALE_1X;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "scale": scale
    };
  }

  double get getScale => scale;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLImageSuperResolutionAnalyzerSetting &&
        o.scale == scale &&
        o.frameType == frameType &&
        o.path == path;
  }

  @override
  int get hashCode {
    return hashList([path, frameType, scale]);
  }
}
