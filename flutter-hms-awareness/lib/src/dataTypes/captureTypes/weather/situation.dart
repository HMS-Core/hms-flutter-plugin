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

class Situation {
  int? cnWeatherId;
  String? humidity;
  int? pressure;
  int? realFeelC;
  int? realFeelF;
  int? temperatureC;
  int? temperatureF;
  int? updateTime;
  int? uvIndex;
  int? weatherId;
  String? windDir;
  int? windSpeed;
  int? windLevel;

  Situation({
    this.cnWeatherId,
    this.humidity,
    this.pressure,
    this.realFeelC,
    this.realFeelF,
    this.temperatureC,
    this.temperatureF,
    this.updateTime,
    this.uvIndex,
    this.weatherId,
    this.windDir,
    this.windSpeed,
    this.windLevel,
  });

  factory Situation.fromJson(String str) => Situation.fromMap(json.decode(str));

  factory Situation.fromMap(Map<String, dynamic> json) => Situation(
        cnWeatherId: json[_Param.cnWeatherId],
        humidity: json[_Param.humidity],
        pressure: json[_Param.pressure],
        realFeelC: json[_Param.realFeelC],
        realFeelF: json[_Param.realFeelF],
        temperatureC: json[_Param.temperatureC],
        temperatureF: json[_Param.temperatureF],
        updateTime: json[_Param.updateTime],
        uvIndex: json[_Param.uvIndex],
        weatherId: json[_Param.weatherId],
        windDir: json[_Param.windDir],
        windSpeed: json[_Param.windSpeed],
        windLevel: json[_Param.windLevel],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.cnWeatherId: cnWeatherId,
        _Param.humidity: humidity,
        _Param.pressure: pressure,
        _Param.realFeelC: realFeelC,
        _Param.realFeelF: realFeelF,
        _Param.temperatureC: temperatureC,
        _Param.temperatureF: temperatureF,
        _Param.updateTime: updateTime,
        _Param.uvIndex: uvIndex,
        _Param.weatherId: weatherId,
        _Param.windDir: windDir,
        _Param.windSpeed: windSpeed,
        _Param.windLevel: windLevel,
      };
}
