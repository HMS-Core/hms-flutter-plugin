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
import 'package:huawei_contactshield/models/sketch_data.dart';

class DailySketch {
  int daysSinceEpoch;
  List<SketchData> reportSketches;
  SketchData sketchData;

  DailySketch({
    int daysSinceEpoch,
    this.reportSketches,
    this.sketchData,
  }) : daysSinceEpoch = daysSinceEpoch ?? 0;

  SketchData getSketchDataForReportType(int reportType) {
    if (!(reportType >= 0 && reportType <= 5)) {
      throw ArgumentError("reportType must be in [0,5]");
    }
    return reportSketches[reportType];
  }

  factory DailySketch.fromJson(String str) =>
      DailySketch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailySketch.fromMap(Map<String, dynamic> map) {
    return map == null
        ? null
        : DailySketch(
            daysSinceEpoch:
                map["daysSinceEpoch"] == null ? null : map["daysSinceEpoch"],
            reportSketches: map["reportSketches"] == null
                ? null
                : List<SketchData>.from(
                    map["reportSketches"].map((x) => SketchData.fromMap(x)),
                  ),
            sketchData: map["sketchData"] == null
                ? null
                : SketchData.fromMap(map["sketchData"]),
          );
  }

  Map<String, dynamic> toMap() => {
        "daysSinceEpoch": daysSinceEpoch == null ? null : daysSinceEpoch,
        "reportSketches": reportSketches?.map((x) => x?.toMap())?.toList(),
        "sketchData": sketchData?.toMap(),
      };

  @override
  String toString() {
    return 'DailySketch(daysSinceEpoch: $daysSinceEpoch, reportSketches: $reportSketches, sketchData: $sketchData)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DailySketch &&
        o.daysSinceEpoch == daysSinceEpoch &&
        listEquals(o.reportSketches, reportSketches) &&
        o.sketchData == sketchData;
  }

  @override
  int get hashCode {
    return daysSinceEpoch.hashCode ^
        reportSketches.hashCode ^
        sketchData.hashCode;
  }
}
