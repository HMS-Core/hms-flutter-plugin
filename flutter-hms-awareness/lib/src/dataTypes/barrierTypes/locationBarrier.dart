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

class LocationBarrier extends AwarenessBarrier {
  String barrierLabel;
  double latitude;
  double longitude;
  double radius;
  int? timeOfDuration;

  LocationBarrier.enter({
    required this.barrierLabel,
    required this.latitude,
    required this.longitude,
    required this.radius,
  }) : super(
          barrierEventType: _Param.locationBarrierReceiverAction,
          barrierType: _Param.locationEnterBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeOfDuration = null;
  }

  LocationBarrier.stay({
    required this.barrierLabel,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.timeOfDuration,
  }) : super(
          barrierEventType: _Param.locationBarrierReceiverAction,
          barrierType: _Param.locationStayBarrier,
          barrierLabel: barrierLabel,
        );

  LocationBarrier.exit({
    required this.barrierLabel,
    required this.latitude,
    required this.longitude,
    required this.radius,
  }) : super(
          barrierEventType: _Param.locationBarrierReceiverAction,
          barrierType: _Param.locationExitBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeOfDuration = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.latitude: latitude,
        _Param.longitude: longitude,
        _Param.radius: radius,
        _Param.timeOfDuration: timeOfDuration,
      };
}
