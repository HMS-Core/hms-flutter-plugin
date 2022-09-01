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

part of huawei_gameservice;

/// Provides APIs for obtaining game information.
abstract class GameSummaryClient {
  /// Obtains the information about the current game from the local cache.
  static Future<GameSummary> getLocalGameSummary() async {
    final dynamic response = await _channel.invokeMethod(
      'GameSummaryClient.getLocalGameSummary',
    );
    return GameSummary.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the information about the current game from Huawei game server.
  /// If the obtaining fails, the information will then be obtained from the local cache.
  static Future<GameSummary> getGameSummary() async {
    final dynamic response = await _channel.invokeMethod(
      'GameSummaryClient.getGameSummary',
    );
    return GameSummary.fromMap(Map<dynamic, dynamic>.from(response));
  }
}
