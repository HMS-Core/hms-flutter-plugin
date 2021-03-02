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

/// Basic game information.
class GameSummary {
  /// Total number of achievements in a game.
  final int achievementCount;

  /// App ID of a game.
  final String appId;

  /// Description of a game.
  final String descInfo;

  /// App name of a game.
  final String gameName;

  ///	URI of the HD image of a game.
  final String gameHdImgUri;

  /// URI of the icon image of a game.
  final String gameIconUri;

  /// Total number of leaderboards of a game.
  final int rankingCount;

  /// Level-1 category of a game.
  final String firstKind;

  /// Level-2 category of a game.
  final String secondKind;

  GameSummary._({
    this.achievementCount,
    this.appId,
    this.descInfo,
    this.gameName,
    this.gameHdImgUri,
    this.gameIconUri,
    this.rankingCount,
    this.firstKind,
    this.secondKind,
  });

  Map<String, dynamic> toMap() {
    return {
      'achievementCount': achievementCount,
      'appId': appId,
      'descInfo': descInfo,
      'gameName': gameName,
      'gameHdImgUri': gameHdImgUri,
      'gameIconUri': gameIconUri,
      'rankingCount': rankingCount,
      'firstKind': firstKind,
      'secondKind': secondKind,
    };
  }

  factory GameSummary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GameSummary._(
      achievementCount: map['achievementCount'],
      appId: map['appId'],
      descInfo: map['descInfo'],
      gameName: map['gameName'],
      gameHdImgUri: map['gameHdImgUri'],
      gameIconUri: map['gameIconUri'],
      rankingCount: map['rankingCount'],
      firstKind: map['firstKind'],
      secondKind: map['secondKind'],
    );
  }

  @override
  String toString() {
    return 'GameSummary(achievementCount: $achievementCount, appId: $appId, descInfo: $descInfo, gameName: $gameName, gameHdImgUri: $gameHdImgUri, gameIconUri: $gameIconUri, rankingCount: $rankingCount, firstKind: $firstKind, secondKind: $secondKind)';
  }
}
