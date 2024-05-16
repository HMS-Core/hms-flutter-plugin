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
  final bool gradient;
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
