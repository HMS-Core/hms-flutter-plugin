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

import 'dart:collection';

import 'package:flutter/material.dart';

import 'hms_account.dart';

class HmsAuthHuaweiId {
  String accessToken;
  HmsAccount account;
  String displayName;
  String email;
  String familyName;
  String givenName;
  List<dynamic> authorizedScopes;
  String idToken;
  String avatarUriString;
  String authorizationCode;
  String unionId;
  String openId;

  HmsAuthHuaweiId(
      {this.accessToken,
      this.account,
      this.displayName,
      this.email,
      this.familyName,
      this.givenName,
      this.authorizedScopes,
      this.idToken,
      this.avatarUriString,
      this.authorizationCode,
      this.unionId,
      this.openId});

  factory HmsAuthHuaweiId.fromMap(LinkedHashMap<dynamic, dynamic> map) {
    if (map == null) return null;

    return HmsAuthHuaweiId(
        accessToken: map['accessToken'] ?? null,
        account: map['account'] != null
            ? new HmsAccount.fromMap(map['account'])
            : null,
        displayName: map['displayName'] ?? null,
        email: map['email'] ?? null,
        familyName: map['familyName'] ?? null,
        givenName: map['givenName'] ?? null,
        authorizedScopes: map['authorizedScopes'] ?? null,
        idToken: map['idToken'] ?? null,
        avatarUriString: map['avatarUriString'] ?? null,
        authorizationCode: map['authorizationCode'] ?? null,
        unionId: map['unionId'] ?? null,
        openId: map['openId'] ?? null);
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'account': account == null
          ? null
          : account.toMap() != null
              ? account.toMap()
              : null,
      'displayName': displayName,
      'email': email,
      'familyName': familyName,
      'givenName': givenName,
      'authorizedScopes': authorizedScopes,
      'idToken': idToken,
      'avatarUriString': avatarUriString,
      'authorizationCode': authorizationCode,
      'unionId': unionId,
      'openId': openId
    };
  }

  HmsAuthHuaweiId createDefault() {
    return new HmsAuthHuaweiId(
        accessToken: null,
        account: null,
        displayName: null,
        email: null,
        familyName: null,
        givenName: null,
        authorizedScopes: null,
        idToken: null,
        avatarUriString: null,
        authorizationCode: null,
        unionId: null,
        openId: null);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HmsAuthHuaweiId &&
        o.accessToken == accessToken &&
        o.account == account &&
        o.displayName == displayName &&
        o.email == email &&
        o.familyName == familyName &&
        o.givenName == givenName &&
        o.authorizedScopes == authorizedScopes &&
        o.idToken == idToken &&
        o.avatarUriString == avatarUriString &&
        o.authorizationCode == authorizationCode &&
        o.unionId == unionId &&
        o.openId == openId;
  }

  @override
  int get hashCode {
    return hashList([
      accessToken,
      account,
      displayName,
      email,
      familyName,
      givenName,
      authorizedScopes,
      idToken,
      avatarUriString,
      authorizationCode,
      unionId,
      openId
    ]);
  }
}
