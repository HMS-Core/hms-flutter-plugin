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

class DailyLiveInfo {
  int dateTimeStamp;
  String level;

  DailyLiveInfo({
    this.dateTimeStamp,
    this.level,
  });

  factory DailyLiveInfo.fromJson(String str) =>
      DailyLiveInfo.fromMap(json.decode(str));

  factory DailyLiveInfo.fromMap(Map<String, dynamic> jsonMap) => DailyLiveInfo(
        dateTimeStamp: jsonMap[Param.dateTimeStamp] == null
            ? null
            : jsonMap[Param.dateTimeStamp],
        level: jsonMap[Param.level] == null ? null : jsonMap[Param.level],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.dateTimeStamp: dateTimeStamp == null ? null : dateTimeStamp,
        Param.level: level == null ? null : level,
      };
}
