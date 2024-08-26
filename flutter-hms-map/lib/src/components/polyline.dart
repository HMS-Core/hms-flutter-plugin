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

/// Defines a polyline on a map.
@immutable
class Polyline {
  /// Unique polyline ID.
  final PolylineId polylineId;

  /// Indicates whether a polyline is tappable.
  final bool clickable;

  /// Stroke color.
  final Color color;

  /// Indicates whether to draw each segment of a polyline as a geodesic.
  ///
  /// The options are `true` (yes) and `false` (no).
  final bool geodesic;

  /// [JointType] of all vertices of a polyline, except the start and end vertices.
  final JointType jointType;

  /// Stroke pattern of a polyline.
  ///
  /// The default value is `null`, indicating that the stroke pattern is solid.
  final List<PatternItem> patterns;

  /// Vertices of a polyline.
  ///
  /// Line segments are drawn between consecutive points.
  /// A polyline is not closed by default.
  /// To form a closed polyline, the start and end vertices must be the same.
  final List<LatLng> points;

  /// Start vertex of a polyline.
  final Cap startCap;

  /// End vertex of a polyline.
  final Cap endCap;

  /// Visibility of a polyline.
  final bool visible;

  /// Stroke width of a polyline.
  final int width;

  /// Z-index of a polyline, which indicates the overlapping order of the polyline.
  final int zIndex;

  /// Function to be executed when a polyline is tapped.
  final VoidCallback? onClick;

  /// Indicates whether a polyline is gradient.
  ///
  /// Default value is `false`.
  final bool gradient;

  /// Colors of different segments of a polyline.
  final List<Color> colorValues;

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
    this.gradient = false,
    this.colorValues = const <Color>[],
  });

  /// Copies a [Polyline] object and updates the specified attributes.
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
    bool? gradient,
    List<Color>? colorValues,
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
      gradient: gradient ?? this.gradient,
      colorValues: colorValues ?? this.colorValues,
    );
  }

  /// Clones a [Polyline] object.
  Polyline clone() {
    return updateCopy(
      patterns: List<PatternItem>.of(patterns),
      points: List<LatLng>.of(points),
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
    return other is Polyline &&
        polylineId == other.polylineId &&
        clickable == other.clickable &&
        color == other.color &&
        geodesic == other.geodesic &&
        jointType == other.jointType &&
        listEquals(patterns, other.patterns) &&
        listEquals(points, other.points) &&
        startCap == other.startCap &&
        endCap == other.endCap &&
        visible == other.visible &&
        width == other.width &&
        zIndex == other.zIndex &&
        gradient == other.gradient &&
        colorValues == other.colorValues;
  }

  @override
  int get hashCode => polylineId.hashCode;
}
