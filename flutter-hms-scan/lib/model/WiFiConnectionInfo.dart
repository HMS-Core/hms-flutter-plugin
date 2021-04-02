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

class WiFiConnectionInfo {
  static const int NoPasswordModeType = 0;
  static const int WepModeType = 1;
  static const int WpaModeType = 2;

  WiFiConnectionInfo({this.password, this.ssidNumber, this.cipherMode});

  String password;
  String ssidNumber;
  int cipherMode;

  factory WiFiConnectionInfo.fromJson(String str) =>
      WiFiConnectionInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WiFiConnectionInfo.fromMap(Map<String, dynamic> json) =>
      WiFiConnectionInfo(
          password: json["password"] == null ? null : json["password"],
          ssidNumber: json["ssidNumber"] == null ? null : json["ssidNumber"],
          cipherMode:
              json["cipherMode"] == null ? null : json["cipherMode"].round());

  Map<String, dynamic> toMap() => {
        "password": password == null ? null : password,
        "ssidNumber": ssidNumber == null ? null : ssidNumber,
        "cipherMode": cipherMode == null ? null : cipherMode,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final WiFiConnectionInfo check = o;
    return o is WiFiConnectionInfo &&
        check.password == password &&
        check.ssidNumber == ssidNumber &&
        check.cipherMode == check.cipherMode;
  }

  @override
  int get hashCode => hashValues(password, ssidNumber, cipherMode);
}
