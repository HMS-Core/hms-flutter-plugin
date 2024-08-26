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

/// Defines a polygon on a map.
@immutable
class Polygon {
  /// Unique polygon ID.
  final PolygonId polygonId;

  /// Indicates whether a polygon is tappable.
  final bool clickable;

  /// Fill color.
  final Color fillColor;

  /// Indicates whether to draw each segment of a polygon as a geodesic.
  ///
  /// The options are `true` (yes) and `false` (no).
  final bool geodesic;

  /// Vertex coordinate set.
  final List<LatLng> points;

  /// Visibility of a polygon.
  final bool visible;

  /// Stroke color.
  final Color strokeColor;

  /// Stroke width of a polygon's outline.
  final int strokeWidth;

  /// Z-index of a polygon, which indicates the overlapping order of the polygon.
  final int zIndex;

  /// Function to be executed when a polygon is tapped.
  final VoidCallback? onClick;

  /// Holes in a polygon.
  final List<List<LatLng>> holes;

  /// Joint type of a polygon.
  final JointType strokeJointType;

  /// Stroke pattern of a polygon's outline.
  final List<PatternItem> strokePattern;

  /// Creates a [Polygon] object.
  const Polygon({
    required this.polygonId,
    required this.points,
    this.geodesic = false,
    this.strokeColor = Colors.white,
    this.strokeWidth = 1,
    this.fillColor = Colors.transparent,
    this.visible = true,
    this.zIndex = 0,
    this.clickable = false,
    this.onClick,
    this.holes = const <List<LatLng>>[],
    this.strokeJointType = JointType.mitered,
    this.strokePattern = const <PatternItem>[],
  });

  /// Copies a [Polygon] object and updates the specified attributes.
  Polygon updateCopy({
    List<LatLng>? points,
    bool? geodesic,
    Color? strokeColor,
    int? strokeWidth,
    Color? fillColor,
    bool? visible,
    int? zIndex,
    bool? clickable,
    VoidCallback? onClick,
    List<List<LatLng>>? holes,
    JointType? strokeJointType,
    List<PatternItem>? strokePattern,
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
      holes: holes ?? this.holes,
      strokeJointType: strokeJointType ?? this.strokeJointType,
      strokePattern: strokePattern ?? this.strokePattern,
    );
  }

  /// Clones a [Polygon] object.
  Polygon clone() {
    return updateCopy(
      points: List<LatLng>.of(points),
      holes: List<List<LatLng>>.of(holes),
      strokePattern: List<PatternItem>.of(strokePattern),
    );
  }

  bool _holesEquals(List<dynamic> curr, List<dynamic> other) {
    if (curr.length != other.length) {
      return false;
    }
    for (int i = 0; i < curr.length; i++) {
      if (!listEquals(curr[i], other[i])) {
        return false;
      }
    }
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is Polygon &&
        polygonId == other.polygonId &&
        clickable == other.clickable &&
        fillColor == other.fillColor &&
        geodesic == other.geodesic &&
        listEquals(points, other.points) &&
        visible == other.visible &&
        strokeColor == other.strokeColor &&
        strokeWidth == other.strokeWidth &&
        zIndex == other.zIndex &&
        _holesEquals(holes, other.holes) &&
        strokeJointType == other.strokeJointType &&
        listEquals(strokePattern, other.strokePattern);
  }

  @override
  int get hashCode => polygonId.hashCode;
}
