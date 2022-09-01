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

class ContactSketch {
  List<int> attenuationDurations;
  int daysSinceLastHit;
  int maxRiskValue;
  int numberOfHits;
  int summationRiskValue;

  ContactSketch({
    this.attenuationDurations = const <int>[0, 0, 0],
    this.daysSinceLastHit = 0,
    this.maxRiskValue = 0,
    this.numberOfHits = 0,
    this.summationRiskValue = 0,
  });

  factory ContactSketch.fromJson(String str) {
    return ContactSketch.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ContactSketch.fromMap(Map<String, dynamic> json) {
    return ContactSketch(
      attenuationDurations: json['attenuationDurations'] == null
          ? <int>[0, 0, 0]
          : List<int>.from(
              json['attenuationDurations'].map((dynamic x) => x),
            ),
      daysSinceLastHit: json['daysSinceLastHit'] ?? 0,
      maxRiskValue: json['maxRiskValue'] ?? 0,
      numberOfHits: json['numberOfHits'] ?? 0,
      summationRiskValue: json['summationRiskValue'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attenuationDurations': attenuationDurations,
      'daysSinceLastHit': daysSinceLastHit,
      'maxRiskValue': maxRiskValue,
      'numberOfHits': numberOfHits,
      'summationRiskValue': summationRiskValue,
    };
  }

  @override
  String toString() {
    return '$ContactSketch('
        'attenuationDurations: $attenuationDurations, '
        'daysSinceLastHit: $daysSinceLastHit, '
        'maxRiskValue: $maxRiskValue, '
        'numberOfHits: $numberOfHits, '
        'summationRiskValue: $summationRiskValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ContactSketch &&
        listEquals(other.attenuationDurations, attenuationDurations) &&
        other.daysSinceLastHit == daysSinceLastHit &&
        other.maxRiskValue == maxRiskValue &&
        other.numberOfHits == numberOfHits &&
        other.summationRiskValue == summationRiskValue;
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
