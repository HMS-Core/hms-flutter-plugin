/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_awareness;

class Aqi {
  int? aqiValue;
  int? co;
  int? no2;
  int? o3;
  int? pm10;
  int? pm25;
  int? so2;

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
        aqiValue: jsonMap[_Param.aqiValue],
        co: jsonMap[_Param.co],
        no2: jsonMap[_Param.no2],
        o3: jsonMap[_Param.o3],
        pm10: jsonMap[_Param.pm10],
        pm25: jsonMap[_Param.pm25],
        so2: jsonMap[_Param.so2],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.aqiValue: aqiValue,
        _Param.co: co,
        _Param.no2: no2,
        _Param.o3: o3,
        _Param.pm10: pm10,
        _Param.pm25: pm25,
        _Param.so2: so2,
      };
}
