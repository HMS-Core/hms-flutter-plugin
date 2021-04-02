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

class HourlyWeather {
  int cnWeatherId;
  int dateTimeStamp;
  bool isDayNight;
  int rainProbability;
  int tempC;
  int tempF;
  int weatherId;

  HourlyWeather({
    this.cnWeatherId,
    this.dateTimeStamp,
    this.isDayNight,
    this.rainProbability,
    this.tempC,
    this.tempF,
    this.weatherId,
  });

  factory HourlyWeather.fromJson(String str) =>
      HourlyWeather.fromMap(json.decode(str));

  factory HourlyWeather.fromMap(Map<String, dynamic> jsonMap) => HourlyWeather(
        cnWeatherId: jsonMap[Param.cnWeatherId] == null
            ? null
            : jsonMap[Param.cnWeatherId],
        dateTimeStamp: jsonMap[Param.dateTimeStamp] == null
            ? null
            : jsonMap[Param.dateTimeStamp],
        isDayNight: jsonMap[Param.isDayNight] == null
            ? null
            : jsonMap[Param.isDayNight],
        rainProbability: jsonMap[Param.rainProbability] == null
            ? null
            : jsonMap[Param.rainProbability],
        tempC: jsonMap[Param.tempC] == null ? null : jsonMap[Param.tempC],
        tempF: jsonMap[Param.tempF] == null ? null : jsonMap[Param.tempF],
        weatherId:
            jsonMap[Param.weatherId] == null ? null : jsonMap[Param.weatherId],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.cnWeatherId: cnWeatherId == null ? null : cnWeatherId,
        Param.dateTimeStamp: dateTimeStamp == null ? null : dateTimeStamp,
        Param.isDayNight: isDayNight == null ? null : isDayNight,
        Param.rainProbability: rainProbability == null ? null : rainProbability,
        Param.tempC: tempC == null ? null : tempC,
        Param.tempF: tempF == null ? null : tempF,
        Param.weatherId: weatherId == null ? null : weatherId,
      };
}
