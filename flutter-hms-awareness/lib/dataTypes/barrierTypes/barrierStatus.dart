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

class BarrierStatus {
  static const int True = 1;
  static const int False = 0;
  static const int Unknown = 2;

  String barrierLabel;
  int lastBarrierUpdateTime;
  int lastStatus;
  int presentStatus;

  BarrierStatus({
    this.barrierLabel,
    this.lastBarrierUpdateTime,
    this.lastStatus,
    this.presentStatus,
  });

  factory BarrierStatus.fromJson(String str) =>
      BarrierStatus.fromMap(json.decode(str));

  factory BarrierStatus.fromMap(Map<String, dynamic> json) => BarrierStatus(
        barrierLabel:
            json[Param.barrierLabel] == null ? null : json[Param.barrierLabel],
        lastBarrierUpdateTime: json[Param.lastBarrierUpdateTime] == null
            ? null
            : json[Param.lastBarrierUpdateTime],
        lastStatus:
            json[Param.lastStatus] == null ? null : json[Param.lastStatus],
        presentStatus: json[Param.presentStatus] == null
            ? null
            : json[Param.presentStatus],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.lastBarrierUpdateTime:
            lastBarrierUpdateTime == null ? null : lastBarrierUpdateTime,
        Param.lastStatus: lastStatus == null ? null : lastStatus,
        Param.presentStatus: presentStatus == null ? null : presentStatus,
      };
}
