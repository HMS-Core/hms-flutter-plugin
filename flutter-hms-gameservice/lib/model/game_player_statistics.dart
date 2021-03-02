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

/// A class that includes the statistics information of a player
/// when the [getGamePlayerStatistics] method of [GamePlayerStatisticsClient] is called.
class GamePlayerStatistics {
  /// Average session duration of a player, in minutes.
  double averageOnLineMinutes;

  /// Number of days elapsed since a player last played.
  int daysFromLastGame;

  /// Number of in-app purchases for a player.
  int paymentTimes;

  /// Number of sessions for a player.
  int onlineTimes;

  /// Spending rank of a player. The options are as follows:
  /// 1: no spending
  /// 2: less than US$10
  /// 3: US$10 or more and less than US$50
  /// 4: US$50 or more and less than US$300
  /// 5: US$300 or more and less than US$1000
  /// 6: more than US$1000
  int totalPurchasesAmountRange;

  GamePlayerStatistics({
    this.averageOnLineMinutes,
    this.daysFromLastGame,
    this.paymentTimes,
    this.onlineTimes,
    this.totalPurchasesAmountRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'averageOnLineMinutes': averageOnLineMinutes,
      'daysFromLastGame': daysFromLastGame,
      'paymentTimes': paymentTimes,
      'onlineTimes': onlineTimes,
      'totalPurchasesAmountRange': totalPurchasesAmountRange,
    };
  }

  factory GamePlayerStatistics.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GamePlayerStatistics(
      averageOnLineMinutes: map['averageOnLineMinutes'],
      daysFromLastGame: map['daysFromLastGame'],
      paymentTimes: map['paymentTimes'],
      onlineTimes: map['onlineTimes'],
      totalPurchasesAmountRange: map['totalPurchasesAmountRange'],
    );
  }

  @override
  String toString() {
    return 'GamePlayerStatistics(averageOnLineMinutes: $averageOnLineMinutes, daysFromLastGame: $daysFromLastGame, paymentTimes: $paymentTimes, onlineTimes: $onlineTimes, totalPurchasesAmountRange: $totalPurchasesAmountRange)';
  }
}
