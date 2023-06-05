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

class AddressInfo {
  static const int ResidentialUseType = 0;
  static const int OtherUseType = -1;
  static const int OfficeType = 1;

  AddressInfo({
    this.addressDetails,
    this.addressType,
  });

  List<String?>? addressDetails;
  int? addressType;

  factory AddressInfo.fromJson(String str) {
    return AddressInfo.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory AddressInfo.fromMap(Map<String, dynamic> json) {
    return AddressInfo(
      addressDetails: json['addressDetails'] == null
          ? null
          : List<String?>.from(json['addressDetails'].map((dynamic x) => x)),
      addressType: json['addressType']?.round(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressDetails': addressDetails == null
          ? null
          : List<dynamic>.from(addressDetails!.map((dynamic x) => x)),
      'addressType': addressType,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is AddressInfo &&
        listEquals(other.addressDetails, addressDetails) &&
        other.addressType == addressType;
  }

  @override
  int get hashCode {
    return Object.hash(
      addressDetails,
      addressType,
    );
  }
}
