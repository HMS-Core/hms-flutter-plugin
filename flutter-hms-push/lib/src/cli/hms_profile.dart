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

import 'package:huawei_push/src/constants/channel.dart';

/// A class for checking whether to display messages for the user based on the account.
///
/// Supported devices: phones and tablets
/// Supported operating systems: EMUI 9.1.0 or later and Android 9.0 or later
class HmsProfile {
  /// Account Type Constant.
  ///
  /// HUAWEI ID that you transfer by [addProfile] or [addMultiSenderProfile] in HmsProfile to verify the account.
  static const int HUAWEI_PROFILE = 1;

  /// Account Type Constant.
  ///
  /// Account different than the HUAWEI ID, which you transfer by [addProfile] or [addMultiSenderProfile] in HmsProfile to verify the account.
  static const int CUSTOM_PROFILE = 2;

  /// Account Type Constant.
  ///
  /// Undefined account type.
  static const UNDEFINED_PROFILE = -1;

  /// Checks whether the device supports account verification.
  static Future<bool> isSupportProfile() async {
    return await methodChannel.invokeMethod('isSupportProfile');
  }

  /// Adds the relationship between the user and app on the device.
  static Future<void> addProfile(int type, String profileId) async {
    return await methodChannel
        .invokeMethod('addProfile', {'type': type, 'profileId': profileId});
  }

  /// Adds the relationships between the user and apps on the device in the multi-sender scenario.
  static Future<void> addMultiSenderProfile(
      String subjectId, int type, String profileId) async {
    return await methodChannel.invokeMethod('addMultiSenderProfile',
        {'subjectId': subjectId, 'type': type, 'profileId': profileId});
  }

  /// Deletes the relationship between the user and app on the device.
  static Future<void> deleteProfile(String profileId) async {
    return await methodChannel
        .invokeMethod('deleteProfile', {'profileId': profileId});
  }

  /// Deletes the relationships between the user and apps on the device in the multi-sender scenario.
  static Future<void> deleteMultiSenderProfile(
      String subjectId, String profileId) async {
    return await methodChannel.invokeMethod(
        'deleteProfile', {'subjectId': subjectId, 'profileId': profileId});
  }
}
