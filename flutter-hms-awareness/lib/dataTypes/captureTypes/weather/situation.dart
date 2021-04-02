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

class Situation {
  int cnWeatherId;
  String humidity;
  int pressure;
  int realFeelC;
  int realFeelF;
  int temperatureC;
  int temperatureF;
  int updateTime;
  int uvIndex;
  int weatherId;
  String windDir;
  int windSpeed;
  int windLevel;

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
        cnWeatherId:
            json[Param.cnWeatherId] == null ? null : json[Param.cnWeatherId],
        humidity: json[Param.humidity] == null ? null : json[Param.humidity],
        pressure: json[Param.pressure] == null ? null : json[Param.pressure],
        realFeelC: json[Param.realFeelC] == null ? null : json[Param.realFeelC],
        realFeelF: json[Param.realFeelF] == null ? null : json[Param.realFeelF],
        temperatureC:
            json[Param.temperatureC] == null ? null : json[Param.temperatureC],
        temperatureF:
            json[Param.temperatureF] == null ? null : json[Param.temperatureF],
        updateTime:
            json[Param.updateTime] == null ? null : json[Param.updateTime],
        uvIndex: json[Param.uvIndex] == null ? null : json[Param.uvIndex],
        weatherId: json[Param.weatherId] == null ? null : json[Param.weatherId],
        windDir: json[Param.windDir] == null ? null : json[Param.windDir],
        windSpeed: json[Param.windSpeed] == null ? null : json[Param.windSpeed],
        windLevel: json[Param.windLevel] == null ? null : json[Param.windLevel],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.cnWeatherId: cnWeatherId == null ? null : cnWeatherId,
        Param.humidity: humidity == null ? null : humidity,
        Param.pressure: pressure == null ? null : pressure,
        Param.realFeelC: realFeelC == null ? null : realFeelC,
        Param.realFeelF: realFeelF == null ? null : realFeelF,
        Param.temperatureC: temperatureC == null ? null : temperatureC,
        Param.temperatureF: temperatureF == null ? null : temperatureF,
        Param.updateTime: updateTime == null ? null : updateTime,
        Param.uvIndex: uvIndex == null ? null : uvIndex,
        Param.weatherId: weatherId == null ? null : weatherId,
        Param.windDir: windDir == null ? null : windDir,
        Param.windSpeed: windSpeed == null ? null : windSpeed,
        Param.windLevel: windLevel == null ? null : windLevel,
      };
}
