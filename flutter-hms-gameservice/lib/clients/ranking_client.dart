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

import 'package:huawei_gameservice/clients/utils.dart';
import 'package:huawei_gameservice/constants/constants.dart';
import 'package:huawei_gameservice/model/model_export.dart';

/// Provides APIs related to leaderboard management, for example,
/// APIs for obtaining leaderboard data and setting the leaderboard switch.
class RankingClient {
  static String _clientName = "RankingsClient.";

  /// Opens the leaderboard list page.
  static Future<void> showTotalRankingsIntent() async {
    return channel.invokeMethod(_clientName + "getTotalRankingsIntent");
  }

  /// Opens the page for a specified leaderboard in a specified time frame.
  static Future<void> showRankingIntent(String rankingId,
      {int timeDimension}) async {
    channel.invokeMethod(_clientName + "getRankingIntent",
        removeNulls({"rankingId": rankingId, "timeDimension": timeDimension}));
  }

  /// Obtains the score of a player on a specified leaderboard in a specified time frame.
  static Future<RankingScore> getCurrentPlayerRankingScore(
      String rankingId, int timeDimension) async {
    final response = await channel.invokeMethod(
        _clientName + "getCurrentPlayerRankingScore",
        removeNulls({"rankingId": rankingId, "timeDimension": timeDimension}));

    return RankingScore.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains the data of a leaderboard. The data can be obtained from the local cache.
  static Future<Ranking> getRankingSummary(
      String rankingId, bool isRealTime) async {
    final response = await channel.invokeMethod(
        _clientName + "getRankingSummary",
        removeNulls({"rankingId": rankingId, "isRealtime": isRealTime}));

    return Ranking.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains all leaderboard data. The data can be obtained from the local cache.
  static Future<List<Ranking>> getAllRankingSummaries(bool isRealTime) async {
    final response = await channel.invokeMethod(
        _clientName + "getAllRankingSummaries",
        removeNulls({"isRealTime": isRealTime}));

    return List<Ranking>.from(
            response.map((x) => Ranking.fromMap(Map<String, dynamic>.from(x))))
        .toList();
  }

  /// Obtains scores on a leaderboard in a specified time frame in pagination mode.
  static Future<RankingScores> getMoreRankingScores(
      String rankingId,
      int offsetPlayerRank,
      int maxResults,
      int pageDirection,
      int timeDimension) async {
    final response = await channel.invokeMethod(
        _clientName + "getMoreRankingScores",
        removeNulls({
          "rankingId": rankingId,
          "offsetPlayerRank": offsetPlayerRank,
          "maxResults": maxResults,
          "pageDirection": pageDirection,
          "timeDimension": timeDimension
        }));

    return RankingScores.fromMap(Map<String, dynamic>.from(response));
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
    final response = await channel.invokeMethod(
        _clientName + "getPlayerCenteredRankingScores",
        removeNulls({
          "rankingId": rankingId,
          "maxResults": maxResults,
          "timeDimension": timeDimension,
          "offsetPlayerRank": offsetPlayerRank,
          "pageDirection": pageDirection
        }));

    return RankingScores.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains scores of a leaderboard with the current player's score displayed in the page center.
  ///
  /// The data can be obtained from the local cache.
  static Future<RankingScores> getRealTimePlayerCenteredRankingScores(
      String rankingId,
      int timeDimension,
      int maxResults,
      bool isRealTime) async {
    final response = await channel.invokeMethod(
        _clientName + "getPlayerCenteredRankingScores",
        removeNulls({
          "rankingId": rankingId,
          "maxResults": maxResults,
          "timeDimension": timeDimension,
          "isRealTime": isRealTime,
        }));

    return RankingScores.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains the scores on the first page of a leaderboard from Huawei game server.
  static Future<RankingScores> getRankingTopScores(
      String rankingId,
      int timeDimension,
      int maxResults,
      int offsetPlayerRank,
      int pageDirection) async {
    final response = await channel.invokeMethod(
        _clientName + "getRankingTopScores",
        removeNulls({
          "rankingId": rankingId,
          "timeDimension": timeDimension,
          "maxResults": maxResults,
          "offsetPlayerRank": offsetPlayerRank,
          "pageDirection": pageDirection
        }));

    return RankingScores.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains scores on the first page of a leaderboard.
  ///
  /// The data can be obtained from the local cache.
  static Future<RankingScores> getRealTimeRankingTopScores(String rankingId,
      int timeDimension, int maxResults, bool isRealTime) async {
    final response = await channel.invokeMethod(
        _clientName + "getRankingTopScores",
        removeNulls({
          "rankingId": rankingId,
          "timeDimension": timeDimension,
          "maxResults": maxResults,
          "isRealTime": isRealTime,
        }));

    return RankingScores.fromMap(Map<String, dynamic>.from(response));
  }

  /// Asynchronously submits the score of the current player with a custom unit.
  static Future<void> submitRankingScores(String rankingId, int score,
      {String scoreTips}) async {
    await channel.invokeMethod(
        _clientName + "submitRankingScores",
        removeNulls(
            {"rankingId": rankingId, "score": score, "scoreTips": scoreTips}));
  }

  /// Synchronously submits the score of the current player with a custom unit.
  static Future<ScoreSubmissionInfo> submitScoreWithResult(
      String rankingId, int score,
      {String scoreTips}) async {
    final response = await channel.invokeMethod(
        _clientName + "submitScoreWithResult",
        removeNulls(
            {"rankingId": rankingId, "score": score, "scoreTips": scoreTips}));

    return ScoreSubmissionInfo.fromMap(Map<String, dynamic>.from(response));
  }

  /// Obtains the current player's leaderboard switch setting.
  static Future<int> getRankingSwitchStatus() async {
    return await channel.invokeMethod(_clientName + "getRankingSwitchStatus");
  }

  /// Sets the leaderboard switch for the current player.
  static Future<int> setRankingSwitchStatus(int status) async {
    return await channel.invokeMethod(
        _clientName + "setRankingSwitchStatus", {"status": status});
  }
}
