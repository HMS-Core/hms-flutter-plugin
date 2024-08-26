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

part of '../../huawei_map.dart';

/// Defines a circle on a map.
@immutable
class Circle {
  /// Unique circle ID.
  final CircleId circleId;

  /// Indicates whether a circle is tappable.
  final bool clickable;

  /// Fill color.
  final Color fillColor;

  /// [Longitude] and [latitude] of the center of a circle.
  final LatLng center;

  /// Radius of a circle.
  final double radius;

  /// Stroke color.
  final Color strokeColor;

  /// Stroke width of a circle's outline.
  final int strokeWidth;

  /// Visibility of a circle.
  final bool visible;

  /// Z-index of a circle, which indicates the overlapping order of the circle.
  final int zIndex;

  /// Stroke pattern of a circle's outline.
  final List<PatternItem> strokePattern;

  /// Function to be executed when a circle is tapped.
  final VoidCallback? onClick;

  /// Animation for a circle.
  ///
  /// Only [HmsTranslateAnimation] is supported.
  final HmsAnimation? animation;

  /// Creates a [Circle] object.
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

  /// Copies a [Circle] object and updates the specified attributes
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

  /// Clones a [Circle] object.
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
