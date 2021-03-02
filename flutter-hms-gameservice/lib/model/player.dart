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

/// A class that includes the details about a player.
class Player {
  /// Player nickname displayed in the game.
  String displayName;

  /// URI of the HD profile picture of a player.
  /// If the player does not have an HD profile picture, this method returns null.
  String hiResImageUri;

  /// Obtains the URI of the icon-size profile picture of a player.
  /// The URI needs to be obtained only when the hasIconImage field is true.
  String iconImageUri;

  /// Obtains the player level information.
  ///
  /// Currently, this method can obtain only the level information for players
  /// registered in the Chinese mainland.
  /// For players registered outside the Chinese mainland, this method returns
  /// 1 by default.
  int level;

  /// Player ID.
  String playerId;

  /// Indicates whether a player has an HD profile picture.
  bool hasHiResImage;

  /// Indicates Whether a player has an icon-size profile picture.
  bool hasIconImage;

  /// Sign-in signature string.
  String playerSign;

  /// Timestamp string.
  ///
  /// By default, the timestamp is valid for five minutes. The sign-in signature
  /// must be verified when the timestamp is valid.
  /// Otherwise, the sign-in signature fails the verification.
  String signTs;

  /// OpenId of a player.
  String openId;

  /// UnionId of a player.
  String unionId;

  /// Access token of a player.
  String accessToken;

  /// Signature string.
  String openIdSign;

  Player({
    this.displayName,
    this.hiResImageUri,
    this.iconImageUri,
    this.level,
    this.playerId,
    this.hasHiResImage,
    this.hasIconImage,
    this.playerSign,
    this.signTs,
    this.openId,
    this.unionId,
    this.accessToken,
    this.openIdSign,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'hiResImageUri': hiResImageUri,
      'iconImageUri': iconImageUri,
      'level': level,
      'playerId': playerId,
      'hasHiResImage': hasHiResImage,
      'hasIcanImage': hasIconImage,
      'playerSign': playerSign,
      'signTs': signTs,
      'openId': openId,
      'unionId': unionId,
      'accessToken': accessToken,
      'openIdSign': openIdSign,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Player(
      displayName: map['displayName'],
      hiResImageUri: map['hiResImageUri'],
      iconImageUri: map['iconImageUri'],
      level: map['level'],
      playerId: map['playerId'],
      hasHiResImage: map['hasHiResImage'],
      hasIconImage: map['hasIcanImage'],
      playerSign: map['playerSign'],
      signTs: map['signTs'],
      openId: map['openId'],
      unionId: map['unionId'],
      accessToken: map['accessToken'],
      openIdSign: map['openIdSign'],
    );
  }

  @override
  String toString() {
    return 'Player(displayName: $displayName, hiResImageUri: $hiResImageUri, iconImageUri: $iconImageUri, level: $level, playerId: $playerId, hasHiResImage: $hasHiResImage, hasIcanImage: $hasIconImage, playerSign: $playerSign, signTs: $signTs, openId: $openId, unionId: $unionId, accessToken: $accessToken, openIdSign: $openIdSign)';
  }
}
