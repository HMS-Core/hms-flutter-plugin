/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library huawei_ml_text;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/common/constants.dart';
part 'src/common/text_analyzer.dart';
part 'src/request/ml_bankcard_settings.dart';
part 'src/request/ml_document_analyzer_setting.dart';
part 'src/request/ml_general_card_analyzer_setting.dart';
part 'src/request/ml_text_analyzer_setting.dart';
part 'src/request/ml_text_embedding_analyzer_setting.dart';
part 'src/request/ml_text_lens_controller.dart';
part 'src/request/ml_customized_view_settings.dart';
part 'src/result/ml_bankcard.dart';
part 'src/result/ml_document.dart';
part 'src/result/ml_general_card.dart';
part 'src/result/ml_point.dart';
part 'src/result/ml_table.dart';
part 'src/result/ml_text.dart';
part 'src/result/ml_text_language.dart';
part 'src/result/ml_vn_icr_capture_result.dart';
part 'src/result/ml_vocabulary_version.dart';
part 'src/result/text_border.dart';
part 'src/service/ml_bankcard_analyzer.dart';
part 'src/service/ml_document_analyzer.dart';
part 'src/service/ml_form_recognition_analyzer.dart';
part 'src/service/ml_general_card_analyzer.dart';
part 'src/service/ml_text_analyzer.dart';
part 'src/service/ml_text_application.dart';
part 'src/service/ml_text_embedding_analyzer.dart';
part 'src/service/ml_vn_icr_capture.dart';
part 'src/service/text_lens_engine.dart';
part 'src/service/ml_custom_view_analyzer.dart';
part 'src/ui/ml_text_lens.dart';
