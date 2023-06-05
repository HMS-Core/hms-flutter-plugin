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

/// Provides the setting-related functions.
class SettingController {
  static const MethodChannel _channel = _healthSettingControllerMethodChannel;

  /// Creates and adds a customized data type.
  ///
  /// The name of the created data type must be prefixed with the package name
  /// of the app Otherwise, the creation fails. The same data type can't be added
  /// more than once otherwise an exception will be thrown.
  static Future<DataType> addDataType(
    DataTypeAddOptions options,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'addDataType',
      options.toMap(),
    );
    return DataType.fromMap(result!);
  }

  /// Reads the data type based on the data type name.
  ///
  /// This method is used to read the customized data types of the app.
  static Future<DataType> readDataType(
    String dataTypeName,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'readDataType',
      dataTypeName,
    );
    return DataType.fromMap(result!);
  }

  /// Disables the Health Kit function, cancels user authorization, and cancels
  /// all data records. (The task takes effect in 24 hours.)
  static Future<void> disableHiHealth() async {
    await _channel.invokeMethod<void>(
      'disableHiHealth',
    );
  }

  /// Checks the user privacy authorization to Health Kit.
  ///
  /// If the authorization has not been granted, the user will be redirected
  /// to the authorization screen where they can authorize the Huawei Health app
  /// to open data to Health Kit.
  static Future<void> checkHealthAppAuthorization() async {
    await _channel.invokeMethod<void>(
      'checkHealthAppAuthorization',
    );
  }

  /// Checks the user privacy authorization to Health Kit.
  static Future<bool> getHealthAppAuthorization() async {
    final bool? result = await _channel.invokeMethod<bool?>(
      'getHealthAppAuthorization',
    );
    return result ?? false;
  }

  static Future<HealthKitAuthResult> requestAuthorizationIntent(
    List<Scope> scopes,
    bool enableHealthAuth,
  ) async {
    final String? result = await _channel.invokeMethod<String?>(
      'requestAuthorizationIntent',
      <String, dynamic>{
        'scopes': List<String>.from(
          scopes.map((Scope e) => e.scopeStr),
        ),
        'enableHealthAuth': enableHealthAuth,
      },
    );
    return HealthKitAuthResult.fromMap(json.decode(result!));
  }
}
