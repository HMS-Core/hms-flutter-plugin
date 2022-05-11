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

part of huawei_health;

/// The sampling dataset class represents the container for storing sampling points.
///
/// The sampling points stored in a sampling dataset must be from the same data collector
/// (but their raw data collectors can be different). This class is usually used to
/// insert or read sampling data in batches.
class SampleSet {
  DataCollector dataCollector;
  List<SamplePoint> samplePoints;

  //List<SamplePoint> _points;
  DateTime? _start;
  DateTime? _end;
  TimeUnit _timeUnit = TimeUnit.MILLISECONDS;

  Map<String, dynamic> pairs = <String, dynamic>{};

  SampleSet(
    this.dataCollector,
    this.samplePoints,
  ) {
    for (Field field in dataCollector.dataType?.fields ?? <Field>[]) {
      pairs[field.name] = null;
    }
  }

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

  // void addSample(SamplePoint samplePoint) {
  //   if (samplePoint.dataCollector.dataType != this.dataCollector.dataType) {
  //     throw 'Please add a sample point with same data type';
  //   }

  //   if (!_points.contains(samplePoint)) {
  //     _points.add(samplePoint);
  //   }
  // }

  void setTimeInterval(DateTime start, DateTime end, TimeUnit timeUnit) {
    _start = start;
    _end = end;
    _timeUnit = timeUnit;
  }

  void setFieldValue(Field field, dynamic value) {
    pairs[field.name] = value;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataCollector': dataCollector.toMap(),
      'samplePoints': List<Map<String, dynamic>>.from(
        samplePoints.map((SamplePoint e) => e.toMap()),
      ),
      'pairs': pairs,
      'startTime': _start?.millisecondsSinceEpoch,
      'endTime': _end?.millisecondsSinceEpoch,
      'timeUnit': describeEnum(_timeUnit),
      //"points": List.from(_points.map((e) => e.toMap())),
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
    return hashValues(
      dataCollector,
      hashList(samplePoints),
    );
  }
}
