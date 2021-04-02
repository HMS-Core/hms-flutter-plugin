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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart' show DailySituation;
import 'package:huawei_awareness/constants/param.dart';

class DailyWeather {
  int aqiValue;
  int dateTimeStamp;
  int maxTempC;
  int maxTempF;
  int minTempC;
  int minTempF;
  int moonRise;
  int moonSet;
  String moonPhase;
  DailySituation situationDay;
  DailySituation situationNight;
  int sunRise;
  int sunSet;

  DailyWeather({
    this.aqiValue,
    this.dateTimeStamp,
    this.maxTempC,
    this.maxTempF,
    this.minTempC,
    this.minTempF,
    this.moonRise,
    this.moonSet,
    this.moonPhase,
    this.situationDay,
    this.situationNight,
    this.sunRise,
    this.sunSet,
  });

  factory DailyWeather.fromJson(String str) =>
      DailyWeather.fromMap(json.decode(str));

  factory DailyWeather.fromMap(Map<String, dynamic> jsonMap) => DailyWeather(
        aqiValue:
            jsonMap[Param.aqiValue] == null ? null : jsonMap[Param.aqiValue],
        dateTimeStamp: jsonMap[Param.dateTimeStamp] == null
            ? null
            : jsonMap[Param.dateTimeStamp],
        maxTempC:
            jsonMap[Param.maxTempC] == null ? null : jsonMap[Param.maxTempC],
        maxTempF:
            jsonMap[Param.maxTempF] == null ? null : jsonMap[Param.maxTempF],
        minTempC:
            jsonMap[Param.minTempC] == null ? null : jsonMap[Param.minTempC],
        minTempF:
            jsonMap[Param.minTempF] == null ? null : jsonMap[Param.minTempF],
        moonRise:
            jsonMap[Param.moonRise] == null ? null : jsonMap[Param.moonRise],
        moonSet: jsonMap[Param.moonSet] == null ? null : jsonMap[Param.moonSet],
        moonPhase:
            jsonMap[Param.moonPhase] == null ? null : jsonMap[Param.moonPhase],
        situationDay: jsonMap[Param.situationDay] == null
            ? null
            : DailySituation.fromMap(jsonMap[Param.situationDay]),
        situationNight: jsonMap[Param.situationNight] == null
            ? null
            : DailySituation.fromMap(jsonMap[Param.situationNight]),
        sunRise: jsonMap[Param.sunRise] == null ? null : jsonMap[Param.sunRise],
        sunSet: jsonMap[Param.sunSet] == null ? null : jsonMap[Param.sunSet],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.aqiValue: aqiValue == null ? null : aqiValue,
        Param.dateTimeStamp: dateTimeStamp == null ? null : dateTimeStamp,
        Param.maxTempC: maxTempC == null ? null : maxTempC,
        Param.maxTempF: maxTempF == null ? null : maxTempF,
        Param.minTempC: minTempC == null ? null : minTempC,
        Param.minTempF: minTempF == null ? null : minTempF,
        Param.moonRise: moonRise == null ? null : moonRise,
        Param.moonSet: moonSet == null ? null : moonSet,
        Param.moonPhase: moonPhase == null ? null : moonPhase,
        Param.situationDay: situationDay == null ? null : situationDay.toMap(),
        Param.situationNight:
            situationNight == null ? null : situationNight.toMap(),
        Param.sunRise: sunRise == null ? null : sunRise,
        Param.sunSet: sunSet == null ? null : sunSet,
      };
}
