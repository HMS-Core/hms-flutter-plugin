/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_drive/src/constants/channel.dart';

/// The class that provides the read/write to external storage permission methods.
class HmsDrivePermissions {
  static const MethodChannel _permissionChannel = drivePermissionMethodChannel;

  /// Requests the read/write to external storage permission from the user.
  static Future<bool> requestReadAndWritePermission() async {
    return await _permissionChannel.invokeMethod('request');
  }

  /// Checks whether the user has given the read/write to external storage permission.
  static Future<bool> hasReadAndWritePermission() async {
    return await _permissionChannel.invokeMethod('has');
  }
}
