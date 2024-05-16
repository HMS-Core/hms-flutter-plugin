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

class BarrierStatus {
  static const int True = 1;
  static const int False = 0;
  static const int Unknown = 2;

  String? barrierLabel;
  int? lastBarrierUpdateTime;
  int? lastStatus;
  int? presentStatus;

  BarrierStatus({
    this.barrierLabel,
    this.lastBarrierUpdateTime,
    this.lastStatus,
    this.presentStatus,
  });

  factory BarrierStatus.fromJson(String str) =>
      BarrierStatus.fromMap(json.decode(str));

  factory BarrierStatus.fromMap(Map<String, dynamic> json) => BarrierStatus(
        barrierLabel: json[_Param.barrierLabel],
        lastBarrierUpdateTime: json[_Param.lastBarrierUpdateTime],
        lastStatus: json[_Param.lastStatus],
        presentStatus: json[_Param.presentStatus],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierLabel: barrierLabel,
        _Param.lastBarrierUpdateTime: lastBarrierUpdateTime,
        _Param.lastStatus: lastStatus,
        _Param.presentStatus: presentStatus,
      };
}
