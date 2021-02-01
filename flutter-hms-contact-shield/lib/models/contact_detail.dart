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

import 'dart:convert';

import 'package:flutter/foundation.dart';

class ContactDetail {
  List<int> attenuationDurations;
  int attenuationRiskValue;
  int dayNumber;
  int durationMinutes;
  int initialRiskLevel;
  int totalRiskValue;

  ContactDetail({
    List<int> attenuationDurations,
    attenuationRiskValue,
    dayNumber,
    durationMinutes,
    initialRiskLevel,
    totalRiskValue,
  })  : attenuationDurations = attenuationDurations ?? <int>[0, 0, 0],
        attenuationRiskValue = attenuationRiskValue ?? 0,
        dayNumber = dayNumber ?? 0,
        durationMinutes = durationMinutes ?? 0,
        initialRiskLevel = initialRiskLevel ?? 0,
        totalRiskValue = totalRiskValue ?? 0;

  factory ContactDetail.fromJson(String str) =>
      ContactDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactDetail.fromMap(Map<String, dynamic> map) => ContactDetail(
        attenuationDurations: map["attenuationDurations"] == null
            ? null
            : List<int>.from(map["attenuationDurations"].map((x) => x)),
        attenuationRiskValue: map["attenuationRiskValue"] == null
            ? null
            : map["attenuationRiskValue"],
        dayNumber: map["dayNumber"] == null ? null : map["dayNumber"],
        durationMinutes:
            map["durationMinutes"] == null ? null : map["durationMinutes"],
        initialRiskLevel:
            map["initialRiskLevel"] == null ? null : map["initialRiskLevel"],
        totalRiskValue:
            map["totalRiskValue"] == null ? null : map["totalRiskValue"],
      );

  Map<String, dynamic> toMap() => {
        "attenuationDurations": attenuationDurations == null
            ? null
            : List<dynamic>.from(attenuationDurations.map((x) => x)),
        "attenuationRiskValue":
            attenuationRiskValue == null ? null : attenuationRiskValue,
        "dayNumber": dayNumber == null ? null : dayNumber,
        "durationMinutes": durationMinutes == null ? null : durationMinutes,
        "initialRiskLevel": initialRiskLevel == null ? null : initialRiskLevel,
        "totalRiskValue": totalRiskValue == null ? null : totalRiskValue,
      };

  @override
  String toString() {
    return 'ContactDetail(attenuationDurations: $attenuationDurations, attenuationRiskValue: $attenuationRiskValue, dayNumber: $dayNumber, durationMinutes: $durationMinutes, initialRiskLevel: $initialRiskLevel, totalRiskValue: $totalRiskValue)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ContactDetail &&
        listEquals(o.attenuationDurations, attenuationDurations) &&
        o.attenuationRiskValue == attenuationRiskValue &&
        o.dayNumber == dayNumber &&
        o.durationMinutes == durationMinutes &&
        o.initialRiskLevel == initialRiskLevel &&
        o.totalRiskValue == totalRiskValue;
  }

  @override
  int get hashCode {
    return attenuationDurations.hashCode ^
        attenuationRiskValue.hashCode ^
        dayNumber.hashCode ^
        durationMinutes.hashCode ^
        initialRiskLevel.hashCode ^
        totalRiskValue.hashCode;
  }
}
