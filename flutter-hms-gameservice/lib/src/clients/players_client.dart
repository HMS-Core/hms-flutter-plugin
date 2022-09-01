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

/// Provides APIs for obtaining player information.
abstract class PlayersClient {
  /// Obtains the Player object of the current player. Only getOpenId, getUnionId, getAccessToken,
  /// and getOpenIdSign in the Player object returned by the AppTouch business have values.
  static Future<Player> getCurrentPlayer() async {
    final dynamic response = await _channel.invokeMethod(
      'PlayersClient.getCurrentPlayer',
    );
    return Player.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the Player object of the current player. In the returned Player object, only the getDisplayName, getOpenId,
  /// getUnionId, and getAccessToken methods have return values. For other methods, a null value is returned.
  static Future<Player> getGamePlayer({
    bool? isRequirePlayerId,
  }) async {
    final dynamic response = await _channel.invokeMethod(
      'PlayersClient.getGamePlayer',
      removeNulls(
        <String, dynamic>{
          'isRequirePlayerId': isRequirePlayerId,
        },
      ),
    );
    return Player.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the locally cached player ID of the current player.
  static Future<String> getCachePlayerId() async {
    return await _channel.invokeMethod(
      'PlayersClient.getCachePlayerId',
    );
  }

  /// Obtains the additional information about a player.
  static Future<PlayerExtraInfo> getPlayerExtraInfo(
    String transactionId,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'PlayersClient.getPlayerExtraInfo',
      <String, dynamic>{
        'transactionId': transactionId,
      },
    );
    return PlayerExtraInfo.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Reports player behavior events.
  static Future<String> submitPlayerEvent(
    String eventId,
    String eventType, {
    String? playerId,
  }) async {
    return await _channel.invokeMethod(
      'PlayersClient.submitPlayerEvent',
      removeNulls(
        <String, dynamic>{
          'eventId': eventId,
          'eventType': eventType,
          'playerId': playerId,
        },
      ),
    );
  }

  /// Saves the information about the player in the current game.
  static Future<void> savePlayerInfo(AppPlayerInfo appPlayerInfo) async {
    return await _channel.invokeMethod(
      'PlayersClient.savePlayerInfo',
      <String, dynamic>{
        ...appPlayerInfo.toMap(),
      },
    );
  }

  /// Listens to trial duration expiration.
  static Future<void> setGameTrialProcess(
    GameTrialProcess processCallback,
  ) async {
    _channel.setMethodCallHandler(
      (MethodCall call) => gameTrialProcessHandler(processCallback, call),
    );
    return await _channel.invokeMethod(
      'PlayersClient.setGameTrialProcess',
    );
  }

  /// Method handler for gameTrialProcess callback.
  static Future<void> gameTrialProcessHandler(
    GameTrialProcess process,
    MethodCall call,
  ) async {
    if (call.method == 'gameTrialCallback#onTrialTimeout') {
      return process.onTrialTimeOut();
    } else if (call.method == 'gameTrialCallback#onCheckRealNameResult') {
      return process.onCheckRealNameResult(call.arguments);
    }
  }
}
