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

/// A class that includes the additional information of a player
/// when the [getPlayerExtraInfo] method of [PlayersClient] is called.
class PlayerExtraInfo {
  /// Indicates whether a player is an adult.
  bool isAdult;

  /// ID of the current player.
  String playerId;

  /// OpenId of the current player.
  String openId;

  /// Played time of a player on the current day, in minutes.
  /// If the time is less than 1 minute, 1 minute is returned.
  int playerDuration;

  /// Indicates whether a player is a real-name player.
  bool isRealName;

  PlayerExtraInfo({
    this.isAdult,
    this.playerId,
    this.openId,
    this.playerDuration,
    this.isRealName,
  });

  Map<String, dynamic> toMap() {
    return {
      'isAdult': isAdult,
      'playerId': playerId,
      'openId': openId,
      'playerDuration': playerDuration,
      'isRealName': isRealName,
    };
  }

  factory PlayerExtraInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PlayerExtraInfo(
      isAdult: map['isAdult'],
      playerId: map['playerId'],
      openId: map['openId'],
      playerDuration: map['playerDuration'],
      isRealName: map['isRealName'],
    );
  }

  @override
  String toString() {
    return 'PlayerExtraInfo(isAdult: $isAdult, playerId: $playerId, openId: $openId, playerDuration: $playerDuration, isRealName: $isRealName)';
  }
}
