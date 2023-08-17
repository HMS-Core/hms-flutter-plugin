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

class HealthRecord {
  DateTime startTime;
  DateTime endTime;
  DataCollector dataCollector;
  String? metadata;
  Map<String, dynamic> fieldValues = <String, dynamic>{};
  List<SamplePoint> subDataSummary = <SamplePoint>[];
  List<SampleSet> subDataDetails = <SampleSet>[];
  String? healthRecordId;
  final List<Map<String, dynamic>> _fieldValueList = <Map<String, dynamic>>[];
  final List<Map<String, dynamic>> _setList = <Map<String, dynamic>>[];
  final List<Map<String, dynamic>> _pointList = <Map<String, dynamic>>[];

  HealthRecord({
    required this.dataCollector,
    required this.startTime,
    required this.endTime,
    this.healthRecordId,
    this.metadata,
  });

  void setStartTime(DateTime st) {
    startTime = st;
  }

  void setEndTime(DateTime et) {
    endTime = et;
  }

  void setDataCollector(DataCollector collector) {
    dataCollector = collector;
  }

  void setMetaData(String s) {
    metadata = s;
  }

  void setSubDataSummary(List<SamplePoint> samplePoints) {
    for (SamplePoint point in samplePoints) {
      if (!_pointList.contains(point.toMap())) {
        _pointList.add(point.toMap());
      }
    }
  }

  void setSubDataDetails(List<SampleSet> sampleSets) {
    for (SampleSet s in sampleSets) {
      if (!_setList.contains(s.toMap())) {
        _setList.add(s.toMap());
      }
    }
  }

  void setFieldValue(Field field, dynamic value) {
    if (value is int || value is double) {
      final Map<String, dynamic> map = <String, dynamic>{
        'field': field.toMap(),
        'value': value,
      };
      if (!_fieldValueList.contains(map)) {
        _fieldValueList.add(map);
      }
    }
  }

  factory HealthRecord.fromMap(Map<dynamic, dynamic> map) {
    return HealthRecord(
      metadata: map['metadata'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      dataCollector: DataCollector.fromMap(map['dataCollector']),
      healthRecordId: map['healthRecordId'],
    )
      ..fieldValues = Map<String, dynamic>.from(map['fieldValues'])
      ..subDataSummary = List<SamplePoint>.from(
        map['subDataSummary'].map((dynamic m) => SamplePoint.fromMap(m)),
      )
      ..subDataDetails = List<SampleSet>.from(
        map['subDataDetails'].map((dynamic m) => SampleSet.fromMap(m)),
      );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime.millisecondsSinceEpoch.toString(),
      'endTime': endTime.millisecondsSinceEpoch.toString(),
      'dataCollector': dataCollector.toMap(),
      'metadata': metadata,
      'subSummary': _pointList,
      'subDetails': _setList,
      'fields': _fieldValueList,
      'healthRecordId': healthRecordId,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  String toJson() => json.encode(toMap());
}
