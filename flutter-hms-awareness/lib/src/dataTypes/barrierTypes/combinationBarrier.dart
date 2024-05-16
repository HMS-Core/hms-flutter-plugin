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

class CombinationBarrier extends AwarenessBarrier {
  String barrierLabel;
  AwarenessBarrier? _barrier;
  List<AwarenessBarrier>? _barriers;

  CombinationBarrier.not({
    required this.barrierLabel,
    required AwarenessBarrier barrier,
  }) : super(
          barrierEventType: _Param.combinedBarrierReceiverAction,
          barrierType: _Param.combinedNot,
          barrierLabel: barrierLabel,
        ) {
    _barriers = null;
    _barrier = barrier;
  }

  CombinationBarrier.and({
    required this.barrierLabel,
    required List<AwarenessBarrier> barriers,
  }) : super(
          barrierEventType: _Param.combinedBarrierReceiverAction,
          barrierType: _Param.combinedAnd,
          barrierLabel: barrierLabel,
        ) {
    _barriers = barriers;
    _barrier = null;
  }

  CombinationBarrier.or({
    required this.barrierLabel,
    required List<AwarenessBarrier> barriers,
  }) : super(
          barrierEventType: _Param.combinedBarrierReceiverAction,
          barrierType: _Param.combinedOr,
          barrierLabel: barrierLabel,
        ) {
    _barriers = barriers;
    _barrier = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierLabel: barrierLabel,
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrier: _barrier?.toMap(),
        _Param.barriers: _barriers == null
            ? null
            : List<dynamic>.from(
                _barriers!.map(
                  (AwarenessBarrier x) => x.toMap(),
                ),
              ),
      };
}
