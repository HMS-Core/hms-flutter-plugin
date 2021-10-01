/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

/// Provides permission handling and logging capabilities for the Modeling3D Kit.
class Modeling3dPermissionClient {
  static const MethodChannel _channel =
      MethodChannel("com.huawei.modelling3d.permission/method");

  /// Request for the storage permission.
  static Future<bool> requestStoragePermission() async {
    return await _channel.invokeMethod("requestStoragePermission");
  }

  /// Checks whether the storage permission is given.
  static Future<bool> hasStoragePermission() async {
    return await _channel.invokeMethod("hasStoragePermission");
  }

  /// Enables HMS Plugin Method Analytics
  static Future<void> enableLogger() async {
    _channel.invokeMethod("enableLogger");
  }

  /// Disables HMS Plugin Method Analytics
  static Future<void> disableLogger() async {
    _channel.invokeMethod("disableLogger");
  }
}
