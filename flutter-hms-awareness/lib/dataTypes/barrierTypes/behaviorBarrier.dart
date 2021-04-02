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
import 'package:flutter/foundation.dart' show required;
import 'package:huawei_awareness/hmsAwarenessLibrary.dart'
    show AwarenessBarrier;
import 'package:huawei_awareness/constants/param.dart';

class BehaviorBarrier extends AwarenessBarrier {
  static const int BehaviorInVehicle = 0;
  static const int BehaviorOnBicycle = 1;
  static const int BehaviorOnFoot = 2;
  static const int BehaviorStill = 3;
  static const int BehaviorUnknown = 4;
  static const int BehaviorWalking = 7;
  static const int BehaviorRunning = 8;

  String barrierLabel;
  List<int> behaviorTypes;

  BehaviorBarrier.keeping({
    @required this.barrierLabel,
    @required this.behaviorTypes,
  }) : super(
          barrierEventType: Param.behaviorBarrierReceiverAction,
          barrierType: Param.behaviorKeepingBarrier,
          barrierLabel: barrierLabel,
        );

  BehaviorBarrier.beginning({
    @required this.barrierLabel,
    @required this.behaviorTypes,
  }) : super(
          barrierEventType: Param.behaviorBarrierReceiverAction,
          barrierType: Param.behaviorBeginningBarrier,
          barrierLabel: barrierLabel,
        );

  BehaviorBarrier.ending({
    @required this.barrierLabel,
    @required this.behaviorTypes,
  }) : super(
          barrierEventType: Param.behaviorBarrierReceiverAction,
          barrierType: Param.behaviorEndingBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.behaviorTypes: behaviorTypes == null
            ? null
            : List<int>.from(behaviorTypes.map((x) => x)),
      };
}
