/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml/utils/channels.dart';

class MLPermissionClient {
  final MethodChannel _channel = Channels.permissionMethodChannel;

  /// CHECKING PERMISSIONS
  Future<bool> checkCameraPermission() async {
    return await _channel.invokeMethod("checkCameraPermission");
  }

  Future<bool> checkWriteExternalStoragePermission() async {
    return await _channel.invokeMethod("checkWriteExternalStoragePermission");
  }

  Future<bool> checkReadExternalStoragePermission() async {
    return await _channel.invokeMethod("checkReadExternalStoragePermission");
  }

  Future<bool> checkRecordAudioPermission() async {
    return await _channel.invokeMethod("checkAudioPermission");
  }

  Future<bool> checkAccessNetworkStatePermission() async {
    return await _channel.invokeMethod("checkAccessNetworkStatePermission");
  }

  Future<bool> checkAccessWifiStatePermission() async {
    return await _channel.invokeMethod("checkAccessWifiStatePermission");
  }

  /// REQUESTING PERMISSIONS
  Future<void> requestCameraPermission() async {
    await _channel.invokeMethod("requestCameraPermission");
  }

  Future<void> requestStoragePermission() async {
    await _channel.invokeMethod("requestStoragePermission");
  }

  Future<void> requestRecordAudioPermission() async {
    await _channel.invokeMethod("requestAudioPermission");
  }

  Future<void> requestConnectionStatePermission() async {
    await _channel.invokeMethod("requestConnectionStatePermission");
  }
}
