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

import 'package:flutter/material.dart';

import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/map.dart';
import 'package:huawei_map/utils/toJson.dart';
import 'package:huawei_map/utils/utils.dart';

class HuaweiMapOptions {
  final MapType? mapType;
  final bool? compassEnabled;
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

  HuaweiMapOptions({
    this.mapType,
    this.compassEnabled,
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
  });

  static HuaweiMapOptions fromWidget(HuaweiMap map) {
    return HuaweiMapOptions(
      mapType: map.mapType,
      compassEnabled: map.compassEnabled,
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
        throw ("Invalid Map Type");
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    addToMap(optionsMap, Param.compassEnabled, compassEnabled);
    addToMap(optionsMap, Param.mapToolbarEnabled, mapToolbarEnabled);
    addToMap(
        optionsMap,
        Param.cameraTargetBounds,
        cameraTargetBounds != null
            ? cameraTargetBoundsToJson(cameraTargetBounds!)
            : null);
    addToMap(optionsMap, Param.mapType, _mapTypeToInt(mapType!));
    addToMap(
        optionsMap,
        Param.minMaxZoomPreference,
        minMaxZoomPreference != null
            ? minMaxZoomPreferenceToJson(minMaxZoomPreference!)
            : null);
    addToMap(optionsMap, Param.rotateGesturesEnabled, rotateGesturesEnabled);
    addToMap(optionsMap, Param.scrollGesturesEnabled, scrollGesturesEnabled);
    addToMap(optionsMap, Param.tiltGesturesEnabled, tiltGesturesEnabled);
    addToMap(optionsMap, Param.zoomControlsEnabled, zoomControlsEnabled);
    addToMap(optionsMap, Param.zoomGesturesEnabled, zoomGesturesEnabled);
    addToMap(optionsMap, Param.trackCameraPosition, trackCameraPosition);
    addToMap(optionsMap, Param.myLocationEnabled, myLocationEnabled);
    addToMap(
        optionsMap, Param.myLocationButtonEnabled, myLocationButtonEnabled);
    addToMap(optionsMap, Param.padding, <double>[
      padding!.top,
      padding!.left,
      padding!.bottom,
      padding!.right,
    ]);
    addToMap(optionsMap, Param.trafficEnabled, trafficEnabled);
    addToMap(
        optionsMap, Param.markersClusteringEnabled, markersClusteringEnabled);
    addToMap(optionsMap, Param.buildingsEnabled, buildingsEnabled);
    addToMap(optionsMap, Param.allGesturesEnabled, allGesturesEnabled);
    addToMap(optionsMap, Param.isScrollGesturesEnabledDuringRotateOrZoom,
        isScrollGesturesEnabledDuringRotateOrZoom);
    addToMap(
        optionsMap, Param.gestureScaleByMapCenter, gestureScaleByMapCenter);
    addToMap(optionsMap, Param.pointToCenter,
        pointToCenter == null ? null : screenCoordinateToJson(pointToCenter!));
    addToMap(optionsMap, Param.clusterMarkerColor, clusterMarkerColor?.value);
    addToMap(optionsMap, Param.clusterMarkerTextColor,
        clusterMarkerTextColor?.value);
    addToMap(
        optionsMap, Param.clusterMarkerIcon, clusterIconDescriptor?.toJson());
    addToMap(optionsMap, Param.logoPosition, logoPosition);
    addToMap(optionsMap, Param.logoPadding, <double>[
      logoPadding!.top,
      logoPadding!.left,
      logoPadding!.bottom,
      logoPadding!.right,
    ]);
    addToMap(optionsMap, Param.styleId, styleId);
    addToMap(optionsMap, Param.previewId, previewId);
    addToMap(optionsMap, Param.liteMode, liteMode);

    return optionsMap;
  }

  Map<String, dynamic> updatesMap(HuaweiMapOptions _new) {
    final Map<String, dynamic> _old = toMap();

    return _new.toMap()
      ..removeWhere((String key, dynamic value) => _old[key] == value);
  }
}
