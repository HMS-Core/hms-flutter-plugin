/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:flutter/material.dart' show Color, Colors, immutable;

import 'package:huawei_map/components/components.dart';

@immutable
class Polyline {
  final PolylineId polylineId;
  final bool clickable;
  final Color color;
  final bool geodesic;
  final JointType jointType;
  final List<PatternItem> patterns;
  final List<LatLng> points;
  final Cap startCap;
  final Cap endCap;
  final bool visible;
  final int width;
  final int zIndex;
  final VoidCallback? onClick;

  const Polyline({
    required this.polylineId,
    required this.points,
    this.geodesic = false,
    this.width = 1,
    this.color = Colors.red,
    this.startCap = Cap.buttCap,
    this.endCap = Cap.buttCap,
    this.jointType = JointType.mitered,
    this.patterns = const <PatternItem>[],
    this.visible = true,
    this.zIndex = 0,
    this.clickable = false,
    this.onClick,
  });

  Polyline updateCopy({
    List<LatLng>? points,
    bool? geodesic,
    int? width,
    Color? color,
    Cap? startCap,
    Cap? endCap,
    JointType? jointType,
    List<PatternItem>? patterns,
    bool? visible,
    int? zIndex,
    bool? clickable,
    VoidCallback? onClick,
  }) {
    return Polyline(
      polylineId: polylineId,
      points: points ?? this.points,
      geodesic: geodesic ?? this.geodesic,
      width: width ?? this.width,
      color: color ?? this.color,
      startCap: startCap ?? this.startCap,
      endCap: endCap ?? this.endCap,
      jointType: jointType ?? this.jointType,
      patterns: patterns ?? this.patterns,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
      clickable: clickable ?? this.clickable,
      onClick: onClick ?? this.onClick,
    );
  }

  Polyline clone() {
    return updateCopy(
      patterns: List<PatternItem>.of(patterns),
      points: List<LatLng>.of(points),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is Polyline &&
        this.polylineId == other.polylineId &&
        this.clickable == other.clickable &&
        this.color == other.color &&
        this.geodesic == other.geodesic &&
        this.jointType == other.jointType &&
        listEquals(this.patterns, other.patterns) &&
        listEquals(this.points, other.points) &&
        this.startCap == other.startCap &&
        this.endCap == other.endCap &&
        this.visible == other.visible &&
        this.width == other.width &&
        this.zIndex == other.zIndex;
  }

  @override
  int get hashCode => polylineId.hashCode;
}
