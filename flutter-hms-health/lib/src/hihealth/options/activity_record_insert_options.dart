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
import 'package:huawei_health/src/hihealth/data/activity_record.dart';
import 'package:huawei_health/src/hihealth/data/sample_set.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

/// Request parameter class for inserting an activity record, including the
/// associated sampling dataset and sampling points to the platform.
class ActivityRecordInsertOptions {
  ActivityRecord activityRecord;
  List<SampleSet> sampleSets;

  ActivityRecordInsertOptions({this.activityRecord, this.sampleSets});

  /// Checks whether two activity records objects are equal.
  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    ActivityRecordInsertOptions compare = other;
    List<dynamic> currentArgs = [activityRecord, sampleSets];
    List<dynamic> otherArgs = [
      compare.activityRecord,
      compare.sampleSets,
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  /// Calculates the ActivityRecordInsertOptions hash value.
  @override
  int get hashCode => hashValues(activityRecord, hashList(sampleSets));

  Map<String, dynamic> toMap() {
    return {
      "activityRecord": activityRecord?.toMap(),
      "sampleSets":
          List<Map<String, dynamic>>.from(sampleSets.map((e) => e.toMap())),
    }..removeWhere((k, v) => v == null);
  }

  /// Represents the ActivityRecordInsertOptions object as a string.
  @override
  String toString() {
    return toMap().toString();
  }
}
