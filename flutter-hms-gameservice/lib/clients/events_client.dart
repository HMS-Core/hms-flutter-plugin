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
import 'package:huawei_gameservice/model/game_event.dart';

/// Provides APIs related to event management,
/// such as submitting event data and obtaining the event data of the current player.
class EventsClient {
  static String _clientName = "EventsClient.";

  /// Submits the event data of the current player.
  static Future<void> grow(String eventId, int growAmount) async {
    await channel.invokeMethod(_clientName + "grow",
        removeNulls({"eventId": eventId, "growAmount": growAmount}));
  }

  /// Obtains all event data of the current player.
  static Future<List<GameEvent>> getEventList(bool forceReload) async {
    final response = await channel.invokeMethod(_clientName + "getEventList",
        removeNulls({"forceReload": forceReload}));

    return List<GameEvent>.from(
        response.map((x) => GameEvent.fromMap(Map<String, dynamic>.from(x))));
  }

  /// Obtains the event data of the current player by event ID.
  static Future<List<GameEvent>> getEventListByIds(bool forceReload,
      {List<String> eventIds}) async {
    final response = await channel.invokeMethod(
        _clientName + "getEventListByIds",
        removeNulls({"forceReload": forceReload, "eventIds": eventIds}));

    return List<GameEvent>.from(
        response.map((x) => GameEvent.fromMap(Map<String, dynamic>.from(x))));
  }
}
