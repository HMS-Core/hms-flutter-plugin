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

abstract class HmsAnimation {
  // Fill Mode Constants
  static const int FORWARDS = 0;
  static const int BACKWARDS = 1;

  // Repeat Mode Constants
  static const int INFINITE = -1;
  static const int RESTART = 1;
  static const int REVERSE = 2;

  // Interpolator Constants
  static const int LINEAR = 0;
  static const int ACCELERATE = 1;
  static const int ANTICIPATE = 2;
  static const int BOUNCE = 3;
  static const int DECELERATE = 4;
  static const int OVERSHOOT = 5;
  static const int ACCELERATE_DECELERATE = 6;
  static const int FAST_OUT_LINEAR_IN = 7;
  static const int FAST_OUT_SLOW_IN = 8;
  static const int LINEAR_OUT_SLOW_IN = 9;

  // Animation Type Constants
  static const String ALPHA = 'HmsAlphaAnimation';
  static const String ROTATE = 'HmsRotateAnimation';
  static const String SCALE = 'HmsScaleAnimation';
  static const String TRANSLATE = 'HmsTranslateAnimation';

  String animationId;
  String type;
  int? duration;
  int? fillMode;
  int? repeatCount;
  int? repeatMode;
  int? interpolator;

  void abstractOnAnimStart();
  void abstractOnAnimEnd();

  late MethodChannel _methodChannel;

  Future<dynamic> _multiMethodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onAnimationStart':
        abstractOnAnimStart();
        break;
      case 'onAnimationEnd':
        abstractOnAnimEnd();
        break;
      default:
        break;
    }
  }

  void setMethodChannel(String id) {
    _methodChannel = MethodChannel('${_animationChannel}_$animationId');
    _methodChannel.setMethodCallHandler(_multiMethodCallHandler);
  }

  HmsAnimation({
    required this.animationId,
    required this.type,
    this.duration,
    this.fillMode,
    this.repeatCount,
    this.repeatMode,
    this.interpolator,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is HmsAnimation &&
        animationId == other.animationId &&
        type == other.type &&
        duration == other.duration &&
        fillMode == other.fillMode &&
        repeatCount == other.repeatCount &&
        repeatMode == other.repeatMode &&
        interpolator == other.interpolator;
  }

  @override
  int get hashCode => animationId.hashCode;
}
