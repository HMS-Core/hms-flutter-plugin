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

/// A class that includes the result of submitting a score to a leaderboard
/// when the [submitScoreWithResult] method of [RankingsClient] is called.
class ScoreSubmissionInfo {
  /// ID of the leaderboard to which a score is to be submitted.
  String? rankingId;

  /// ID of the player who has achieved a specified score.
  String? playerId;

  /// A Map object that includes the submission results by time frame.
  Map<int, dynamic>? _submissionScoreResult;

  ScoreSubmissionInfo._(
    this._submissionScoreResult, {
    this.rankingId,
    this.playerId,
  });

  factory ScoreSubmissionInfo.fromMap(Map<dynamic, dynamic> map) {
    return ScoreSubmissionInfo._(
      map['submissionScoreResult'] != null
          ? Map<int, dynamic>.from(map['submissionScoreResult'])
          : null,
      rankingId: map['rankingId'],
      playerId: map['playerId'],
    );
  }

  /// Obtains the submission result by time frame.
  SubmissionScoreResult? getSubmissionScoreResult(int timeDimension) {
    if (timeDimension < 0 || timeDimension > 2) {
      throw ArgumentError('Please provide valid time dimension');
    }
    if (_submissionScoreResult?.containsKey(timeDimension) ?? false) {
      final dynamic value = _submissionScoreResult![timeDimension]!;
      if (value is Map<dynamic, dynamic>) {
        return SubmissionScoreResult.fromMap(value);
      }
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rankingId': rankingId,
      'playerId': playerId,
      'submissionScoreResult': _submissionScoreResult?[2],
    };
  }

  @override
  String toString() {
    return '$ScoreSubmissionInfo('
        'rankingId: $rankingId, '
        'playerId: $playerId, '
        'submissionScoreResult: ${_submissionScoreResult?[2]})';
  }
}
