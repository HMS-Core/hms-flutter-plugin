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

/// A class that includes the details about an achievement.
class Achievement {
  /// Achievement ID string.
  String id;

  /// Number of steps that the player has gone toward unlocking the achievement.
  int reachedSteps;

  /// Description of the achievement.
  String descInfo;

  /// Localized number of steps that the player has gone toward unlocking the achievement.
  String localeReachedSteps;

  /// Localized total number of steps required for unlocking the achievement.
  String localeAllSteps;

  /// Timestamp when the achievement is updated the last time, that is, number of milliseconds
  /// between the last achievement update time and 00:00:00 on January 1, 1970.
  int recentUpdateTime;

  /// Achievement name.
  String displayName;

  /// A [Player] object that contains player information.
  Player gamePlayer;

  /// URI that can be used to load the achievement icon after the achievement is revealed.
  String visualizedThumbnailUri;

  /// Achievement status.
  /// 1: The achievement is revealed.
  /// 2: The achievement is hidden.
  /// 3: The achievement is unlocked.
  int state;

  /// Total number of steps required for unlocking the achievement.
  int allSteps;

  /// Achievement type.
  /// 1: standard achievement without steps
  /// 2: incremental achievement with steps
  int type;

  /// URI that can be used to load the achievement icon after the achievement is unlocked.
  String reachedThumbnailUri;

  Achievement({
    this.id,
    this.reachedSteps,
    this.descInfo,
    this.localeReachedSteps,
    this.localeAllSteps,
    this.recentUpdateTime,
    this.displayName,
    this.gamePlayer,
    this.visualizedThumbnailUri,
    this.state,
    this.allSteps,
    this.type,
    this.reachedThumbnailUri,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reachedSteps': reachedSteps,
      'descInfo': descInfo,
      'localeReachedSteps': localeReachedSteps,
      'localeAllSteps': localeAllSteps,
      'recentUpdateTime': recentUpdateTime,
      'displayName': displayName,
      'gamePlayer': gamePlayer?.toMap(),
      'visualizedThumbnailUri': visualizedThumbnailUri,
      'state': state,
      'allSteps': allSteps,
      'type': type,
      'reachedThumbnailUri': reachedThumbnailUri,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Achievement(
      id: map['id'],
      reachedSteps: map['reachedSteps'],
      descInfo: map['descInfo'],
      localeReachedSteps: map['localeReachedSteps'],
      localeAllSteps: map['localeAllSteps'],
      recentUpdateTime: map['recentUpdateTime'],
      displayName: map['displayName'],
      gamePlayer: map['gamePlayer'] == null
          ? null
          : Player.fromMap(Map<String, dynamic>.from(map['gamePlayer'])),
      visualizedThumbnailUri: map['visualizedThumbnailUri'],
      state: map['state'],
      allSteps: map['allSteps'],
      type: map['type'],
      reachedThumbnailUri: map['reachedThumbnailUri'],
    );
  }

  @override
  String toString() {
    return 'Achievement(id: $id, reachedSteps: $reachedSteps, descInfo: $descInfo, localeReachedSteps: $localeReachedSteps, localeAllSteps: $localeAllSteps, recentUpdateTime: $recentUpdateTime, displayName: $displayName, gamePlayer: $gamePlayer, visualizedThumbnailUri: $visualizedThumbnailUri, state: $state, allSteps: $allSteps, type: $type, reachedThumbnailUri: $reachedThumbnailUri)';
  }
}
