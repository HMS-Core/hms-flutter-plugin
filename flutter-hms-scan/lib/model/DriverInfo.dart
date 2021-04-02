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

import 'dart:convert' show json;
import 'dart:ui' show hashValues;

class DriverInfo {
  DriverInfo(
      {this.avenue,
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
      this.zipCode});

  String avenue;
  String certificateNumber;
  String certificateType;
  String city;
  String countryOfIssue;
  String dateOfBirth;
  String dateOfExpire;
  String dateOfIssue;
  String familyName;
  String givenName;
  String middleName;
  String province;
  String sex;
  String zipCode;

  factory DriverInfo.fromJson(String str) =>
      DriverInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverInfo.fromMap(Map<String, dynamic> json) => DriverInfo(
        avenue: json["avenue"] == null ? null : json["avenue"],
        certificateNumber: json["certificateNumber"] == null
            ? null
            : json["certificateNumber"],
        certificateType:
            json["certificateType"] == null ? null : json["certificateType"],
        city: json["city"] == null ? null : json["city"],
        countryOfIssue:
            json["countryOfIssue"] == null ? null : json["countryOfIssue"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        dateOfExpire:
            json["dateOfExpire"] == null ? null : json["dateOfExpire"],
        dateOfIssue: json["dateOfIssue"] == null ? null : json["dateOfIssue"],
        familyName: json["familyName"] == null ? null : json["familyName"],
        givenName: json["givenName"] == null ? null : json["givenName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        province: json["province"] == null ? null : json["province"],
        sex: json["sex"] == null ? null : json["sex"],
        zipCode: json["zipCode"] == null ? null : json["zipCode"],
      );

  Map<String, dynamic> toMap() => {
        "avenue": avenue == null ? null : avenue,
        "certificateNumber":
            certificateNumber == null ? null : certificateNumber,
        "certificateType": certificateType == null ? null : certificateType,
        "city": city == null ? null : city,
        "countryOfIssue": countryOfIssue == null ? null : countryOfIssue,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "dateOfExpire": dateOfExpire == null ? null : dateOfExpire,
        "dateOfIssue": dateOfIssue == null ? null : dateOfIssue,
        "familyName": familyName == null ? null : familyName,
        "givenName": givenName == null ? null : givenName,
        "middleName": middleName == null ? null : middleName,
        "province": province == null ? null : province,
        "sex": sex == null ? null : sex,
        "zipCode": zipCode == null ? null : zipCode,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final DriverInfo check = o;
    return o is DriverInfo &&
        check.avenue == avenue &&
        check.certificateNumber == certificateNumber &&
        check.certificateType == certificateType &&
        check.city == city &&
        check.countryOfIssue == countryOfIssue &&
        check.dateOfBirth == dateOfBirth &&
        check.dateOfExpire == dateOfExpire &&
        check.dateOfIssue == dateOfIssue &&
        check.familyName == familyName &&
        check.givenName == givenName &&
        check.middleName == middleName &&
        check.province == province &&
        check.sex == sex &&
        check.zipCode == zipCode;
  }

  @override
  int get hashCode => hashValues(
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
