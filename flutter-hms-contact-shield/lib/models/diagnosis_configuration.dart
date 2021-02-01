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

class DiagnosisConfiguration {
  List<int> attenuationDurationThresholds;
  List<int> attenuationRiskValues;
  int attenuationWeight;
  List<int> daysAfterContactedRiskValues;
  int daysAfterContactedWeight;
  List<int> durationRiskValues;
  int durationWeight;
  List<int> initialRiskLevelRiskValues;
  int initialRiskLevelWeight;
  int minimumRiskValueThreshold;

  DiagnosisConfiguration({
    List<int> attenuationDurationThresholds,
    List<int> attenuationRiskValues,
    this.attenuationWeight = 50,
    List<int> daysAfterContactedRiskValues,
    this.daysAfterContactedWeight = 50,
    List<int> durationRiskValues,
    this.durationWeight = 50,
    List<int> initialRiskLevelRiskValues,
    this.initialRiskLevelWeight = 50,
    this.minimumRiskValueThreshold = 1,
  })  : attenuationDurationThresholds =
            attenuationDurationThresholds ?? <int>[50, 74],
        attenuationRiskValues =
            attenuationRiskValues ?? <int>[4, 4, 4, 4, 4, 4, 4, 4],
        daysAfterContactedRiskValues =
            daysAfterContactedRiskValues ?? <int>[4, 4, 4, 4, 4, 4, 4, 4],
        durationRiskValues =
            durationRiskValues ?? <int>[4, 4, 4, 4, 4, 4, 4, 4],
        initialRiskLevelRiskValues =
            initialRiskLevelRiskValues ?? <int>[4, 4, 4, 4, 4, 4, 4, 4];

  factory DiagnosisConfiguration.fromJson(String str) =>
      DiagnosisConfiguration.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiagnosisConfiguration.fromMap(Map<String, dynamic> json) =>
      DiagnosisConfiguration(
        attenuationDurationThresholds:
            json["mAttenuationDurationThresholds"] == null
                ? null
                : List<int>.from(
                    json["mAttenuationDurationThresholds"].map((x) => x)),
        attenuationRiskValues: json["mAttenuationRiskValues"] == null
            ? null
            : List<int>.from(json["mAttenuationRiskValues"].map((x) => x)),
        attenuationWeight: json["mAttenuationWight"] == null
            ? null
            : json["mAttenuationWight"],
        daysAfterContactedRiskValues:
            json["mDaysAfterContactedRiskValues"] == null
                ? null
                : List<int>.from(
                    json["mDaysAfterContactedRiskValues"].map((x) => x)),
        daysAfterContactedWeight: json["mDaysAfterContactedWeight"] == null
            ? null
            : json["mDaysAfterContactedWeight"],
        durationRiskValues: json["mDurationRiskValues"] == null
            ? null
            : List<int>.from(json["mDurationRiskValues"].map((x) => x)),
        durationWeight:
            json["mDurationWeight"] == null ? null : json["mDurationWeight"],
        initialRiskLevelRiskValues: json["mInitialRiskLevelRiskValues"] == null
            ? null
            : List<int>.from(json["mInitialRiskLevelRiskValues"].map((x) => x)),
        initialRiskLevelWeight: json["mInitialRiskLevelWeight"] == null
            ? null
            : json["mInitialRiskLevelWeight"],
        minimumRiskValueThreshold: json["mMinimumRiskValueThreshold"] == null
            ? null
            : json["mMinimumRiskValueThreshold"],
      );

  Map<String, dynamic> toMap() => {
        "mAttenuationDurationThresholds": attenuationDurationThresholds == null
            ? null
            : List<dynamic>.from(attenuationDurationThresholds.map((x) => x)),
        "mAttenuationRiskValues": attenuationRiskValues == null
            ? null
            : List<dynamic>.from(attenuationRiskValues.map((x) => x)),
        "mAttenuationWight":
            attenuationWeight == null ? null : attenuationWeight,
        "mDaysAfterContactedRiskValues": daysAfterContactedRiskValues == null
            ? null
            : List<dynamic>.from(daysAfterContactedRiskValues.map((x) => x)),
        "mDaysAfterContactedWeight":
            daysAfterContactedWeight == null ? null : daysAfterContactedWeight,
        "mDurationRiskValues": durationRiskValues == null
            ? null
            : List<dynamic>.from(durationRiskValues.map((x) => x)),
        "mDurationWeight": durationWeight == null ? null : durationWeight,
        "mInitialRiskLevelRiskValues": initialRiskLevelRiskValues == null
            ? null
            : List<dynamic>.from(initialRiskLevelRiskValues.map((x) => x)),
        "mInitialRiskLevelWeight":
            initialRiskLevelWeight == null ? null : initialRiskLevelWeight,
        "mMinimumRiskValueThreshold": minimumRiskValueThreshold == null
            ? null
            : minimumRiskValueThreshold,
      };

  @override
  String toString() {
    return 'DiagnosisConfiguration(attenuationDurationThresholds: $attenuationDurationThresholds, attenuationRiskValues: $attenuationRiskValues, attenuationWeight: $attenuationWeight, daysAfterContactedRiskValues: $daysAfterContactedRiskValues, daysAfterContactedWeight: $daysAfterContactedWeight, durationRiskValues: $durationRiskValues, durationWeight: $durationWeight, initialRiskLevelRiskValues: $initialRiskLevelRiskValues, initialRiskLevelWeight: $initialRiskLevelWeight, minimumRiskValueThreshold: $minimumRiskValueThreshold)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiagnosisConfiguration &&
        listEquals(
            o.attenuationDurationThresholds, attenuationDurationThresholds) &&
        listEquals(o.attenuationRiskValues, attenuationRiskValues) &&
        o.attenuationWeight == attenuationWeight &&
        listEquals(
            o.daysAfterContactedRiskValues, daysAfterContactedRiskValues) &&
        o.daysAfterContactedWeight == daysAfterContactedWeight &&
        listEquals(o.durationRiskValues, durationRiskValues) &&
        o.durationWeight == durationWeight &&
        listEquals(o.initialRiskLevelRiskValues, initialRiskLevelRiskValues) &&
        o.initialRiskLevelWeight == initialRiskLevelWeight &&
        o.minimumRiskValueThreshold == minimumRiskValueThreshold;
  }

  @override
  int get hashCode {
    return attenuationDurationThresholds.hashCode ^
        attenuationRiskValues.hashCode ^
        attenuationWeight.hashCode ^
        daysAfterContactedRiskValues.hashCode ^
        daysAfterContactedWeight.hashCode ^
        durationRiskValues.hashCode ^
        durationWeight.hashCode ^
        initialRiskLevelRiskValues.hashCode ^
        initialRiskLevelWeight.hashCode ^
        minimumRiskValueThreshold.hashCode;
  }
}
