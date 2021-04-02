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
import 'package:huawei_awareness/hmsAwarenessLibrary.dart'
    show DetectedBehavior;
import 'package:huawei_awareness/constants/param.dart';

class BehaviorResponse {
  int elapsedRealtimeMillis;
  int time;
  DetectedBehavior mostLikelyBehavior;
  List<DetectedBehavior> probableBehavior;

  BehaviorResponse({
    this.elapsedRealtimeMillis,
    this.time,
    this.mostLikelyBehavior,
    this.probableBehavior,
  });

  factory BehaviorResponse.fromJson(String str) =>
      BehaviorResponse.fromMap(json.decode(str));

  factory BehaviorResponse.fromMap(Map<dynamic, dynamic> jsonMap) =>
      BehaviorResponse(
        elapsedRealtimeMillis: jsonMap[Param.elapsedRealtimeMillis] == null
            ? null
            : jsonMap[Param.elapsedRealtimeMillis],
        time: jsonMap[Param.time] == null ? null : jsonMap[Param.time],
        mostLikelyBehavior: jsonMap[Param.mostLikelyBehavior] == null
            ? null
            : DetectedBehavior.fromMap(jsonMap[Param.mostLikelyBehavior]),
        probableBehavior: jsonMap[Param.probableBehavior] == null
            ? null
            : List<DetectedBehavior>.from(jsonMap[Param.probableBehavior]
                .map((x) => DetectedBehavior.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      Param.elapsedRealtimeMillis:
          elapsedRealtimeMillis == null ? null : elapsedRealtimeMillis,
      Param.time: time == null ? null : time,
      Param.mostLikelyBehavior:
          mostLikelyBehavior == null ? null : mostLikelyBehavior.toMap(),
      Param.probableBehavior: probableBehavior == null
          ? null
          : List<DetectedBehavior>.from(probableBehavior.map((x) => x)),
    };
  }
}
