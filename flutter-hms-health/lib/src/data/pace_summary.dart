/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

class PaceSummary {
  /// Pace per mile.
  Map<String, double>? britishPaceMap;

  /// Segment data table in the imperial system.
  Map<String, double>? britishPartTimeMap;

  /// Pace per kilometer.
  Map<String, double>? paceMap;

  /// Segment data table in the metric system.
  Map<String, double>? partTimeMap;

  /// Average pace.
  double? avgPace;

  /// Optimal pace.
  double? bestPace;

  PaceSummary({
    this.paceMap,
    this.britishPaceMap,
    this.partTimeMap,
    this.britishPartTimeMap,
    this.avgPace,
    this.bestPace,
  });

  factory PaceSummary.fromMap(Map<dynamic, dynamic> map) {
    return PaceSummary(
      avgPace: map['avgPace'],
      bestPace: map['bestPace'],
      britishPaceMap: map['britishPaceMap'] != null
          ? Map<String, double>.from(map['britishPaceMap'])
          : null,
      britishPartTimeMap: map['britishPartTimeMap'] != null
          ? Map<String, double>.from(map['britishPartTimeMap'])
          : null,
      paceMap: map['paceMap'] != null
          ? Map<String, double>.from(map['paceMap'])
          : null,
      partTimeMap: map['partTimeMap'] != null
          ? Map<String, double>.from(map['partTimeMap'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'britishPaceMap': britishPaceMap,
      'britishPartTimeMap': britishPartTimeMap,
      'partTimeMap': partTimeMap,
      'paceMap': paceMap,
      'avgPace': avgPace,
      'bestPace': bestPace,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is PaceSummary &&
        mapEquals(other.britishPaceMap, britishPaceMap) &&
        mapEquals(other.britishPartTimeMap, britishPartTimeMap) &&
        mapEquals(other.paceMap, paceMap) &&
        mapEquals(other.partTimeMap, partTimeMap) &&
        other.avgPace == avgPace &&
        other.bestPace == bestPace;
  }

  @override
  int get hashCode {
    return Object.hash(
      Object.hashAll(britishPaceMap?.values.toList() ?? <dynamic>[]),
      Object.hashAll(britishPartTimeMap?.values.toList() ?? <dynamic>[]),
      Object.hashAll(paceMap?.values.toList() ?? <dynamic>[]),
      Object.hashAll(partTimeMap?.values.toList() ?? <dynamic>[]),
      avgPace,
      bestPace,
    );
  }
}
