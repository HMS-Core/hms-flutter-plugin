/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_account;

/// Signs in to an app with an ID.
class AccountAuthService {
  static const MethodChannel _c = MethodChannel(_AUTH_SERVICE);

  final Map<String, dynamic> _params;

  AccountAuthService(this._params);

  /// Obtains the Intent object of the ID authorization screen.
  Future<AuthAccount> signIn() async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'signIn',
        <String, dynamic>{
          ..._params,
        },
      ),
    );
  }

  /// Obtains the sign-in information (or error information) about the ID that has been used to sign in to the app.
  ///
  /// In this process, the authorization screen is not displayed to the ID user.
  Future<AuthAccount> silentSignIn() async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'silentSignIn',
        <String, dynamic>{
          ..._params,
        },
      ),
    );
  }

  /// Obtains the Intent object of the dialog box that requests independent authorization from users.
  Future<AuthAccount> independentSignIn(
    String accessToken,
  ) async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'independentSignIn',
        <String, dynamic>{
          ..._params,
          'accessToken': accessToken,
        },
      ),
    );
  }

  /// Signs out of the current ID.
  ///
  /// The account SDK deletes the cached ID information.
  Future<bool> signOut() async {
    return await _c.invokeMethod(
      'signOut',
      <String, dynamic>{
        ..._params,
      },
    );
  }

  /// Cancels the authorization from an ID user.
  Future<bool> cancelAuthorization() async {
    return await _c.invokeMethod(
      'cancelAuthorization',
      <String, dynamic>{
        ..._params,
      },
    );
  }

  /// Obtains icon information.
  Future<AccountIcon> getChannel() async {
    return AccountIcon.fromMap(
      await _c.invokeMethod(
        'getChannel',
        <String, dynamic>{
          ..._params,
        },
      ),
    );
  }
}
