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

class ActivitySummary {
  /// [PaceSummary] Instance.
  PaceSummary? paceSummary;

  /// Statistical data points that consist from [SamplePoint]s.
  List<SamplePoint>? dataSummary;

  /// Segment statistical data list.
  List<SampleSection>? sectionSummary;

  ActivitySummary({
    this.paceSummary,
    this.dataSummary,
    this.sectionSummary,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paceSummary': paceSummary?.toMap(),
      'dataSummary': dataSummary != null
          ? List<Map<String, dynamic>>.from(
              dataSummary!.map((SamplePoint e) => e.toMap()),
            )
          : null,
      'sectionSummary': sectionSummary != null
          ? List<Map<String, dynamic>>.from(
              sectionSummary!.map((SampleSection e) => e._toMap()),
            )
          : null,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory ActivitySummary.fromMap(Map<dynamic, dynamic> map) {
    return ActivitySummary(
      paceSummary: map['paceSummary'] != null
          ? PaceSummary.fromMap(map['paceSummary'])
          : null,
      dataSummary: map['dataSummary'] != null
          ? List<SamplePoint>.from(
              map['dataSummary'].map((dynamic e) {
                return SamplePoint.fromMap(e);
              }),
            )
          : null,
      sectionSummary: map['sectionSummary'] != null
          ? List<SampleSection>.from(
              map['sectionSummary'].map((dynamic e) {
                return SampleSection._fromMap(e);
              }),
            )
          : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitySummary &&
        other.paceSummary == paceSummary &&
        listEquals(other.dataSummary, dataSummary) &&
        listEquals(other.sectionSummary, sectionSummary);
  }

  @override
  int get hashCode {
    return Object.hash(
      paceSummary,
      Object.hashAll(dataSummary ?? <dynamic>[]),
      Object.hashAll(sectionSummary ?? <dynamic>[]),
    );
  }
}
