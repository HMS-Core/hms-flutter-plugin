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

/// Defines the delete options for an [ActivityRecord] delete process.
class DeleteOptions {
  /// Should be set to `true` if all the data types are marked for deletion.
  bool? deleteAllData;

  /// Should be set to `true` if all the activity records are marked for deletion.
  bool? deleteAllActivityRecords;

  /// List of activity records to be deleted.
  List<ActivityRecord>? activityRecords;

  /// List of data collectors whose data is to be deleted.
  List<DataCollector>? dataCollectors;

  /// List of data types whose data is to be deleted.
  List<DataType>? dataTypes;

  /// Start time for data to be deleted.
  DateTime? startTime;

  /// End time for data to be deleted.
  DateTime? endTime;

  /// TimeUnit for data to be deleted.
  TimeUnit timeUnit = TimeUnit.MILLISECONDS;

  DeleteOptions({
    this.startTime,
    this.endTime,
    this.dataTypes,
    this.dataCollectors,
    this.activityRecords,
    this.deleteAllActivityRecords,
    this.deleteAllData,
    this.timeUnit = TimeUnit.MILLISECONDS,
  });

  /// Sets the start time and end time for data to be deleted.
  ///
  /// The start time must be greater than `0`, and the end time must not be earlier
  /// than the start time.
  void setTimeInterval(DateTime startTime, DateTime endTime) {
    this.startTime = startTime;
    this.endTime = endTime;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'timeUnit': describeEnum(timeUnit),
      'dataTypes': dataTypes != null
          ? List<Map<String, dynamic>>.from(
              dataTypes!.map((DataType e) => e.toMap()),
            )
          : null,
      'dataCollectors': dataCollectors != null
          ? List<Map<String, dynamic>>.from(
              dataCollectors!.map((DataCollector e) => e.toMap()),
            )
          : null,
      'activityRecords': activityRecords != null
          ? List<Map<String, dynamic>>.from(
              activityRecords!.map((ActivityRecord e) => e.toMap()),
            )
          : null,
      'deleteAllActivityRecords': deleteAllActivityRecords,
      'deleteAllData': deleteAllData,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteOptions &&
        other.deleteAllData == deleteAllData &&
        other.deleteAllActivityRecords == deleteAllActivityRecords &&
        listEquals(other.activityRecords, activityRecords) &&
        listEquals(other.dataCollectors, dataCollectors) &&
        listEquals(other.dataTypes, dataTypes) &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      deleteAllData,
      deleteAllActivityRecords,
      Object.hashAll(activityRecords ?? <dynamic>[]),
      Object.hashAll(dataCollectors ?? <dynamic>[]),
      Object.hashAll(dataTypes ?? <dynamic>[]),
      startTime,
      endTime,
    );
  }
}
