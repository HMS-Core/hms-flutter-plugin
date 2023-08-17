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

class HealthKitAuthResult {
  HealthKitAuthResultStatus? status;
  AuthAccount? authAccount;

  HealthKitAuthResult({
    this.status,
    this.authAccount,
  });

  factory HealthKitAuthResult.fromMap(Map<dynamic, dynamic> map) {
    return HealthKitAuthResult(
      status: map['status'] != null
          ? HealthKitAuthResultStatus.fromMap(map['status'])
          : null,
      authAccount:
          map['HuaweiId'] != null ? AuthAccount.fromMap(map['HuaweiId']) : null,
    );
  }
}

class HealthKitAuthResultStatus {
  int? statusCode;
  String? statusMessage;

  HealthKitAuthResultStatus({
    this.statusCode,
    this.statusMessage,
  });

  factory HealthKitAuthResultStatus.fromMap(Map<dynamic, dynamic> map) {
    return HealthKitAuthResultStatus(
      statusCode: map['statusCode'],
      statusMessage: map['statusMessage'],
    );
  }
}

class AuthAccount {
  String? ageRange;
  String? email;
  String? countryCode;
  String? serviceCountryCode;
  String? serverAuthCode;
  String? uid;
  String? openId;
  String? photoUriString;
  String? accessToken;
  String? displayName;
  int? status;
  int? gender;
  String? unionId;
  String? idToken;
  int? expirationTimeSecs;
  String? givenName;
  String? familyName;
  int? homeZone;
  int? accountFlag;

  AuthAccount({
    this.ageRange,
    this.email,
    this.countryCode,
    this.serviceCountryCode,
    this.serverAuthCode,
    this.uid,
    this.status,
    this.accessToken,
    this.displayName,
    this.unionId,
    this.idToken,
    this.openId,
    this.familyName,
    this.accountFlag,
    this.expirationTimeSecs,
    this.gender,
    this.givenName,
    this.homeZone,
    this.photoUriString,
  });

  factory AuthAccount.fromMap(Map<dynamic, dynamic> map) {
    return AuthAccount(
      uid: map['uid'],
      openId: map['openId'],
      displayName: map['displayName'],
      photoUriString: map['photoUriString'],
      accessToken: map['accessToken'],
      status: map['status'],
      gender: map['gender'],
      serverAuthCode: map['serverAuthCode'],
      serviceCountryCode: map['serviceCountryCode'],
      countryCode: map['countryCode'],
      unionId: map['unionId'],
      email: map['email'],
      idToken: map['idToken'],
      expirationTimeSecs: map['expirationTimeSecs'],
      givenName: map['givenName'],
      familyName: map['familyName'],
      ageRange: map['ageRange'],
      homeZone: map['homeZone'],
      accountFlag: map['accountFlag'],
    );
  }
}
