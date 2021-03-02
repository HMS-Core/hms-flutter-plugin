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

import 'ranking.dart';
import 'ranking_score.dart';

/// A class that includes the information about a leaderboard
/// and the list of scores on the leaderboard.
class RankingScores {
  /// Leaderboard information.
  Ranking ranking;

  /// All scores on a leaderboard.
  List<RankingScore> rankingScores;

  RankingScores({
    this.ranking,
    this.rankingScores,
  });

  Map<String, dynamic> toMap() {
    return {
      'ranking': ranking?.toMap(),
      'rankingScores': rankingScores?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory RankingScores.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RankingScores(
      ranking: map['ranking'] == null
          ? null
          : Ranking.fromMap(Map<String, dynamic>.from(map['ranking'])),
      rankingScores: map['rankingScores'] == null
          ? null
          : List<RankingScore>.from(map['rankingScores']
              ?.map((x) => RankingScore.fromMap(Map<String, dynamic>.from(x)))),
    );
  }

  @override
  String toString() =>
      'RankingScores(ranking: $ranking, rankingScores: $rankingScores)';
}
