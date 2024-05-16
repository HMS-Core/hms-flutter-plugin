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

class AmbientLightBarrier extends AwarenessBarrier {
  String barrierLabel;
  double? minLightIntensity;
  double? maxLightIntensity;

  AmbientLightBarrier.above({
    required this.barrierLabel,
    required this.minLightIntensity,
  }) : super(
          barrierEventType: _Param.ambientLightBarrierReceiverAction,
          barrierType: _Param.ambientLightAboveBarrier,
          barrierLabel: barrierLabel,
        ) {
    maxLightIntensity = null;
  }

  AmbientLightBarrier.below({
    required this.barrierLabel,
    required this.maxLightIntensity,
  }) : super(
          barrierEventType: _Param.ambientLightBarrierReceiverAction,
          barrierType: _Param.ambientLightBelowBarrier,
          barrierLabel: barrierLabel,
        ) {
    minLightIntensity = null;
  }

  AmbientLightBarrier.range({
    required this.barrierLabel,
    required this.minLightIntensity,
    required this.maxLightIntensity,
  }) : super(
          barrierEventType: _Param.ambientLightBarrierReceiverAction,
          barrierType: _Param.ambientLightRangeBarrier,
          barrierLabel: barrierLabel,
        );

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.minLightIntensity: minLightIntensity,
        _Param.maxLightIntensity: maxLightIntensity,
      };
}
