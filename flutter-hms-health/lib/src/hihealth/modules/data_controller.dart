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

import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/options/hihealth_option.dart';
import 'package:huawei_health/src/hihealth/options/read_options.dart';
import 'package:huawei_health/src/hihealth/options/update_options.dart';
import 'package:huawei_health/src/hihealth/result/read_reply.dart';

/// Determines the API for data management.
///
/// The user can use this API to insert, delete, update, and read data, as well
/// as query the data statistics of the current day and past days.
class DataController {
  static final MethodChannel _channel = health_data_controller_method_channel;

  static final _instance = DataController._();

  DataController._();

  /// Initializes a DataController instance by a list of [HiHealthOption] objects
  /// that define data types and read and write permissions.
  static Future<DataController> init(
      List<HiHealthOption> hiHealthOptions) async {
    if (_instance != null) {
      _channel.invokeMethod(
          "init",
          List<Map<String, dynamic>>.from(
              hiHealthOptions.map((e) => e.toMap())));
    }
    return _instance;
  }

  /// Clears all data inserted by the app from the device and the cloud.
  Future<void> clearAll() async {
    _channel.invokeMethod("clearAll");
  }

  /// Deletes inserted sampling datasets by specifying a time range or deletes
  /// them all. It can also be used to delete workout records.
  Future<void> delete(DeleteOptions options) async {
    _channel.invokeMethod("delete", options.toMap());
  }

  /// Inserts a sampling dataset into the Health platform.
  Future<void> insert(SampleSet sampleSet) async {
    _channel.invokeMethod("insert", sampleSet.toMap());
  }

  /// Reads user data.
  ///
  /// You can read data by time, device, data collector, and more by specifying
  /// the related parameters in ReadOptions.
  Future<ReadReply> read(ReadOptions readOptions) async {
    final resultMap = await _channel.invokeMethod("read", readOptions.toMap());
    return ReadReply.fromMap(Map<String, dynamic>.from(resultMap));
  }

  /// Reads the daily statistics of a specified data type.
  ///
  /// You can set the data type, start time, and end time to read the daily
  /// statistics in the specified period. If the related data type does not
  /// support aggregation statistics, an exception will be thrown.
  Future<SampleSet> readDailySummation(
      DataType dataType, int startTime, int endTime) async {
    Map<String, dynamic> callMap = {
      "dataType": dataType?.toMap(),
      "startTime": startTime,
      "endTime": endTime
    };
    final resultMap =
        await _channel.invokeMethod("readDailySummation", callMap);
    return SampleSet.fromMap(Map<String, dynamic>.from(resultMap));
  }

  /// Reads the summary data of a specified data type of the current day.
  ///
  /// If the related data type does not support aggregation statistics, an
  /// exception will be thrown.
  Future<SampleSet> readTodaySummation(DataType dataType) async {
    final resultMap =
        await _channel.invokeMethod("readTodaySummation", dataType?.toMap());
    return SampleSet.fromMap(Map<String, dynamic>.from(resultMap));
  }

  /// Updates existing data.
  ///
  /// If the update target does not exist, a new entry of data will be inserted.
  Future<void> update(UpdateOptions options) async {
    _channel.invokeMethod("update", options?.toMap());
  }
}
