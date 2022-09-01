/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

library huawei_gameservice;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/clients/achievement_client.dart';
part 'src/clients/archives_client.dart';
part 'src/clients/buoy_client.dart';
part 'src/clients/events_client.dart';
part 'src/clients/game_player_statistics_client.dart';
part 'src/clients/game_summary_client.dart';
part 'src/clients/games_client.dart';
part 'src/clients/hms_gameservice_logger.dart';
part 'src/clients/jos_apps_client.dart';
part 'src/clients/players_client.dart';
part 'src/clients/ranking_client.dart';
part 'src/clients/utils.dart';
part 'src/constants/archive_constants.dart';
part 'src/constants/constants.dart';
part 'src/constants/game_scopes.dart';
part 'src/constants/game_service_result_codes.dart';
part 'src/model/achievement.dart';
part 'src/model/apk_upgrade_info.dart';
part 'src/model/app_player_info.dart';
part 'src/model/archive.dart';
part 'src/model/archive_details.dart';
part 'src/model/archive_summary.dart';
part 'src/model/archive_summary_update.dart';
part 'src/model/check_update_callback.dart';
part 'src/model/difference.dart';
part 'src/model/game_event.dart';
part 'src/model/game_player_statistics.dart';
part 'src/model/game_summary.dart';
part 'src/model/game_trial_process.dart';
part 'src/model/operation_result.dart';
part 'src/model/player.dart';
part 'src/model/player_extra_info.dart';
part 'src/model/product_order_info.dart';
part 'src/model/ranking.dart';
part 'src/model/ranking_score.dart';
part 'src/model/ranking_scores.dart';
part 'src/model/ranking_variant.dart';
part 'src/model/score_submission_info.dart';
part 'src/model/submission_score_result.dart';
part 'src/model/update_info.dart';
