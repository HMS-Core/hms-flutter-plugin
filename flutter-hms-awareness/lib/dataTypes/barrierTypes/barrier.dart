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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart' show BarrierStatus;
import 'package:huawei_awareness/constants/param.dart';

class Barrier {
  String barrierLabel;
  BarrierStatus barrierStatus;

  Barrier({
    this.barrierLabel,
    this.barrierStatus,
  });

  factory Barrier.fromJson(String str) => Barrier.fromMap(json.decode(str));

  factory Barrier.fromMap(Map<String, dynamic> json) => Barrier(
        barrierLabel:
            json[Param.barrierLabel] == null ? null : json[Param.barrierLabel],
        barrierStatus: json[Param.barrierStatus] == null
            ? null
            : BarrierStatus.fromMap(json[Param.barrierStatus]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.barrierStatus:
            barrierStatus == null ? null : barrierStatus.toMap(),
      };
}
