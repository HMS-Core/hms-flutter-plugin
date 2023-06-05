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

/// Activity record class, which records the basic information about an activity
/// of the user. For example, for an outdoor running activity, information including
/// the start time, end time, activity record name, identifier, description, activity
/// type (as defined in [HiHealthActivities]), and activity duration will be recorded.
class ActivityRecord {
  /// ActivityRecord object contained in additional inforation.
  @Deprecated('This constant has been deprecated.')
  static const String EXTRA_ACTIVITY_RECORD =
      'vnd.huawei.hihealth.activityRecord';

  /// General prefix of an activity record.
  @Deprecated('This constant has been deprecated.')
  static const String MIME_TYPE_PREFIX = 'vnd.huawei.hihealth.mimeType/';

  DeviceInfo? deviceInfo;

  /// The start time of the activity record.
  DateTime? startTime;

  /// The end time of the activity record.
  DateTime? endTime;

  /// Activity duration in milliseconds.
  int? activeTimeMillis;

  /// Name of the activity record.
  String? name;

  /// Identifier of the activity record.
  String? id;

  /// Description of the activity record.
  String? description;

  /// Time Zone.
  String? timeZone;

  /// Activity type corresponding to the activity record.
  String? activityTypeId;

  bool _isKeepGoing;

  bool _hasDurationTime;

  ActivitySummary? activitySummary;

  /// Indicates whether an activity record is in progress.
  ///
  /// If the activity record has ended, the value `false` will be returned.
  bool get isKeepGoing => _isKeepGoing;

  /// Indicates whether the activity record has durations.
  bool get hasDurationTime => _hasDurationTime;

  ActivityRecord({
    required this.activityTypeId,
    this.startTime,
    this.endTime,
    this.id,
    this.name,
    this.description,
    this.timeZone,
    this.activeTimeMillis,
    this.activitySummary,
    this.deviceInfo,
  })  : _isKeepGoing = false,
        _hasDurationTime = false;

  /// Represents the [ActivityRecord] object as a Map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceInfo': deviceInfo?.toMap(),
      'name': name,
      'description': description,
      'timezone': timeZone,
      'id': id,
      'activityTypeId': activityTypeId,
      'startTimeMillis': startTime?.millisecondsSinceEpoch,
      'endTimeMillis': endTime?.millisecondsSinceEpoch,
      'activeTimeMillis': activeTimeMillis,
      'activitySummary': activitySummary?.toMap(),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory ActivityRecord.fromMap(Map<dynamic, dynamic> map) {
    return ActivityRecord(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      activeTimeMillis: map['activeTime'],
      timeZone: map['timeZone'],
      activitySummary: map['activitySummary'] != null
          ? ActivitySummary.fromMap(map['activitySummary'])
          : null,
      activityTypeId: map['activityTypeId'],
      deviceInfo: map['deviceInfo'] != null
          ? DeviceInfo.fromMap(map['deviceInfo'])
          : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityRecord &&
        other.name == name &&
        other.description == description &&
        other.timeZone == timeZone &&
        other.id == id &&
        other.activityTypeId == activityTypeId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.activeTimeMillis == activeTimeMillis &&
        other.activitySummary == activitySummary;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      description,
      activityTypeId,
      startTime,
      endTime,
      activeTimeMillis,
    );
  }
}
