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

class Aqi {
  int aqiValue;
  int co;
  int no2;
  int o3;
  int pm10;
  int pm25;
  int so2;

  Aqi({
    this.aqiValue,
    this.co,
    this.no2,
    this.o3,
    this.pm10,
    this.pm25,
    this.so2,
  });

  factory Aqi.fromJson(String str) => Aqi.fromMap(json.decode(str));

  factory Aqi.fromMap(Map<String, dynamic> jsonMap) => Aqi(
        aqiValue:
            jsonMap[Param.aqiValue] == null ? null : jsonMap[Param.aqiValue],
        co: jsonMap[Param.co] == null ? null : jsonMap[Param.co],
        no2: jsonMap[Param.no2] == null ? null : jsonMap[Param.no2],
        o3: jsonMap[Param.o3] == null ? null : jsonMap[Param.o3],
        pm10: jsonMap[Param.pm10] == null ? null : jsonMap[Param.pm10],
        pm25: jsonMap[Param.pm25] == null ? null : jsonMap[Param.pm25],
        so2: jsonMap[Param.so2] == null ? null : jsonMap[Param.so2],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.aqiValue: aqiValue == null ? null : aqiValue,
        Param.co: co == null ? null : co,
        Param.no2: no2 == null ? null : no2,
        Param.o3: o3 == null ? null : o3,
        Param.pm10: pm10 == null ? null : pm10,
        Param.pm25: pm25 == null ? null : pm25,
        Param.so2: so2 == null ? null : so2,
      };
}
