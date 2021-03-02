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

/// Defines constants related to archive management.
class ArchiveConstants {
  /// Constant returned when a player views a saved game on the saved game list page of
  /// HUAWEI AppAssistant.
  static const String ARCHIVE_SELECT = "com.huawei.hms.games.ARCHIVE_METADATA";

  /// Constant returned when a player adds a saved game on the saved game list page of
  /// HUAWEI AppAssistant.
  static const String ARCHIVE_ADD = "com.huawei.hms.games.ARCHIVE_NEW";

  /// Constant for setting the conflict resolution policy as no conflict resolution.
  static const int STRATEGY_SELF = -1;

  /// Constant for setting the conflict resolution policy as automatic resolution by
  /// Huawei game server based on the progress.
  static const int STRATEGY_TOTAL_PROGRESS = 1;

  /// Constant for setting the conflict resolution policy as automatic resolution by
  /// Huawei game server based on the last modified time.
  static const int STRATEGY_LAST_UPDATE = 2;

  /// Constant for setting the conflict resolution policy as automatic resolution by
  /// Huawei game server based on the played time.
  static const int STRATEGY_ACTIVE_TIME = 3;
}
