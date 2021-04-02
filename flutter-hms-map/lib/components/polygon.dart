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

import 'package:flutter/foundation.dart' show listEquals, VoidCallback;
import 'package:flutter/material.dart' show Color, Colors;
import 'package:meta/meta.dart' show immutable, required;

import 'package:huawei_map/components/components.dart';

@immutable
class Polygon {
  final PolygonId polygonId;
  final bool clickable;
  final Color fillColor;
  final bool geodesic;
  final List<LatLng> points;
  final bool visible;
  final Color strokeColor;
  final int strokeWidth;
  final int zIndex;
  final VoidCallback onClick;

  const Polygon({
    @required this.polygonId,
    this.points = const <LatLng>[],
    this.geodesic = false,
    this.strokeColor = Colors.white,
    this.strokeWidth = 1,
    this.fillColor = Colors.transparent,
    this.visible = true,
    this.zIndex = 0,
    this.clickable = false,
    this.onClick,
  });

  Polygon updateCopy({
    List<LatLng> points,
    bool geodesic,
    Color strokeColor,
    int strokeWidth,
    Color fillColor,
    bool visible,
    int zIndex,
    bool clickable,
    VoidCallback onClick,
  }) {
    return Polygon(
      polygonId: polygonId,
      points: points ?? this.points,
      geodesic: geodesic ?? this.geodesic,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      fillColor: fillColor ?? this.fillColor,
      visible: visible ?? this.visible,
      clickable: clickable ?? this.clickable,
      onClick: onClick ?? this.onClick,
      zIndex: zIndex ?? this.zIndex,
    );
  }

  Polygon clone() {
    return updateCopy(points: List<LatLng>.of(points));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Polygon check = other;
    return polygonId == check.polygonId &&
        clickable == check.clickable &&
        fillColor == check.fillColor &&
        geodesic == check.geodesic &&
        listEquals(points, check.points) &&
        visible == check.visible &&
        strokeColor == check.strokeColor &&
        strokeWidth == check.strokeWidth &&
        zIndex == check.zIndex;
  }

  @override
  int get hashCode => polygonId.hashCode;
}
