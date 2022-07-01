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

import 'dart:convert';
import 'dart:ui';

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/utils/utils.dart';

dynamic pointsToJson(List<LatLng> points) {
  final List<dynamic> result = <dynamic>[];
  for (final LatLng point in points) {
    result.add(latLngToJson(point));
  }
  return result;
}

dynamic holesToJson(List<List<LatLng>> holes) {
  final List<dynamic> result = <dynamic>[];
  for (final List hole in holes) {
    result.add(pointsToJson(hole as List<LatLng>));
  }
  return result;
}

dynamic patternToJson(List<PatternItem> patterns) {
  final List<dynamic> result = <dynamic>[];
  for (final PatternItem patternItem in patterns) {
    result.add(patternItem.toJson());
  }
  return result;
}

Map<String, dynamic> markerToJson(Marker marker) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.markerId, marker.markerId.id);
  addToJson(json, Param.alpha, marker.alpha);
  addToJson(json, Param.anchor, offsetToJson(marker.anchor));
  addToJson(json, Param.clickable, marker.clickable);
  addToJson(json, Param.draggable, marker.draggable);
  addToJson(json, Param.flat, marker.flat);
  addToJson(json, Param.icon, marker.icon.toJson());
  addToJson(json, Param.infoWindow, infoWindowtoJson(marker.infoWindow));
  addToJson(json, Param.position, latLngToJson(marker.position));
  addToJson(json, Param.rotation, marker.rotation);
  addToJson(json, Param.visible, marker.visible);
  addToJson(json, Param.zIndex, marker.zIndex);
  addToJson(json, Param.clusterable, marker.clusterable);
  addToJson(json, Param.animation, animationSetToJson(marker.animationSet));

  return json;
}

String animationSetToJson(List<dynamic> animationSet) {
  return json.encode(List<dynamic>.from(animationSet.map((e) {
    switch (e.type) {
      case HmsMarkerAnimation.ALPHA:
        return alphaAnimationToJson(e);
      case HmsMarkerAnimation.ROTATE:
        return rotateAnimationToJson(e);
      case HmsMarkerAnimation.SCALE:
        return scaleAnimationToJson(e);
      case HmsMarkerAnimation.TRANSLATE:
        return translateAnimationToJson(e);
    }
  })));
}

Map<String, dynamic> animationBaseToJson(
    final Map<String, dynamic> json, HmsMarkerAnimation animation) {
  addToJson(json, Param.animationId, animation.animationId);
  addToJson(json, Param.animationType, animation.type);
  addToJson(json, Param.duration, animation.duration);
  addToJson(json, Param.fillMode, animation.fillMode);
  addToJson(json, Param.repeatCount, animation.repeatCount);
  addToJson(json, Param.repeatMode, animation.repeatMode);
  addToJson(json, Param.interpolator, animation.interpolator);

  return json;
}

Map<String, dynamic> alphaAnimationToJson(HmsMarkerAlphaAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, Param.fromAlpha, animation.fromAlpha);
  addToJson(json, Param.toAlpha, animation.toAlpha);

  return json;
}

Map<String, dynamic> rotateAnimationToJson(HmsMarkerRotateAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, Param.fromDegree, animation.fromDegree);
  addToJson(json, Param.toDegree, animation.toDegree);

  return json;
}

Map<String, dynamic> scaleAnimationToJson(HmsMarkerScaleAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, Param.fromX, animation.fromX);
  addToJson(json, Param.toX, animation.toX);
  addToJson(json, Param.fromY, animation.fromY);
  addToJson(json, Param.toY, animation.toY);

  return json;
}

Map<String, dynamic> translateAnimationToJson(
    HmsMarkerTranslateAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, Param.lat_lng, latLngToJson(animation.target));

  return json;
}

dynamic polygonToJson(Polygon polygon) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.polygonId, polygon.polygonId.id);
  addToJson(json, Param.clickable, polygon.clickable);
  addToJson(json, Param.fillColor, polygon.fillColor.value);
  addToJson(json, Param.geodesic, polygon.geodesic);
  addToJson(json, Param.strokeColor, polygon.strokeColor.value);
  addToJson(json, Param.strokeWidth, polygon.strokeWidth);
  addToJson(json, Param.visible, polygon.visible);
  addToJson(json, Param.zIndex, polygon.zIndex);
  addToJson(json, Param.strokeJointType, polygon.strokeJointType.type);
  addToJson(json, Param.points, pointsToJson(polygon.points));
  addToJson(json, Param.holes, holesToJson(polygon.holes));
  addToJson(json, Param.strokePattern, patternToJson(polygon.strokePattern));

  return json;
}

dynamic polylineToJson(Polyline polyline) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.polylineId, polyline.polylineId.id);
  addToJson(json, Param.clickable, polyline.clickable);
  addToJson(json, Param.color, polyline.color.value);
  addToJson(json, Param.endCap, polyline.endCap.toJson());
  addToJson(json, Param.geodesic, polyline.geodesic);
  addToJson(json, Param.jointType, polyline.jointType.type);
  addToJson(json, Param.startCap, polyline.startCap.toJson());
  addToJson(json, Param.visible, polyline.visible);
  addToJson(json, Param.width, polyline.width);
  addToJson(json, Param.zIndex, polyline.zIndex);
  addToJson(json, Param.points, pointsToJson(polyline.points));
  addToJson(json, Param.pattern, patternToJson(polyline.patterns));

  return json;
}

dynamic offsetToJson(Offset offset) {
  return <dynamic>[offset.dx, offset.dy];
}

dynamic infoWindowtoJson(InfoWindow infoWindow) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.title, infoWindow.title);
  addToJson(json, Param.snippet, infoWindow.snippet);
  addToJson(json, Param.anchor, offsetToJson(infoWindow.anchor));

  return json;
}

dynamic circleToJson(Circle circle) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.circleId, circle.circleId.id);
  addToJson(json, Param.clickable, circle.clickable);
  addToJson(json, Param.fillColor, circle.fillColor.value);
  addToJson(json, Param.center, latLngToJson(circle.center));
  addToJson(json, Param.radius, circle.radius);
  addToJson(json, Param.strokeColor, circle.strokeColor.value);
  addToJson(json, Param.strokeWidth, circle.strokeWidth);
  addToJson(json, Param.visible, circle.visible);
  addToJson(json, Param.zIndex, circle.zIndex);
  addToJson(json, Param.strokePattern, patternToJson(circle.strokePattern));

  return json;
}

Map<String, dynamic> groundOverlayToJson(GroundOverlay groundOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.groundOverlayId, groundOverlay.groundOverlayId.id);
  addToJson(json, Param.bearing, groundOverlay.bearing);
  addToJson(json, Param.clickable, groundOverlay.clickable);
  addToJson(json, Param.width, groundOverlay.width);
  addToJson(json, Param.height, groundOverlay.height);
  addToJson(
      json, Param.imageDescriptor, groundOverlay.imageDescriptor.toJson());
  addToJson(
      json,
      Param.position,
      groundOverlay.position != null
          ? latLngToJson(groundOverlay.position!)
          : null);
  addToJson(
      json,
      Param.bounds,
      groundOverlay.bounds != null
          ? latLngBoundsToJson(groundOverlay.bounds!)
          : null);
  addToJson(json, Param.transparency, groundOverlay.transparency);
  addToJson(json, Param.visible, groundOverlay.visible);
  addToJson(json, Param.zIndex, groundOverlay.zIndex);
  addToJson(json, Param.anchor, offsetToJson(groundOverlay.anchor));

  return json;
}

Map<String, dynamic> tileOverlayToJson(TileOverlay tileOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, Param.tileOverlayId, tileOverlay.tileOverlayId.id);
  addToJson(
      json, Param.tileProvider, tileProviderToJson(tileOverlay.tileProvider));
  addToJson(json, Param.fadeIn, tileOverlay.fadeIn);
  addToJson(json, Param.transparency, tileOverlay.transparency);
  addToJson(json, Param.visible, tileOverlay.visible);
  addToJson(json, Param.zIndex, tileOverlay.zIndex);

  return json;
}

Map<String, dynamic> heatMapToJson(HeatMap heatMap) {
  final Map<String, dynamic> json = <String, dynamic>{};

  final Map<double, String> colorMap = {};

  heatMap.color
      ?.forEach((key, value) => colorMap[key] = value.value.toString());

  addToJson(json, Param.heatMapId, heatMap.heatMapId.id);
  addToJson(json, Param.color, colorMap);
  addToJson(json, Param.resourceId, heatMap.resourceId);
  addToJson(json, Param.jsonData, heatMap.dataSet);
  addToJson(json, Param.intensity, heatMap.intensity);
  addToJson(json, Param.intensityMap, heatMap.intensityMap);
  addToJson(json, Param.opacity, heatMap.opacity);
  addToJson(json, Param.opacityMap, heatMap.opacityMap);
  addToJson(json, Param.radius, heatMap.radius);
  addToJson(json, Param.radiusMap, heatMap.radiusMap);
  addToJson(
      json, Param.radiusUnit, heatMap.radiusUnit == RadiusUnit.pixel ? 0 : 1);
  addToJson(json, Param.visible, heatMap.visible);

  return json;
}

Map<String, dynamic> polylineUpdatesToJson(PolylineUpdates polylineUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(updateMap, Param.polylinesToInsert,
      polylineToList(polylineUpdates.insertSet));
  addToMap(updateMap, Param.polylinesToUpdate,
      polylineToList(polylineUpdates.updateSet));
  addToMap(updateMap, Param.polylinesToDelete,
      polylineUpdates.deleteSet.map<dynamic>((PolylineId m) => m.id).toList());

  return updateMap;
}

dynamic latLngBoundsToJson(LatLngBounds latLngBounds) {
  return <dynamic>[
    latLngToJson(latLngBounds.southwest),
    latLngToJson(latLngBounds.northeast)
  ];
}

dynamic tileProviderToJson(dynamic tileProviders) {
  if (tileProviders is List<Tile>) {
    final List<dynamic> result = <dynamic>[];
    for (final Tile tileProvider in tileProviders) {
      result.add(tileProvider.toJson());
    }
    return result;
  } else if (tileProviders is RepetitiveTile || tileProviders is UrlTile) {
    return tileProviders.toJson();
  } else {
    throw ArgumentError(
        "Please provide a tile provider type (RepetitiveTile, UrlTile or List<Tile>).");
  }
}

dynamic latLngStartEndToJson(LatLng start, LatLng end) {
  return <dynamic>[latLngToJson(start), latLngToJson(end)];
}

dynamic latLngToJson(LatLng latLng) {
  return <double>[latLng.lat, latLng.lng];
}

dynamic cameraTargetBoundsToJson(CameraTargetBounds cameraTargetBounds) {
  if (cameraTargetBounds.bounds == null) return;
  return <dynamic>[latLngBoundsToJson(cameraTargetBounds.bounds!)];
}

dynamic screenCoordinateToJson(ScreenCoordinate screenCoordinate) {
  return <String, int>{
    Param.x: screenCoordinate.x,
    Param.y: screenCoordinate.y,
  };
}

Map<String, dynamic> polygonUpdatesToJson(PolygonUpdates polygonUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(updateMap, Param.polygonsToInsert,
      polygonToList(polygonUpdates.insertSet));
  addToMap(updateMap, Param.polygonsToUpdate,
      polygonToList(polygonUpdates.updateSet));
  addToMap(updateMap, Param.polygonsToDelete,
      polygonUpdates.deleteSet.map<dynamic>((PolygonId m) => m.id).toList());

  return updateMap;
}

Map<String, dynamic> markerUpdatesToJson(MarkerUpdates markerUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
      updateMap, Param.markersToInsert, markerToList(markerUpdates.insertSet));
  addToMap(
      updateMap, Param.markersToUpdate, markerToList(markerUpdates.updateSet));
  addToMap(updateMap, Param.markersToDelete,
      markerUpdates.deleteSet.map<dynamic>((MarkerId m) => m.id).toList());

  return updateMap;
}

dynamic minMaxZoomPreferenceToJson(MinMaxZoomPreference minMaxZoomPreference) =>
    <dynamic>[minMaxZoomPreference.minZoom, minMaxZoomPreference.maxZoom];

Map<String, dynamic> circleUpdatesToJson(CircleUpdates circleUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
      updateMap, Param.circlesToInsert, circleToList(circleUpdates.insertSet));
  addToMap(
      updateMap, Param.circlesToUpdate, circleToList(circleUpdates.updateSet));
  addToMap(updateMap, Param.circlesToDelete,
      circleUpdates.deleteSet.map<dynamic>((CircleId m) => m.id).toList());

  return updateMap;
}

Map<String, dynamic> groundOverlayUpdatesToJson(
    GroundOverlayUpdates groundOverlayUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(updateMap, Param.groundOverlaysToInsert,
      groundOverlayToList(groundOverlayUpdates.insertSet));
  addToMap(updateMap, Param.groundOverlaysToUpdate,
      groundOverlayToList(groundOverlayUpdates.updateSet));
  addToMap(
      updateMap,
      Param.groundOverlaysToDelete,
      groundOverlayUpdates.deleteSet
          .map<dynamic>((GroundOverlayId g) => g.id)
          .toList());

  return updateMap;
}

Map<String, dynamic> tileOverlayUpdatesToJson(
    TileOverlayUpdates tileOverlayUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(updateMap, Param.tileOverlaysToInsert,
      tileOverlayToList(tileOverlayUpdates.insertSet));
  addToMap(updateMap, Param.tileOverlaysToUpdate,
      tileOverlayToList(tileOverlayUpdates.updateSet));
  addToMap(
      updateMap,
      Param.tileOverlaysToDelete,
      tileOverlayUpdates.deleteSet
          .map<dynamic>((TileOverlayId t) => t.id)
          .toList());

  return updateMap;
}

Map<String, dynamic> heatMapUpdatesToJson(HeatMapUpdates heatMapUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(updateMap, Param.heatMapsToInsert,
      heatMapToList(heatMapUpdates.insertSet));
  addToMap(updateMap, Param.heatMapsToUpdate,
      heatMapToList(heatMapUpdates.updateSet));
  addToMap(updateMap, Param.heatMapsToDelete,
      heatMapUpdates.deleteSet.map<dynamic>((HeatMapId h) => h.id).toList());

  return updateMap;
}
