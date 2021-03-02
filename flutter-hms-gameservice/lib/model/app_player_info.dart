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

/// A class that includes the in-game information for the current player,
/// such as the level, role, and server region,
/// for you to use when calling the savePlayerInfo method of PlayersClient.
class AppPlayerInfo {
  /// Level of a player in a game.
  String rank;

  /// Role of a player in a game.
  String role;

  /// Server region of a player in a game.
  String area;

  /// Guild information of a player in a game.
  String society;

  /// ID of a player in a game.
  String playerId;

  /// OpenId of a player in a game. A user has different OpenIds across apps.
  /// If you use an OpenId to identify a user, the same HUAWEI ID may be
  /// identified as different users in your apps.
  String openId;

  AppPlayerInfo(
      {this.rank,
      this.role,
      this.area,
      this.society,
      this.playerId,
      this.openId});

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'role': role,
      'area': area,
      'society': society,
      'playerId': playerId,
      'openId': openId,
    };
  }

  factory AppPlayerInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppPlayerInfo(
      rank: map['rank'],
      role: map['role'],
      area: map['area'],
      society: map['society'],
      playerId: map['playerId'],
      openId: map['openId'],
    );
  }

  @override
  String toString() {
    return 'AppPlayerInfo(rank: $rank, role: $role, area: $area, society: $society, playerId: $playerId, openId: $openId)';
  }
}
