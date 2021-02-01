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
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class PeriodicKey {
  Int8List content;
  int initialRiskLevel;
  int periodicKeyLifeTime;
  int periodicKeyValidTime;
  int reportType;
  int daysSinceStartOfSymptoms;

  PeriodicKey({
    this.content,
    this.initialRiskLevel = 0,
    this.periodicKeyLifeTime = 0,
    this.periodicKeyValidTime = 0,
    this.reportType = 0,
    this.daysSinceStartOfSymptoms = 0,
  });

  factory PeriodicKey.fromJson(String str) =>
      PeriodicKey.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PeriodicKey.fromMap(Map<String, dynamic> json) {
    return PeriodicKey(
      content: json["content"] == null
          ? null
          : _parseIntListAsInt8List(json["content"]),
      initialRiskLevel:
          json["initialRiskLevel"] == null ? null : json["initialRiskLevel"],
      periodicKeyLifeTime: json["periodicKeyLifeTime"] == null
          ? null
          : json["periodicKeyLifeTime"],
      periodicKeyValidTime: json["periodicKeyValidTime"] == null
          ? null
          : json["periodicKeyValidTime"],
      reportType: json["reportType"] == null ? null : json["reportType"],
      daysSinceStartOfSymptoms: json["daysSinceStartOfSymptoms"] == null
          ? null
          : json["daysSinceStartOfSymptoms"],
    );
  }

  Map<String, dynamic> toMap() => {
        "content":
            content == null ? null : List<dynamic>.from(content.map((x) => x)),
        "initialRiskLevel": initialRiskLevel,
        "periodicKeyLifeTime": periodicKeyLifeTime,
        "periodicKeyValidTime": periodicKeyValidTime,
        "reportType": reportType,
        "daysSinceStartOfSymptoms": daysSinceStartOfSymptoms,
      };

  @override
  String toString() {
    return 'PeriodicKey(content: $content, initialRiskLevel: $initialRiskLevel, periodicKeyLifeTime: $periodicKeyLifeTime, periodicKeyValidTime: $periodicKeyValidTime, reportType: $reportType, daysSinceStartOfSymptoms: $daysSinceStartOfSymptoms)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PeriodicKey &&
        listEquals(o.content.toList(), content.toList()) &&
        o.initialRiskLevel == initialRiskLevel &&
        o.periodicKeyLifeTime == periodicKeyLifeTime &&
        o.periodicKeyValidTime == periodicKeyValidTime &&
        o.reportType == reportType &&
        o.daysSinceStartOfSymptoms == daysSinceStartOfSymptoms;
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
    List<int> intList = List<int>.from(items);
    return Int8List.fromList(intList);
  }
}
