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

class ContactSketch {
  ContactSketch({
    List<int> attenuationDurations,
    this.daysSinceLastHit = 0,
    this.maxRiskValue = 0,
    this.numberOfHits = 0,
    this.summationRiskValue = 0,
  }) : attenuationDurations = attenuationDurations ?? <int>[0, 0, 0];

  List<int> attenuationDurations;
  int daysSinceLastHit;
  int maxRiskValue;
  int numberOfHits;
  int summationRiskValue;

  factory ContactSketch.fromJson(String str) =>
      ContactSketch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactSketch.fromMap(Map<String, dynamic> json) => ContactSketch(
        attenuationDurations: json["attenuationDurations"] == null
            ? null
            : List<int>.from(json["attenuationDurations"].map((x) => x)),
        daysSinceLastHit:
            json["daysSinceLastHit"] == null ? null : json["daysSinceLastHit"],
        maxRiskValue:
            json["maxRiskValue"] == null ? null : json["maxRiskValue"],
        numberOfHits:
            json["numberOfHits"] == null ? null : json["numberOfHits"],
        summationRiskValue: json["summationRiskValue"] == null
            ? null
            : json["summationRiskValue"],
      );

  Map<String, dynamic> toMap() => {
        "attenuationDurations": attenuationDurations == null
            ? null
            : List<dynamic>.from(attenuationDurations.map((x) => x)),
        "daysSinceLastHit": daysSinceLastHit == null ? null : daysSinceLastHit,
        "maxRiskValue": maxRiskValue == null ? null : maxRiskValue,
        "numberOfHits": numberOfHits == null ? null : numberOfHits,
        "summationRiskValue":
            summationRiskValue == null ? null : summationRiskValue,
      };

  @override
  String toString() {
    return 'ContactSketch(attenuationDurations: $attenuationDurations, daysSinceLastHit: $daysSinceLastHit, maxRiskValue: $maxRiskValue, numberOfHits: $numberOfHits, summationRiskValue: $summationRiskValue)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ContactSketch &&
        listEquals(o.attenuationDurations, attenuationDurations) &&
        o.daysSinceLastHit == daysSinceLastHit &&
        o.maxRiskValue == maxRiskValue &&
        o.numberOfHits == numberOfHits &&
        o.summationRiskValue == summationRiskValue;
  }

  @override
  int get hashCode {
    return attenuationDurations.hashCode ^
        daysSinceLastHit.hashCode ^
        maxRiskValue.hashCode ^
        numberOfHits.hashCode ^
        summationRiskValue.hashCode;
  }
}
