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

class BeaconBarrier extends AwarenessBarrier {
  String barrierLabel;
  List<BeaconFilter>? filters;

  BeaconBarrier.discover({
    required this.barrierLabel,
    required this.filters,
  }) : super(
          barrierEventType: _Param.beaconBarrierReceiverAction,
          barrierType: _Param.beaconDiscoverBarrier,
          barrierLabel: barrierLabel,
        );

  BeaconBarrier.missed({
    required this.barrierLabel,
    required this.filters,
  }) : super(
          barrierEventType: _Param.beaconBarrierReceiverAction,
          barrierType: _Param.beaconMissedBarrier,
          barrierLabel: barrierLabel,
        );

  BeaconBarrier.keep({
    required this.barrierLabel,
    required this.filters,
  }) : super(
          barrierEventType: _Param.beaconBarrierReceiverAction,
          barrierType: _Param.beaconKeepBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.beaconFilters: List<dynamic>.from(
          filters!.map(
            (BeaconFilter x) => x.toMap(),
          ),
        ),
      };
}
