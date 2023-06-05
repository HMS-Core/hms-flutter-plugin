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

/// Defines the activity record read options for an [ActivityRecord] read process
class ActivityRecordReadOptions {
  String? activityRecordId;
  String? activityRecordName;
  DateTime startTime;
  DateTime endTime;
  TimeUnit timeUnit;
  DataType? dataType;

  ActivityRecordReadOptions({
    required this.startTime,
    required this.endTime,
    this.activityRecordId,
    this.activityRecordName,
    this.timeUnit = TimeUnit.MILLISECONDS,
    this.dataType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityRecordId': activityRecordId,
      'activityRecordName': activityRecordName,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'timeUnit': describeEnum(timeUnit),
      'dataType': dataType?.toString(),
    }..removeWhere((String k, dynamic v) => v == null);
  }
}
