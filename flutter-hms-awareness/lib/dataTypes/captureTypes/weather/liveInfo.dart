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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart' show DailyLiveInfo;
import 'package:huawei_awareness/constants/param.dart';

class LiveInfo {
  String code;
  List<DailyLiveInfo> levelList;

  LiveInfo({
    this.code,
    this.levelList,
  });

  factory LiveInfo.fromJson(String str) => LiveInfo.fromMap(json.decode(str));

  factory LiveInfo.fromMap(Map<String, dynamic> jsonMap) => LiveInfo(
        code: jsonMap[Param.code] == null ? null : jsonMap[Param.code],
        levelList: jsonMap[Param.dailyLiveInfo] == null
            ? null
            : List<DailyLiveInfo>.from(jsonMap[Param.dailyLiveInfo]
                .map((x) => DailyLiveInfo.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.code: code == null ? null : code,
        Param.dailyLiveInfo: levelList == null
            ? null
            : List<DailyLiveInfo>.from(levelList.map((x) => x.toMap())),
      };
}
