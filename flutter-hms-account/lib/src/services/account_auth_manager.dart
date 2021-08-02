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
import '../results/auth_account.dart';
import '../common/scope.dart';
import '../utils/account_utils.dart';
import '../utils/constants.dart';
import '../request/account_auth_extended_params.dart';

/// Entry for the ID sign-in service.
class AccountAuthManager {
  static final MethodChannel _c = const MethodChannel(AUTH_MANAGER);

  /// Enables HMS Plugin Method Analytics which is used for sending usage
  /// analytics of Account Kit SDK's methods to improve the service quality.
  static void enableLogger() {
    _c.invokeMethod("enableLogger");
  }

  /// Disables HMS Plugin Method Analytics which is used for sending usage
  /// analytics of Account Kit SDK's methods to improve the service quality.
  static void disableLogger() {
    _c.invokeMethod("disableLogger");
  }

  /// Obtains information about the current sign-in ID.
  static Future<AuthAccount> getAuthResult() async {
    return AuthAccount.fromMap(await _c.invokeMethod("getAuthResult"));
  }

  /// Obtains the [AuthAccount] instance with all permissions specified in scopeList.
  static Future<AuthAccount> getAuthResultWithScopes(
      List<Scope> scopeList) async {
    List<String> scopes = getScopeList(scopeList);

    return AuthAccount.fromMap(
        await _c.invokeMethod("getAuthResultWithScopes", {'scopes': scopes}));
  }

  /// Obtains the [AuthAccount] instance with all permissions specified in [extendedParams].
  static Future<AuthAccount> getExtendedAuthResult(
      AccountAuthExtendedParams extendedParams) async {
    final Map<String, dynamic> extMap = getExtendedParamsMap(extendedParams);

    return AuthAccount.fromMap(
        await _c.invokeMethod("getExtendedAuthResult", extMap));
  }

  /// Checks whether an ID has been assigned all permissions specified by [scopeList].
  static Future<bool> containScopes(
      AuthAccount? account, List<Scope> scopeList) async {
    final List<String> scopes = getScopeList(scopeList);

    return await _c.invokeMethod(
        "containScopes", {'account': account?.toMap(), 'scopes': scopes});
  }

  /// Checks whether an ID has been assigned all permissions specified by [extendedParams].
  static Future<bool> containScopesWithExtendedParams(
      AuthAccount? account, AccountAuthExtendedParams extendedParams) async {
    final Map<String, dynamic> extMap = getExtendedParamsMap(extendedParams);

    return await _c.invokeMethod(
        "containScopesExt", {'account': account?.toMap(), 'ext': extMap});
  }

  /// Requests permissions specified by [scopeList] from an ID.
  static void addAuthScopes(int requestCode, List<Scope> scopeList) {
    final List<String> scopes = getScopeList(scopeList);

    _c.invokeMethod(
        "addAuthScopes", {'reqCode': requestCode, 'scopes': scopes});
  }

  /// Requests permissions specified by [extendedParams] from an ID.
  static void addAuthScopesWithExtendedParams(
      int requestCode, AccountAuthExtendedParams extendedParams) {
    Map<String, dynamic> extMap = getExtendedParamsMap(extendedParams);

    _c.invokeMethod(
        "addAuthScopesExt", {'reqCode': requestCode, 'ext': extMap});
  }
}
