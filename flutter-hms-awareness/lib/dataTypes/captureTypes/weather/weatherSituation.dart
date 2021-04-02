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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart' show Situation, City;
import 'package:huawei_awareness/constants/param.dart';

class WeatherSituation {
  City city;
  Situation situation;

  WeatherSituation({
    this.city,
    this.situation,
  });

  factory WeatherSituation.fromJson(String str) =>
      WeatherSituation.fromMap(json.decode(str));

  factory WeatherSituation.fromMap(Map<String, dynamic> jsonMap) =>
      WeatherSituation(
        city: jsonMap[Param.city] == null
            ? null
            : City.fromMap(jsonMap[Param.city]),
        situation: jsonMap[Param.situation] == null
            ? null
            : Situation.fromMap(jsonMap[Param.situation]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.city: city == null ? null : city.toMap(),
        Param.situation: situation == null ? null : situation.toMap(),
      };
}
