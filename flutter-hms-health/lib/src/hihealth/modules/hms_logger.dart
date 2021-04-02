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

import 'package:huawei_health/huawei_health.dart';

/// Includes the methods for enabling and disabling the HMSLogger capability which
/// is used for sending usage analytics of the Huawei Flutter Health Kit's methods
/// to improve its service quality.
class HMSLogger {
  static const _channel = health_setting_controller_method_channel;

  /// Enables the HMSLogger capability.
  static Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger');
  }

  /// Disables the HMSLogger capability.
  static Future<void> disableLogger() async {
    _channel.invokeMethod('disableLogger');
  }
}
