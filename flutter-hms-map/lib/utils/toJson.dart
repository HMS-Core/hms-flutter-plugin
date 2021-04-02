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

import 'dart:convert';
import 'dart:ui';

import 'package:huawei_map/components/animations/animation.dart';
import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/components/tileProviders/repetitiveTile.dart';
import 'package:huawei_map/components/tileProviders/urlTile.dart';
import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/utils/utils.dart';

Map<String, dynamic> addJson(Map json, String fieldName, dynamic value) {
  if (value != null) {
    json[fieldName] = value;
  }
  return json;
}

dynamic pointsToJson(List<LatLng> points) {
  final List<dynamic> result = <dynamic>[];
  for (final LatLng point in points) {
    result.add(latLngToJson(point));
  }
  return result;
}

dynamic patternToJson(List<PatternItem> patterns) {
  final List<dynamic> result = <dynamic>[];
  for (final PatternItem patternItem in patterns) {
    if (patternItem != null) {
      result.add(patternItem.toJson());
    }
  }
  return result;
}

Map<String, dynamic> markerToJson(Marker marker) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.markerId, marker.markerId.id);
  addJson(json, Param.alpha, marker.alpha);
  addJson(json, Param.anchor,
      marker.anchor != null ? offsetToJson(marker.anchor) : null);
  addJson(json, Param.clickable, marker.clickable);
  addJson(json, Param.draggable, marker.draggable);
  addJson(json, Param.flat, marker.flat);
  addJson(json, Param.icon, marker.icon?.toJson());
  addJson(json, Param.infoWindow,
      marker.infoWindow != null ? infoWindowtoJson(marker.infoWindow) : null);
  addJson(json, Param.position,
      marker.position != null ? latLngToJson(marker.position) : null);
  addJson(json, Param.rotation, marker.rotation);
  addJson(json, Param.visible, marker.visible);
  addJson(json, Param.zIndex, marker.zIndex);
  addJson(json, Param.clusterable, marker.clusterable);
  addJson(json, Param.animation, animationSetToJson(marker.animationSet));
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
  addJson(json, Param.animationId, animation.animationId);
  addJson(json, Param.animationType, animation.type);
  addJson(json, Param.duration, animation.duration);
  addJson(json, Param.fillMode, animation.fillMode);
  addJson(json, Param.repeatCount, animation.repeatCount);
  addJson(json, Param.repeatMode, animation.repeatMode);
  addJson(json, Param.interpolator, animation.interpolator);

  return json;
}

Map<String, dynamic> alphaAnimationToJson(HmsMarkerAlphaAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addJson(json, Param.fromAlpha, animation.fromAlpha);
  addJson(json, Param.toAlpha, animation.toAlpha);

  return json;
}

Map<String, dynamic> rotateAnimationToJson(HmsMarkerRotateAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addJson(json, Param.fromDegree, animation.fromDegree);
  addJson(json, Param.toDegree, animation.toDegree);

  return json;
}

Map<String, dynamic> scaleAnimationToJson(HmsMarkerScaleAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addJson(json, Param.fromX, animation.fromX);
  addJson(json, Param.toX, animation.toX);
  addJson(json, Param.fromY, animation.fromY);
  addJson(json, Param.toY, animation.toY);

  return json;
}

Map<String, dynamic> translateAnimationToJson(
    HmsMarkerTranslateAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addJson(json, Param.lat_lng, latLngToJson(animation.target));

  return json;
}

dynamic polygonToJson(Polygon polygon) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.polygonId, polygon.polygonId.id);
  addJson(json, Param.clickable, polygon.clickable);
  addJson(json, Param.fillColor, polygon.fillColor.value);
  addJson(json, Param.geodesic, polygon.geodesic);
  addJson(json, Param.strokeColor, polygon.strokeColor.value);
  addJson(json, Param.strokeWidth, polygon.strokeWidth);
  addJson(json, Param.visible, polygon.visible);
  addJson(json, Param.zIndex, polygon.zIndex);

  if (polygon.points != null) {
    json[Param.points] = pointsToJson(polygon.points);
  }

  return json;
}

dynamic polylineToJson(Polyline polyline) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.polylineId, polyline.polylineId.id);
  addJson(json, Param.clickable, polyline.clickable);
  addJson(json, Param.color, polyline.color.value);
  addJson(json, Param.endCap, polyline.endCap?.toJson());
  addJson(json, Param.geodesic, polyline.geodesic);
  addJson(json, Param.jointType, polyline.jointType?.type);
  addJson(json, Param.startCap, polyline.startCap?.toJson());
  addJson(json, Param.visible, polyline.visible);
  addJson(json, Param.width, polyline.width);
  addJson(json, Param.zIndex, polyline.zIndex);

  if (polyline.points != null) {
    json[Param.points] = pointsToJson(polyline.points);
  }

  if (polyline.patterns != null) {
    json[Param.pattern] = patternToJson(polyline.patterns);
  }

  return json;
}

dynamic offsetToJson(Offset offset) {
  if (offset == null) {
    return null;
  }
  return <dynamic>[offset.dx, offset.dy];
}

dynamic infoWindowtoJson(InfoWindow infoWindow) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.title, infoWindow.title);
  addJson(json, Param.snippet, infoWindow.snippet);
  addJson(json, Param.anchor, offsetToJson(infoWindow.anchor));

  return json;
}

dynamic circleToJson(Circle circle) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.circleId, circle.circleId.id);
  addJson(json, Param.clickable, circle.clickable);
  addJson(json, Param.fillColor, circle.fillColor.value);
  addJson(json, Param.center, latLngToJson(circle.center));
  addJson(json, Param.radius, circle.radius);
  addJson(json, Param.strokeColor, circle.strokeColor.value);
  addJson(json, Param.strokeWidth, circle.strokeWidth);
  addJson(json, Param.visible, circle.visible);
  addJson(json, Param.zIndex, circle.zIndex);

  return json;
}

Map<String, dynamic> groundOverlayToJson(GroundOverlay groundOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.groundOverlayId, groundOverlay.groundOverlayId.id);
  addJson(json, Param.bearing, groundOverlay.bearing);
  addJson(json, Param.clickable, groundOverlay.clickable);
  addJson(json, Param.width, groundOverlay.width);
  addJson(json, Param.height, groundOverlay.height);
  addJson(json, Param.imageDescriptor, groundOverlay.imageDescriptor?.toJson());
  addJson(
      json,
      Param.position,
      groundOverlay.position != null
          ? latLngToJson(groundOverlay.position)
          : null);
  addJson(
      json,
      Param.bounds,
      groundOverlay.bounds != null
          ? latLngBoundsToJson(groundOverlay.bounds)
          : null);
  addJson(json, Param.transparency, groundOverlay.transparency);
  addJson(json, Param.visible, groundOverlay.visible);
  addJson(json, Param.zIndex, groundOverlay.zIndex);
  addJson(json, Param.anchor,
      groundOverlay.anchor != null ? offsetToJson(groundOverlay.anchor) : null);

  return json;
}

Map<String, dynamic> tileOverlayToJson(TileOverlay tileOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addJson(json, Param.tileOverlayId, tileOverlay.tileOverlayId.id);
  addJson(
      json, Param.tileProvider, tileProviderToJson(tileOverlay.tileProvider));
  addJson(json, Param.fadeIn, tileOverlay.fadeIn);
  addJson(json, Param.transparency, tileOverlay.transparency);
  addJson(json, Param.visible, tileOverlay.visible);
  addJson(json, Param.zIndex, tileOverlay.zIndex);

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
  if (latLngBounds == null) {
    return null;
  }
  return <dynamic>[
    latLngToJson(latLngBounds.southwest),
    latLngToJson(latLngBounds.northeast)
  ];
}

dynamic tileProviderToJson(dynamic tileProviders) {
  if (tileProviders is List<Tile>) {
    final List<dynamic> result = <dynamic>[];
    for (final Tile tileProvider in tileProviders) {
      if (tileProvider != null) {
        result.add(tileProvider.toJson());
      }
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
  if (start == null && end == null) {
    return null;
  }
  return <dynamic>[latLngToJson(start), latLngToJson(end)];
}

dynamic latLngToJson(LatLng latLng) {
  return <double>[latLng.lat, latLng.lng];
}

dynamic cameraTargetBoundsToJson(CameraTargetBounds cameraTargetBounds) {
  if (cameraTargetBounds == null) {
    return null;
  }
  return <dynamic>[latLngBoundsToJson(cameraTargetBounds.bounds)];
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
