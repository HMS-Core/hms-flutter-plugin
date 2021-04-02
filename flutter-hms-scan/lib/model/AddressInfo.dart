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

class AddressInfo {
  static const int ResidentialUseType = 0;
  static const int OtherUseType = -1;
  static const int OfficeType = 1;

  AddressInfo({
    this.addressDetails,
    this.addressType,
  });

  List<String> addressDetails;
  int addressType;

  factory AddressInfo.fromJson(String str) =>
      AddressInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressInfo.fromMap(Map<String, dynamic> json) => AddressInfo(
        addressDetails: json["addressDetails"] == null
            ? null
            : List<String>.from(json["addressDetails"].map((x) => x)),
        addressType:
            json["addressType"] == null ? null : json["addressType"].round(),
      );

  Map<String, dynamic> toMap() => {
        "addressDetails": addressDetails == null
            ? null
            : List<dynamic>.from(addressDetails.map((x) => x)),
        "addressType": addressType == null ? null : addressType,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final AddressInfo check = o;
    return o is AddressInfo &&
        check.addressDetails == addressDetails &&
        check.addressType == addressType;
  }

  @override
  int get hashCode => hashValues(
        addressDetails,
        addressType,
      );
}
