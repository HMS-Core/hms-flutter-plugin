/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class WiFiConnectionInfo {
  static const int NoPasswordModeType = 0;
  static const int WepModeType = 1;
  static const int WpaModeType = 2;

  WiFiConnectionInfo({
    this.password,
    this.ssidNumber,
    this.cipherMode,
  });

  String? password;
  String? ssidNumber;
  int? cipherMode;

  factory WiFiConnectionInfo.fromJson(String str) {
    return WiFiConnectionInfo.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory WiFiConnectionInfo.fromMap(Map<String, dynamic> json) {
    return WiFiConnectionInfo(
        password: json['password'],
        ssidNumber: json['ssidNumber'],
        cipherMode: json['cipherMode']?.round());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'ssidNumber': ssidNumber,
      'cipherMode': cipherMode,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is WiFiConnectionInfo &&
        other.password == password &&
        other.ssidNumber == ssidNumber &&
        other.cipherMode == other.cipherMode;
  }

  @override
  int get hashCode {
    return hashValues(
      password,
      ssidNumber,
      cipherMode,
    );
  }
}
