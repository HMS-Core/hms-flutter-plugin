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

/// A class that includes the score information of the current player
/// on the leaderboard in a specified time frame
class RankingVariant {
  /// Unknown total score on a leaderboard.
  static const int NUM_SCORES_UNKNOWN = -1;

  /// Unknown rank of a player on a leaderboard.
  static const int PLAYER_RANK_UNKNOWN = -2;

  /// Unknown score of a player.
  static const int PLAYER_SCORE_UNKNOWN = -3;

  /// Number of time frames of a leaderboard.
  static const int NUM_TIME_DIMENSION = 3;

  /// Daily leaderboard.
  static const int TIME_DIMENSION_DAILY = 0;

  /// Weekly leaderboard.
  static const int TIME_DIMENSION_WEEKLY = 1;

  /// All-time leaderboard.
  static const int TIME_DIMENSION_ALL_TIME = 2;

  /// Indicates the localized number corresponding to a player's rank to be displayed.
  /// The number is returned only when hasPlayerInfo field is true.
  String displayRanking;

  /// Indicates the localized number corresponding to a player's score to be displayed.
  /// The number is returned only when hasPlayerInfo field is true.
  String playerDisplayScore;

  /// Total score on a leaderboard.
  int rankTotalScoreNum;

  /// Indicates the player's rank on a leaderboard.
  /// The number is returned only when hasPlayerInfo field is true.
  int playerRank;

  /// Custom unit for a player's score.
  /// The number is returned only when hasPlayerInfo field is true.
  String playerScoreTips;

  /// Raw score of a player.
  /// The number is returned only when hasPlayerInfo field is true.
  int playerRawScore;

  /// Time frame. The options are as follows:
  /// 0: daily
  /// 1: weekly
  /// 2: all-time
  int timeDimension;

  /// Indicates whether the current player exists on the leaderboard.
  bool hasPlayerInfo;

  RankingVariant({
    this.displayRanking,
    this.playerDisplayScore,
    this.rankTotalScoreNum,
    this.playerRank,
    this.playerScoreTips,
    this.playerRawScore,
    this.timeDimension,
    this.hasPlayerInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayRanking': displayRanking,
      'playerDisplayScore': playerDisplayScore,
      'rankTotalScoreNum': rankTotalScoreNum,
      'playerRank': playerRank,
      'playerScoreTips': playerScoreTips,
      'playerRawScore': playerRawScore,
      'timeDimension': timeDimension,
      'hasPlayerInfo': hasPlayerInfo,
    };
  }

  factory RankingVariant.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RankingVariant(
      displayRanking: map['displayRanking'],
      playerDisplayScore: map['playerDisplayScore'],
      rankTotalScoreNum: map['rankTotalScoreNum'],
      playerRank: map['playerRank'],
      playerScoreTips: map['playerScoreTips'],
      playerRawScore: map['playerRawScore'],
      timeDimension: map['timeDimension'],
      hasPlayerInfo: map['hasPlayerInfo'],
    );
  }

  @override
  String toString() {
    return 'RankingVariant(displayRanking: $displayRanking, playerDisplayScore: $playerDisplayScore, rankTotalScoreNum: $rankTotalScoreNum, playerRank: $playerRank, playerScoreTips: $playerScoreTips, playerRawScore: $playerRawScore, timeDimension: $timeDimension, hasPlayerInfo: $hasPlayerInfo)';
  }
}
