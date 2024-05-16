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

class WeatherPosition {
  String? country;
  String? province;
  String city;
  String? district;
  String? county;
  String locale;

  WeatherPosition({
    required this.city,
    required this.locale,
    this.country,
    this.province,
    this.district,
    this.county,
  });

  factory WeatherPosition.fromJson(String str) =>
      WeatherPosition.fromMap(json.decode(str));

  factory WeatherPosition.fromMap(Map<String, dynamic> jsonMap) =>
      WeatherPosition(
        city: jsonMap[_Param.city],
        locale: jsonMap[_Param.locale],
        country: jsonMap[_Param.country],
        province: jsonMap[_Param.province],
        district: jsonMap[_Param.district],
        county: jsonMap[_Param.county],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.city: city,
        _Param.locale: locale,
        _Param.country: country,
        _Param.province: province,
        _Param.district: district,
        _Param.county: county,
      };
}
