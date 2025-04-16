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

library huawei_ml_body;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/common/constants.dart';
part 'src/common/ml_body_analyzer.dart';
part 'src/request/ml_3d_face_analyzer_setting.dart';
part 'src/request/ml_body_lens_controller.dart';
part 'src/request/ml_face_analyzer_setting.dart';
part 'src/request/ml_hand_keypoint_analyzer_setting.dart';
part 'src/request/ml_skeleton_analyzer_setting.dart';
part 'src/request/ml_custom_interactive_liveness_detection_setting.dart';
part 'src/result/body_border.dart';
part 'src/result/body_position.dart';
part 'src/result/ml_3d_face.dart';
part 'src/result/ml_face.dart';
part 'src/result/ml_face_info.dart';
part 'src/result/ml_gesture.dart';
part 'src/result/ml_hand_keypoints.dart';
part 'src/result/ml_interactive_liveness_capture_result.dart';
part 'src/result/ml_liveness_capture_result.dart';
part 'src/result/ml_skeleton.dart';
part 'src/service/body_lens_engine.dart';
part 'src/service/ml_3d_face_analyzer.dart';
part 'src/service/ml_body_application.dart';
part 'src/service/ml_face_analyzer.dart';
part 'src/service/ml_face_verification_analyzer.dart';
part 'src/service/ml_gesture_analyzer.dart';
part 'src/service/ml_hand_keypoint_analyzer.dart';
part 'src/service/ml_interactive_liveness_capture.dart';
part 'src/service/ml_liveness_capture.dart';
part 'src/service/ml_skeleton_analyzer.dart';
part 'src/service/ml_custom_view_analyzer.dart';
part 'src/ui/ml_body_lens.dart';
part 'src/model/text_options.dart';
part 'src/model/actions.dart';
part 'src/model/rect.dart';
