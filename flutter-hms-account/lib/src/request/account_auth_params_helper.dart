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

import '../common/scope.dart';
import 'account_auth_params.dart';

class AccountAuthParamsHelper {
  int? _param;
  bool? _needUid;
  bool? _needAuthorizationCode;
  bool? _needAccessToken;
  bool? _needEmail;
  bool? _needId;
  bool? _needIdToken;
  bool? _needProfile;
  bool? _needAuthDialog;

  /// test et
  bool? _needCarrierId;
  late List<String> _scopeList;

  AccountAuthParamsHelper() {
    _needUid = false;
    _needAuthorizationCode = false;
    _needAccessToken = false;
    _needEmail = false;
    _needId = false;
    _needIdToken = false;
    _needProfile = false;
    _needAuthDialog = false;
    _needCarrierId = false;
    _scopeList = [];
    _param = AccountAuthParams.defaultAuthRequestParam.create;
  }

  /// Creates a map object from attributes.
  Map<String, dynamic> toMap() {
    return {
      "setUid": _needUid,
      "setAuthorizationCode": _needAuthorizationCode,
      "setAccessToken": _needAccessToken,
      "setEmail": _needEmail,
      "setId": _needId,
      "setIdToken": _needIdToken,
      "setProfile": _needProfile,
      "setAuthDialog": _needAuthDialog,
      "scopeList": _scopeList,
      "setCarrierId": _needCarrierId,
      "defaultParam": _param
    }..removeWhere((k, v) => v == null);
  }

  /// Sets the default auth parameter for signing in.
  void setDefaultParam(int p) {
    _param = p;
  }

  /// Requests an ID user to authorize an app to obtain the user ID.
  void setUid() {
    _needUid = true;
  }

  /// Requests an ID user to authorize an app to obtain the authorization code.
  void setAuthorizationCode() {
    _needAuthorizationCode = true;
  }

  /// Requests an ID user to authorize an app to obtain the access token.
  void setAccessToken() {
    _needAccessToken = true;
  }

  /// Requests an ID user to authorize an app to obtain the email address.
  void setEmail() {
    _needEmail = true;
  }

  /// Requests an ID user to authorize an app to obtain the UnionID and OpenID.
  void setId() {
    _needId = true;
  }

  /// Requests an ID user to authorize an app to obtain the ID token.
  void setIdToken() {
    _needIdToken = true;
  }

  /// Requests an ID user to authorize an app to obtain the account information,
  /// such as the nickname and profile picture.
  void setProfile() {
    _needProfile = true;
  }

  /// Sets the ID sign-in authorization screen to be displayed in a dialog box.
  void setDialogAuth() {
    _needAuthDialog = true;
  }

  /// Requests an ID user to authorize an app to obtain the carrier ID.
  void setCarrierId() {
    _needCarrierId = true;
  }

  /// Adds specified scopes to authorization configurations to request an ID user to
  /// authorize an app to obtain the permissions specified by the scopes.
  void setScopeList(List<Scope> scopes, {List<String>? extraScopeURIs}) {
    _scopeList.clear();
    if (scopes.isNotEmpty) {
      scopes.forEach((scope) {
        _scopeList.add(scope.getScopeUri());
      });
      if (extraScopeURIs != null) {
        extraScopeURIs.forEach((elem) {
          _scopeList.add(elem);
        });
      }
    }
  }
}
