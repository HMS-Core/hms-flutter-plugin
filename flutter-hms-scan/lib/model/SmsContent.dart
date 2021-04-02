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

class SmsContent {
  SmsContent({
    this.msgContent,
    this.destPhoneNumber,
  });

  String msgContent;
  String destPhoneNumber;

  factory SmsContent.fromJson(String str) =>
      SmsContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SmsContent.fromMap(Map<String, dynamic> json) => SmsContent(
        msgContent: json["msgContent"] == null ? null : json["msgContent"],
        destPhoneNumber:
            json["destPhoneNumber"] == null ? null : json["destPhoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "msgContent": msgContent == null ? null : msgContent,
        "destPhoneNumber": destPhoneNumber == null ? null : destPhoneNumber,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final SmsContent check = o;
    return o is SmsContent &&
        check.msgContent == msgContent &&
        check.destPhoneNumber == destPhoneNumber;
  }

  @override
  int get hashCode => hashValues(
        msgContent,
        destPhoneNumber,
      );
}
