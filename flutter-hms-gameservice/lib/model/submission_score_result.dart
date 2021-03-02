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

/// A class that includes the information about a submitted score on a leaderboard.
class SubmissionScoreResult {
  /// Localized score on a leaderboard.
  String displayScore;

  /// Indicates whether the score is the best score ever achieved by the player.
  bool isBest;

  /// Raw value of a submitted score.
  int playerRawScore;

  /// Custom unit of a submitted score.
  /// If no custom unit is defined, null is returned.
  String scoreTips;

  SubmissionScoreResult({
    this.displayScore,
    this.isBest,
    this.playerRawScore,
    this.scoreTips,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayScore': displayScore,
      'isBest': isBest,
      'rawScore': playerRawScore,
      'scoreTips': scoreTips,
    };
  }

  factory SubmissionScoreResult.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubmissionScoreResult(
      displayScore: map['displayScore'],
      isBest: map['isBest'],
      playerRawScore: map['playerRawScore'],
      scoreTips: map['scoreTips'],
    );
  }

  @override
  String toString() {
    return 'SubmissionScoreResult(displayScore: $displayScore, isBest: $isBest, playerRawScore: $playerRawScore, scoreTips: $scoreTips)';
  }
}
