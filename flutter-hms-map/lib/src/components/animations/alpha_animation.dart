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

part of huawei_map;

class HmsAlphaAnimation extends HmsAnimation {
  double fromAlpha;
  double toAlpha;
  Function? onAnimationStart;
  Function? onAnimationEnd;

  @override
  void abstractOnAnimStart() {
    onAnimationStart?.call();
  }

  @override
  void abstractOnAnimEnd() {
    onAnimationEnd?.call();
  }

  HmsAlphaAnimation({
    required String animationId,
    required this.fromAlpha,
    required this.toAlpha,
    int duration = 250,
    int fillMode = 0,
    int repeatCount = 0,
    int repeatMode = 1,
    int interpolator = 0,
    this.onAnimationStart,
    this.onAnimationEnd,
  }) : super(
          animationId: animationId,
          type: HmsAnimation.ALPHA,
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
    return other is HmsAlphaAnimation &&
        animationId == other.animationId &&
        fromAlpha == other.fromAlpha &&
        toAlpha == other.toAlpha;
  }

  @override
  int get hashCode => animationId.hashCode;
}
