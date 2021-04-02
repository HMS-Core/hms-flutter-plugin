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

class LocationBarrier extends AwarenessBarrier {
  String barrierLabel;
  double latitude;
  double longitude;
  double radius;
  int timeOfDuration;

  LocationBarrier.enter({
    @required this.barrierLabel,
    @required this.latitude,
    @required this.longitude,
    @required this.radius,
  }) : super(
          barrierEventType: Param.locationBarrierReceiverAction,
          barrierType: Param.locationEnterBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeOfDuration = null;
  }

  LocationBarrier.stay({
    @required this.barrierLabel,
    @required this.latitude,
    @required this.longitude,
    @required this.radius,
    @required this.timeOfDuration,
  }) : super(
          barrierEventType: Param.locationBarrierReceiverAction,
          barrierType: Param.locationStayBarrier,
          barrierLabel: barrierLabel,
        );

  LocationBarrier.exit({
    @required this.barrierLabel,
    @required this.latitude,
    @required this.longitude,
    @required this.radius,
  }) : super(
          barrierEventType: Param.locationBarrierReceiverAction,
          barrierType: Param.locationExitBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeOfDuration = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.latitude: latitude == null ? null : latitude,
        Param.longitude: longitude == null ? null : longitude,
        Param.radius: radius == null ? null : radius,
        Param.timeOfDuration: timeOfDuration == null ? null : timeOfDuration,
      };
}
