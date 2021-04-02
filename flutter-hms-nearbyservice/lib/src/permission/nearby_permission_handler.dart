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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:huawei_nearbyservice/src/utils/channels.dart';

class NearbyPermissionHandler {
  static final MethodChannel _channel =
      MethodChannel(PERMISSION_METHOD_CHANNEL);

  static Future<bool> requestPermission(List<NearbyPermission> permissions) {
    if (permissions == null || permissions.length == 0) {
      throw ArgumentError('List of permissions cannot be null or empty.');
    }
    List<String> permList = List<String>();
    permissions.forEach((NearbyPermission permission) {
      permList.add(describeEnum(permission));
    });
    return _channel.invokeMethod(
        'requestPermission', <String, dynamic>{'permissions': permList});
  }

  static Future<bool> hasLocationPermission() {
    return _channel.invokeMethod('hasLocationPermission');
  }

  static Future<bool> hasExternalStoragePermission() {
    return _channel.invokeMethod('hasExternalStoragePermission');
  }
}

enum NearbyPermission {
  /// ACCESS_COARSE_LOCATION & ACCESS_FINE_LOCATION
  location,

  /// READ_EXTERNAL_STORAGE & WRITE_EXTERNAL_STORAGE
  externalStorage,
}
