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

  String familyName;
  String fullName;
  String givenName;
  String middleName;
  String namePrefix;
  String nameSuffix;
  String spelling;

  factory PeopleName.fromJson(String str) =>
      PeopleName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PeopleName.fromMap(Map<String, dynamic> json) => PeopleName(
        familyName: json["familyName"] == null ? null : json["familyName"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        givenName: json["givenName"] == null ? null : json["givenName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        namePrefix: json["namePrefix"] == null ? null : json["namePrefix"],
        nameSuffix: json["nameSuffix"] == null ? null : json["nameSuffix"],
        spelling: json["spelling"] == null ? null : json["spelling"],
      );

  Map<String, dynamic> toMap() => {
        "familyName": familyName == null ? null : familyName,
        "fullName": fullName == null ? null : fullName,
        "givenName": givenName == null ? null : givenName,
        "middleName": middleName == null ? null : middleName,
        "namePrefix": namePrefix == null ? null : namePrefix,
        "nameSuffix": nameSuffix == null ? null : nameSuffix,
        "spelling": spelling == null ? null : spelling,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final PeopleName check = o;
    return o is PeopleName &&
        check.familyName == familyName &&
        check.fullName == fullName &&
        check.givenName == givenName &&
        check.middleName == middleName &&
        check.namePrefix == namePrefix &&
        check.nameSuffix == nameSuffix &&
        check.spelling == spelling;
  }

  @override
  int get hashCode => hashValues(
        familyName,
        fullName,
        givenName,
        middleName,
        namePrefix,
        nameSuffix,
        spelling,
      );
}
