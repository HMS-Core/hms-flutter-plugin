/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Result class that defines a HuaweiID for the [HealthAuth.signIn] method.
class AuthHuaweiId {
  final String? openId;
  final String? photoUriString;
  final String? accessToken;
  final String? displayName;
  final int? status;
  final int? gender;
  final String? unionId;
  final String? idToken;
  final int? expirationTimeSecs;
  final String? givenName;
  final String? familyName;
  final int? homeZone;

  /// Authorized permission scopes
  List<String>? grantedScopes;
  List<dynamic>? extensionScopes;

  AuthHuaweiId({
    this.openId,
    this.photoUriString,
    this.accessToken,
    this.displayName,
    this.status,
    this.gender,
    this.unionId,
    this.idToken,
    this.expirationTimeSecs,
    this.givenName,
    this.familyName,
    this.homeZone,
    this.grantedScopes,
    this.extensionScopes,
  });

  factory AuthHuaweiId.fromMap(Map<dynamic, dynamic> map) {
    AuthHuaweiId instance = AuthHuaweiId(
      openId: map['openId'],
      photoUriString: map['photoUriString'],
      accessToken: map['accessToken'],
      displayName: map['displayName'],
      status: map['status'],
      gender: map['gender'],
      unionId: map['unionId'],
      idToken: map['idToken'],
      expirationTimeSecs: map['expirationTimeSecs'],
      givenName: map['givenName'],
      familyName: map['familyName'],
      homeZone: map['homeZone'],
    );
    if (map['grantedScopes'] != null) {
      List<String> grantedScopes = <String>[];
      map['grantedScopes'].forEach((dynamic v) {
        if (v['mScopeUri'] != null) {
          grantedScopes.add((v['mScopeUri']));
        }
      });
      instance.grantedScopes = grantedScopes;
    }
    if (map['extensionScopes'] != null) {
      List<String> extensionScopes = <String>[];
      map['extensionScopes'].forEach((dynamic v) {
        if (v['mScopeUri'] != null) {
          extensionScopes.add(v['mScopeUri']);
        }
      });
    }
    return instance;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openId': openId,
      'photoUriString': photoUriString,
      'accessToken': accessToken,
      'displayName': displayName,
      'gender': gender,
      'unionId': unionId,
      'idToken': idToken,
      'expirationTimeSecs': expirationTimeSecs,
      'givenName': givenName,
      'familyName': familyName,
      'homeZone': homeZone,
      'extensionScopes': extensionScopes,
      'grantedScopes': grantedScopes,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
