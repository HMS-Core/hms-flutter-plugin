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

class DailySituation {
  int? cnWeatherId;
  int? weatherId;
  String? windDir;
  int? windLevel;
  int? windSpeed;

  DailySituation({
    this.cnWeatherId,
    this.weatherId,
    this.windDir,
    this.windLevel,
    this.windSpeed,
  });

  factory DailySituation.fromJson(String str) =>
      DailySituation.fromMap(json.decode(str));

  factory DailySituation.fromMap(Map<String, dynamic> jsonMap) =>
      DailySituation(
        cnWeatherId: jsonMap[_Param.cnWeatherId],
        weatherId: jsonMap[_Param.weatherId],
        windDir: jsonMap[_Param.windDir],
        windLevel: jsonMap[_Param.windLevel],
        windSpeed: jsonMap[_Param.windSpeed],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.cnWeatherId: cnWeatherId,
        _Param.weatherId: weatherId,
        _Param.windDir: windDir,
        _Param.windLevel: windLevel,
        _Param.windSpeed: windSpeed,
      };
}
