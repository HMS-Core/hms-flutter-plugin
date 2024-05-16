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

class DailyWeather {
  int? aqiValue;
  int? dateTimeStamp;
  int? maxTempC;
  int? maxTempF;
  int? minTempC;
  int? minTempF;
  int? moonRise;
  int? moonSet;
  String? moonPhase;
  DailySituation? situationDay;
  DailySituation? situationNight;
  int? sunRise;
  int? sunSet;

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
        aqiValue: jsonMap[_Param.aqiValue],
        dateTimeStamp: jsonMap[_Param.dateTimeStamp],
        maxTempC: jsonMap[_Param.maxTempC],
        maxTempF: jsonMap[_Param.maxTempF],
        minTempC: jsonMap[_Param.minTempC],
        minTempF: jsonMap[_Param.minTempF],
        moonRise: jsonMap[_Param.moonRise],
        moonSet: jsonMap[_Param.moonSet],
        moonPhase: jsonMap[_Param.moonPhase],
        situationDay: DailySituation.fromMap(jsonMap[_Param.situationDay]),
        situationNight: DailySituation.fromMap(jsonMap[_Param.situationNight]),
        sunRise: jsonMap[_Param.sunRise],
        sunSet: jsonMap[_Param.sunSet],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.aqiValue: aqiValue,
        _Param.dateTimeStamp: dateTimeStamp,
        _Param.maxTempC: maxTempC,
        _Param.maxTempF: maxTempF,
        _Param.minTempC: minTempC,
        _Param.minTempF: minTempF,
        _Param.moonRise: moonRise,
        _Param.moonSet: moonSet,
        _Param.moonPhase: moonPhase,
        _Param.situationDay: situationDay?.toMap(),
        _Param.situationNight: situationNight?.toMap(),
        _Param.sunRise: sunRise,
        _Param.sunSet: sunSet,
      };
}
