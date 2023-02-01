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

part of huawei_ar;

class AREngine {
  /// Common method channel for handling common methods.
  static const MethodChannel _commonChannel =
      MethodChannel(COMMON_METHOD_CHANNEL);

  /// Checks if the AREngineService APK is installed
  static Future<bool> isArEngineServiceApkReady() async {
    bool exists = await _commonChannel.invokeMethod(
      'isArEngineServiceApkReady',
    );
    return exists;
  }

  /// Navigates to AREngine AppGallery Page for downloading the AREngine
  /// Service APK
  static Future<void> navigateToAppMarketPage() async {
    await _commonChannel.invokeMethod(
      'navigateToAppMarketPage',
    );
  }

  /// Enables HMS Plugin Method Analytics.
  static Future<void> enableLogger() async {
    await _commonChannel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables HMS Plugin Method Analytics.
  static Future<void> disableLogger() async {
    await _commonChannel.invokeMethod(
      'disableLogger',
    );
  }
}
