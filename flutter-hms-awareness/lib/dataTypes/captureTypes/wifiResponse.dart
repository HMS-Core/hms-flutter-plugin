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
import 'package:huawei_awareness/constants/param.dart';

class WiFiResponse {
  int status;
  String bssid;
  String ssid;

  WiFiResponse({
    this.status,
    this.bssid,
    this.ssid,
  });

  factory WiFiResponse.fromJson(String str) =>
      WiFiResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WiFiResponse.fromMap(Map<String, dynamic> jsonMap) => WiFiResponse(
        status: jsonMap[Param.status] == null ? null : jsonMap[Param.status],
        bssid: jsonMap[Param.bssid] == null ? null : jsonMap[Param.bssid],
        ssid: jsonMap[Param.ssid] == null ? null : jsonMap[Param.ssid],
      );

  Map<String, dynamic> toMap() => {
        Param.status: status == null ? null : status,
        Param.bssid: bssid == null ? null : bssid,
        Param.ssid: ssid == null ? null : ssid,
      };
}
