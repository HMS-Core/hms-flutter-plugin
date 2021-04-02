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

import 'package:flutter/services.dart' show MethodChannel;
import 'constants/channel.dart';
import 'constants/method.dart';

class AwarenessUtilsClient {
  static const MethodChannel _utilsChannel =
      const MethodChannel(Channel.AwarenessUtilsChannel);

  static const MethodChannel _permissionChannel =
      const MethodChannel(Channel.AwarenessPermissionCahnnel);

  static Future<void> enableLogger() async {
    await _utilsChannel.invokeMethod(Method.EnableLogger);
  }

  static Future<void> disableLogger() async {
    await _utilsChannel.invokeMethod(Method.DisableLogger);
  }

  static Future<bool> hasLocationPermission() async {
    return _permissionChannel.invokeMethod(Method.HasLocationPermission);
  }

  static Future<bool> hasBackgroundLocationPermission() async {
    return _permissionChannel
        .invokeMethod(Method.HasBackgroundLocationPermission);
  }

  static Future<bool> hasActivityRecognitionPermission() async {
    return _permissionChannel
        .invokeMethod(Method.HasActivityRecognitionPermission);
  }

  static Future<bool> requestLocationPermission() async {
    return _permissionChannel.invokeMethod(Method.RequestLocationPermission);
  }

  static Future<bool> requestBackgroundLocationPermission() async {
    return _permissionChannel
        .invokeMethod(Method.RequestBackgroundLocationPermission);
  }

  static Future<bool> requestActivityRecognitionPermission() async {
    return _permissionChannel
        .invokeMethod(Method.RequestActivityRecognitionPermission);
  }
}
