/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

class DiagnosisConfiguration {
  List<int> attenuationDurationThresholds;
  List<int> attenuationRiskValues;
  int? attenuationWeight;
  List<int> daysAfterContactedRiskValues;
  int? daysAfterContactedWeight;
  List<int> durationRiskValues;
  int? durationWeight;
  List<int> initialRiskLevelRiskValues;
  int? initialRiskLevelWeight;
  int? minimumRiskValueThreshold;

  DiagnosisConfiguration({
    List<int>? attenuationDurationThresholds,
    List<int>? attenuationRiskValues,
    this.attenuationWeight = 50,
    List<int>? daysAfterContactedRiskValues,
    this.daysAfterContactedWeight = 50,
    List<int>? durationRiskValues,
    this.durationWeight = 50,
    List<int>? initialRiskLevelRiskValues,
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

  factory DiagnosisConfiguration.fromJson(String str) {
    return DiagnosisConfiguration.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DiagnosisConfiguration.fromMap(Map<String, dynamic> json) {
    return DiagnosisConfiguration(
      attenuationDurationThresholds:
          json['mAttenuationDurationThresholds'] == null
              ? null
              : List<int>.from(
                  json['mAttenuationDurationThresholds'].map((dynamic x) => x),
                ),
      attenuationRiskValues: json['mAttenuationRiskValues'] == null
          ? null
          : List<int>.from(
              json['mAttenuationRiskValues'].map((dynamic x) => x),
            ),
      attenuationWeight: json['mAttenuationWight'],
      daysAfterContactedRiskValues:
          json['mDaysAfterContactedRiskValues'] == null
              ? null
              : List<int>.from(
                  json['mDaysAfterContactedRiskValues'].map((dynamic x) => x),
                ),
      daysAfterContactedWeight: json['mDaysAfterContactedWeight'],
      durationRiskValues: json['mDurationRiskValues'] == null
          ? null
          : List<int>.from(
              json['mDurationRiskValues'].map((dynamic x) => x),
            ),
      durationWeight: json['mDurationWeight'],
      initialRiskLevelRiskValues: json['mInitialRiskLevelRiskValues'] == null
          ? null
          : List<int>.from(
              json['mInitialRiskLevelRiskValues'].map((dynamic x) => x),
            ),
      initialRiskLevelWeight: json['mInitialRiskLevelWeight'],
      minimumRiskValueThreshold: json['mMinimumRiskValueThreshold'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mAttenuationDurationThresholds': attenuationDurationThresholds,
      'mAttenuationRiskValues': attenuationRiskValues,
      'mAttenuationWight': attenuationWeight,
      'mDaysAfterContactedRiskValues': daysAfterContactedRiskValues,
      'mDaysAfterContactedWeight': daysAfterContactedWeight,
      'mDurationRiskValues': durationRiskValues,
      'mDurationWeight': durationWeight,
      'mInitialRiskLevelRiskValues': initialRiskLevelRiskValues,
      'mInitialRiskLevelWeight': initialRiskLevelWeight,
      'mMinimumRiskValueThreshold': minimumRiskValueThreshold,
    };
  }

  @override
  String toString() {
    return '$DiagnosisConfiguration('
        'attenuationDurationThresholds: $attenuationDurationThresholds, '
        'attenuationRiskValues: $attenuationRiskValues, '
        'attenuationWeight: $attenuationWeight, '
        'daysAfterContactedRiskValues: $daysAfterContactedRiskValues, '
        'daysAfterContactedWeight: $daysAfterContactedWeight, '
        'durationRiskValues: $durationRiskValues, '
        'durationWeight: $durationWeight, '
        'initialRiskLevelRiskValues: $initialRiskLevelRiskValues, '
        'initialRiskLevelWeight: $initialRiskLevelWeight, '
        'minimumRiskValueThreshold: $minimumRiskValueThreshold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DiagnosisConfiguration &&
        listEquals(
          other.attenuationDurationThresholds,
          attenuationDurationThresholds,
        ) &&
        listEquals(other.attenuationRiskValues, attenuationRiskValues) &&
        other.attenuationWeight == attenuationWeight &&
        listEquals(
          other.daysAfterContactedRiskValues,
          daysAfterContactedRiskValues,
        ) &&
        other.daysAfterContactedWeight == daysAfterContactedWeight &&
        listEquals(other.durationRiskValues, durationRiskValues) &&
        other.durationWeight == durationWeight &&
        listEquals(
          other.initialRiskLevelRiskValues,
          initialRiskLevelRiskValues,
        ) &&
        other.initialRiskLevelWeight == initialRiskLevelWeight &&
        other.minimumRiskValueThreshold == minimumRiskValueThreshold;
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
