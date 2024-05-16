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

class BehaviorResponse {
  int? elapsedRealtimeMillis;
  int? time;
  DetectedBehavior? mostLikelyBehavior;
  List<DetectedBehavior>? probableBehavior;

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
        elapsedRealtimeMillis: jsonMap[_Param.elapsedRealtimeMillis],
        time: jsonMap[_Param.time],
        mostLikelyBehavior: DetectedBehavior.fromMap(
          jsonMap[_Param.mostLikelyBehavior],
        ),
        probableBehavior: List<DetectedBehavior>.from(
          jsonMap[_Param.probableBehavior].map(
            (dynamic x) => DetectedBehavior.fromMap(x),
          ),
        ),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _Param.elapsedRealtimeMillis: elapsedRealtimeMillis,
      _Param.time: time,
      _Param.mostLikelyBehavior: mostLikelyBehavior?.toMap(),
      _Param.probableBehavior: List<DetectedBehavior>.from(
        probableBehavior!.map((DetectedBehavior x) => x),
      ),
    };
  }
}
