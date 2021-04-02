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
import 'package:flutter/foundation.dart' show required;
import 'package:huawei_awareness/constants/param.dart';

class WeatherPosition {
  String country;
  String province;
  String city;
  String district;
  String county;
  String locale;

  WeatherPosition({
    @required this.city,
    @required this.locale,
    this.country,
    this.province,
    this.district,
    this.county,
  });

  factory WeatherPosition.fromJson(String str) =>
      WeatherPosition.fromMap(json.decode(str));

  factory WeatherPosition.fromMap(Map<String, dynamic> jsonMap) =>
      WeatherPosition(
        city: jsonMap[Param.city] == null ? null : jsonMap[Param.city],
        locale: jsonMap[Param.locale] == null ? null : jsonMap[Param.locale],
        country: jsonMap[Param.country] == null ? null : jsonMap[Param.country],
        province:
            jsonMap[Param.province] == null ? null : jsonMap[Param.province],
        district:
            jsonMap[Param.district] == null ? null : jsonMap[Param.district],
        county: jsonMap[Param.county] == null ? null : jsonMap[Param.county],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.city: city == null ? null : city,
        Param.locale: locale == null ? null : locale,
        Param.country: country == null ? null : country,
        Param.province: province == null ? null : province,
        Param.district: district == null ? null : district,
        Param.county: county == null ? null : county,
      };
}
