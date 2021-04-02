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

class DailySituation {
  int cnWeatherId;
  int weatherId;
  String windDir;
  int windLevel;
  int windSpeed;

  DailySituation({
    this.cnWeatherId,
    this.weatherId,
    this.windDir,
    this.windLevel,
    this.windSpeed,
  });

  factory DailySituation.fromJson(String str) =>
      DailySituation.fromMap(json.decode(str));

  factory DailySituation.fromMap(Map<String, dynamic> jsonMap) =>
      DailySituation(
        cnWeatherId: jsonMap[Param.cnWeatherId] == null
            ? null
            : jsonMap[Param.cnWeatherId],
        weatherId:
            jsonMap[Param.weatherId] == null ? null : jsonMap[Param.weatherId],
        windDir: jsonMap[Param.windDir] == null ? null : jsonMap[Param.windDir],
        windLevel:
            jsonMap[Param.windLevel] == null ? null : jsonMap[Param.windLevel],
        windSpeed:
            jsonMap[Param.windSpeed] == null ? null : jsonMap[Param.windSpeed],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.cnWeatherId: cnWeatherId == null ? null : cnWeatherId,
        Param.weatherId: weatherId == null ? null : weatherId,
        Param.windDir: windDir == null ? null : windDir,
        Param.windLevel: windLevel == null ? null : windLevel,
        Param.windSpeed: windSpeed == null ? null : windSpeed,
      };
}
