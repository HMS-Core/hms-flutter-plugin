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

class HuaweiMapOptions {
  final MapType? mapType;
  final bool? compassEnabled;
  final bool? isDark;
  final bool? mapToolbarEnabled;
  final CameraTargetBounds? cameraTargetBounds;
  final MinMaxZoomPreference? minMaxZoomPreference;
  final bool? rotateGesturesEnabled;
  final bool? scrollGesturesEnabled;
  final bool? tiltGesturesEnabled;
  final bool? trackCameraPosition;
  final bool? zoomControlsEnabled;
  final bool? zoomGesturesEnabled;
  final bool? myLocationEnabled;
  final bool? myLocationButtonEnabled;
  final EdgeInsets? padding;
  final bool? trafficEnabled;
  final bool? markersClusteringEnabled;
  final bool? buildingsEnabled;
  final bool? allGesturesEnabled;
  final bool? isScrollGesturesEnabledDuringRotateOrZoom;
  final bool? gestureScaleByMapCenter;
  final ScreenCoordinate? pointToCenter;
  final Color? clusterMarkerColor;
  final Color? clusterMarkerTextColor;
  final BitmapDescriptor? clusterIconDescriptor;
  final int? logoPosition;
  final EdgeInsets? logoPadding;
  final String? styleId;
  final String? previewId;
  final bool? liteMode;
  final MyLocationStyle? myLocationStyle;

  const HuaweiMapOptions({
    this.mapType,
    this.compassEnabled,
    this.isDark,
    this.mapToolbarEnabled,
    this.cameraTargetBounds,
    this.minMaxZoomPreference,
    this.rotateGesturesEnabled,
    this.scrollGesturesEnabled,
    this.tiltGesturesEnabled,
    this.trackCameraPosition,
    this.zoomControlsEnabled,
    this.zoomGesturesEnabled,
    this.myLocationEnabled,
    this.myLocationButtonEnabled,
    this.padding,
    this.trafficEnabled,
    this.markersClusteringEnabled,
    this.buildingsEnabled,
    this.allGesturesEnabled,
    this.isScrollGesturesEnabledDuringRotateOrZoom,
    this.gestureScaleByMapCenter,
    this.pointToCenter,
    this.clusterMarkerColor,
    this.clusterMarkerTextColor,
    this.clusterIconDescriptor,
    this.logoPosition,
    this.logoPadding,
    this.styleId,
    this.previewId,
    this.liteMode,
    this.myLocationStyle,
  });

  static HuaweiMapOptions fromWidget(HuaweiMap map) {
    return HuaweiMapOptions(
      mapType: map.mapType,
      compassEnabled: map.compassEnabled,
      isDark: map.isDark,
      mapToolbarEnabled: map.mapToolbarEnabled,
      cameraTargetBounds: map.cameraTargetBounds,
      minMaxZoomPreference: map.minMaxZoomPreference,
      rotateGesturesEnabled: map.rotateGesturesEnabled,
      scrollGesturesEnabled: map.scrollGesturesEnabled,
      tiltGesturesEnabled: map.tiltGesturesEnabled,
      trackCameraPosition: map.onCameraMove != null,
      zoomControlsEnabled: map.zoomControlsEnabled,
      zoomGesturesEnabled: map.zoomGesturesEnabled,
      myLocationEnabled: map.myLocationEnabled,
      myLocationButtonEnabled: map.myLocationButtonEnabled,
      padding: map.padding,
      trafficEnabled: map.trafficEnabled,
      markersClusteringEnabled: map.markersClusteringEnabled,
      buildingsEnabled: map.buildingsEnabled,
      allGesturesEnabled: map.allGesturesEnabled,
      isScrollGesturesEnabledDuringRotateOrZoom:
          map.isScrollGesturesEnabledDuringRotateOrZoom,
      gestureScaleByMapCenter: map.gestureScaleByMapCenter,
      pointToCenter: map.pointToCenter,
      clusterMarkerColor: map.clusterMarkerColor,
      clusterMarkerTextColor: map.clusterMarkerTextColor,
      clusterIconDescriptor: map.clusterIconDescriptor,
      logoPosition: map.logoPosition,
      logoPadding: map.logoPadding,
      styleId: map.styleId,
      previewId: map.previewId,
      liteMode: map.liteMode,
      myLocationStyle: map.myLocationStyle,
    );
  }

  int _mapTypeToInt(MapType mapType) {
    switch (mapType) {
      case MapType.none:
        return 0;
      case MapType.normal:
        return 1;
      case MapType.terrain:
        return 3;
      default:
        throw ('Invalid Map Type');
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    addToMap(optionsMap, _Param.compassEnabled, compassEnabled);
    addToMap(optionsMap, _Param.isDark, isDark);
    addToMap(optionsMap, _Param.mapToolbarEnabled, mapToolbarEnabled);
    addToMap(
      optionsMap,
      _Param.cameraTargetBounds,
      cameraTargetBounds != null
          ? cameraTargetBoundsToJson(cameraTargetBounds!)
          : null,
    );
    addToMap(optionsMap, _Param.mapType, _mapTypeToInt(mapType!));
    addToMap(
      optionsMap,
      _Param.minMaxZoomPreference,
      minMaxZoomPreference != null
          ? minMaxZoomPreferenceToJson(minMaxZoomPreference!)
          : null,
    );
    addToMap(optionsMap, _Param.rotateGesturesEnabled, rotateGesturesEnabled);
    addToMap(optionsMap, _Param.scrollGesturesEnabled, scrollGesturesEnabled);
    addToMap(optionsMap, _Param.tiltGesturesEnabled, tiltGesturesEnabled);
    addToMap(optionsMap, _Param.zoomControlsEnabled, zoomControlsEnabled);
    addToMap(optionsMap, _Param.zoomGesturesEnabled, zoomGesturesEnabled);
    addToMap(optionsMap, _Param.trackCameraPosition, trackCameraPosition);
    addToMap(optionsMap, _Param.myLocationEnabled, myLocationEnabled);
    addToMap(
      optionsMap,
      _Param.myLocationButtonEnabled,
      myLocationButtonEnabled,
    );
    addToMap(optionsMap, _Param.padding, <double>[
      padding!.top,
      padding!.left,
      padding!.bottom,
      padding!.right,
    ]);
    addToMap(optionsMap, _Param.trafficEnabled, trafficEnabled);
    addToMap(
      optionsMap,
      _Param.markersClusteringEnabled,
      markersClusteringEnabled,
    );
    addToMap(optionsMap, _Param.buildingsEnabled, buildingsEnabled);
    addToMap(optionsMap, _Param.allGesturesEnabled, allGesturesEnabled);
    addToMap(
      optionsMap,
      _Param.isScrollGesturesEnabledDuringRotateOrZoom,
      isScrollGesturesEnabledDuringRotateOrZoom,
    );
    addToMap(
      optionsMap,
      _Param.gestureScaleByMapCenter,
      gestureScaleByMapCenter,
    );
    addToMap(
      optionsMap,
      _Param.pointToCenter,
      pointToCenter == null ? null : screenCoordinateToJson(pointToCenter!),
    );
    addToMap(optionsMap, _Param.clusterMarkerColor, clusterMarkerColor?.value);
    addToMap(
      optionsMap,
      _Param.clusterMarkerTextColor,
      clusterMarkerTextColor?.value,
    );
    addToMap(
      optionsMap,
      _Param.clusterMarkerIcon,
      clusterIconDescriptor?.toJson(),
    );
    addToMap(optionsMap, _Param.logoPosition, logoPosition);
    addToMap(optionsMap, _Param.logoPadding, <double>[
      logoPadding!.top,
      logoPadding!.left,
      logoPadding!.bottom,
      logoPadding!.right,
    ]);
    addToMap(optionsMap, _Param.styleId, styleId);
    addToMap(optionsMap, _Param.previewId, previewId);
    addToMap(optionsMap, _Param.liteMode, liteMode);
    addToMap(
        optionsMap,
        _Param.myLocationStyle,
        myLocationStyle != null
            ? myLocationStyleToJson(myLocationStyle!)
            : null);

    return optionsMap;
  }

  Map<String, dynamic> updatesMap(HuaweiMapOptions mapOptions) {
    final Map<String, dynamic> old = toMap();

    return mapOptions.toMap()
      ..removeWhere((String key, dynamic value) => old[key] == value);
  }
}
