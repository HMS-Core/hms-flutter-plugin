/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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
  ContactDetail({
    List<int> attenuationDurations,
    this.attenuationRiskValue = 0,
    this.dayNumber = 0,
    this.durationMinutes = 0,
    this.initialRiskLevel = 0,
    this.totalRiskValue = 0,
  }) : attenuationDurations = attenuationDurations ?? <int>[0, 0, 0];

  List<int> attenuationDurations;
  int attenuationRiskValue;
  int dayNumber;
  int durationMinutes;
  int initialRiskLevel;
  int totalRiskValue;

  factory ContactDetail.fromJson(String str) =>
      ContactDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactDetail.fromMap(Map<String, dynamic> json) => ContactDetail(
        attenuationDurations: json["attenuationDurations"] == null
            ? null
            : List<int>.from(json["attenuationDurations"].map((x) => x)),
        attenuationRiskValue: json["attenuationRiskValue"] == null
            ? null
            : json["attenuationRiskValue"],
        dayNumber: json["dayNumber"] == null ? null : json["dayNumber"],
        durationMinutes:
            json["durationMinutes"] == null ? null : json["durationMinutes"],
        initialRiskLevel:
            json["initialRiskLevel"] == null ? null : json["initialRiskLevel"],
        totalRiskValue:
            json["totalRiskValue"] == null ? null : json["totalRiskValue"],
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
