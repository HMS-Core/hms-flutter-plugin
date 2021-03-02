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

import 'package:huawei_gameservice/constants/constants.dart';
import 'package:huawei_gameservice/model/game_summary.dart';

/// Provides APIs for obtaining game information.
class GameSummaryClient {
  static String _clientName = "GameSummaryClient.";

  /// Obtains the information about the current game from the local cache.
  static Future<GameSummary> getLocalGameSummary() async {
    final response =
        await channel.invokeMethod(_clientName + "getLocalGameSummary");

    return GameSummary.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains the information about the current game from Huawei game server.
  /// If the obtaining fails, the information will then be obtained from the local cache.
  static Future<GameSummary> getGameSummary() async {
    final response = await channel.invokeMethod(_clientName + "getGameSummary");

    return GameSummary.fromMap(Map<String, dynamic>.from(response));
  }
}
