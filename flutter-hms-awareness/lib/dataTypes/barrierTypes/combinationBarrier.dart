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

class CombinationBarrier extends AwarenessBarrier {
  String barrierLabel;
  AwarenessBarrier _barrier;
  List<AwarenessBarrier> _barriers;

  CombinationBarrier.not({
    @required this.barrierLabel,
    @required AwarenessBarrier barrier,
  }) : super(
          barrierEventType: Param.combinedBarrierReceiverAction,
          barrierType: Param.combinedNot,
        ) {
    _barriers = null;
    _barrier = barrier;
  }

  CombinationBarrier.and({
    @required this.barrierLabel,
    @required List<AwarenessBarrier> barriers,
  }) : super(
          barrierEventType: Param.combinedBarrierReceiverAction,
          barrierType: Param.combinedAnd,
        ) {
    _barriers = barriers;
    _barrier = null;
  }

  CombinationBarrier.or({
    @required this.barrierLabel,
    @required List<AwarenessBarrier> barriers,
  }) : super(
          barrierEventType: Param.combinedBarrierReceiverAction,
          barrierType: Param.combinedOr,
        ) {
    _barriers = barriers;
    _barrier = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrier: _barrier == null ? null : _barrier.toMap(),
        Param.barriers: _barriers == null
            ? null
            : List<dynamic>.from(_barriers.map((x) => x.toMap())),
      };
}
