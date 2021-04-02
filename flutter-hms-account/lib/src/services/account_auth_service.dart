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
import '../request/account_auth_params_helper.dart';
import '../results/account_icon.dart';
import '../results/auth_account.dart';
import '../utils/constants.dart';

/// Signs in to an app with an ID.
class AccountAuthService {
  static final MethodChannel _c = const MethodChannel(AUTH_SERVICE);

  /// Obtains the Intent object of the ID authorization screen.
  static Future<AuthAccount> signIn([AccountAuthParamsHelper h]) async {
    return AuthAccount.fromMap(await _c.invokeMethod("signIn",
        h != null ? h.toMap() : new AccountAuthParamsHelper().toMap()));
  }

  /// Obtains the sign-in information (or error information) about the ID that has been used to sign in to the app.
  /// In this process, the authorization screen is not displayed to the ID user.
  static Future<AuthAccount> silentSignIn() async {
    return AuthAccount.fromMap(await _c.invokeMethod("silentSignIn"));
  }

  /// Signs out of the current ID. The account SDK deletes the cached ID information.
  static Future<bool> signOut() {
    return _c.invokeMethod("signOut");
  }

  /// Cancels the authorization from an ID user.
  static Future<bool> cancelAuthorization() {
    return _c.invokeMethod("cancelAuthorization");
  }

  /// Obtains icon information.
  static Future<AccountIcon> getChannel() async {
    return AccountIcon.fromMap(await _c.invokeMethod("getChannel"));
  }
}
