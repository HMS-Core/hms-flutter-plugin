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

import '../common/account.dart';

/// Signed-in ID information, including the ID, nickname, profile picture URI,
/// permission, and access token.
class AuthAccount {
  String accessToken;
  Account account;
  String serviceCountryCode;
  String displayName;
  String email;
  String familyName;
  String givenName;
  int gender;
  List<dynamic> authorizedScopes;
  String idToken;
  String avatarUri;
  String authorizationCode;
  String unionId;
  String openId;
  int accountFlag;

  AuthAccount(
      {this.accessToken,
      this.account,
      this.accountFlag,
      this.authorizationCode,
      this.authorizedScopes,
      this.avatarUri,
      this.displayName,
      this.email,
      this.familyName,
      this.gender,
      this.givenName,
      this.idToken,
      this.openId,
      this.serviceCountryCode,
      this.unionId});

  factory AuthAccount.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return AuthAccount(
        accessToken: map['accessToken'] ?? null,
        account:
            map['account'] != null ? Account.fromMap(map['account']) : null,
        accountFlag: map['accountFlag'] ?? null,
        authorizationCode: map['authorizationCode'] ?? null,
        authorizedScopes: map['authorizedScopes'] ?? null,
        avatarUri: map['avatarUri'] ?? null,
        displayName: map['displayName'] ?? null,
        email: map['email'] ?? null,
        familyName: map['familyName'] ?? null,
        gender: map['gender'] ?? null,
        givenName: map['givenName'] ?? null,
        idToken: map['idToken'] ?? null,
        openId: map['openId'] ?? null,
        serviceCountryCode: map['serviceCountryCode'] ?? null,
        unionId: map['unionId'] ?? null);
  }

  /// Creates a map object from attributes.
  Map<String, dynamic> toMap() {
    return {
      "accessToken": accessToken,
      "account": account != null ? account.toMap() : null,
      "accountFlag": accountFlag,
      "authorizationCode": authorizationCode,
      "authorizedScopes": authorizedScopes,
      "avatarUri": avatarUri,
      "displayName": displayName,
      "email": email,
      "familyName": familyName,
      "gender": gender,
      "givenName": givenName,
      "idToken": idToken,
      "openId": openId,
      "serviceCountryCode": serviceCountryCode,
      "unionId": unionId
    };
  }

  /// Constructs an [AuthAccount] object whose attributes are left empty.
  AuthAccount createDefault() => AuthAccount();
}
