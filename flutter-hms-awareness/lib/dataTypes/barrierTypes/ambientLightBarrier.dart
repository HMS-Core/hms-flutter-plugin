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

class AmbientLightBarrier extends AwarenessBarrier {
  String barrierLabel;
  double minLightIntensity;
  double maxLightIntensity;

  AmbientLightBarrier.above({
    @required this.barrierLabel,
    @required this.minLightIntensity,
  }) : super(
          barrierEventType: Param.ambientLightBarrierReceiverAction,
          barrierType: Param.ambientLightAboveBarrier,
          barrierLabel: barrierLabel,
        ) {
    maxLightIntensity = null;
  }

  AmbientLightBarrier.below({
    @required this.barrierLabel,
    @required this.maxLightIntensity,
  }) : super(
          barrierEventType: Param.ambientLightBarrierReceiverAction,
          barrierType: Param.ambientLightBelowBarrier,
          barrierLabel: barrierLabel,
        ) {
    minLightIntensity = null;
  }

  AmbientLightBarrier.range({
    @required this.barrierLabel,
    @required this.minLightIntensity,
    @required this.maxLightIntensity,
  }) : super(
          barrierEventType: Param.ambientLightBarrierReceiverAction,
          barrierType: Param.ambientLightRangeBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.minLightIntensity:
            minLightIntensity == null ? null : minLightIntensity,
        Param.maxLightIntensity:
            maxLightIntensity == null ? null : maxLightIntensity,
      };
}
