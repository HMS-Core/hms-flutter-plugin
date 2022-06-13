/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class PermissionHandler {
  static PermissionHandler? _instance;

  final MethodChannel _methodChannel;

  PermissionHandler._create(
    this._methodChannel,
  );

  factory PermissionHandler() {
    if (_instance == null) {
      final MethodChannel methodChannel = const MethodChannel(
          'com.huawei.flutter.location/permission_methodchannel');
      _instance = PermissionHandler._create(methodChannel);
    }
    return _instance!;
  }

  /// Checks whether the location permission is available.
  Future<bool> hasLocationPermission() async {
    return (await _methodChannel.invokeMethod<bool>('hasLocationPermission'))!;
  }

  /// Checks whether the background location permission is available.
  Future<bool> hasBackgroundLocationPermission() async {
    return (await _methodChannel
        .invokeMethod<bool>('hasBackgroundLocationPermission'))!;
  }

  /// Checks whether the activity permission is available.
  Future<bool> hasActivityRecognitionPermission() async {
    return (await _methodChannel
        .invokeMethod<bool>('hasActivityRecognitionPermission'))!;
  }

  /// Requests the location permission.
  ///
  /// The value `true` is returned if the permission is granted.
  /// Otherwise, `false` is returned.
  Future<bool> requestLocationPermission() async {
    return (await _methodChannel
        .invokeMethod<bool>('requestLocationPermission'))!;
  }

  /// Requests the background location permission.
  ///
  /// The value `true` is returned if the permission is granted.
  /// Otherwise, `false` is returned.
  Future<bool> requestBackgroundLocationPermission() async {
    return (await _methodChannel
        .invokeMethod<bool>('requestBackgroundLocationPermission'))!;
  }

  /// Requests the activity permission.
  ///
  /// The value `true` is returned if the permission is granted.
  /// Otherwise, `false` is returned.
  Future<bool> requestActivityRecognitionPermission() async {
    return (await _methodChannel
        .invokeMethod<bool>('requestActivityRecognitionPermission'))!;
  }
}
