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

part of huawei_scan;

class PeopleName {
  PeopleName({
    this.familyName,
    this.fullName,
    this.givenName,
    this.middleName,
    this.namePrefix,
    this.nameSuffix,
    this.spelling,
  });

  String? familyName;
  String? fullName;
  String? givenName;
  String? middleName;
  String? namePrefix;
  String? nameSuffix;
  String? spelling;

  factory PeopleName.fromJson(String str) {
    return PeopleName.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory PeopleName.fromMap(Map<String, dynamic> json) {
    return PeopleName(
      familyName: json['familyName'],
      fullName: json['fullName'],
      givenName: json['givenName'],
      middleName: json['middleName'],
      namePrefix: json['namePrefix'],
      nameSuffix: json['nameSuffix'],
      spelling: json['spelling'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'familyName': familyName,
      'fullName': fullName,
      'givenName': givenName,
      'middleName': middleName,
      'namePrefix': namePrefix,
      'nameSuffix': nameSuffix,
      'spelling': spelling,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is PeopleName &&
        other.familyName == familyName &&
        other.fullName == fullName &&
        other.givenName == givenName &&
        other.middleName == middleName &&
        other.namePrefix == namePrefix &&
        other.nameSuffix == nameSuffix &&
        other.spelling == spelling;
  }

  @override
  int get hashCode {
    return Object.hash(
      familyName,
      fullName,
      givenName,
      middleName,
      namePrefix,
      nameSuffix,
      spelling,
    );
  }
}
