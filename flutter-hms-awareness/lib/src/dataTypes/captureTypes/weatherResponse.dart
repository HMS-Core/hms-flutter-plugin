/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the 'License")
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

class WeatherResponse {
  static const String clothingIndex = '1';
  static const String downJacket = '1';
  static const String heavyCoat = '2';
  static const String sweater = '3';
  static const String thinCoat = '4';
  static const String longSleeves = '5';
  static const String shortSleeve = '6';
  static const String thinShortSleeve = '7';
  static const String sportIndex = '2';
  static const String suitableSport = '1';
  static const String moreSuitableSport = '2';
  static const String notSuitableSport = '3';
  static const String coldIndex = '3';
  static const String notEasyCatchCold = '1';
  static const String easierCatchCold = '2';
  static const String beSusceptibleCold = '3';
  static const String extremelySusceptibleCold = '4';
  static const String carWashIndex = '4';
  static const String tourismIndex = '5';
  static const String unsuitable = '1';
  static const String notVerySuitable = '2';
  static const String moreSuitable = '3';
  static const String suitable = '4';
  static const String uvIndex = '6';
  static const String weakest = '1';
  static const String weak = '2';
  static const String medium = '3';
  static const String strong = '4';
  static const String veryStrong = '5';

  List<DailyWeather>? dailyWeather;
  List<HourlyWeather>? hourlyWeather;
  List<LiveInfo>? liveInfo;
  Aqi? aqi;
  WeatherSituation? weatherSituation;

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
        dailyWeather: List<DailyWeather>.from(
          jsonMap[_Param.dailyWeather].map(
            (dynamic x) => DailyWeather.fromMap(x),
          ),
        ),
        hourlyWeather: List<HourlyWeather>.from(
          jsonMap[_Param.hourlyWeather].map(
            (dynamic x) => HourlyWeather.fromMap(x),
          ),
        ),
        liveInfo: List<LiveInfo>.from(
          jsonMap[_Param.liveInfo].map(
            (dynamic x) => LiveInfo.fromMap(x),
          ),
        ),
        aqi: Aqi.fromMap(jsonMap[_Param.aqi]),
        weatherSituation: WeatherSituation.fromMap(
          jsonMap[_Param.weatherSituation],
        ),
      );

  String toJson() {
    return json.encode(toMap());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _Param.dailyWeather: List<dynamic>.from(
        dailyWeather!.map(
          (DailyWeather x) => x.toMap(),
        ),
      ),
      _Param.hourlyWeather: List<dynamic>.from(
        hourlyWeather!.map(
          (HourlyWeather x) => x.toMap(),
        ),
      ),
      _Param.liveInfo: List<dynamic>.from(
        liveInfo!.map(
          (LiveInfo x) => x.toMap(),
        ),
      ),
      _Param.aqi: aqi?.toMap(),
      _Param.weatherSituation: weatherSituation?.toMap(),
    };
  }
}
