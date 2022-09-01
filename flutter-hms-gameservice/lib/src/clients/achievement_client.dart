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

/// Provides APIs for achievement management, for example, obtaining the game achievement list,
/// incrementing an achievement, and setting steps required for unlocking an achievement.
abstract class AchievementClient {
  /// Obtains the list of all game achievements of the current player.
  static Future<void> showAchievementListIntent() async {
    return await _channel.invokeMethod(
      'AchievementClient.getShowAchievementListIntent',
    );
  }

  /// Asynchronously increases an achievement by the given number of steps.
  static Future<void> grow(String id, int numSteps) async {
    return await _channel.invokeMethod(
      'AchievementClient.grow',
      <String, dynamic>{
        'id': id,
        'numSteps': numSteps,
      },
    );
  }

  /// Synchronously increases an achievement by the given number of steps.
  static Future<bool> growWithResult(String id, int numSteps) async {
    return await _channel.invokeMethod(
      'AchievementClient.growWithResult',
      <String, dynamic>{
        'id': id,
        'numSteps': numSteps,
      },
    );
  }

  /// Obtains the list of achievements in all statuses for the current player.
  static Future<List<Achievement>> getAchievementList(bool forceReload) async {
    final dynamic response = await _channel.invokeMethod(
      'AchievementClient.getAchievementList',
      <String, dynamic>{
        'forceReload': forceReload,
      },
    );
    return List<Achievement>.from(
      response.map(
        (dynamic x) => Achievement.fromMap(Map<dynamic, dynamic>.from(x)),
      ),
    ).toList();
  }

  /// Asynchronously reveals a hidden achievement to the current player.
  static Future<void> visualize(String id) async {
    return await _channel.invokeMethod(
      'AchievementClient.visualize',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  /// Synchronously reveals a hidden achievement to the current player.
  static Future<void> visualizeWithResult(String id) async {
    return await _channel.invokeMethod(
      'AchievementClient.visualizeWithResult',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  /// Asynchronously sets an achievement to have the given number of steps completed.
  static Future<void> makeSteps(String id, int numSteps) async {
    return await _channel.invokeMethod(
      'AchievementClient.makeSteps',
      <String, dynamic>{
        'id': id,
        'numSteps': numSteps,
      },
    );
  }

  /// Synchronously sets an achievement to have the given number of steps completed.
  static Future<bool> makeStepsWithResult(String id, int numSteps) async {
    return await _channel.invokeMethod(
      'AchievementClient.makeStepsWithResult',
      <String, dynamic>{
        'id': id,
        'numSteps': numSteps,
      },
    );
  }

  /// Asynchronously unlocks an achievement for the current player.
  static Future<void> reach(String id) async {
    return await _channel.invokeMethod(
      'AchievementClient.reach',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  /// Synchronously unlocks an achievement for the current player.
  static Future<bool> reachWithResult(String id) async {
    return await _channel.invokeMethod(
      'AchievementClient.reachWithResult',
      <String, dynamic>{
        'id': id,
      },
    );
  }
}
