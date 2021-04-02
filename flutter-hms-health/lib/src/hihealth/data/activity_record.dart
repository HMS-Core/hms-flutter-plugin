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

import 'package:flutter/cupertino.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

import 'activity_summary.dart';

/// Activity record class, which records the basic information about an activity
/// of the user. For example, for an outdoor running activity, information including
/// the start time, end time, activity record name, identifier, description, activity
/// type (as defined in [HiHealthActivities]), and activity duration will be recorded.
class ActivityRecord {
  /// Start of an activity record.
  static const String ACTION_ACTIVITY_RECORD_START =
      "vnd.huawei.hihealth.activityRecordStart";

  /// End of an activity record.
  static const String ACTION_ACTIVITY_RECORD_END =
      "vnd.huawei.hihealth.activityRecordEnd";

  /// ActivityRecord object contained in additional inforation.
  static const String EXTRA_ACTIVITY_RECORD =
      "vnd.huawei.hihealth.activityRecord";

  /// General prefix of an activity record.
  static const String MIME_TYPE_PREFIX = "vnd.huawei.hihealth.mimeType/";

  /// The start time of the activity record.
  DateTime startTime;

  /// The end time of the activity record.
  DateTime endTime;

  /// Activity duration in milliseconds.
  int activeTimeMillis;

  /// Name of the activity record.
  String name;

  /// Identifier of the activity record.
  String id;

  /// Description of the activity record.
  String description;

  /// Time Zone.
  String timeZone;

  /// Activity type corresponding to the activity record.
  String activityTypeId;

  /// Indicates whether an activity record is in progress.
  ///
  /// If the activity record has ended, the value `false` will be returned.
  bool _isKeepGoing;

  /// Indicates whether the activity record has durations.
  bool _hasDurationTime;

  bool get isKeepGoing => _isKeepGoing;

  bool get hasDurationTime => _hasDurationTime;

  ActivitySummary activitySummary;

  ActivityRecord(
      {this.startTime,
      this.endTime,
      this.id,
      this.name,
      this.description,
      this.activityTypeId,
      this.timeZone,
      this.activeTimeMillis,
      this.activitySummary});

  /// Represents the [ActivityRecord] object as a Map.
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "timezone": timeZone,
      "id": id,
      "activityTypeId": activityTypeId,
      "startTimeMillis": startTime?.millisecondsSinceEpoch,
      "endTimeMillis": endTime?.millisecondsSinceEpoch,
      "activeTimeMillis": activeTimeMillis,
      "activitySummary": activitySummary?.toMap()
    }..removeWhere((k, v) => v == null);
  }

  /// Represents the [ActivityRecord] object as a string.
  @override
  String toString() {
    return toMap().toString();
  }

  factory ActivityRecord.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ActivityRecord(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      description: map['description'] != null ? map['description'] : null,
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      activeTimeMillis: map['activeTime'] != null ? map['activeTime'] : null,
      timeZone: map['timeZone'] != null ? map['timeZone'] : null,
      activitySummary: map['activitySummary'] != null
          ? ActivitySummary.fromMap(
              Map<String, dynamic>.from(map['activitySummary']))
          : null,
      activityTypeId:
          map['activityTypeId'] != null ? map['activityTypeId'] : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    ActivityRecord compare = other;
    List<dynamic> currentArgs = [
      name,
      description,
      timeZone,
      id,
      activityTypeId,
      startTime,
      endTime,
      activeTimeMillis,
      activitySummary
    ];
    List<dynamic> otherArgs = [
      compare.name,
      compare.description,
      compare.timeZone,
      compare.id,
      compare.activityTypeId,
      compare.startTime,
      compare.endTime,
      compare.activeTimeMillis,
      compare.activitySummary
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  /// Returns the hashCode of the [ActivityRecord] object.
  @override
  int get hashCode => hashValues(id, name, description, activityTypeId,
      startTime, endTime, activeTimeMillis);
}
