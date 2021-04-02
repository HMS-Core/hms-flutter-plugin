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

import '../constants/channel.dart' as CHANNEL;

class AREngine {
  /// Common method channel for handling common methods.
  static const MethodChannel _commonChannel =
      MethodChannel(CHANNEL.COMMON_METHOD_CHANNEL);

  /// Permission method channel for handling permission methods.
  static const MethodChannel _permissionChannel =
      MethodChannel(CHANNEL.PERMISSION_METHOD_CHANNEL);

  /// Checks if the AREngineService APK is installed
  static Future<bool> isArEngineServiceApkReady() async {
    bool exists =
        await _commonChannel.invokeMethod("isArEngineServiceApkReady");
    return exists;
  }

  /// Navigates to AREngine AppGallery Page for downloading the AREngine
  /// Service APK
  static Future<void> navigateToAppMarketPage() async {
    await _commonChannel.invokeMethod("navigateToAppMarketPage");
  }

  /// Checks if the camera permission is given.
  static Future<bool> hasCameraPermission() async {
    bool result = await _permissionChannel.invokeMethod("hasCameraPermission");
    return result;
  }

  /// Requests the camera permission which is required to display an AREngine
  /// Scene
  static Future<void> requestCameraPermission() async {
    _permissionChannel.invokeMethod("requestCameraPermission");
  }

  /// Enables HMS Plugin Method Analytics.
  static Future<void> enableLogger() async {
    _commonChannel.invokeMethod("enableLogger");
  }

  /// Disables HMS Plugin Method Analytics.
  static Future<void> disableLogger() async {
    _commonChannel.invokeMethod("disableLogger");
  }
}
