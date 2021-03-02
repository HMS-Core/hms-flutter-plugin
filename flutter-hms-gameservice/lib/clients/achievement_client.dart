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

import 'dart:async';

import 'package:huawei_gameservice/clients/utils.dart';
import 'package:huawei_gameservice/constants/constants.dart';
import 'package:huawei_gameservice/model/achievement.dart';

/// Provides APIs for achievement management, for example, obtaining the game achievement list,
/// incrementing an achievement, and setting steps required for unlocking an achievement.
class AchievementClient {
  static String _clientName = "AchievementClient.";

  /// Obtains the list of all game achievements of the current player.
  static Future<void> showAchievementListIntent() async {
    return await channel.invokeMethod(
      "AchievementClient.getShowAchievementListIntent",
    );
  }

  /// Asynchronously increases an achievement by the given number of steps.
  static Future<void> grow(String id, int numSteps) async {
    return await channel.invokeMethod(
        _clientName + "grow", removeNulls({"id": id, "numSteps": numSteps}));
  }

  /// Synchronously increases an achievement by the given number of steps.
  static Future<bool> growWithResult(String id, int numSteps) async {
    return await channel.invokeMethod(_clientName + "growWithResult",
        removeNulls({"id": id, "numSteps": numSteps}));
  }

  /// Obtains the list of achievements in all statuses for the current player.
  static Future<List<Achievement>> getAchievementList(bool forceReload) async {
    final response = await channel.invokeMethod(
      _clientName + "getAchievementList",
      removeNulls({"forceReload": forceReload}),
    );

    return List<Achievement>.from(response.map(
        (x) => Achievement.fromMap(Map<String, dynamic>.from(x)))).toList();
  }

  /// Asynchronously reveals a hidden achievement to the current player.
  static Future<void> visualize(String id) async {
    return await channel.invokeMethod(
        _clientName + "visualize", removeNulls({"id": id}));
  }

  /// Synchronously reveals a hidden achievement to the current player.
  static Future<void> visualizeWithResult(String id) async {
    return await channel.invokeMethod(
        _clientName + "visualizeWithResult", removeNulls({"id": id}));
  }

  /// Asynchronously sets an achievement to have the given number of steps completed.
  static Future<void> makeSteps(String id, int numSteps) async {
    return await channel.invokeMethod(_clientName + "makeSteps",
        removeNulls({"id": id, "numSteps": numSteps}));
  }

  /// Synchronously sets an achievement to have the given number of steps completed.
  static Future<bool> makeStepsWithResult(String id, int numSteps) async {
    return await channel.invokeMethod(_clientName + "makeStepsWithResult",
        removeNulls({"id": id, "numSteps": numSteps}));
  }

  /// Asynchronously unlocks an achievement for the current player.
  static Future<void> reach(String id) async {
    return await channel.invokeMethod(
        _clientName + "reach", removeNulls({"id": id}));
  }

  /// Synchronously unlocks an achievement for the current player.
  static Future<bool> reachWithResult(String id) async {
    return await channel.invokeMethod(
        _clientName + "reachWithResult", removeNulls({"id": id}));
  }
}
