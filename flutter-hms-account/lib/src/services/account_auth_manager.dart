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

/// Entry for the ID sign-in service.
class AccountAuthManager {
  static const MethodChannel _c = MethodChannel(_AUTH_MANAGER);

  /// Obtain the AccountAuthService instance that initiates
  /// the ID authorization and sign-in process.
  static AccountAuthService getService(AccountAuthParams authParams) {
    return AccountAuthService(authParams._params);
  }

  /// Enables HMS Plugin Method Analytics which is used for sending usage
  /// analytics of Account Kit SDK's methods to improve the service quality.
  static void enableLogger() {
    _c.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables HMS Plugin Method Analytics which is used for sending usage
  /// analytics of Account Kit SDK's methods to improve the service quality.
  static void disableLogger() {
    _c.invokeMethod(
      'disableLogger',
    );
  }

  /// Obtains information about the current sign-in ID.
  static Future<AuthAccount> getAuthResult() async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'getAuthResult',
      ),
    );
  }

  /// Obtains the [AuthAccount] instance with all permissions specified in scopeList.
  static Future<AuthAccount> getAuthResultWithScopes(
    List<Scope> scopeList,
  ) async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'getAuthResultWithScopes',
        <String, dynamic>{
          'scopes': _getScopeList(scopeList),
        },
      ),
    );
  }

  /// Obtains the [AuthAccount] instance with all permissions specified in [extendedParams].
  static Future<AuthAccount> getExtendedAuthResult(
    AccountAuthExtendedParams extendedParams,
  ) async {
    return AuthAccount.fromMap(
      await _c.invokeMethod(
        'getExtendedAuthResult',
        <String, dynamic>{
          ..._getExtendedParamsMap(extendedParams),
        },
      ),
    );
  }

  /// Checks whether an ID has been assigned all permissions specified by [scopeList].
  static Future<bool> containScopes(
    AuthAccount? account,
    List<Scope> scopeList,
  ) async {
    return await _c.invokeMethod(
      'containScopes',
      <String, dynamic>{
        'account': account?.toMap(),
        'scopes': _getScopeList(scopeList),
      },
    );
  }

  /// Checks whether an ID has been assigned all permissions specified by [extendedParams].
  static Future<bool> containScopesWithExtendedParams(
    AuthAccount? account,
    AccountAuthExtendedParams extendedParams,
  ) async {
    return await _c.invokeMethod(
      'containScopesExt',
      <String, dynamic>{
        'account': account?.toMap(),
        'ext': _getExtendedParamsMap(extendedParams),
      },
    );
  }

  /// Requests permissions specified by [scopeList] from an ID.
  static void addAuthScopes(
    int requestCode,
    List<Scope> scopeList,
  ) {
    _c.invokeMethod(
      'addAuthScopes',
      <String, dynamic>{
        'reqCode': requestCode,
        'scopes': _getScopeList(scopeList),
      },
    );
  }

  /// Requests permissions specified by [extendedParams] from an ID.
  static void addAuthScopesWithExtendedParams(
    int requestCode,
    AccountAuthExtendedParams extendedParams,
  ) {
    _c.invokeMethod(
      'addAuthScopesExt',
      <String, dynamic>{
        'reqCode': requestCode,
        'ext': _getExtendedParamsMap(extendedParams),
      },
    );
  }
}
