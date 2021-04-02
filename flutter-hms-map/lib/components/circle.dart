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

import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:flutter/material.dart' show Color, Colors;
import 'package:meta/meta.dart' show immutable, required;

import 'package:huawei_map/components/components.dart';

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

  final VoidCallback onClick;

  const Circle({
    @required this.circleId,
    this.center = const LatLng(0.0, 0.0),
    this.radius = 0,
    this.strokeColor = Colors.white,
    this.strokeWidth = 1,
    this.fillColor = Colors.transparent,
    this.visible = true,
    this.zIndex = 0,
    this.clickable = false,
    this.onClick,
  });

  Circle updateCopy({
    LatLng center,
    double radius,
    Color strokeColor,
    int strokeWidth,
    Color fillColor,
    bool visible,
    int zIndex,
    bool clickable,
    VoidCallback onClick,
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
    );
  }

  Circle clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Circle check = other;
    return circleId == check.circleId &&
        center == check.center &&
        radius == check.radius &&
        strokeColor == check.strokeColor &&
        strokeWidth == check.strokeWidth &&
        fillColor == check.fillColor &&
        visible == check.visible &&
        clickable == check.clickable &&
        zIndex == check.zIndex;
  }

  @override
  int get hashCode => circleId.hashCode;
}
