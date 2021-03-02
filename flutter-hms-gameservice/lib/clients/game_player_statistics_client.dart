/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_gameservice/clients/utils.dart';
import 'package:huawei_gameservice/constants/constants.dart';
import 'package:huawei_gameservice/model/game_player_statistics.dart';

/// Provides APIs related to player information statistics.
class GamePlayerStatisticsClient {
  static String _clientName = "GamePlayerStatisticsClient.";

  /// Obtains the statistics of the current player, such as the session duration and rank.
  static Future<GamePlayerStatistics> getGamePlayerStatistics(
      bool isRealTime) async {
    final response = await channel.invokeMethod(
        _clientName + "getGamePlayerStatistics",
        removeNulls({"isRealTime": isRealTime}));

    return GamePlayerStatistics.fromMap(Map<String, dynamic>.from(response));
  }
}
