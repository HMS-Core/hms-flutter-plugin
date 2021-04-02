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

import '../../../huawei_health.dart';

/// Grouped data class, which represents a data group obtained by the user when
/// querying the grouped data.
///
/// For example, the user can query the grouped weight data collected within a
/// period of time to learn about the maximum, minimum, and average body weight
/// over this period of time.
/// Currently, data can be grouped by time, activity record, activity type, or
/// activity fragment.
class Group {
  DateTime startTime;
  DateTime endTime;

  /// The activity record if data is grouped by activity record.
  ActivityRecord activityRecord;
  int activityType;
  List<SampleSet> sampleSets;
  GroupType groupType;

  /// Whether there is additional data.
  bool hasMoreSample;

  Group(
      {this.startTime,
      this.endTime,
      this.activityRecord,
      this.activityType,
      this.sampleSets,
      this.groupType,
      this.hasMoreSample});

  Map<String, dynamic> toMap() {
    return {
      "startTime": startTime?.millisecondsSinceEpoch,
      "endTime": endTime?.millisecondsSinceEpoch,
      "activityRecord": activityRecord?.toMap(),
      "activityType": activityType,
      "sampleSets": List.from(sampleSets.map((e) => e.toMap())),
      "groupType": getGroupTypeValue(groupType),
      "hasMoreSample": hasMoreSample
    }..removeWhere((k, v) => v == null);
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Group(
        startTime: map['startTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
            : null,
        endTime: map['endTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
            : null,
        activityRecord: map['activityRecord'] != null
            ? ActivityRecord.fromMap(
                Map<String, dynamic>.from(map['activityRecord']))
            : null,
        activityType: map['activityType'] != null ? map['activityType'] : null,
        sampleSets: map['sampleSets'] != null
            ? List<SampleSet>.from(map['sampleSets']
                .map((e) => SampleSet.fromMap(Map<String, dynamic>.from(e))))
            : null,
        groupType: map['groupType'] != null
            ? GroupType.values[map['groupType'] + 1]
            : null,
        hasMoreSample:
            map['hasMoreSample'] != null ? map['hasMoreSample'] : null);
  }

  int getGroupTypeValue(GroupType groupType) {
    if (groupType == GroupType.TYPE_INTERVALS) return 5;
    return 1;
  }

  /// Obtains the name the group type.
  String getGroupTypeString(int groupType) {
    switch (groupType) {
      case 0:
        return "none";
      case 1:
        return "time";
      case 2:
        return "activityRecord";
      case 3:
        return "activityType";
      case 4:
        return "activityFragment";
      case 5:
        return "intervals";
      default:
        return "error";
    }
  }

  /// Returns the sampling dataset based on data type.
  SampleSet getSampleSet(DataType dataType) {
    if (sampleSets != null) {
      for (var sampleSet in sampleSets) {
        if (sampleSet.getDataType.name == dataType.name) {
          return sampleSet;
        }
      }
    }
    return null;
  }

  /// Obtains the activity as a string.
  String get getActivity =>
      HiHealthActivities.typeActivityMap[this.activityType];

  /// Checks whether the group has the same structure.
  bool hasSameSample(Group group) {
    return this.activityType == group.activityType &&
        this.groupType == this.groupType &&
        this.startTime == group.startTime &&
        this.endTime == this.endTime;
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    Group compare = other;
    List<dynamic> currentArgs = [
      startTime,
      endTime,
      activityRecord,
      activityType,
      sampleSets,
      groupType,
      hasMoreSample
    ];
    List<dynamic> otherArgs = [
      compare.startTime,
      compare.endTime,
      compare.activityRecord,
      compare.activityType,
      compare.sampleSets,
      compare.groupType,
      compare.hasMoreSample
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(startTime, endTime, activityRecord,
      activityType, hashList(sampleSets), groupType, hasMoreSample);
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
  TYPE_INTERVALS
}
