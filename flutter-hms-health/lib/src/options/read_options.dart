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

/// Request class for reading data.
///
/// The request can be used to specify the type of data to be read and grouped
/// parameters. The read request requires the setting of a time range and allows
/// data to be read in detail or summary mode.
class ReadOptions {
  DateTime? startTime;
  DateTime? endTime;
  TimeUnit timeUnit = TimeUnit.MILLISECONDS;
  int? duration;
  List<DataCollector>? dataCollectors;
  List<DataType>? dataTypes;

  List<Map<String, dynamic>>? _polymerizedDataCollectors;
  List<Map<String, dynamic>>? _polymerizedDataTypes;
  Map<String, dynamic>? _groupByTime;

  /// The maximum number of pages for the paginated query results.
  int? pageSize;

  /// Allows for query on the cloud.
  bool? allowRemoteInquiry;

  ReadOptions({
    this.startTime,
    this.endTime,
    this.timeUnit = TimeUnit.MILLISECONDS,
    this.pageSize,
    this.allowRemoteInquiry,
    this.dataCollectors,
    this.dataTypes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'timeUnit': describeEnum(timeUnit),
      'duration': duration,
      'dataCollectors': dataCollectors != null
          ? List<Map<String, dynamic>>.from(
              dataCollectors!.map((DataCollector e) => e.toMap()),
            )
          : null,
      'dataTypes': dataTypes != null
          ? List<Map<String, dynamic>>.from(
              dataTypes!.map((DataType e) => e.toMap()),
            )
          : null,
      'polymerizedDataCollectors': _polymerizedDataCollectors,
      'polymerizedDataTypes': _polymerizedDataTypes,
      'groupByTime': _groupByTime,
      'pageSize': pageSize,
      'allowRemoteInquiry': allowRemoteInquiry,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  /// Sets the group type to TYPE_TIME and sets the duration for each group.
  void groupByTime(
    int duration, {
    TimeUnit timeUnit = TimeUnit.MILLISECONDS,
  }) {
    _groupByTime = <String, dynamic>{
      'duration': duration,
      'timeUnit': describeEnum(timeUnit),
    };
  }

  /// Adds a new data type to the grouped data and sets the type of the grouped
  /// data to be returned.
  void polymerizeByDataType(
    DataType inputDataType,
    DataType outputDataType,
  ) {
    _polymerizedDataTypes ??= <Map<String, dynamic>>[];
    _polymerizedDataTypes?.add(
      <String, dynamic>{
        'inputDataType': inputDataType.toMap(),
        'outputDataType': outputDataType.toMap(),
      },
    );
  }

  /// Adds a data collector for reading data.
  void polymerizeByDataCollector(
    DataCollector dataCollector,
    DataType outputDataType,
  ) {
    _polymerizedDataCollectors ??= <Map<String, dynamic>>[];
    _polymerizedDataCollectors?.add(
      <String, dynamic>{
        'dataCollector': dataCollector.toMap(),
        'outputDataType': outputDataType.toMap(),
      },
    );
  }
}
