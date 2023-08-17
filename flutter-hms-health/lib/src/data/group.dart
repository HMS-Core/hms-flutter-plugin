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

/// Grouped data class, which represents a data group obtained by the user when
/// querying the grouped data.
///
/// For example, the user can query the grouped weight data collected within a
/// period of time to learn about the maximum, minimum, and average body weight
/// over this period of time.
/// Currently, data can be grouped by time, activity record, activity type, or
/// activity fragment.
class Group {
  DateTime? startTime;
  DateTime? endTime;

  /// The activity record if data is grouped by activity record.
  ActivityRecord? activityRecord;
  int? activityType;
  List<SampleSet>? sampleSets;
  GroupType? groupType;

  /// Whether there is additional data.
  bool? hasMoreSample;

  Group({
    this.startTime,
    this.endTime,
    this.activityRecord,
    this.activityType,
    this.sampleSets,
    this.groupType,
    this.hasMoreSample,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'activityRecord': activityRecord?.toMap(),
      'activityType': activityType,
      'sampleSets': List<Map<String, dynamic>>.from(
        sampleSets?.map((SampleSet e) => e.toMap()) ?? <Map<String, dynamic>>[],
      ),
      'groupType': getGroupTypeValue(groupType),
      'hasMoreSample': hasMoreSample,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory Group.fromMap(Map<dynamic, dynamic> map) {
    return Group(
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      activityRecord: map['activityRecord'] != null
          ? ActivityRecord.fromMap(
              Map<String, dynamic>.from(
                map['activityRecord'],
              ),
            )
          : null,
      activityType: map['activityType'],
      sampleSets: map['sampleSets'] != null
          ? List<SampleSet>.from(
              map['sampleSets'].map(
                (dynamic e) {
                  return SampleSet.fromMap(e);
                },
              ),
            )
          : null,
      groupType: map['groupType'] != null
          ? GroupType.values[map['groupType'] + 1]
          : null,
      hasMoreSample: map['hasMoreSample'],
    );
  }

  int getGroupTypeValue(GroupType? groupType) {
    if (groupType == GroupType.TYPE_INTERVALS) {
      return 5;
    }
    return 1;
  }

  /// Obtains the name the group type.
  String getGroupTypeString(int groupType) {
    switch (groupType) {
      case 0:
        return 'none';
      case 1:
        return 'time';
      case 2:
        return 'activityRecord';
      case 3:
        return 'activityType';
      case 4:
        return 'activityFragment';
      case 5:
        return 'intervals';
      default:
        return 'error';
    }
  }

  /// Returns the sampling dataset based on data type.
  SampleSet? getSampleSet(DataType dataType) {
    if (sampleSets != null) {
      for (SampleSet sampleSet in sampleSets ?? <SampleSet>[]) {
        if (sampleSet.getDataType?.name == dataType.name) {
          return sampleSet;
        }
      }
    }
    return null;
  }

  /// Obtains the activity as a string.
  String? get getActivity => HiHealthActivities.typeActivityMap[activityType];

  /// Checks whether the group has the same structure.
  bool hasSameSample(Group group) {
    return activityType == group.activityType &&
        groupType == group.groupType &&
        startTime == group.startTime &&
        endTime == group.endTime;
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is Group &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.activityRecord == activityRecord &&
        other.activityType == activityType &&
        listEquals(other.sampleSets, sampleSets) &&
        other.groupType == groupType &&
        other.hasMoreSample == hasMoreSample;
  }

  @override
  int get hashCode {
    return Object.hash(
      startTime,
      endTime,
      activityRecord,
      activityType,
      Object.hashAll(sampleSets ?? <dynamic>[]),
      groupType,
      hasMoreSample,
    );
  }
}

enum GroupType {
  /// Type constant, requesting data to be grouped by time.
  ///
  /// Constant Value: 1
  TYPE_TIME,

  /// Type constant requiesting data to be grouped by activity record.
  ///
  /// Constant Value: 2
  TYPE_ACTIVITY_RECORD,

  /// Type constant requiesting data to be grouped by activity type.
  ///
  /// Constant Value: 3
  TYPE_ACTIVITY_TYPE,

  /// Type constant requiesting data to be grouped by activity fragment.
  ///
  /// Constant Value: 4
  TYPE_ACTIVITY_FRAGMENT,

  /// Type constant, requesting data to be grouped by interval.
  ///
  /// Constant Value: 5
  TYPE_INTERVALS,
}
