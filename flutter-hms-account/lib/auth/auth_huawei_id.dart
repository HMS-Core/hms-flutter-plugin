/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/


import 'package:huawei_account/auth/account.dart';

class AuthHuaweiId {
  Account account;
  String accessToken;
  String displayName;
  String email;
  String familyName;
  String givenName;
  String idToken;
  String authorizationCode;
  String unionId;
  String avatarUriString;
  String openId;
  List<dynamic> authorizedScopes;

  String countryCode;
  String serviceCountryCode;
  String uid;
  int status;
  int gender;

  AuthHuaweiId(
      {this.openId,
      this.email,
      this.accessToken,
      this.unionId,
      this.idToken,
      this.displayName,
      this.familyName,
      this.givenName,
      this.authorizationCode,
      this.authorizedScopes,
      this.avatarUriString,
      this.account,
      this.uid,
      this.serviceCountryCode,
      this.countryCode,
      this.status,
      this.gender});

  AuthHuaweiId.fromJson(Map<String, dynamic> json) {
    account = json['account'] != null ? new Account.fromJson(json['account']) : null;
    openId = json['openId'] ?? null;
    email = json['email'] ?? null;
    accessToken = json['accessToken'] ?? null;
    unionId = json['unionId'] ?? null;
    idToken = json['idToken'] ?? null;
    displayName = json['displayName'] ?? null;
    familyName = json['familyName'] ?? null;
    givenName = json['givenName'] ?? null;
    authorizationCode = json['authorizationCode'] ?? null;
    authorizedScopes = json['authorizedScopes'] ?? null;
    avatarUriString = json['avatarUriString'] ?? null;
    countryCode = json['countryCode'] ?? null;
    serviceCountryCode = json['serviceCountryCode'] ?? null;
    status = json['status'] ?? null;
    gender = json['gender'] ?? null;
    uid = json['uid'] ?? null;
  }

  Map<String, dynamic> toJson() => {
    'account': account == null ? null : account.toJson() != null ? account.toJson() : null,
    'openId': openId,
    'email': email,
    'accessToken': accessToken,
    'unionId': unionId,
    'idToken': idToken,
    'displayName': displayName,
    'familyName': familyName,
    'givenName': givenName,
    'authorizationCode': authorizationCode,
    'authorizedScopes': authorizedScopes,
    'avatarUriString': avatarUriString,
    'gender': gender,
    'status': status,
    'countryCode': countryCode,
    'serviceCountryCode': serviceCountryCode,
    'uid': uid
  };
}
