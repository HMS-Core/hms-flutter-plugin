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

/// Determines the API for data management.
///
/// The user can use this API to insert, delete, update, and read data, as well
/// as query the data statistics of the current day and past days.
class DataController {
  static const MethodChannel _channel = _healthDataControllerMethodChannel;

  static final DataController _instance = DataController._();

  DataController._();

  /// Initializes a DataController instance.
  static Future<DataController> init() async {
    await _channel.invokeMethod(
      'init',
    );
    return _instance;
  }

  /// Clears all data inserted by the app from the device and the cloud.
  Future<void> clearAll() async {
    await _channel.invokeMethod<void>(
      'clearAll',
    );
  }

  /// Deletes inserted sampling datasets by specifying a time range or deletes
  /// them all. It can also be used to delete workout records.
  Future<void> delete(
    DeleteOptions options,
  ) async {
    await _channel.invokeMethod<void>(
      'delete',
      options.toMap(),
    );
  }

  /// Inserts a sampling dataset into the Health platform.
  Future<void> insert(
    SampleSet sampleSet,
  ) async {
    await _channel.invokeMethod<void>(
      'insert',
      sampleSet.toMap(),
    );
  }

  /// Reads user data.
  ///
  /// You can read data by time, device, data collector, and more by specifying
  /// the related parameters in ReadOptions.
  Future<ReadReply?> read(
    ReadOptions readOptions,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'read',
      readOptions.toMap(),
    );
    if (result == null) {
      return null;
    }
    return ReadReply.fromMap(result);
  }

  /// Reads the daily statistics of a specified data type.
  ///
  /// You can set the data type, start time, and end time to read the daily
  /// statistics in the specified period. If the related data type does not
  /// support aggregation statistics, an exception will be thrown.
  Future<SampleSet?> readDailySummation(
    DataType dataType,
    int startTime,
    int endTime,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'readDailySummation',
      <String, dynamic>{
        'dataType': dataType.toMap(),
        'startTime': startTime,
        'endTime': endTime,
      },
    );
    if (result == null) {
      return null;
    }
    return SampleSet.fromMap(result);
  }

  /// Reads the daily statistics of multiple data types.
  ///
  /// You can set the data types, start time, and end time to read the daily
  /// statistics in the specified period. If the related data types does not
  /// support aggregation statistics, an exception will be thrown.
  Future<List<SampleSet?>?> readDailySummationList(
    List<DataType> dataTypes,
    int startTime,
    int endTime,
  ) async {
    final List<dynamic>? result =
        await _channel.invokeMethod<List<dynamic>?>(
      'readDailySummationList',
      <String, dynamic>{
        'dataType': DataType.toMapList(dataTypes),
        'startTime': startTime,
        'endTime': endTime,
      },
    );
    List<SampleSet> records = <SampleSet>[];
    if (result != null) {
      for (dynamic e in result) {
        records.add(SampleSet.fromMap(e));
      }
    }
    return records;
  }

  /// Reads the summary data of a specified data type of the current day.
  ///
  /// If the related data type does not support aggregation statistics, an
  /// exception will be thrown.
  Future<SampleSet?> readTodaySummation(
    DataType dataType,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'readTodaySummation',
      dataType.toMap(),
    );
    if (result == null) {
      return null;
    }
    return SampleSet.fromMap(result);
  }

  /// Reads the summary data of multiple data types of the current day.
  ///
  /// If the related data type does not support aggregation statistics, an
  /// exception will be thrown.
  Future<List<SampleSet?>?> readTodaySummationList(
    List<DataType> dataTypes,
  ) async {
    final List<dynamic>? result =
        await _channel.invokeMethod<List<dynamic>?>(
      'readTodaySummationList',
      DataType.toMapList(dataTypes),
    );
   List<SampleSet> records = <SampleSet>[];
    if (result != null) {
      for (dynamic e in result) {
        records.add(SampleSet.fromMap(e));
      }
    }
    return records;
  }

  /// Updates existing data.
  ///
  /// If the update target does not exist, a new entry of data will be inserted.
  Future<void> update(
    UpdateOptions options,
  ) async {
    await _channel.invokeMethod<void>(
      'update',
      options.toMap(),
    );
  }

  /// Reads the latest data points of the specified data type.
  ///
  /// Currently, only the following data types can be read:
  ///
  /// Height: DataType.DT_INSTANTANEOUS_HEIGHT
  ///
  /// Weight: DataType.DT_INSTANTANEOUS_BODY_WEIGHT
  ///
  /// Heart rate: DataType.DT_INSTANTANEOUS_HEART_RATE
  ///
  /// Stress: DataType.DT_INSTANTANEOUS_STRESS
  ///
  /// Blood pressure: HealthDataTypes.DT_INSTANTANEOUS_BLOOD_PRESSURE
  ///
  /// Blood glucose: HealthDataTypes.DT_INSTANTANEOUS_BLOOD_GLUCOSE
  ///
  /// Blood oxygen: HealthDataTypes.DT_INSTANTANEOUS_SPO2
  Future<Map<DataType, SamplePoint>> readLatestData(
    List<DataType> types,
    String packageName,
  ) async {
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (DataType type in types) {
      list.add(type.toMap());
    }

    final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>?>(
      'readLatestData',
      <String, dynamic>{
        'types': list,
        'packageName': packageName,
      },
    );

    Map<DataType, SamplePoint> resultMap = <DataType, SamplePoint>{};
    if (result != null) {
      for (dynamic map in result) {
        final DataType dataType = DataType.fromMap(map['dataType']);
        final SamplePoint samplePoint = SamplePoint.fromMap(map);
        resultMap[dataType] = samplePoint;
      }
    }
    return resultMap;
  }
}
