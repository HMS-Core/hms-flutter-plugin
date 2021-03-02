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

import 'package:huawei_gameservice/model/player.dart';

/// A class that includes the details about a score on a leaderboard
/// when the score obtaining method of [RankingsClient] is called.
class RankingScore {
  /// Constant returned when no rank is returned.
  static const int RANK_UNKNOWN = -1;

  /// Localized rank of a score on a leaderboard.
  String displayRank;

  /// Score displayed on a leaderboard.
  String rankingDisplayScore;

  /// Rank of a score on a leaderboard.
  int playerRank;

  /// Raw value of a score.
  int playerRawScore;

  /// Information about the player who achieved a specified score.
  ///
  /// Player information includes only the player nickname and profile picture information.
  /// That is, only the [displayName], [hiResImageUri], and [iconImageUri] methods have values.
  Player scoreOwnerPlayer;

  /// Nickname of the player with the score.
  /// If the player's identity is unknown, an anonymous name is returned.
  String scoreOwnerDisplayName;

  /// URI of the HD profile picture of a player.
  /// If no URI is available, null is returned.
  String scoreOwnerHiIconUri;

  /// URI of the icon-size profile picture of a player.
  /// If no URI is available, null is returned.
  String scoreOwnerIconUri;

  /// Custom unit of a score.
  String scoreTips;

  /// Timestamp when the player achieved a specified score.
  int scoreTimestamp;

  /// Time frame that a player's rank is drawn from. The options are as follows:
  /// 0: daily
  /// 1: weekly
  /// 2: all-time
  int timeDimension;

  RankingScore({
    this.displayRank,
    this.rankingDisplayScore,
    this.playerRank,
    this.playerRawScore,
    this.scoreOwnerPlayer,
    this.scoreOwnerDisplayName,
    this.scoreOwnerHiIconUri,
    this.scoreOwnerIconUri,
    this.scoreTips,
    this.scoreTimestamp,
    this.timeDimension,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayRank': displayRank,
      'rankingDisplayScore': rankingDisplayScore,
      'playerRank': playerRank,
      'playerRawScore': playerRawScore,
      'scoreOwnerPlayer': scoreOwnerPlayer?.toMap(),
      'scoreOwnerDisplayName': scoreOwnerDisplayName,
      'scoreOwnerHiIconUri': scoreOwnerHiIconUri,
      'scoreOwnerIconUri': scoreOwnerIconUri,
      'scoreTips': scoreTips,
      'scoreTimestamp': scoreTimestamp,
      'timeDimension': timeDimension,
    };
  }

  factory RankingScore.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RankingScore(
      displayRank: map['displayRank'],
      rankingDisplayScore: map['rankingDisplayScore'],
      playerRank: map['playerRank'],
      playerRawScore: map['playerRawScore'],
      scoreOwnerPlayer: map['scoreOwnerPlayer'] == null
          ? null
          : Player.fromMap(Map<String, dynamic>.from(map['scoreOwnerPlayer'])),
      scoreOwnerDisplayName: map['scoreOwnerDisplayName'],
      scoreOwnerHiIconUri: map['scoreOwnerHiIconUri'],
      scoreOwnerIconUri: map['scoreOwnerIconUri'],
      scoreTips: map['scoreTips'],
      scoreTimestamp: map['scoreTimestamp'],
      timeDimension: map['timeDimension'],
    );
  }

  @override
  String toString() {
    return 'RankingScore(displayRank: $displayRank, rankingDisplayScore: $rankingDisplayScore, playerRank: $playerRank, playerRawScore: $playerRawScore, scoreOwnerPlayer: $scoreOwnerPlayer, scoreOwnerDisplayName: $scoreOwnerDisplayName, scoreOwnerHiIconUri: $scoreOwnerHiIconUri, scoreOwnerIconUri: $scoreOwnerIconUri, scoreTips: $scoreTips, scoreTimestamp: $scoreTimestamp, timeDimension: $timeDimension)';
  }
}
