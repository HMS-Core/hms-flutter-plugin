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

class PeriodicKey {
  Int8List? content;
  int? initialRiskLevel;
  int? periodicKeyLifeTime;
  int? periodicKeyValidTime;
  int? reportType;
  int? daysSinceStartOfSymptoms;

  PeriodicKey({
    this.content,
    this.initialRiskLevel = 0,
    this.periodicKeyLifeTime = 0,
    this.periodicKeyValidTime = 0,
    this.reportType = 0,
    this.daysSinceStartOfSymptoms = 0,
  });

  factory PeriodicKey.fromJson(String str) {
    return PeriodicKey.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory PeriodicKey.fromMap(Map<String, dynamic> json) {
    return PeriodicKey(
      content: json['content'] == null
          ? null
          : _parseIntListAsInt8List(json['content']),
      initialRiskLevel: json['initialRiskLevel'],
      periodicKeyLifeTime: json['periodicKeyLifeTime'],
      periodicKeyValidTime: json['periodicKeyValidTime'],
      reportType: json['reportType'],
      daysSinceStartOfSymptoms: json['daysSinceStartOfSymptoms'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'initialRiskLevel': initialRiskLevel,
      'periodicKeyLifeTime': periodicKeyLifeTime,
      'periodicKeyValidTime': periodicKeyValidTime,
      'reportType': reportType,
      'daysSinceStartOfSymptoms': daysSinceStartOfSymptoms,
    };
  }

  @override
  String toString() {
    return '$PeriodicKey('
        'content: $content, '
        'initialRiskLevel: $initialRiskLevel, '
        'periodicKeyLifeTime: $periodicKeyLifeTime, '
        'periodicKeyValidTime: $periodicKeyValidTime, '
        'reportType: $reportType, '
        'daysSinceStartOfSymptoms: $daysSinceStartOfSymptoms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PeriodicKey &&
        listEquals(other.content?.toList(), content?.toList()) &&
        other.initialRiskLevel == initialRiskLevel &&
        other.periodicKeyLifeTime == periodicKeyLifeTime &&
        other.periodicKeyValidTime == periodicKeyValidTime &&
        other.reportType == reportType &&
        other.daysSinceStartOfSymptoms == daysSinceStartOfSymptoms;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        initialRiskLevel.hashCode ^
        periodicKeyLifeTime.hashCode ^
        periodicKeyValidTime.hashCode ^
        reportType.hashCode ^
        daysSinceStartOfSymptoms.hashCode;
  }

  static Int8List _parseIntListAsInt8List(List<dynamic> items) {
    return Int8List.fromList(List<int>.from(items));
  }
}
