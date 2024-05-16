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

@immutable
class Circle {
  final CircleId circleId;
  final bool clickable;
  final Color fillColor;
  final LatLng center;
  final double radius;
  final Color strokeColor;
  final int strokeWidth;
  final bool visible;
  final int zIndex;
  final List<PatternItem> strokePattern;
  final VoidCallback? onClick;
  final HmsAnimation? animation;

  const Circle({
    required this.circleId,
    required this.center,
    this.radius = 0,
    this.strokeColor = Colors.white,
    this.strokeWidth = 1,
    this.fillColor = Colors.transparent,
    this.visible = true,
    this.zIndex = 0,
    this.clickable = false,
    this.onClick,
    this.strokePattern = const <PatternItem>[],
    this.animation,
  });

  Circle updateCopy({
    LatLng? center,
    double? radius,
    Color? strokeColor,
    int? strokeWidth,
    Color? fillColor,
    bool? visible,
    int? zIndex,
    bool? clickable,
    VoidCallback? onClick,
    List<PatternItem>? strokePattern,
    List<dynamic>? animations,
  }) {
    return Circle(
      circleId: circleId,
      center: center ?? this.center,
      radius: radius ?? this.radius,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      fillColor: fillColor ?? this.fillColor,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
      clickable: clickable ?? this.clickable,
      onClick: onClick ?? this.onClick,
      strokePattern: strokePattern ?? this.strokePattern,
      animation: animation ?? this.animation,
    );
  }

  Circle clone() {
    return updateCopy(
      strokePattern: List<PatternItem>.of(strokePattern),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is Circle &&
        circleId == other.circleId &&
        center == other.center &&
        radius == other.radius &&
        strokeColor == other.strokeColor &&
        strokeWidth == other.strokeWidth &&
        fillColor == other.fillColor &&
        visible == other.visible &&
        clickable == other.clickable &&
        zIndex == other.zIndex &&
        listEquals(strokePattern, other.strokePattern) &&
        animation == other.animation;
  }

  @override
  int get hashCode => circleId.hashCode;
}
