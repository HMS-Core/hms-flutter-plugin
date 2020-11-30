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
import 'package:huawei_account/model/hms_auth_huawei_id.dart';

import '../helpers/hms_auth_param_helper.dart';

const String AUTH_SERVICE_METHOD_CHANNEL =
    "com.huawei.hms.flutter.account/auth/service";

const String HUAWEI_HMS_LOGGER_METHOD_CHANNEL =
    "com.huawei.hms.flutter.account/logger";

class HmsAuthService {
  static const MethodChannel _channel =
      const MethodChannel(AUTH_SERVICE_METHOD_CHANNEL);

  static const MethodChannel _loggerChannel =
      const MethodChannel(HUAWEI_HMS_LOGGER_METHOD_CHANNEL);

  /// Obtains the intent of the HUAWEI ID sign-in authorization page
  ///
  /// On first sign in, an authorization page shows up. After a successful
  /// operation, signed account data is received via [HmsAuthHuaweiId] object.
  ///
  /// [authParamHelper] optional parameter to customize the authorization.
  static Future<HmsAuthHuaweiId> signIn(
      {HmsAuthParamHelper authParamHelper}) async {
    return new HmsAuthHuaweiId.fromMap(await _channel.invokeMethod(
        "signIn",
        authParamHelper != null
            ? authParamHelper.requestData
            : new HmsAuthParamHelper().requestData));
  }

  /// Obtains the sign-in information (or error information) about the
  /// HUAWEI ID that has been used to sign in to the app.
  ///
  /// In this process, the authorization page is not displayed to the HUAWEI ID user.
  ///
  /// [authParamHelper] optional parameter to customize the authorization
  static Future<HmsAuthHuaweiId> silentSignIn(
      {HmsAuthParamHelper authParamHelper}) async {
    return new HmsAuthHuaweiId.fromMap(await _channel.invokeMethod(
        "silentSignIn",
        authParamHelper != null
            ? authParamHelper.requestData
            : new HmsAuthParamHelper().requestData));
  }

  /// Signs out of the HUAWEI ID.
  ///
  /// The HMS Core Account SDK deletes the cached HUAWEI ID information
  static Future<bool> signOut() async {
    return await _channel.invokeMethod("signOut");
  }

  /// Cancels the authorization from the HUAWEI ID user.
  ///
  /// The authorization page will be shown on another signing attempt
  static Future<bool> revokeAuthorization() async {
    return await _channel.invokeMethod("revokeAuthorization");
  }

  /// Enables the HMS Logger service.
  static Future<void> enableLogger() async {
    await _loggerChannel.invokeMethod("enableLogger");
  }

  /// Disables the HMS Logger service.
  static Future<void> disableLogger() async {
    await _loggerChannel.invokeMethod("disableLogger");
  }
}
