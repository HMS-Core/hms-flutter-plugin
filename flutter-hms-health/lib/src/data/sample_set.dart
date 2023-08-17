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

/// The sampling dataset class represents the container for storing sampling points.
///
/// The sampling points stored in a sampling dataset must be from the same data collector
/// (but their raw data collectors can be different). This class is usually used to
/// insert or read sampling data in batches.
class SampleSet {
  DataCollector dataCollector;
  List<SamplePoint> samplePoints;

  Map<String, dynamic> pairs = <String, dynamic>{};

  SampleSet(
    this.dataCollector,
    this.samplePoints,
  );

  factory SampleSet.fromMap(Map<dynamic, dynamic> map) {
    return SampleSet(
      DataCollector.fromMap(map['dataCollector']),
      List<SamplePoint>.from(
        map['samplePoints'].map(
          (dynamic e) {
            return SamplePoint.fromMap(e);
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataCollector': dataCollector.toMap(),
      'samplePoints': List<Map<String, dynamic>>.from(
        samplePoints.map((SamplePoint e) => e.toMap()),
      ),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  DataType? get getDataType => dataCollector.dataType;

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is SampleSet &&
        other.dataCollector == dataCollector &&
        listEquals(other.samplePoints, samplePoints);
  }

  @override
  int get hashCode {
    return Object.hash(
      dataCollector,
      Object.hashAll(samplePoints),
    );
  }
}
