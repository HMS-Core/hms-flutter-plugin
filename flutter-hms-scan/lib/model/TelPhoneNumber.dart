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

class TelPhoneNumber {
  static const int FaxUseType = 0;
  static const int ResidentialUseType = 1;
  static const int CellphoneNumberUseType = 2;
  static const int OtherUseType = -1;
  static const int OfficeUseType = 3;

  TelPhoneNumber({this.telPhoneNumber, this.useType});

  String telPhoneNumber;
  int useType;

  factory TelPhoneNumber.fromJson(String str) =>
      TelPhoneNumber.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TelPhoneNumber.fromMap(Map<String, dynamic> json) => TelPhoneNumber(
        telPhoneNumber:
            json["telPhoneNumber"] == null ? null : json["telPhoneNumber"],
        useType: json["useType"] == null ? null : json["useType"].round(),
      );

  Map<String, dynamic> toMap() => {
        "telPhoneNumber": telPhoneNumber == null ? null : telPhoneNumber,
        "useType": useType == null ? null : useType
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final TelPhoneNumber check = o;
    return o is TelPhoneNumber &&
        check.telPhoneNumber == telPhoneNumber &&
        check.useType == useType;
  }

  @override
  int get hashCode => hashValues(telPhoneNumber, useType);
}
