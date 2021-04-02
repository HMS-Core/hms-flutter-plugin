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

class MlBankcardSettings {
  /// Failed to initialize the camera.
  static const int ERROR_CODE_INIT_CAMERA_FAILED = 10101;

  /// Adaptive mode. The physical sensor determines the screen orientation.
  static const int ORIENTATION_AUTO = 0;

  /// Portrait mode. The screen height is greater than the screen width.
  static const int ORIENTATION_PORTRAIT = 2;

  /// Landscape mode. The screen width is greater than the screen height.
  static const int ORIENTATION_LANDSCAPE = 1;

  /// Only the bank card number is recognized.
  static const int RESULT_NUM_ONLY = 0;

  /// Only two items recognized, including bank card number and validity period.
  static const int RESULT_SIMPLE = 1;

  /// Recognized information, such as the bank card number,
  /// validity period, issuing bank, card organization, and card type.
  static const int RESULT_ALL = 2;

  /// Weak recognition mode.
  static const int WEAK_MODE = 0;

  /// Strict recognition mode.
  static const int STRICT_MODE = 1;

  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  int orientation;
  int resultType;
  int rectMode;

  MlBankcardSettings() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    orientation = ORIENTATION_AUTO;
    resultType = RESULT_ALL;
    rectMode = STRICT_MODE;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "orientation": orientation,
      "resultType": resultType,
      "rectMode": rectMode
    };
  }

  int get getOrientation => orientation;

  int get getResultType => resultType;

  int get getRectMode => rectMode;
}
