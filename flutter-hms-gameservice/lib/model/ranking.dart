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

import 'ranking_variant.dart';

/// A class that includes the leaderboard data when the
/// [getRankingSummary] method of [RankingsClient] is called.
class Ranking {
  /// Ordering mode of scores. A larger score is better.
  static const int SCORE_VALUE_HIGH_BETTER = 1;

  /// Ordering mode of scores. A smaller score is better.
  static const int SCORE_VALUE_SMALL_BETTER = 0;

  /// Display name of a leaderboard.
  String rankingDisplayName;

  /// URI of a leaderboard icon.
  String rankingImageUri;

  /// Leaderboard ID allocated by AppGallery Connect when creating a leaderboard.
  String rankingId;

  /// Ordering mode of scores.
  ///
  /// SCORE_VALUE_HIGH_BETTER(1): A larger score is better.
  /// SCORE_VALUE_SMALL_BETTER(0): A smaller score is better.
  int rankingScoreOrder;

  /// A [RankingVariant] object by time frame (daily, weekly, and all-time),
  /// including the scores of the current player in the three time frames.
  List<RankingVariant> rankingVariants;

  Ranking({
    this.rankingDisplayName,
    this.rankingImageUri,
    this.rankingId,
    this.rankingScoreOrder,
    this.rankingVariants,
  });

  Map<String, dynamic> toMap() {
    return {
      'rankingDisplayName': rankingDisplayName,
      'rankingImageUri': rankingImageUri,
      'rankingId': rankingId,
      'rankingScoreOrder': rankingScoreOrder,
      'rankingVariants': rankingVariants?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Ranking.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Ranking(
      rankingDisplayName: map['rankingDisplayName'],
      rankingImageUri: map['rankingImageUri'],
      rankingId: map['rankingId'],
      rankingScoreOrder: map['rankingScoreOrder'],
      rankingVariants: map['rankingVariants'] == null
          ? null
          : List<RankingVariant>.from(map['rankingVariants']?.map(
              (x) => RankingVariant.fromMap(Map<String, dynamic>.from(x)))),
    );
  }

  @override
  String toString() {
    return 'Ranking(rankingDisplayName: $rankingDisplayName, rankingImageUri: $rankingImageUri, rankingId: $rankingId, rankingScoreOrder: $rankingScoreOrder, rankingVariants: $rankingVariants)';
  }
}
