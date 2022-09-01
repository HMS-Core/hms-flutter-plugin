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

/// Provides APIs related to basic game functions, such as obtaining the app ID
/// and setting the position for displaying the game greeting pop-up on the screen.
abstract class GamesClient {
  /// Obtains the app ID of a game.
  static Future<String> getAppId() async {
    return await _channel.invokeMethod(
      'GamesClient.getAppId',
    );
  }

  /// Sets the position for displaying the game greeting and achievement unlocking pop-ups on the screen.
  static Future<void> setPopupsPosition(int position) async {
    return await _channel.invokeMethod(
      'GamesClient.setPopupsPosition',
      <String, dynamic>{
        'position': position,
      },
    );
  }

  /// Revokes the authorization to Huawei Game Service.
  static Future<bool> cancelGameService() async {
    return await _channel.invokeMethod(
      'GamesClient.cancelGameService',
    );
  }
}
