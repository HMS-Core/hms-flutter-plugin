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
    show AwarenessBarrier, BeaconFilter;
import 'package:huawei_awareness/constants/param.dart';

class BeaconBarrier extends AwarenessBarrier {
  String barrierLabel;
  List<BeaconFilter> filters;

  BeaconBarrier.discover({
    @required this.barrierLabel,
    @required this.filters,
  }) : super(
          barrierEventType: Param.beaconBarrierReceiverAction,
          barrierType: Param.beaconDiscoverBarrier,
          barrierLabel: barrierLabel,
        );

  BeaconBarrier.missed({
    @required this.barrierLabel,
    @required this.filters,
  }) : super(
          barrierEventType: Param.beaconBarrierReceiverAction,
          barrierType: Param.beaconMissedBarrier,
          barrierLabel: barrierLabel,
        );

  BeaconBarrier.keep({
    @required this.barrierLabel,
    @required this.filters,
  }) : super(
          barrierEventType: Param.beaconBarrierReceiverAction,
          barrierType: Param.beaconKeepBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.beaconFilters: filters == null
            ? null
            : List<dynamic>.from(filters.map((x) => x.toMap())),
      };
}
