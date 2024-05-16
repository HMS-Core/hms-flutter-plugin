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

enum IdTokenSignAlgorithm {
  PS256,
  RS256,
}

class AccountAuthParamsHelper {
  final List<String> _scopeList = <String>[];
  final Map<String, dynamic> _params = <String, dynamic>{};

  AccountAuthParamsHelper([
    AccountAuthParams? accountAuthParams,
  ]) {
    if (accountAuthParams != null) {
      _params.addAll(accountAuthParams._params);

      dynamic scopeList = _params['scopeList'];
      if (scopeList != null && scopeList is List) {
        for (dynamic scope in scopeList) {
          _scopeList.add(scope);
        }
      }
      _params.remove('scopeList');
    }
  }

  /// Constructs AccountAuthParams.
  AccountAuthParams createParams() {
    return AccountAuthParams._fromParams(
      <String, dynamic>{
        ..._params,
        'scopeList': _scopeList,
      },
    );
  }

  /// Requests an ID user to authorize an app to obtain the user ID.
  void setUid() {
    _params['setUid'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the authorization code.
  void setAuthorizationCode() {
    _params['setAuthorizationCode'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the access token.
  void setAccessToken() {
    _params['setAccessToken'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the email address.
  void setEmail() {
    _params['setEmail'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the UnionID and OpenID.
  void setId() {
    _params['setId'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the ID token.
  void setIdToken() {
    _params['setIdToken'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the account information,
  /// such as the nickname and profile picture.
  void setProfile() {
    _params['setProfile'] = true;
  }

  /// Sets the ID sign-in authorization screen to be displayed in a dialog box.
  void setDialogAuth() {
    _params['setDialogAuth'] = true;
  }

  /// Requests an ID user to authorize an app to obtain the carrier ID.
  void setCarrierId() {
    _params['setCarrierId'] = true;
  }

  void setIdTokenSignAlg(IdTokenSignAlgorithm idTokenSignAlg) {
    _params['setIdTokenSignAlg'] = idTokenSignAlg.index;
  }

  void setMobileNumber() {
    _params['setMobileNumber'] = true;
  }

  void setForceLogout() {
    _params['setForceLogout'] = true;
  }

  void setAssistToken() {
    _params['setAssistToken'] = true;
  }

  void setScope(Scope scope) {
    if (!_scopeList.contains(scope._uri)) {
      _scopeList.add(scope._uri);
    }
  }

  /// Adds specified scopes to authorization configurations to request an ID user to
  /// authorize an app to obtain the permissions specified by the scopes.
  void setScopeList(
    List<Scope> scopes, {
    List<String>? extraScopeURIs,
  }) {
    _scopeList.clear();
    if (scopes.isNotEmpty) {
      for (Scope scope in scopes) {
        _scopeList.add(scope.getScopeUri());
      }
      for (String elem in (extraScopeURIs ?? <String>[])) {
        _scopeList.add(elem);
      }
    }
  }
}
