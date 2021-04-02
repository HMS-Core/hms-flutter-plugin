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

import 'dart:ui';

import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/data/activity_record.dart';
import 'package:huawei_health/src/hihealth/data/data_collector.dart';
import 'package:huawei_health/src/hihealth/data/data_type.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

/// Defines the delete options for an [ActivityRecord] delete process.
class DeleteOptions {
  /// Should be set to `true` if all the data types are marked for deletion.
  bool deleteAllData;

  /// Should be set to `true` if all the activity records are marked for deletion.
  bool deleteAllActivityRecords;

  /// List of activity records to be deleted.
  List<ActivityRecord> activityRecords;

  /// List of data collectors whose data is to be deleted.
  List<DataCollector> dataCollectors;

  /// List of data types whose data is to be deleted.
  List<DataType> dataTypes;

  /// Start time for data to be deleted.
  DateTime startTime;

  /// End time for data to be deleted.
  DateTime endTime;

  /// TimeUnit for data to be deleted.
  TimeUnit timeUnit = TimeUnit.MILLISECONDS;

  DeleteOptions(
      {this.startTime,
      this.endTime,
      this.dataTypes,
      this.dataCollectors,
      this.activityRecords,
      this.deleteAllActivityRecords,
      this.deleteAllData,
      this.timeUnit});

  Map<String, dynamic> toMap() {
    return {
      "startTime": startTime?.millisecondsSinceEpoch,
      "endTime": endTime?.millisecondsSinceEpoch,
      "timeUnit": timeUnit,
      "dataTypes":
          dataTypes != null ? List.from(dataTypes.map((e) => e.toMap())) : null,
      "dataCollectors": dataCollectors != null
          ? List.from(dataCollectors.map((e) => e.toMap()))
          : null,
      "activityRecords": activityRecords != null
          ? List.from(activityRecords.map((e) => e.toMap()))
          : null,
      "deleteAllActivityRecords": deleteAllActivityRecords,
      "deleteAllData": deleteAllData
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  /// Sets the start time and end time for data to be deleted.
  ///
  /// The start time must be greater than `0`, and the end time must not be earlier
  /// than the start time.
  void setTimeInterval(DateTime startTime, DateTime endTime) {
    this.startTime = startTime;
    this.endTime = endTime;
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    DeleteOptions compare = other;
    List<dynamic> currentArgs = [
      deleteAllData,
      deleteAllActivityRecords,
      activityRecords,
      dataCollectors,
      dataTypes,
      startTime,
      endTime
    ];
    List<dynamic> otherArgs = [
      compare.deleteAllData,
      compare.deleteAllActivityRecords,
      compare.activityRecords,
      compare.dataCollectors,
      compare.dataTypes,
      compare.startTime,
      compare.endTime
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(
      deleteAllData,
      deleteAllActivityRecords,
      hashList(activityRecords),
      hashList(dataCollectors),
      hashList(dataTypes),
      startTime,
      endTime);
}
