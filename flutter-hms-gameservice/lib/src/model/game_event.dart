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

/// A class that includes the details about an event.
class GameEvent {
  /// Description of the current event.
  String? description;

  /// ID of the current event.
  String? eventId;

  /// Localized event value.
  String? localeValue;

  /// URI of an event icon.
  String? thumbnailUri;

  /// Name of the current event.
  String? name;

  /// A [Player] object that contains player information.
  Player? gamePlayer;

  /// Current event value of the current player.
  int? value;

  /// Whether to display an event.
  /// true: yes
  /// false: no
  bool? isVisible;

  GameEvent({
    this.description,
    this.eventId,
    this.localeValue,
    this.thumbnailUri,
    this.name,
    this.gamePlayer,
    this.value,
    this.isVisible,
  });

  factory GameEvent.fromMap(Map<dynamic, dynamic> map) {
    return GameEvent(
      description: map['description'],
      eventId: map['eventId'],
      localeValue: map['localeValue'],
      thumbnailUri: map['thumbnailUri'],
      name: map['name'],
      gamePlayer:
          map['gamePlayer'] != null ? Player.fromMap(map['gamePlayer']) : null,
      value: map['value'],
      isVisible: map['isVisible'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'eventId': eventId,
      'localeValue': localeValue,
      'thumbnailUri': thumbnailUri,
      'name': name,
      'gamePlayer': gamePlayer?.toMap(),
      'value': value,
      'isVisible': isVisible,
    };
  }

  @override
  String toString() {
    return '$GameEvent('
        'description: $description, '
        'eventId: $eventId, '
        'localeValue: $localeValue, '
        'thumbnailUri: $thumbnailUri, '
        'name: $name, '
        'gamePlayer: $gamePlayer, '
        'value: $value, '
        'isVisible: $isVisible)';
  }
}
