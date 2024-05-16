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

class City {
  String? cityCode;
  String? name;
  String? provinceName;
  String? timeZone;

  City({
    this.cityCode,
    this.name,
    this.provinceName,
    this.timeZone,
  });

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  factory City.fromMap(Map<String, dynamic> jsonMap) => City(
        cityCode: jsonMap[_Param.cityCode],
        name: jsonMap[_Param.name],
        provinceName: jsonMap[_Param.provinceName],
        timeZone: jsonMap[_Param.timeZone],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.cityCode: cityCode,
        _Param.name: name,
        _Param.provinceName: provinceName,
        _Param.timeZone: timeZone,
      };
}
