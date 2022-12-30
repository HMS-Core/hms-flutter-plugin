/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:async';

import 'package:flutter/services.dart';

class PushFcm {
  static const MethodChannel _channel =
      MethodChannel('com.huawei.hms.flutter.pushfcm/method');

  /// Initializes the push capability of FCM.
  static Future<bool> init() async {
    return await _channel.invokeMethod(
      'initFcmProxy',
    );
  }

  /// Sets a country/region code. This method is available only for Huawei-developed apps.
  static Future<void> setCountryCode(String countryCode) async {
    await _channel.invokeMethod(
      'setCountryCode',
      <String, dynamic>{
        'countryCode': countryCode,
      },
    );
  }

  /// Enables the HMSLogger capability which is used for sending usage
  /// analytics of DTM SDK's methods to improve the service quality.
  static Future<void> enableLogger() async {
    await _channel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables the HMSLogger capability which is used for sending usage
  /// analytics of DTM SDK's methods to improve the service quality.
  static Future<void> disableLogger() async {
    await _channel.invokeMethod(
      'disableLogger',
    );
  }
}
