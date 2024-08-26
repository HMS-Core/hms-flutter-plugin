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

/// Controls the animation scale.
class HmsScaleAnimation extends HmsAnimation {
  /// Horizontal scale ratio when the animation starts.
  double fromX;

  /// Horizontal scale ratio when the animation ends.
  double toX;

  /// Vertical scale ratio when the animation starts.
  double fromY;

  /// Vertical scale ratio when the animation ends.
  double toY;

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

  /// Creates an [HmScaleAnimation] object.
  HmsScaleAnimation({
    required String animationId,
    required this.fromX,
    required this.toX,
    required this.fromY,
    required this.toY,
    int duration = 250,
    int fillMode = 1,
    int repeatCount = 0,
    int repeatMode = 1,
    int interpolator = 0,
    this.onAnimationStart,
    this.onAnimationEnd,
  }) : super(
          animationId: animationId,
          type: HmsAnimation.SCALE,
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
    return other is HmsScaleAnimation &&
        animationId == other.animationId &&
        fromX == other.fromX &&
        toX == other.toX &&
        fromY == other.fromY &&
        toY == other.toY;
  }

  @override
  int get hashCode => animationId.hashCode;
}
