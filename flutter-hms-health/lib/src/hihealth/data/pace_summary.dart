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

import 'dart:ui';

import 'package:huawei_health/src/hihealth/util/util.dart';

class PaceSummary {
  /// Pace per mile.
  Map<String, double> britishPaceMap;

  /// Segment data table in the imperial system.
  Map<String, double> britishPartTimeMap;

  /// Pace per kilometer.
  Map<String, double> paceMap;

  /// Segment data table in the metric system.
  Map<String, double> partTimeMap;

  /// Health pace records.
  Map<String, double> sportHealthPaceMap;

  /// Average pace.
  double avgPace;

  /// Optimal pace.
  double bestPace;

  PaceSummary(
      {this.paceMap,
      this.britishPaceMap,
      this.partTimeMap,
      this.britishPartTimeMap,
      this.avgPace,
      this.bestPace,
      this.sportHealthPaceMap});

  factory PaceSummary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return PaceSummary(
        avgPace: map['avgPace'] != null ? map['avgPace'] : null,
        bestPace: map['bestPace'] != null ? map['bestPace'] : null,
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
        sportHealthPaceMap: map['sportHealthPaceMap'] != null
            ? Map<String, double>.from(map['sportHealthPaceMap'])
            : null);
  }

  Map<String, dynamic> toMap() {
    return {
      "britishPaceMap": britishPaceMap,
      "britishPartTimeMap": britishPartTimeMap,
      "partTimeMap": partTimeMap,
      "paceMap": paceMap,
      "sportsHealthPaceMap": sportHealthPaceMap,
      "avgPace": avgPace,
      "bestPace": bestPace
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    PaceSummary compare = other;
    List<dynamic> currentArgs = [
      britishPaceMap,
      britishPartTimeMap,
      paceMap,
      partTimeMap,
      sportHealthPaceMap,
      avgPace,
      bestPace
    ];
    List<dynamic> otherArgs = [
      compare.britishPaceMap,
      compare.britishPartTimeMap,
      compare.paceMap,
      compare.partTimeMap,
      compare.sportHealthPaceMap,
      compare.avgPace,
      compare.bestPace
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(
      hashList(britishPaceMap?.values),
      hashList(britishPartTimeMap?.values),
      hashList(paceMap?.values),
      hashList(partTimeMap?.values),
      hashList(sportHealthPaceMap?.values),
      avgPace,
      bestPace);
}
