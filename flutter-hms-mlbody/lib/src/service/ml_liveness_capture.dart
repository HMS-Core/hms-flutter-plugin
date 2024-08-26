/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLLivenessCapture {
  static const int startDetectFace = 1;
  static const int startDetectLiveness = 2;

  /// The camera permission is not obtained.
  static const int cameraNoPermission = 11401;

  /// Failed to start the camera.
  static const int cameraStartFailed = 11402;

  /// The face detection module times out. (The duration does not exceed 2 minutes.)
  static const int detectFaceTimeout = 11404;

  /// The operation is canceled by the user.
  static const int userCancel = 11403;

  /// The user-defined action is invalid.
  static const int userDefinedActionsInvalid = 11405;

  /// Sets whether to detect the mask.
  static const int detectMask = 1;

  /// A mask is detected.
  static const int maskWasDetected = 2;

  /// No face is detected.
  static const int noFaceWasDetected = 1;

  late MethodChannel _channel;

  MLLivenessCapture() {
    _channel = const MethodChannel('$baseChannel.liveness');
  }

  Future<MLLivenessCaptureResult> startDetect({
    bool? detectMask,
  }) async {
    return MLLivenessCaptureResult.fromJson(
      await _channel.invokeMethod(
        'liveness#startDetect',
        <String, dynamic>{
          'detectMask': detectMask ?? true,
        },
      ),
    );
  }
}
