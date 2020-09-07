/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/services.dart';

class MlPermissionClient {
  static const MethodChannel _channel = const MethodChannel("permissions");

  // CHECKING PERMISSIONS

  static Future<bool> checkCameraPermission() async {
    return await _channel.invokeMethod("checkCameraPermission");
  }

  static Future<bool> checkInternetPermission() async {
    return await _channel.invokeMethod("checkInternetPermission");
  }

  static Future<bool> checkWriteExternalStoragePermission() async {
    return await _channel.invokeMethod("checkWriteExternalStoragePermission");
  }

  static Future<bool> checkReadExternalStoragePermission() async {
    return await _channel.invokeMethod("checkReadExternalStoragePermission");
  }

  static Future<bool> checkRecordAudioPermission() async {
    return await _channel.invokeMethod("checkAudioPermission");
  }

  static Future<bool> checkAccessNetworkStatePermission() async {
    return await _channel.invokeMethod("checkAccessNetworkStatePermission");
  }

  static Future<bool> checkAccessWifiStatePermission() async {
    return await _channel.invokeMethod("checkAccessWifiStatePermission");
  }

  // REQUESTING PERMISSIONS

  static Future requestCameraPermission() async {
    await _channel.invokeMethod("requestCameraPermission");
  }

  static Future requestInternetPermission() async {
    await _channel.invokeMethod("requestInternetPermission");
  }

  static Future requestStoragePermission() async {
    await _channel.invokeMethod("requestStoragePermission");
  }

  static Future requestRecordAudioPermission() async {
    await _channel.invokeMethod("requestAudioPermission");
  }

  static Future requestConnectionStatePermission() async {
    await _channel.invokeMethod("requestConnectionStatePermission");
  }
}
