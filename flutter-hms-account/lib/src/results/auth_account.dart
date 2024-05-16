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

/// Signed-in ID information, including the ID, nickname, profile picture URI,
/// permission, and access token.
class AuthAccount {
  @Deprecated('')
  String? accessToken;
  Account? account;
  String? serviceCountryCode;
  String? displayName;
  String? email;
  @Deprecated('')
  String? familyName;
  @Deprecated('')
  String? givenName;
  int? gender;
  List<dynamic>? authorizedScopes;
  String? idToken;
  String? avatarUri;
  String? authorizationCode;
  String? unionId;
  String? openId;
  int? accountFlag;
  int? carrierId;

  AuthAccount({
    this.accessToken,
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
    this.unionId,
    this.carrierId,
  });

  factory AuthAccount.fromMap(Map<dynamic, dynamic> map) {
    return AuthAccount(
      accessToken: map['accessToken'],
      account: map['account'] != null ? Account.fromMap(map['account']) : null,
      accountFlag: map['accountFlag'],
      authorizationCode: map['authorizationCode'],
      authorizedScopes: map['authorizedScopes'],
      avatarUri: map['avatarUri'],
      displayName: map['displayName'],
      email: map['email'],
      familyName: map['familyName'],
      gender: map['gender'],
      givenName: map['givenName'],
      idToken: map['idToken'],
      openId: map['openId'],
      serviceCountryCode: map['serviceCountryCode'],
      unionId: map['unionId'],
      carrierId: map['carrierId'],
    );
  }

  /// Creates a map object from attributes.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'account': account?.toMap(),
      'accountFlag': accountFlag,
      'authorizationCode': authorizationCode,
      'authorizedScopes': authorizedScopes,
      'avatarUri': avatarUri,
      'displayName': displayName,
      'email': email,
      'familyName': familyName,
      'gender': gender,
      'givenName': givenName,
      'idToken': idToken,
      'openId': openId,
      'serviceCountryCode': serviceCountryCode,
      'unionId': unionId,
      'carrierId': carrierId,
    };
  }

  /// Constructs an [AuthAccount] object whose attributes are left empty.
  AuthAccount createDefault() {
    return AuthAccount();
  }
}
