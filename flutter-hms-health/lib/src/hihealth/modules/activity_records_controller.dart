/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';

/// Provides functions to create and manage user activities.
class ActivityRecordsController {
  static final MethodChannel _channel = health_activity_record_method_channel;

  /// Inserts a specified activity record and corresponding data to the HUAWEI Health platform.
  static Future<String> addActivityRecord(
      ActivityRecordInsertOptions activityRecordInsertOptions) async {
    final res = await _channel.invokeMethod(
        "addActivityRecord", activityRecordInsertOptions.toMap());
    return res.toString();
  }

  /// Reads [ActivityRecord] data from the HUAWEI Health platform.
  static Future<List<ActivityRecord>> getActivityRecord(
      ActivityRecordReadOptions activityRecordReadOptions) async {
    final List res = await _channel.invokeMethod<List>(
        "getActivityRecord", activityRecordReadOptions.toMap());
    List<ActivityRecord> records = [];
    for (var e in res) {
      records.add(ActivityRecord.fromMap(
          Map<String, dynamic>.from(e['activityRecord'])));
    }
    return records;
  }

  /// Starts a new activity record for the current app.
  static Future<void> beginActivityRecord(ActivityRecord activityRecord) async {
    await _channel.invokeMethod("beginActivityRecord", activityRecord?.toMap());
  }

  /// Stops the ActivityRecord of a specific ID.
  static Future<List<ActivityRecord>> endActivityRecord(
      String activityRecordId) async {
    final List res = await _channel.invokeMethod<List>(
        "endActivityRecord", activityRecordId);
    List<ActivityRecord> records = [];
    for (var e in res) {
      records.add(ActivityRecord.fromMap(Map<String, dynamic>.from(e)));
    }
    return records;
  }

  /// Stops all the ongoing Activity records.
  static Future<List<ActivityRecord>> endAllActivityRecords() async {
    final List res = await _channel.invokeMethod<List>("endAllActivityRecords");
    List<ActivityRecord> records = [];
    for (var e in res) {
      records.add(ActivityRecord.fromMap(Map<String, dynamic>.from(e)));
    }
    return records;
  }
}
