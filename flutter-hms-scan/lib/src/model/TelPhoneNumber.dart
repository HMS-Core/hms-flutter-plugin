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

class TelPhoneNumber {
  static const int FaxUseType = 0;
  static const int ResidentialUseType = 1;
  static const int CellphoneNumberUseType = 2;
  static const int OtherUseType = -1;
  static const int OfficeUseType = 3;

  TelPhoneNumber({
    this.telPhoneNumber,
    this.useType,
  });

  String? telPhoneNumber;
  int? useType;

  factory TelPhoneNumber.fromJson(String str) {
    return TelPhoneNumber.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TelPhoneNumber.fromMap(Map<String, dynamic> json) {
    return TelPhoneNumber(
      telPhoneNumber: json['telPhoneNumber'],
      useType: json['useType']?.round(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'telPhoneNumber': telPhoneNumber,
      'useType': useType,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is TelPhoneNumber &&
        other.telPhoneNumber == telPhoneNumber &&
        other.useType == useType;
  }

  @override
  int get hashCode {
    return Object.hash(
      telPhoneNumber,
      useType,
    );
  }
}
