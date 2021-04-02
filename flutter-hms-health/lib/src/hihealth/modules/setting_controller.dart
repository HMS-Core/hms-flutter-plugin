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
import 'package:huawei_health/src/hihealth/options/data_type_add_options.dart';

/// Provides the setting-related functions.
class SettingController {
  static final MethodChannel _channel =
      health_setting_controller_method_channel;

  /// Creates and adds a customized data type.
  ///
  /// The name of the created data type must be prefixed with the package name
  /// of the app Otherwise, the creation fails. The same data type can't be added
  /// more than once otherwise an exception will be thrown.
  static Future<DataType> addDataType(DataTypeAddOptions options) async {
    final _result =
        await _channel.invokeMethod("addDataType", options?.toMap());
    return DataType.fromMap(Map<String, dynamic>.from(_result));
  }

  /// Reads the data type based on the data type name.
  ///
  /// This method is used to read the customized data types of the app.
  static Future<DataType> readDataType(String dataTypeName) async {
    final _result = await _channel.invokeMethod("readDataType", dataTypeName);
    return DataType.fromMap(Map<String, dynamic>.from(_result));
  }

  /// Disables the Health Kit function, cancels user authorization, and cancels
  /// all data records. (The task takes effect in 24 hours.)
  static Future<void> disableHiHealth() async {
    _channel.invokeMethod("disableHiHealth");
  }

  /// Checks the user privacy authorization to Health Kit.
  ///
  /// If the authorization has not been granted, the user will be redirected
  /// to the authorization screen where they can authorize the Huawei Health app
  /// to open data to Health Kit.
  static Future<void> checkHealthAppAuthorization() async {
    _channel.invokeMethod("checkHealthAppAuthorization");
  }

  /// Checks the user privacy authorization to Health Kit.
  static Future<bool> getHealthAppAuthorization() async {
    return await _channel.invokeMethod("getHealthAppAuthorization");
  }
}
