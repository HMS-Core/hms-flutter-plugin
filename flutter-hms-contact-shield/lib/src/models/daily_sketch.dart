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

class DailySketch {
  int daysSinceEpoch;
  List<SketchData?>? reportSketches;
  SketchData? sketchData;

  DailySketch({
    int? daysSinceEpoch,
    this.reportSketches,
    this.sketchData,
  }) : daysSinceEpoch = daysSinceEpoch ?? 0;

  SketchData? getSketchDataForReportType(int reportType) {
    if (!(reportType >= 0 && reportType <= 5)) {
      throw ArgumentError('reportType must be in [0,5]');
    }
    return reportSketches?[reportType];
  }

  factory DailySketch.fromJson(String str) {
    return DailySketch.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DailySketch.fromMap(Map<String, dynamic> map) {
    return DailySketch(
      daysSinceEpoch: map['daysSinceEpoch'],
      reportSketches: map['reportSketches'] == null
          ? null
          : List<SketchData>.from(
              map['reportSketches'].map((dynamic x) => SketchData.fromMap(x)),
            ),
      sketchData: map['sketchData'] == null
          ? null
          : SketchData.fromMap(map['sketchData']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'daysSinceEpoch': daysSinceEpoch,
      'reportSketches':
          reportSketches?.map((SketchData? x) => x?.toMap()).toList(),
      'sketchData': sketchData?.toMap(),
    };
  }

  @override
  String toString() {
    return '$DailySketch('
        'daysSinceEpoch: $daysSinceEpoch, '
        'reportSketches: $reportSketches, '
        'sketchData: $sketchData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DailySketch &&
        other.daysSinceEpoch == daysSinceEpoch &&
        listEquals(other.reportSketches, reportSketches) &&
        other.sketchData == sketchData;
  }

  @override
  int get hashCode {
    return daysSinceEpoch.hashCode ^
        reportSketches.hashCode ^
        sketchData.hashCode;
  }
}
