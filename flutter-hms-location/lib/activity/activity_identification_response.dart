/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'activity_identification_data.dart';

class ActivityIdentificationResponse {
  int time;
  int elapsedTimeFromReboot;
  List<ActivityIdentificationData> activityIdentificationDatas;

  ActivityIdentificationResponse({
    this.activityIdentificationDatas,
    this.time,
    this.elapsedTimeFromReboot,
  });

  ActivityIdentificationData get mostActivityIdentification {
    return activityIdentificationDatas != null &&
            activityIdentificationDatas.length > 0
        ? activityIdentificationDatas[0]
        : null;
  }

  int getActivityPossibility(int activityType) {
    if (activityIdentificationDatas != null &&
        activityIdentificationDatas.length > 0) {
      Iterator iterator = activityIdentificationDatas.iterator;

      while (iterator.moveNext()) {
        ActivityIdentificationData currentData = iterator.current;
        if (currentData.identificationActivity == activityType) {
          return currentData.possibility;
        }
      }
    }

    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'elapsedTimeFromReboot': elapsedTimeFromReboot,
      'activityIdentificationDatas':
          activityIdentificationDatas?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ActivityIdentificationResponse.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ActivityIdentificationResponse(
      time: map['time'],
      elapsedTimeFromReboot: map['elapsedTimeFromReboot'],
      activityIdentificationDatas: List<ActivityIdentificationData>.from(
          map['activityIdentificationDatas']
              ?.map((x) => ActivityIdentificationData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityIdentificationResponse.fromJson(String source) =>
      ActivityIdentificationResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActivityIdentificationResponse(time: $time, elapsedTimeFromReboot: $elapsedTimeFromReboot, activityIdentificationDatas: $activityIdentificationDatas)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ActivityIdentificationResponse &&
        o.time == time &&
        o.elapsedTimeFromReboot == elapsedTimeFromReboot &&
        listEquals(o.activityIdentificationDatas, activityIdentificationDatas);
  }

  @override
  int get hashCode {
    return hashList([
      time,
      elapsedTimeFromReboot,
      activityIdentificationDatas,
    ]);
  }
}
