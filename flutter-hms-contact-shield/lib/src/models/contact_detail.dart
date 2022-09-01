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

class ContactDetail {
  List<int> attenuationDurations;
  int attenuationRiskValue;
  int dayNumber;
  int durationMinutes;
  int initialRiskLevel;
  int totalRiskValue;

  ContactDetail({
    List<int>? attenuationDurations,
    this.attenuationRiskValue = 0,
    this.dayNumber = 0,
    this.durationMinutes = 0,
    this.initialRiskLevel = 0,
    this.totalRiskValue = 0,
  }) : attenuationDurations = attenuationDurations ?? <int>[0, 0, 0];

  factory ContactDetail.fromJson(String str) {
    return ContactDetail.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ContactDetail.fromMap(Map<String, dynamic> map) {
    return ContactDetail(
      attenuationDurations: map['attenuationDurations'] == null
          ? null
          : List<int>.from(
              map['attenuationDurations'].map((dynamic x) => x),
            ),
      attenuationRiskValue: map['attenuationRiskValue'],
      dayNumber: map['dayNumber'],
      durationMinutes: map['durationMinutes'],
      initialRiskLevel: map['initialRiskLevel'],
      totalRiskValue: map['totalRiskValue'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attenuationDurations': attenuationDurations,
      'attenuationRiskValue': attenuationRiskValue,
      'dayNumber': dayNumber,
      'durationMinutes': durationMinutes,
      'initialRiskLevel': initialRiskLevel,
      'totalRiskValue': totalRiskValue,
    };
  }

  @override
  String toString() {
    return '$ContactDetail('
        'attenuationDurations: $attenuationDurations, '
        'attenuationRiskValue: $attenuationRiskValue, '
        'dayNumber: $dayNumber, '
        'durationMinutes: $durationMinutes, '
        'initialRiskLevel: $initialRiskLevel, '
        'totalRiskValue: $totalRiskValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ContactDetail &&
        listEquals(other.attenuationDurations, attenuationDurations) &&
        other.attenuationRiskValue == attenuationRiskValue &&
        other.dayNumber == dayNumber &&
        other.durationMinutes == durationMinutes &&
        other.initialRiskLevel == initialRiskLevel &&
        other.totalRiskValue == totalRiskValue;
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
