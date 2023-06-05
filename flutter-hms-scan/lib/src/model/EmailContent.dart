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

class EmailContent {
  static const int ResidentialUseType = 0;
  static const int OtherUseType = -1;
  static const int OfficeType = 1;

  EmailContent({
    this.addressInfo,
    this.addressType,
    this.bodyInfo,
    this.subjectInfo,
  });

  int? addressType;
  String? addressInfo;
  String? bodyInfo;
  String? subjectInfo;

  factory EmailContent.fromJson(String str) {
    return EmailContent.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory EmailContent.fromMap(Map<String, dynamic> json) {
    return EmailContent(
      addressInfo: json['addressInfo'],
      addressType: json['addressType']?.round(),
      bodyInfo: json['bodyInfo'],
      subjectInfo: json['subjectInfo'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressInfo': addressInfo,
      'addressType': addressType,
      'bodyInfo': bodyInfo,
      'subjectInfo': subjectInfo
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is EmailContent &&
        other.addressInfo == addressInfo &&
        other.addressType == addressType &&
        other.bodyInfo == bodyInfo &&
        other.subjectInfo == subjectInfo;
  }

  @override
  int get hashCode {
    return Object.hash(
      addressInfo,
      addressType,
      bodyInfo,
      subjectInfo,
    );
  }
}
