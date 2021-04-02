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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart'
    show DailyWeather, HourlyWeather, LiveInfo, Aqi, WeatherSituation;
import 'package:huawei_awareness/constants/param.dart';

class WeatherResponse {
  static const String ClothingIndex = "1";
  static const String DownJacket = "1";
  static const String HeavyCoat = "2";
  static const String Sweater = "3";
  static const String ThinCoat = "4";
  static const String LongSleeves = "5";
  static const String ShortSleeve = "6";
  static const String ThinShortSleeve = "7";
  static const String SportIndex = "2";
  static const String SuitableSport = "1";
  static const String MoreSuitableSport = "2";
  static const String NotSuitableSport = "3";
  static const String ColdIndex = "3";
  static const String NotEasyCatchCold = "1";
  static const String EasierCatchCold = "2";
  static const String BeSusceptibleCold = "3";
  static const String ExtremelySusceptibleCold = "4";
  static const String CarWashIndex = "4";
  static const String TourismIndex = "5";
  static const String Unsuitable = "1";
  static const String NotVerySuitable = "2";
  static const String MoreSuitable = "3";
  static const String Suitable = "4";
  static const String UVIndex = "6";
  static const String Weakest = "1";
  static const String Weak = "2";
  static const String Medium = "3";
  static const String Strong = "4";
  static const String VeryStrong = "5";

  List<DailyWeather> dailyWeather;
  List<HourlyWeather> hourlyWeather;
  List<LiveInfo> liveInfo;
  Aqi aqi;
  WeatherSituation weatherSituation;

  WeatherResponse({
    this.dailyWeather,
    this.hourlyWeather,
    this.liveInfo,
    this.aqi,
    this.weatherSituation,
  });

  factory WeatherResponse.fromJson(String str) =>
      WeatherResponse.fromMap(json.decode(str));

  factory WeatherResponse.fromMap(Map<String, dynamic> jsonMap) =>
      WeatherResponse(
        dailyWeather: jsonMap[Param.dailyWeather] == null
            ? null
            : List<DailyWeather>.from(jsonMap[Param.dailyWeather]
                .map((x) => DailyWeather.fromMap(x))),
        hourlyWeather: jsonMap[Param.hourlyWeather] == null
            ? null
            : List<HourlyWeather>.from(jsonMap[Param.hourlyWeather]
                .map((x) => HourlyWeather.fromMap(x))),
        liveInfo: jsonMap[Param.liveInfo] == null
            ? null
            : List<LiveInfo>.from(
                jsonMap[Param.liveInfo].map((x) => LiveInfo.fromMap(x))),
        aqi:
            jsonMap[Param.aqi] == null ? null : Aqi.fromMap(jsonMap[Param.aqi]),
        weatherSituation: jsonMap[Param.weatherSituation] == null
            ? null
            : WeatherSituation.fromMap(jsonMap[Param.weatherSituation]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.dailyWeather: dailyWeather == null
            ? null
            : List<dynamic>.from(dailyWeather.map((x) => x.toMap())),
        Param.hourlyWeather: hourlyWeather == null
            ? null
            : List<dynamic>.from(hourlyWeather.map((x) => x.toMap())),
        Param.liveInfo: liveInfo == null
            ? null
            : List<dynamic>.from(liveInfo.map((x) => x.toMap())),
        Param.aqi: aqi == null ? null : aqi.toMap(),
        Param.weatherSituation:
            weatherSituation == null ? null : weatherSituation.toMap(),
      };
}
