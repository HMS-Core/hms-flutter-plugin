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

/// Result class that defines a HuaweiID for the [HealthAuth.signIn] method.
class AuthHuaweiId {
  final String openId;
  final String photoUriString;
  final String accessToken;
  final String displayName;
  final int status;
  final int gender;
  final String unionId;
  final String idToken;
  final int expirationTimeSecs;
  final String givenName;
  final String familyName;
  final int homeZone;

  /// Authorized permission scopes
  List<String> grantedScopes;
  List<dynamic> extensionScopes;

  AuthHuaweiId(
      {this.openId,
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
      this.extensionScopes});

  factory AuthHuaweiId.fromMap(Map<String, dynamic> map) {
    AuthHuaweiId instance = AuthHuaweiId(
      openId: map['openId'] != null ? map['openId'] : null,
      photoUriString:
          map['photoUriString'] != null ? map['photoUriString'] : null,
      accessToken: map['accessToken'] != null ? map['accessToken'] : null,
      displayName: map['displayName'] != null ? map['displayName'] : null,
      status: map['status'] != null ? map['status'] : null,
      gender: map['gender'] != null ? map['gender'] : null,
      unionId: map['unionId'] != null ? map['unionId'] : null,
      idToken: map['idToken'] != null ? map['idToken'] : null,
      expirationTimeSecs:
          map['expirationTimeSecs'] != null ? map['expirationTimeSecs'] : null,
      givenName: map['givenName'] != null ? map['givenName'] : null,
      familyName: map['familyName'] != null ? map['familyName'] : null,
      homeZone: map['homeZone'] != null ? map['homeZone'] : null,
    );
    if (map['grantedScopes'] != null) {
      List<String> grantedScopes = <String>[];
      map['grantedScopes'].forEach((v) {
        if (v['mScopeUri'] != null) {
          grantedScopes.add((v['mScopeUri']));
        }
      });
      instance.grantedScopes = grantedScopes;
    }
    if (map['extensionScopes'] != null) {
      List<String> extensionScopes = <String>[];
      map['extensionScopes'].forEach((v) {
        if (v['mScopeUri'] != null) {
          extensionScopes.add(v['mScopeUri']);
        }
      });
    }
    return instance;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openId'] = this.openId;
    data['photoUriString'] = this.photoUriString;
    data['accessToken'] = this.accessToken;
    data['displayName'] = this.displayName;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['unionId'] = this.unionId;
    data['idToken'] = this.idToken;
    data['expirationTimeSecs'] = this.expirationTimeSecs;
    data['givenName'] = this.givenName;
    data['familyName'] = this.familyName;
    data['homeZone'] = this.homeZone;
    data['extensionScopes'] = this.extensionScopes;
    data['grantedScopes'] = this.grantedScopes;
    data.removeWhere((k, v) => v == null);
    return data;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
