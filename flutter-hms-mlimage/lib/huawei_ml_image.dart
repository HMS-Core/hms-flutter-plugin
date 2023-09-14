/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

library huawei_ml_image;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/common/base_image_analyzer.dart';
part 'src/common/constants.dart';
part 'src/common/method.dart';
part 'src/request/ml_classification_analyzer_setting.dart';
part 'src/request/ml_image_lens_controller.dart';
part 'src/request/ml_image_super_resolution_analyzer_setting.dart';
part 'src/request/ml_landmark_analyzer_setting.dart';
part 'src/request/ml_model_in_out_settings.dart';
part 'src/request/ml_object_analyzer_setting.dart';
part 'src/request/ml_product_vision_search_analyzer_setting.dart';
part 'src/request/ml_scene_detection_analyzer_setting.dart';
part 'src/request/ml_segmentation_analyzer_setting.dart';
part 'src/result/ml_border.dart';
part 'src/result/ml_document_skew_correction_result.dart';
part 'src/result/ml_document_skew_detect_result.dart';
part 'src/result/ml_image_classification.dart';
part 'src/result/ml_image_resolution_result.dart';
part 'src/result/ml_image_segmentation.dart';
part 'src/result/ml_landmark.dart';
part 'src/result/ml_object.dart';
part 'src/result/ml_point.dart';
part 'src/result/ml_product_visual_search.dart';
part 'src/result/ml_scene_detection.dart';
part 'src/result/ml_text_image_super_resolution.dart';
part 'src/service/ml_custom_model.dart';
part 'src/service/ml_document_skew_correction_analyzer.dart';
part 'src/service/ml_image_application.dart';
part 'src/service/ml_image_classification_analyzer.dart';
part 'src/service/ml_image_lens_engine.dart';
part 'src/service/ml_image_segmentation_analyzer.dart';
part 'src/service/ml_image_super_resolution_analyzer.dart';
part 'src/service/ml_landmark_analyzer.dart';
part 'src/service/ml_object_analyzer.dart';
part 'src/service/ml_product_vision_search_analyzer.dart';
part 'src/service/ml_scene_detection_analyzer.dart';
part 'src/service/ml_text_image_super_resolution_analyzer.dart';
part 'src/ui/ml_image_lens.dart';
