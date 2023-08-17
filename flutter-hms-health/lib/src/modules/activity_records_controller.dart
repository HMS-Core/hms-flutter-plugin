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

/// Provides functions to create and manage user activities.
class ActivityRecordsController {
  static const MethodChannel _channel = _healthActivityRecordMethodChannel;

  /// Inserts a specified activity record and corresponding data to the HUAWEI Health platform.
  static Future<void> addActivityRecord(
    ActivityRecordInsertOptions activityRecordInsertOptions,
  ) async {
    return await _channel.invokeMethod<void>(
      'addActivityRecord',
      activityRecordInsertOptions.toMap(),
    );
  }

  /// Reads [ActivityRecord] data from the HUAWEI Health platform.
  static Future<List<ActivityRecord>> getActivityRecord(
    ActivityRecordReadOptions activityRecordReadOptions,
  ) async {
    final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>?>(
      'getActivityRecord',
      activityRecordReadOptions.toMap(),
    );

    List<ActivityRecord> records = <ActivityRecord>[];
    if (result != null) {
      for (dynamic e in result) {
        records.add(
          ActivityRecord.fromMap(e['activityRecord']),
        );
      }
    }
    return records;
  }

  /// Starts a new activity record for the current app.
  static Future<void> beginActivityRecord(
    ActivityRecord activityRecord,
  ) async {
    return await _channel.invokeMethod<void>(
      'beginActivityRecord',
      activityRecord.toMap(),
    );
  }

  static Future<void> continueActivityRecord(
    String activityRecordId,
  ) async {
    return await _channel.invokeMethod<void>(
      'continueActivityRecord',
      activityRecordId,
    );
  }

  /// Stops the ActivityRecord of a specific ID.
  static Future<List<ActivityRecord>> endActivityRecord(
    String activityRecordId,
  ) async {
    final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>?>(
      'endActivityRecord',
      activityRecordId,
    );

    List<ActivityRecord> records = <ActivityRecord>[];
    if (result != null) {
      for (dynamic e in result) {
        records.add(ActivityRecord.fromMap(e));
      }
    }
    return records;
  }

  /// Stops all the ongoing Activity records.
  static Future<List<ActivityRecord>> endAllActivityRecords() async {
    final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>?>(
      'endAllActivityRecords',
    );

    List<ActivityRecord> records = <ActivityRecord>[];
    if (result != null) {
      for (dynamic e in result) {
        records.add(ActivityRecord.fromMap(e));
      }
    }
    return records;
  }

  static Future<void> deleteActivityRecord(
    ActivityRecordDeleteOptions activityRecordDeleteOptions,
  ) async {
    return await _channel.invokeMethod<void>(
      'deleteActivityRecord',
      activityRecordDeleteOptions.toMap(),
    );
  }
}
