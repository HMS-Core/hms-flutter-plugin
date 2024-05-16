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

class HourlyWeather {
  int? cnWeatherId;
  int? dateTimeStamp;
  bool? isDayNight;
  int? rainProbability;
  int? tempC;
  int? tempF;
  int? weatherId;

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
        cnWeatherId: jsonMap[_Param.cnWeatherId],
        dateTimeStamp: jsonMap[_Param.dateTimeStamp],
        isDayNight: jsonMap[_Param.isDayNight],
        rainProbability: jsonMap[_Param.rainProbability],
        tempC: jsonMap[_Param.tempC],
        tempF: jsonMap[_Param.tempF],
        weatherId: jsonMap[_Param.weatherId],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.cnWeatherId: cnWeatherId,
        _Param.dateTimeStamp: dateTimeStamp,
        _Param.isDayNight: isDayNight,
        _Param.rainProbability: rainProbability,
        _Param.tempC: tempC,
        _Param.tempF: tempF,
        _Param.weatherId: weatherId,
      };
}
