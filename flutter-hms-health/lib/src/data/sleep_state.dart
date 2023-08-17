/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Sleep state class. Five states: light sleep, REM sleep, deep sleep, awake, and nap.
class SleepState {
  final int value;

  const SleepState._(this.value);

  /// Light sleep. Constant Value: 1
  static const SleepState SLEEP_LIGHT = SleepState._(1);

  /// REM sleep. Constant Value: 2
  static const SleepState SLEEP_DREAM = SleepState._(2);

  /// Deep sleep. Constant Value: 3
  static const SleepState SLEEP_DEEP = SleepState._(3);

  /// Awake. Constant Value: 4
  static const SleepState SLEEP_AWAKE = SleepState._(4);
}
