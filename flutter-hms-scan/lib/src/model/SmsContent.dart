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

class SmsContent {
  SmsContent({
    this.msgContent,
    this.destPhoneNumber,
  });

  String? msgContent;
  String? destPhoneNumber;

  factory SmsContent.fromJson(String str) {
    return SmsContent.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory SmsContent.fromMap(Map<String, dynamic> json) {
    return SmsContent(
      msgContent: json['msgContent'],
      destPhoneNumber: json['destPhoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msgContent': msgContent,
      'destPhoneNumber': destPhoneNumber,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is SmsContent &&
        other.msgContent == msgContent &&
        other.destPhoneNumber == destPhoneNumber;
  }

  @override
  int get hashCode {
    return Object.hash(
      msgContent,
      destPhoneNumber,
    );
  }
}
