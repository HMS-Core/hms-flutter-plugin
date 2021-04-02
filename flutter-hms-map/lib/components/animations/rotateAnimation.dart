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

import 'package:flutter/foundation.dart' show required;

import 'animation.dart';

class HmsMarkerRotateAnimation extends HmsMarkerAnimation {
  String animationId;
  double fromDegree;
  double toDegree;

  Function onAnimationStart;
  Function onAnimationEnd;

  @override
  void abstractOnAnimStart() {
    this.onAnimationStart();
  }

  @override
  void abstractOnAnimEnd() {
    this.onAnimationEnd();
  }

  HmsMarkerRotateAnimation({
    @required this.animationId,
    @required this.fromDegree,
    @required this.toDegree,
    int duration = 250,
    int fillMode = 0,
    int repeatCount = 0,
    int repeatMode = 1,
    int interpolator = 1,
    this.onAnimationStart,
    this.onAnimationEnd,
  }) : super(
          animationId: animationId,
          type: HmsMarkerAnimation.ROTATE,
          duration: duration,
          fillMode: fillMode,
          repeatCount: repeatCount,
          repeatMode: repeatMode,
          interpolator: interpolator,
        ) {
    setMethodChannel(animationId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final HmsMarkerRotateAnimation check = other;
    return animationId == check.animationId &&
        fromDegree == check.fromDegree &&
        toDegree == check.toDegree;
  }

  @override
  int get hashCode => animationId.hashCode;
}
