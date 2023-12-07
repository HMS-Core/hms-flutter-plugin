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

class HmsScanFrame {
  HmsScanFrame({
    this.avenue,
    this.certificateNumber,
    this.certificateType,
    this.city,
    this.countryOfIssue,
    this.dateOfBirth,
    this.dateOfExpire,
    this.dateOfIssue,
    this.familyName,
    this.givenName,
    this.middleName,
    this.province,
    this.sex,
    this.zipCode,
  });

  String? avenue;
  String? certificateNumber;
  String? certificateType;
  String? city;
  String? countryOfIssue;
  String? dateOfBirth;
  String? dateOfExpire;
  String? dateOfIssue;
  String? familyName;
  String? givenName;
  String? middleName;
  String? province;
  String? sex;
  String? zipCode;

  // factory HmsScanFrame.fromJson(String str) {
  //   return HmsScanFrame.fromMap(json.decode(str));
  // }

  // String toJson() {
  //   return json.encode(toMap());
  // }

  factory HmsScanFrame.fromMap(Map<String, dynamic> json) {
    return HmsScanFrame(
      avenue: json['avenue'],
      certificateNumber: json['certificateNumber'],
      certificateType: json['certificateType'],
      city: json['city'],
      countryOfIssue: json['countryOfIssue'],
      dateOfBirth: json['dateOfBirth'],
      dateOfExpire: json['dateOfExpire'],
      dateOfIssue: json['dateOfIssue'],
      familyName: json['familyName'],
      givenName: json['givenName'],
      middleName: json['middleName'],
      province: json['province'],
      sex: json['sex'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avenue': avenue,
      'certificateNumber': certificateNumber,
      'certificateType': certificateType,
      'city': city,
      'countryOfIssue': countryOfIssue,
      'dateOfBirth': dateOfBirth,
      'dateOfExpire': dateOfExpire,
      'dateOfIssue': dateOfIssue,
      'familyName': familyName,
      'givenName': givenName,
      'middleName': middleName,
      'province': province,
      'sex': sex,
      'zipCode': zipCode,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is HmsScanFrame &&
        other.avenue == avenue &&
        other.certificateNumber == certificateNumber &&
        other.certificateType == certificateType &&
        other.city == city &&
        other.countryOfIssue == countryOfIssue &&
        other.dateOfBirth == dateOfBirth &&
        other.dateOfExpire == dateOfExpire &&
        other.dateOfIssue == dateOfIssue &&
        other.familyName == familyName &&
        other.givenName == givenName &&
        other.middleName == middleName &&
        other.province == province &&
        other.sex == sex &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return Object.hash(
      avenue,
      certificateNumber,
      certificateType,
      city,
      countryOfIssue,
      dateOfBirth,
      dateOfExpire,
      dateOfIssue,
      familyName,
      givenName,
      middleName,
      province,
      sex,
      zipCode,
    );
  }
}
