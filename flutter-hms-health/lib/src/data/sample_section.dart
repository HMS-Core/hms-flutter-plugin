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

class SampleSection {
  /// Segment index.
  final int? sectionNum;

  /// Segment interval.
  final int? sectionTime;

  /// Start time of a segment.
  final int? startTime;

  /// End time of a segment.
  final int? endTime;

  /// Segment statistical data list.
  final List<SamplePoint> sectionDataList;

  const SampleSection({
    this.sectionNum,
    this.sectionTime,
    this.startTime,
    this.endTime,
    this.sectionDataList = const <SamplePoint>[],
  });

  factory SampleSection._fromMap(Map<dynamic, dynamic> map) {
    return SampleSection(
      sectionNum: map['sectionNum'],
      sectionTime: map['sectionTime'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      sectionDataList: map['sectionDataList'] != null
          ? List<SamplePoint>.from(
              map['sectionDataList'].map((dynamic e) {
                return SamplePoint.fromMap(e);
              }),
            )
          : const <SamplePoint>[],
    );
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'sectionNum': sectionNum,
      'sectionTime': sectionTime,
      'startTime': startTime,
      'endTime': endTime,
      'sectionDataList': List<Map<String, dynamic>>.from(
        sectionDataList.map(
          (SamplePoint e) => e.toMap(),
        ),
      ),
    };
  }
}
