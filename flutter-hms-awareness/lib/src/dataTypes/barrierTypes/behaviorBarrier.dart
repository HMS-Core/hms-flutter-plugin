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

class BehaviorBarrier extends AwarenessBarrier {
  static const int behaviorInVehicle = 0;
  static const int behaviorOnBicycle = 1;
  static const int behaviorOnFoot = 2;
  static const int behaviorStill = 3;
  static const int behaviorUnknown = 4;
  static const int behaviorWalking = 7;
  static const int behaviorRunning = 8;

  String barrierLabel;
  List<int>? behaviorTypes;

  BehaviorBarrier.keeping({
    required this.barrierLabel,
    required this.behaviorTypes,
  }) : super(
          barrierEventType: _Param.behaviorBarrierReceiverAction,
          barrierType: _Param.behaviorKeepingBarrier,
          barrierLabel: barrierLabel,
        );

  BehaviorBarrier.beginning({
    required this.barrierLabel,
    required this.behaviorTypes,
  }) : super(
          barrierEventType: _Param.behaviorBarrierReceiverAction,
          barrierType: _Param.behaviorBeginningBarrier,
          barrierLabel: barrierLabel,
        );

  BehaviorBarrier.ending({
    required this.barrierLabel,
    required this.behaviorTypes,
  }) : super(
          barrierEventType: _Param.behaviorBarrierReceiverAction,
          barrierType: _Param.behaviorEndingBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.behaviorTypes: List<int>.from(
          behaviorTypes!.map((int x) => x),
        ),
      };
}
