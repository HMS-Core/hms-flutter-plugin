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

/// Sampling point class, which presents the sampled data of a specific type collected
/// by a specific data collector at a given time or within a time range. It stores
/// the values of each dimension of the data type at the given time (or within the time range)
/// and the start time and end time of the sampling operation.
///
/// The sampling modes of sampling points are classified into instantaneous sampling
/// and continuous sampling based on the definition of data types.
///
/// When setting the sampling point time, you are advised to call setSamplingTime()
/// for instantaneous sampling data and setTimeInterval() for continuous sampling
/// data (make sure to set a valid time duration). In addition, you can also call
/// setTimeInterval() to set the time for instantaneous sampling data. Make sure
/// that the passed start time and end time are the same. Otherwise, the creation
/// will fail.
///
/// The setSamplingTime() API cannot be used when creating the continuous sampling point.
/// Otherwise, the creation will fail. This API can be used to update the end time
/// of a created continuous sampling point. After the API is called, only the end time
/// will be updated.
class SamplePoint {
  int? id;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? samplingTime;
  TimeUnit timeUnit;
  String? metadata;
  bool _isSampling = false;
  DateTime? _insertionTime;

  FieldValueOptions? fieldValueOptions;
  Map<String, dynamic>? _fieldValues;
  final DataCollector? dataCollector;
  final DataType? dataType;
  int? _dataTypeId;
  final List<Map<String, dynamic>> _metaDataValues = <Map<String, dynamic>>[];

  Map<String, dynamic> pairs = <String, dynamic>{};

  /// You must set dataCollector or dataType.
  SamplePoint({
    this.dataCollector,
    this.dataType,
    this.id,
    this.startTime,
    this.endTime,
    this.samplingTime,
    this.fieldValueOptions,
    this.timeUnit = TimeUnit.MILLISECONDS,
    this.metadata,
  }) : assert(dataCollector != null || dataType != null) {
    for (Field field
        in dataCollector?.dataType?.fields ?? dataType?.fields ?? <Field>[]) {
      pairs[field.name] = null;
    }
  }

  DateTime? get getInsertionTime => _insertionTime;

  /// Obtains the field values that are returned from the native platform.
  ///
  /// For example, while using the [AutoRecorderController] API, the resulting
  /// step count data can be obtained from this field.
  Map<String, dynamic>? get fieldValues => _fieldValues;

  int? get getDataTypeId => _dataTypeId;

  DataType? get getDataType => dataType;

  /// Sets the sampling timestamp of instantaneous data.
  void setSamplingTime(DateTime timestamp, TimeUnit timeUnit) {
    samplingTime = timestamp;
    this.timeUnit = timeUnit;
    _isSampling = false;
  }

  /// Sets the sampling timestamp of data within an interval.
  void setTimeInterval(
    DateTime startTime,
    DateTime endTime,
    TimeUnit timeUnit,
  ) {
    this.startTime = startTime;
    this.endTime = endTime;
    this.timeUnit = timeUnit;
    _isSampling = true;
  }

  void addMetadata(String key, String value) {
    final Map<String, dynamic> map = <String, dynamic>{
      'key': key,
      'value': value,
    };
    if (!_metaDataValues.contains(map)) {
      _metaDataValues.add(map);
    }
  }

  void setFieldValue(Field field, dynamic value) {
    pairs[field.name] = value;
  }

  factory SamplePoint.fromMap(Map<dynamic, dynamic> map) {
    SamplePoint instance = SamplePoint(
      id: map['id'],
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      samplingTime: map['samplingTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['samplingTime'])
          : null,
      dataCollector: map['dataCollector'] != null
          ? DataCollector.fromMap(map['dataCollector'])
          : null,
      dataType:
          map['dataType'] != null ? DataType.fromMap(map['dataType']) : null,
    );
    if (map['insertionTime'] != null) {
      instance._insertionTime =
          DateTime.fromMillisecondsSinceEpoch(map['insertionTime']);
    }
    if (map['fieldValues'] != null) {
      instance._fieldValues = Map<String, dynamic>.from(map['fieldValues']);
    }
    if (map['dataTypeId'] != null) {
      instance._dataTypeId = map['dataTypeId'];
    }
    return instance;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime?.millisecondsSinceEpoch.toString(),
      'endTime': endTime?.millisecondsSinceEpoch.toString(),
      'samplingTime': samplingTime?.millisecondsSinceEpoch.toString(),
      'timeUnit': describeEnum(timeUnit),
      'isSampling': _isSampling,
      'fieldValue': fieldValueOptions?.toMap(),
      'platformFieldValues': _fieldValues,
      'dataCollector': dataCollector?.toMap(),
      'dataType': dataType?.toMap(),
      'metadataValues': _metaDataValues,
      'pairs': pairs,
      'metadata': metadata,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is SamplePoint &&
        other.id == id &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.samplingTime == samplingTime &&
        other.timeUnit == timeUnit &&
        other.fieldValueOptions == fieldValueOptions &&
        other.dataCollector == dataCollector &&
        other._isSampling == _isSampling &&
        other._insertionTime == _insertionTime &&
        mapEquals(other._fieldValues, _fieldValues) &&
        other._dataTypeId == _dataTypeId &&
        other.dataType == dataType;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      startTime,
      endTime,
      samplingTime,
      timeUnit,
      fieldValueOptions,
      dataCollector,
      _isSampling,
      _insertionTime,
      Object.hashAll(_fieldValues?.values.toList() ?? <dynamic>[]),
      _dataTypeId,
      dataType,
    );
  }
}

/// Base class for FieldValueOptions.
///
/// This class contain the specified [Field] and the
/// corresponding value for that [Field].
abstract class FieldValueOptions {
  final Field field;
  final dynamic value;

  FieldValueOptions(
    this.field,
    this.value,
  );

  Map<String, dynamic> toMap();

  @override
  bool operator ==(Object other) {
    return other is FieldValueOptions &&
        other.field == field &&
        other.value == value;
  }

  @override
  int get hashCode {
    return Object.hash(
      field,
      value,
    );
  }
}

/// Sets the integer attribute value of a sampling point.
class FieldInt implements FieldValueOptions {
  @override
  Field field;

  @override
  final int value;

  FieldInt(
    this.field,
    this.value,
  );

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.unmodifiable(
      <String, dynamic>{
        'field': field.toMap(),
        'intValue': value,
      },
    );
  }
}

/// Sets the long integer attribute value of a sampling point.
///
/// Different from [FieldInt], this option's value will be set as long integer in
/// Android Platfom.
class FieldLong implements FieldValueOptions {
  @override
  Field field;

  @override
  final int value;

  FieldLong(
    this.field,
    this.value,
  );

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.unmodifiable(
      <String, dynamic>{
        'field': field.toMap(),
        'longValue': value,
      },
    );
  }
}

/// Sets the double-precision floating-point attribute value of a sampling point.
class FieldFloat implements FieldValueOptions {
  @override
  Field field;

  @override
  final double value;

  FieldFloat(
    this.field,
    this.value,
  );

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.unmodifiable(
      <String, dynamic>{
        'field': field.toMap(),
        'floatValue': value,
      },
    );
  }
}

/// Sets the mapped attribute value of a sampling point.
class FieldMap implements FieldValueOptions {
  @override
  Field field;

  @override
  final Map<String, double> value;

  FieldMap(
    this.field,
    this.value,
  );

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.unmodifiable(
      <String, dynamic>{
        'field': field.toMap(),
        'mapValue': value,
      },
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FieldMap &&
        other.field == field &&
        mapEquals(other.value, value);
  }

  @override
  int get hashCode {
    return Object.hash(
      field,
      Object.hashAll(value.values),
    );
  }
}

/// Sets the string attribute value of a sampling point.
class FieldString implements FieldValueOptions {
  @override
  Field field;

  @override
  final String value;

  FieldString(
    this.field,
    this.value,
  );

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.unmodifiable(
      <String, dynamic>{
        'field': field.name,
        'stringValue': value,
      },
    );
  }
}
