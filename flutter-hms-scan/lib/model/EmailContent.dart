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

class EmailContent {
  static const int ResidentialUseType = 0;
  static const int OtherUseType = -1;
  static const int OfficeType = 1;

  EmailContent(
      {this.addressInfo, this.addressType, this.bodyInfo, this.subjectInfo});

  int addressType;
  String addressInfo;
  String bodyInfo;
  String subjectInfo;

  factory EmailContent.fromJson(String str) =>
      EmailContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmailContent.fromMap(Map<String, dynamic> json) => EmailContent(
        addressInfo: json["addressInfo"] == null ? null : json["addressInfo"],
        addressType:
            json["addressType"] == null ? null : json["addressType"].round(),
        bodyInfo: json["bodyInfo"] == null ? null : json["bodyInfo"],
        subjectInfo: json["subjectInfo"] == null ? null : json["subjectInfo"],
      );

  Map<String, dynamic> toMap() => {
        "addressInfo": addressInfo == null ? null : addressInfo,
        "addressType": addressType == null ? null : addressType,
        "bodyInfo": bodyInfo == null ? null : bodyInfo,
        "subjectInfo": subjectInfo == null ? null : subjectInfo
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final EmailContent check = o;
    return o is EmailContent &&
        check.addressInfo == addressInfo &&
        check.addressType == addressType &&
        check.bodyInfo == bodyInfo &&
        check.subjectInfo == subjectInfo;
  }

  @override
  int get hashCode => hashValues(
        addressInfo,
        addressType,
        bodyInfo,
        subjectInfo,
      );
}
