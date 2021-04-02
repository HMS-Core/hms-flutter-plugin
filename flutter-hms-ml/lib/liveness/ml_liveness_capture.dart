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

import 'package:flutter/services.dart';
import 'package:huawei_ml/models/ml_liveness_capture_result.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLLivenessCapture {
  static const int START_DETECT_FACE = 1;
  static const int START_DETECT_LIVENESS = 2;

  /// The camera permission is not obtained.
  static const int CAMERA_NO_PERMISSION = 11401;

  /// Failed to start the camera.
  static const int CAMERA_START_FAILED = 11402;

  /// The face detection module times out. (The duration does not exceed 2 minutes.)
  static const int DETECT_FACE_TIME_OUT = 11404;

  /// The operation is canceled by the user.
  static const int USER_CANCEL = 11403;

  /// Sets whether to detect the mask.
  static const int DETECT_MASK = 1;

  /// A mask is detected.
  static const int MASK_WAS_DETECTED = 2;

  /// No face is detected.
  static const int NO_FACE_WAS_DETECTED = 1;

  final MethodChannel _channel = Channels.livenessMethodChannel;

  Future<MLLivenessCaptureResult> startLivenessDetection({bool detectMask = true}) async {
    return new MLLivenessCaptureResult.fromMap(await _channel.invokeMethod("getLivenessDetectionResult", <String, dynamic>{'detectMask': detectMask}));
  }
}
