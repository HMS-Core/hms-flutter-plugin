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

/// Provides APIs related to leaderboard management, for example,
/// APIs for obtaining leaderboard data and setting the leaderboard switch.
abstract class RankingClient {
  /// Opens the leaderboard list page.
  static Future<void> showTotalRankingsIntent() async {
    return _channel.invokeMethod(
      'RankingsClient.getTotalRankingsIntent',
    );
  }

  /// Opens the page for a specified leaderboard in a specified time frame.
  static Future<void> showRankingIntent(
    String rankingId, {
    int? timeDimension,
  }) async {
    _channel.invokeMethod(
      'RankingsClient.getRankingIntent',
      removeNulls(
        <String, dynamic>{
          'rankingId': rankingId,
          'timeDimension': timeDimension,
        },
      ),
    );
  }

  /// Obtains the score of a player on a specified leaderboard in a specified time frame.
  static Future<RankingScore> getCurrentPlayerRankingScore(
    String rankingId,
    int timeDimension,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getCurrentPlayerRankingScore',
      <String, dynamic>{
        'rankingId': rankingId,
        'timeDimension': timeDimension,
      },
    );
    return RankingScore.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the data of a leaderboard. The data can be obtained from the local cache.
  static Future<Ranking> getRankingSummary(
    String rankingId,
    bool isRealTime,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getRankingSummary',
      <String, dynamic>{
        'rankingId': rankingId,
        'isRealtime': isRealTime,
      },
    );
    return Ranking.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains all leaderboard data. The data can be obtained from the local cache.
  static Future<List<Ranking>> getAllRankingSummaries(bool isRealTime) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getAllRankingSummaries',
      removeNulls(
        <String, dynamic>{
          'isRealTime': isRealTime,
        },
      ),
    );
    return List<Ranking>.from(
      response.map(
        (dynamic x) => Ranking.fromMap(
          Map<dynamic, dynamic>.from(x),
        ),
      ),
    ).toList();
  }

  /// Obtains scores on a leaderboard in a specified time frame in pagination mode.
  static Future<RankingScores> getMoreRankingScores(
    String rankingId,
    int offsetPlayerRank,
    int maxResults,
    int pageDirection,
    int timeDimension,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getMoreRankingScores',
      <String, dynamic>{
        'rankingId': rankingId,
        'offsetPlayerRank': offsetPlayerRank,
        'maxResults': maxResults,
        'pageDirection': pageDirection,
        'timeDimension': timeDimension,
      },
    );
    return RankingScores.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains scores of a leaderboard with the current player's score displayed
  /// in the page center from Huawei game server.
  static Future<RankingScores> getPlayerCenteredRankingScores(
    String rankingId,
    int timeDimension,
    int maxResults,
    int offsetPlayerRank,
    int pageDirection,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getPlayerCenteredRankingScores',
      <String, dynamic>{
        'rankingId': rankingId,
        'maxResults': maxResults,
        'timeDimension': timeDimension,
        'offsetPlayerRank': offsetPlayerRank,
        'pageDirection': pageDirection,
      },
    );
    return RankingScores.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains scores of a leaderboard with the current player's score displayed in the page center.
  ///
  /// The data can be obtained from the local cache.
  static Future<RankingScores> getRealTimePlayerCenteredRankingScores(
    String rankingId,
    int timeDimension,
    int maxResults,
    bool isRealTime,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getPlayerCenteredRankingScores',
      <String, dynamic>{
        'rankingId': rankingId,
        'maxResults': maxResults,
        'timeDimension': timeDimension,
        'isRealTime': isRealTime,
      },
    );
    return RankingScores.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the scores on the first page of a leaderboard from Huawei game server.
  static Future<RankingScores> getRankingTopScores(
    String rankingId,
    int timeDimension,
    int maxResults,
    int offsetPlayerRank,
    int pageDirection,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getRankingTopScores',
      <String, dynamic>{
        'rankingId': rankingId,
        'timeDimension': timeDimension,
        'maxResults': maxResults,
        'offsetPlayerRank': offsetPlayerRank,
        'pageDirection': pageDirection,
      },
    );
    return RankingScores.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains scores on the first page of a leaderboard.
  ///
  /// The data can be obtained from the local cache.
  static Future<RankingScores> getRealTimeRankingTopScores(
    String rankingId,
    int timeDimension,
    int maxResults,
    bool isRealTime,
  ) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.getRankingTopScores',
      <String, dynamic>{
        'rankingId': rankingId,
        'timeDimension': timeDimension,
        'maxResults': maxResults,
        'isRealTime': isRealTime,
      },
    );
    return RankingScores.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Asynchronously submits the score of the current player with a custom unit.
  static Future<void> submitRankingScores(
    String rankingId,
    int score, {
    String? scoreTips,
  }) async {
    await _channel.invokeMethod(
      'RankingsClient.submitRankingScores',
      removeNulls(
        <String, dynamic>{
          'rankingId': rankingId,
          'score': score,
          'scoreTips': scoreTips,
        },
      ),
    );
  }

  /// Synchronously submits the score of the current player with a custom unit.
  static Future<ScoreSubmissionInfo> submitScoreWithResult(
    String rankingId,
    int score, {
    String? scoreTips,
  }) async {
    final dynamic response = await _channel.invokeMethod(
      'RankingsClient.submitScoreWithResult',
      removeNulls(
        <String, dynamic>{
          'rankingId': rankingId,
          'score': score,
          'scoreTips': scoreTips,
        },
      ),
    );
    return ScoreSubmissionInfo.fromMap(Map<dynamic, dynamic>.from(response));
  }

  /// Obtains the current player's leaderboard switch setting.
  static Future<int> getRankingSwitchStatus() async {
    return await _channel.invokeMethod(
      'RankingsClient.getRankingSwitchStatus',
    );
  }

  /// Sets the leaderboard switch for the current player.
  static Future<int> setRankingSwitchStatus(int status) async {
    return await _channel.invokeMethod(
      'RankingsClient.setRankingSwitchStatus',
      <String, dynamic>{
        'status': status,
      },
    );
  }
}
