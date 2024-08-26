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

part of '../../../huawei_map.dart';

/// Controls the animation rotation.
class HmsRotateAnimation extends HmsAnimation {
  /// Initial angle.
  double fromDegree;

  /// Target angle.
  double toDegree;

  /// Function to be executed when an animation starts.
  Function? onAnimationStart;

  /// Function to be executed when an animation ends.
  Function? onAnimationEnd;

  @override
  void abstractOnAnimStart() {
    onAnimationStart?.call();
  }

  @override
  void abstractOnAnimEnd() {
    onAnimationEnd?.call();
  }

  /// Creates an [HmsRotateAnimation] object.
  HmsRotateAnimation({
    required String animationId,
    required this.fromDegree,
    required this.toDegree,
    int duration = 250,
    int fillMode = 0,
    int repeatCount = 0,
    int repeatMode = 1,
    int interpolator = 1,
    this.onAnimationStart,
    this.onAnimationEnd,
  }) : super(
          animationId: animationId,
          type: HmsAnimation.ROTATE,
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
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is HmsRotateAnimation &&
        animationId == other.animationId &&
        fromDegree == other.fromDegree &&
        toDegree == other.toDegree;
  }

  @override
  int get hashCode => animationId.hashCode;
}
