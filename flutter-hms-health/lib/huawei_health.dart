/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

library huawei_health;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/constants/channels.dart';
part 'src/constants/hihealth_activities.dart';
part 'src/constants/hihealth_status_codes.dart';
part 'src/constants/time_unit.dart';
part 'src/data/activity_record.dart';
part 'src/data/activity_summary.dart';
part 'src/data/auth_huawei_id.dart';
part 'src/data/data_collector.dart';
part 'src/data/data_type.dart';
part 'src/data/device_info.dart';
part 'src/data/field.dart';
part 'src/data/group.dart';
part 'src/data/health_data_types.dart';
part 'src/data/health_fields.dart';
part 'src/data/health_kit_auth_result.dart';
part 'src/data/health_record.dart';
part 'src/data/health_record_reply.dart';
part 'src/data/pace_summary.dart';
part 'src/data/sample_point.dart';
part 'src/data/sample_section.dart';
part 'src/data/sample_set.dart';
part 'src/data/scope_lang_item.dart';
part 'src/data/scopes.dart';
part 'src/data/sleep_state.dart';
part 'src/modules/activity_records_controller.dart';
part 'src/modules/app_info.dart';
part 'src/modules/auto_recorder_controller.dart';
part 'src/modules/consents_controller.dart';
part 'src/modules/data_controller.dart';
part 'src/modules/health_auth.dart';
part 'src/modules/health_record_controller.dart';
part 'src/modules/hms_logger.dart';
part 'src/modules/setting_controller.dart';
part 'src/options/activity_record_delete_options.dart';
part 'src/options/activity_record_insert_options.dart';
part 'src/options/activity_record_read_options.dart';
part 'src/options/data_type_add_options.dart';
part 'src/options/delete_options.dart';
part 'src/options/health_record_delete_options.dart';
part 'src/options/health_record_insert_options.dart';
part 'src/options/health_record_read_options.dart';
part 'src/options/health_record_update_options.dart';
part 'src/options/hihealth_option.dart';
part 'src/options/read_options.dart';
part 'src/options/update_options.dart';
part 'src/result/read_reply.dart';
