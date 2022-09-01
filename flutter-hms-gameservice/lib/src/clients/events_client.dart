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

/// Provides APIs related to event management,
/// such as submitting event data and obtaining the event data of the current player.
abstract class EventsClient {
  /// Submits the event data of the current player.
  static Future<void> grow(String eventId, int growAmount) async {
    await _channel.invokeMethod(
      'EventsClient.grow',
      <String, dynamic>{
        'eventId': eventId,
        'growAmount': growAmount,
      },
    );
  }

  /// Obtains all event data of the current player.
  static Future<List<GameEvent>> getEventList(bool forceReload) async {
    final dynamic response = await _channel.invokeMethod(
      'EventsClient.getEventList',
      <String, dynamic>{
        'forceReload': forceReload,
      },
    );
    return List<GameEvent>.from(
      response.map(
        (dynamic x) => GameEvent.fromMap(
          Map<dynamic, dynamic>.from(x),
        ),
      ),
    );
  }

  /// Obtains the event data of the current player by event ID.
  static Future<List<GameEvent>> getEventListByIds(
    bool forceReload, {
    List<String>? eventIds,
  }) async {
    final dynamic response = await _channel.invokeMethod(
      'EventsClient.getEventListByIds',
      removeNulls(
        <String, dynamic>{
          'forceReload': forceReload,
          'eventIds': eventIds,
        },
      ),
    );
    return List<GameEvent>.from(
      response.map(
        (dynamic x) => GameEvent.fromMap(
          Map<dynamic, dynamic>.from(x),
        ),
      ),
    );
  }
}
