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

class MLInteractiveLivenessCaptureResult {
  /// Image frame of the interactive biometric verification result.
  final Uint8List? bitmap;

  final double? score;

  /// 1001: FACE_ASPECT --> The face orientation is inconsistent with that of the phone.
  ///
  /// 1002: NO_FACE --> No face is detected.
  ///
  /// 1003: MULTI_FACES --> Multiple faces are detected.
  ///
  /// 1004: PART_FACE --> The face deviates from the center of the face frame.
  ///
  /// 1005: BIG_FACE --> The face is too large.
  ///
  /// 1006: SMALL_FACE --> The face is too small.
  ///
  /// 1007: WEAR_SUNGLASSES --> The face is blocked by the sunglasses.
  ///
  /// 1008: WEAR_MASK --> The face is blocked by the mask.
  ///
  /// 1009: ACTION_MUTUALLY_EXCLUSIVE_ERROR --> The detected action is not the required one. When this result code is returned, exit the detection, and the call will be charged as a valid call.
  ///
  /// 1014: CONTINUITY_DETECTION_ERROR --> The continuity detection fails. When this result code is returned, exit the detection, and the call will be charged as a valid call.
  ///
  /// 1018: DARK --> The light is dark.
  ///
  /// 1019: BLUR --> The image is blurry.
  ///
  /// 1020: BACK_LIGHTING --> The face is backlit.
  ///
  /// 1021: BRIGHT --> The light is bright.
  ///
  /// 2000: IN_PROGRESS --> The detection is underway.
  ///
  /// 2002: SPOOFING --> The face does not belong to a real person. When this result code is returned, exit the detection, and the call will be charged as a valid call.
  ///
  /// 2003: LIVE_AND_ACTION_CORRECT --> Verification is performed, and the detected action is correct.
  ///
  /// 2004: GUIDE_DETECTION_SUCCESS --> Verification succeeded.
  ///
  /// 2007: INIT_FACE_RECTANGLE_ERROR --> The position of the face frame is not set before the algorithm is called.
  ///
  /// 5020: ERROR_RESULT_BEFORE --> The previous detection ended when it was not complete. When this result code is returned, exit the detection, and the call will not be charged.
  ///
  /// 5030: RESULT_TIME_OUT --> The detection times out. When this result code is returned, the call will be charged as a valid call.
  ///
  /// 9999: ALL_ACTION_CORRECT --> Three consecutive actions are correct, and the detection ends. When this result code is returned, the call will be charged as a valid call.
  ///
  /// -1: INITIALED_FAILED --> The initialization of the interactive biometric verification service failed. When this result code is returned, exit the detection.
  ///
  /// -5001: NO_ORDER_PAY --> The developer account does not subscribe to any API call plan. When this result code is returned, exit the detection.
  ///
  /// -5002: OUT_OF_CREDIT --> The developer account is in arrears. When this result code is returned, exit the detection.
  ///
  /// -5003: FREE_AMOUNT_USE_UP --> The free quota in the free plan is used up. When this result code is returned, exit the detection.
  ///
  /// -5004: BLACK_LIST --> The app is in the blocklist. When this result code is returned, exit the detection.
  ///
  /// -6001:  OFFLINE_USE_COUNT_OVER_THRESHOLD --> The number of offline API calls exceeds the maximum. When this result code is returned, exit the detection.
  ///
  /// -6002: OFFLINE_USE_TIME_OVER_THRESHOLD --> The offline usage time exceeds the maximum. When this result code is returned, exit the detection.
  ///
  /// -7001:  LOCAL_AND_CLOUD_BILL_INFO_IS_NULL --> The first initialization is not performed for the interactive biometric verification service. When this result code is returned, exit the detection.
  ///
  /// -7002: UPDATE_BILL_INFO_FILE_FAILED --> The usage status of the interactive biometric verification service is not synchronized from the cloud to the local. When this result code is returned, exit the detection.
  final int? stateCode;

  /// 1: SHAKE_DOWN_ACTION --> Nod.
  ///
  /// 2: OPEN_MOUTH_ACTION --> Open mouth.
  ///
  /// 3: EYE_CLOSE_ACTION --> Blink.
  ///
  /// 4: SHAKE_LEFT_ACTION --> Turn left.
  ///
  /// 5: SHAKE_RIGHT_ACTION --> Turn right.
  ///
  /// 6: GAZED_ACTION --> Stare at the screen.
  final int? actionType;

  final int? frameNum;

  const MLInteractiveLivenessCaptureResult._({
    this.bitmap,
    this.score,
    this.stateCode,
    this.actionType,
    this.frameNum,
  });

  factory MLInteractiveLivenessCaptureResult._fromJson(
    Map<dynamic, dynamic> json,
  ) {
    return MLInteractiveLivenessCaptureResult._(
      bitmap: json['bitmap'],
      score: json['score'],
      stateCode: json['stateCode'],
      actionType: json['actionType'],
      frameNum: json['frameNum'],
    );
  }

  @override
  String toString() {
    return '$MLInteractiveLivenessCaptureResult('
        'bitmap: $bitmap, '
        'score: $score, '
        'stateCode: $stateCode, '
        'actionType: $actionType, '
        'frameNum: $frameNum)';
  }
}
