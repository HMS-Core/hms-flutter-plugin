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

import 'package:flutter/material.dart';

import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/map.dart';
import 'package:huawei_map/utils/toJson.dart';
import 'package:huawei_map/utils/utils.dart';

class HuaweiMapOptions {
  final MapType mapType;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool trackCameraPosition;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final EdgeInsets padding;
  final bool trafficEnabled;
  final bool markersClusteringEnabled;
  final bool buildingsEnabled;

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
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    addToMap(optionsMap, Param.compassEnabled, compassEnabled);
    addToMap(optionsMap, Param.mapToolbarEnabled, mapToolbarEnabled);
    addToMap(
        optionsMap,
        Param.cameraTargetBounds,
        cameraTargetBounds != null
            ? cameraTargetBoundsToJson(cameraTargetBounds)
            : null);
    addToMap(optionsMap, Param.mapType, mapType?.index);
    addToMap(
        optionsMap,
        Param.minMaxZoomPreference,
        minMaxZoomPreference != null
            ? minMaxZoomPreferenceToJson(minMaxZoomPreference)
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
      padding?.top,
      padding?.left,
      padding?.bottom,
      padding?.right,
    ]);
    addToMap(optionsMap, Param.trafficEnabled, trafficEnabled);
    addToMap(
        optionsMap, Param.markersClusteringEnabled, markersClusteringEnabled);
    addToMap(optionsMap, Param.buildingsEnabled, buildingsEnabled);
    return optionsMap;
  }

  Map<String, dynamic> updatesMap(HuaweiMapOptions _new) {
    final Map<String, dynamic> _old = toMap();

    return _new.toMap()
      ..removeWhere((String key, dynamic value) => _old[key] == value);
  }
}
