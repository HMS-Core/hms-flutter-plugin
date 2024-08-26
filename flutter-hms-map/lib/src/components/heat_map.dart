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

/// Defines a heatmap placed at a specified position on a map according to GeoJSON format.
@immutable
class HeatMap {
  /// Unique heatmap ID.
  final HeatMapId heatMapId;

  /// Modifies the heatmap color.
  final Map<double, Color>? color;

  /// Resource ID of the heatmap dataset file, in GeoJSON format.
  final int? resourceId;

  /// GeoJSON-format dataset.
  final String? dataSet;

  /// Heatmap intensity.
  ///
  /// The value must be greater than 0.
  /// The default value is `1.0`.
  final double intensity;

  /// - **Key:** Specified zoom levels.
  ///
  /// If only one zoom level is specified, the intensity takes effect for all zoom levels. If multiple zoom levels are specified, the intensity takes effect only for the specified zoom levels.
  ///
  /// - **Value:** Heatmap intensity.
  ///
  /// The value must be greater than 0. The default value is `1.0`.
  final Map<double, double>? intensityMap;

  /// Heatmap transparency.
  ///
  /// The value ranges from 0 to 1.
  /// - `0`: fully opaque.
  /// - `1`: fully transparent.
  /// The default value is `0`.
  final double opacity;

  /// - **Key:** Specified zoom levels.
  ///
  /// If only one zoom level is specified, the transparency takes effect for all zoom levels. If multiple zoom levels are specified, the transparency takes effect only for the specified zoom levels.
  /// - **Value:** Heatmap transparency. The value ranges from 0 to 1.
  ///   - `0`: fully opaque.
  ///   - `1`: fully transparent.
  final Map<double, double>? opacityMap;

  /// Heatmap radius.
  ///
  /// The unit is specified by [RadiusUnit].
  /// The value must be greater than or equal to `1`.
  /// The default value is `10`.
  final double radius;

  /// - **Key:** Specified zoom levels.
  ///
  /// If only one zoom level is specified, the radius takes effect for all zoom levels. If multiple zoom levels are specified, the radius takes effect only for the specified zoom levels.
  ///
  /// - **Value:** Heatmap radius.
  ///
  /// The unit is specified by [RadiusUnit]. The value must be greater than or equal to 1. The default value is 10.
  final Map<double, double>? radiusMap;

  /// Heatmap radius unit.
  /// The options are specified by [RadiusUnit].
  /// The default value is `PIXEL`.
  final RadiusUnit radiusUnit;

  /// Indicates whether a heatmap is visible.
  ///
  /// - **true:** yes
  /// - **false:** no
  ///
  /// The default value is `true`.
  final bool visible;

  /// Creates a [HeatMap] object.
  const HeatMap({
    required this.heatMapId,
    this.color,
    this.resourceId,
    this.dataSet,
    this.intensity = 1.0,
    this.intensityMap,
    this.opacity = 0.0,
    this.opacityMap,
    this.radius = 10,
    this.radiusMap,
    this.radiusUnit = RadiusUnit.pixel,
    this.visible = true,
  });

  /// Copies a [HeatMap] object and updates the specified attributes.
  HeatMap updateCopy({
    Map<double, Color>? color,
    int? resourceId,
    String? dataSet,
    double? intensity,
    Map<double, double>? intensityMap,
    double? opacity,
    Map<double, double>? opacityMap,
    double? radius,
    Map<double, double>? radiusMap,
    RadiusUnit? radiusUnit,
    bool? visible,
  }) {
    return HeatMap(
      heatMapId: heatMapId,
      color: color ?? this.color,
      resourceId: resourceId ?? this.resourceId,
      dataSet: dataSet ?? this.dataSet,
      intensity: intensity ?? this.intensity,
      intensityMap: intensityMap ?? this.intensityMap,
      opacity: opacity ?? this.opacity,
      opacityMap: opacityMap ?? this.opacityMap,
      radius: radius ?? this.radius,
      radiusMap: radiusMap ?? this.radiusMap,
      radiusUnit: radiusUnit ?? this.radiusUnit,
      visible: visible ?? this.visible,
    );
  }

  /// Clones a [HeatMap] object.
  HeatMap clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is HeatMap &&
        heatMapId == other.heatMapId &&
        color == other.color &&
        resourceId == other.resourceId &&
        dataSet == other.dataSet &&
        intensity == other.intensity &&
        intensityMap == other.intensityMap &&
        opacity == other.opacity &&
        opacityMap == other.opacityMap &&
        radius == other.radius &&
        radiusMap == other.radiusMap &&
        radiusUnit == other.radiusUnit &&
        visible == other.visible;
  }

  @override
  int get hashCode => heatMapId.hashCode;
}
