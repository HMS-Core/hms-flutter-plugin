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

List<dynamic> pointsToJson(List<LatLng> points) {
  final List<dynamic> result = <dynamic>[];
  for (final LatLng point in points) {
    result.add(latLngToJson(point));
  }
  return result;
}

List<dynamic> holesToJson(List<List<LatLng>> holes) {
  final List<dynamic> result = <dynamic>[];
  for (final List<LatLng> hole in holes) {
    result.add(pointsToJson(hole));
  }
  return result;
}

List<dynamic> patternToJson(List<PatternItem> patterns) {
  final List<dynamic> result = <dynamic>[];
  for (final PatternItem patternItem in patterns) {
    result.add(patternItem.toJson());
  }
  return result;
}

Map<String, dynamic> markerToJson(Marker marker) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.markerId, marker.markerId.id);
  addToJson(json, _Param.alpha, marker.alpha);
  addToJson(json, _Param.anchor, offsetToJson(marker.anchor));
  addToJson(json, _Param.clickable, marker.clickable);
  addToJson(json, _Param.draggable, marker.draggable);
  addToJson(json, _Param.flat, marker.flat);
  addToJson(json, _Param.icon, marker.icon.toJson());
  addToJson(json, _Param.infoWindow, infoWindowtoJson(marker.infoWindow));
  addToJson(json, _Param.position, latLngToJson(marker.position));
  addToJson(json, _Param.rotation, marker.rotation);
  addToJson(json, _Param.visible, marker.visible);
  addToJson(json, _Param.zIndex, marker.zIndex);
  addToJson(json, _Param.clusterable, marker.clusterable);
  addToJson(json, _Param.animation, animationSetToJson(marker.animationSet));

  return json;
}

String animationSetToJson(List<dynamic> animationSet) {
  return json.encode(
    List<dynamic>.from(
      animationSet.map((dynamic e) {
        switch (e.type) {
          case HmsAnimation.ALPHA:
            return alphaAnimationToJson(e);
          case HmsAnimation.ROTATE:
            return rotateAnimationToJson(e);
          case HmsAnimation.SCALE:
            return scaleAnimationToJson(e);
          case HmsAnimation.TRANSLATE:
            return translateAnimationToJson(e);
        }
      }),
    ),
  );
}

String animationToJson(HmsAnimation animation) {
  switch (animation.type) {
    case HmsAnimation.ALPHA:
      return json.encode(
        alphaAnimationToJson(animation as HmsAlphaAnimation),
      );
    case HmsAnimation.ROTATE:
      return json.encode(
        rotateAnimationToJson(animation as HmsRotateAnimation),
      );
    case HmsAnimation.SCALE:
      return json.encode(
        scaleAnimationToJson(animation as HmsScaleAnimation),
      );
    case HmsAnimation.TRANSLATE:
      return json.encode(
        translateAnimationToJson(animation as HmsTranslateAnimation),
      );
  }
  throw ArgumentError(
    'Please provide a valid animation type.',
  );
}

Map<String, dynamic> animationBaseToJson(
  final Map<String, dynamic> json,
  HmsAnimation animation,
) {
  addToJson(json, _Param.animationId, animation.animationId);
  addToJson(json, _Param.animationType, animation.type);
  addToJson(json, _Param.duration, animation.duration);
  addToJson(json, _Param.fillMode, animation.fillMode);
  addToJson(json, _Param.repeatCount, animation.repeatCount);
  addToJson(json, _Param.repeatMode, animation.repeatMode);
  addToJson(json, _Param.interpolator, animation.interpolator);

  return json;
}

Map<String, dynamic> alphaAnimationToJson(HmsAlphaAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, _Param.fromAlpha, animation.fromAlpha);
  addToJson(json, _Param.toAlpha, animation.toAlpha);

  return json;
}

Map<String, dynamic> rotateAnimationToJson(HmsRotateAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, _Param.fromDegree, animation.fromDegree);
  addToJson(json, _Param.toDegree, animation.toDegree);

  return json;
}

Map<String, dynamic> scaleAnimationToJson(HmsScaleAnimation animation) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, _Param.fromX, animation.fromX);
  addToJson(json, _Param.toX, animation.toX);
  addToJson(json, _Param.fromY, animation.fromY);
  addToJson(json, _Param.toY, animation.toY);

  return json;
}

Map<String, dynamic> translateAnimationToJson(
  HmsTranslateAnimation animation,
) {
  Map<String, dynamic> json = <String, dynamic>{};

  json = animationBaseToJson(json, animation);
  addToJson(json, _Param.latLng, latLngToJson(animation.target));

  return json;
}

dynamic polygonToJson(Polygon polygon) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.polygonId, polygon.polygonId.id);
  addToJson(json, _Param.clickable, polygon.clickable);
  addToJson(json, _Param.fillColor, polygon.fillColor.value);
  addToJson(json, _Param.geodesic, polygon.geodesic);
  addToJson(json, _Param.strokeColor, polygon.strokeColor.value);
  addToJson(json, _Param.strokeWidth, polygon.strokeWidth);
  addToJson(json, _Param.visible, polygon.visible);
  addToJson(json, _Param.zIndex, polygon.zIndex);
  addToJson(json, _Param.strokeJointType, polygon.strokeJointType.type);
  addToJson(json, _Param.points, pointsToJson(polygon.points));
  addToJson(json, _Param.holes, holesToJson(polygon.holes));
  addToJson(json, _Param.strokePattern, patternToJson(polygon.strokePattern));

  return json;
}

List<int> colorValuesToJson(List<Color> colorValues) {
  List<int> intColorValues = <int>[];

  colorValues.forEach((element) {
    intColorValues.add(element.value);
  });

  return intColorValues;
}

dynamic polylineToJson(Polyline polyline) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.polylineId, polyline.polylineId.id);
  addToJson(json, _Param.clickable, polyline.clickable);
  addToJson(json, _Param.color, polyline.color.value);
  addToJson(json, _Param.endCap, polyline.endCap.toJson());
  addToJson(json, _Param.geodesic, polyline.geodesic);
  addToJson(json, _Param.jointType, polyline.jointType.type);
  addToJson(json, _Param.startCap, polyline.startCap.toJson());
  addToJson(json, _Param.visible, polyline.visible);
  addToJson(json, _Param.width, polyline.width);
  addToJson(json, _Param.zIndex, polyline.zIndex);
  addToJson(json, _Param.points, pointsToJson(polyline.points));
  addToJson(json, _Param.pattern, patternToJson(polyline.patterns));
  addToJson(json, _Param.gradient, polyline.gradient);
  addToJson(json, _Param.colorValues, colorValuesToJson(polyline.colorValues));

  return json;
}

List<double> offsetToJson(Offset offset) {
  return <double>[offset.dx, offset.dy];
}

Map<String, dynamic> infoWindowtoJson(InfoWindow infoWindow) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.title, infoWindow.title);
  addToJson(json, _Param.snippet, infoWindow.snippet);
  addToJson(json, _Param.anchor, offsetToJson(infoWindow.anchor));

  return json;
}

Map<String, dynamic> circleToJson(Circle circle) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.circleId, circle.circleId.id);
  addToJson(json, _Param.clickable, circle.clickable);
  addToJson(json, _Param.fillColor, circle.fillColor.value);
  addToJson(json, _Param.center, latLngToJson(circle.center));
  addToJson(json, _Param.radius, circle.radius);
  addToJson(json, _Param.strokeColor, circle.strokeColor.value);
  addToJson(json, _Param.strokeWidth, circle.strokeWidth);
  addToJson(json, _Param.visible, circle.visible);
  addToJson(json, _Param.zIndex, circle.zIndex);
  addToJson(json, _Param.strokePattern, patternToJson(circle.strokePattern));
  addToJson(
    json,
    _Param.animation,
    circle.animation != null ? animationToJson(circle.animation!) : null,
  );

  return json;
}

Map<String, dynamic> groundOverlayToJson(GroundOverlay groundOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.groundOverlayId, groundOverlay.groundOverlayId.id);
  addToJson(json, _Param.bearing, groundOverlay.bearing);
  addToJson(json, _Param.clickable, groundOverlay.clickable);
  addToJson(json, _Param.width, groundOverlay.width);
  addToJson(json, _Param.height, groundOverlay.height);
  addToJson(
    json,
    _Param.imageDescriptor,
    groundOverlay.imageDescriptor.toJson(),
  );
  addToJson(
    json,
    _Param.position,
    groundOverlay.position != null
        ? latLngToJson(groundOverlay.position!)
        : null,
  );
  addToJson(
    json,
    _Param.bounds,
    groundOverlay.bounds != null
        ? latLngBoundsToJson(groundOverlay.bounds!)
        : null,
  );
  addToJson(json, _Param.transparency, groundOverlay.transparency);
  addToJson(json, _Param.visible, groundOverlay.visible);
  addToJson(json, _Param.zIndex, groundOverlay.zIndex);
  addToJson(json, _Param.anchor, offsetToJson(groundOverlay.anchor));

  return json;
}

Map<String, dynamic> tileOverlayToJson(TileOverlay tileOverlay) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.tileOverlayId, tileOverlay.tileOverlayId.id);
  addToJson(
    json,
    _Param.tileProvider,
    tileProviderToJson(tileOverlay.tileProvider),
  );
  addToJson(json, _Param.fadeIn, tileOverlay.fadeIn);
  addToJson(json, _Param.transparency, tileOverlay.transparency);
  addToJson(json, _Param.visible, tileOverlay.visible);
  addToJson(json, _Param.zIndex, tileOverlay.zIndex);

  return json;
}

Map<String, dynamic> heatMapToJson(HeatMap heatMap) {
  final Map<String, dynamic> json = <String, dynamic>{};

  final Map<double, String> colorMap = <double, String>{};
  heatMap.color?.forEach((double key, Color value) {
    colorMap[key] = value.value.toString();
  });

  addToJson(json, _Param.heatMapId, heatMap.heatMapId.id);
  addToJson(json, _Param.color, colorMap);
  addToJson(json, _Param.resourceId, heatMap.resourceId);
  addToJson(json, _Param.jsonData, heatMap.dataSet);
  addToJson(json, _Param.intensity, heatMap.intensity);
  addToJson(json, _Param.intensityMap, heatMap.intensityMap);
  addToJson(json, _Param.opacity, heatMap.opacity);
  addToJson(json, _Param.opacityMap, heatMap.opacityMap);
  addToJson(json, _Param.radius, heatMap.radius);
  addToJson(json, _Param.radiusMap, heatMap.radiusMap);
  addToJson(
    json,
    _Param.radiusUnit,
    heatMap.radiusUnit == RadiusUnit.pixel ? 0 : 1,
  );
  addToJson(json, _Param.visible, heatMap.visible);

  return json;
}

Map<String, dynamic> polylineUpdatesToJson(PolylineUpdates polylineUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.polylinesToInsert,
    polylineToList(polylineUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.polylinesToUpdate,
    polylineToList(polylineUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.polylinesToDelete,
    polylineUpdates.deleteSet.map<dynamic>((PolylineId m) => m.id).toList(),
  );

  return updateMap;
}

List<List<double>> latLngBoundsToJson(LatLngBounds latLngBounds) {
  return <List<double>>[
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
      'Please provide a tile provider type (RepetitiveTile, UrlTile or List<Tile>).',
    );
  }
}

List<List<double>> latLngStartEndToJson(LatLng start, LatLng end) {
  return <List<double>>[
    latLngToJson(start),
    latLngToJson(end),
  ];
}

List<double> latLngToJson(LatLng latLng) {
  return <double>[latLng.lat, latLng.lng];
}

List<List<List<double>>>? cameraTargetBoundsToJson(
  CameraTargetBounds cameraTargetBounds,
) {
  if (cameraTargetBounds.bounds == null) {
    return null;
  }
  return <List<List<double>>>[latLngBoundsToJson(cameraTargetBounds.bounds!)];
}

Map<String, int> screenCoordinateToJson(ScreenCoordinate screenCoordinate) {
  return <String, int>{
    _Param.x: screenCoordinate.x,
    _Param.y: screenCoordinate.y,
  };
}

Map<String, dynamic> myLocationStyleToJson(MyLocationStyle myLocationStle) {
  final Map<String, dynamic> json = <String, dynamic>{};

  addToJson(json, _Param.anchor, offsetToJson(myLocationStle.anchor));
  addToJson(json, _Param.radiusFillColor, myLocationStle.radiusFillColor.value);
  addToJson(json, _Param.icon,
      myLocationStle.icon != null ? myLocationStle.icon!.toJson() : null);

  return json;
}

Map<String, dynamic> polygonUpdatesToJson(PolygonUpdates polygonUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.polygonsToInsert,
    polygonToList(polygonUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.polygonsToUpdate,
    polygonToList(polygonUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.polygonsToDelete,
    polygonUpdates.deleteSet.map<dynamic>((PolygonId m) => m.id).toList(),
  );

  return updateMap;
}

Map<String, dynamic> markerUpdatesToJson(MarkerUpdates markerUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.markersToInsert,
    markerToList(markerUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.markersToUpdate,
    markerToList(markerUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.markersToDelete,
    markerUpdates.deleteSet.map<dynamic>((MarkerId m) => m.id).toList(),
  );

  return updateMap;
}

List<double> minMaxZoomPreferenceToJson(
  MinMaxZoomPreference minMaxZoomPreference,
) {
  return <double>[
    minMaxZoomPreference.minZoom,
    minMaxZoomPreference.maxZoom,
  ];
}

Map<String, dynamic> circleUpdatesToJson(CircleUpdates circleUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.circlesToInsert,
    circleToList(circleUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.circlesToUpdate,
    circleToList(circleUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.circlesToDelete,
    circleUpdates.deleteSet.map<dynamic>((CircleId m) => m.id).toList(),
  );

  return updateMap;
}

Map<String, dynamic> groundOverlayUpdatesToJson(
  GroundOverlayUpdates groundOverlayUpdates,
) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.groundOverlaysToInsert,
    groundOverlayToList(groundOverlayUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.groundOverlaysToUpdate,
    groundOverlayToList(groundOverlayUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.groundOverlaysToDelete,
    groundOverlayUpdates.deleteSet
        .map<dynamic>((GroundOverlayId g) => g.id)
        .toList(),
  );

  return updateMap;
}

Map<String, dynamic> tileOverlayUpdatesToJson(
  TileOverlayUpdates tileOverlayUpdates,
) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.tileOverlaysToInsert,
    tileOverlayToList(tileOverlayUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.tileOverlaysToUpdate,
    tileOverlayToList(tileOverlayUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.tileOverlaysToDelete,
    tileOverlayUpdates.deleteSet
        .map<dynamic>((TileOverlayId t) => t.id)
        .toList(),
  );

  return updateMap;
}

Map<String, dynamic> heatMapUpdatesToJson(HeatMapUpdates heatMapUpdates) {
  final Map<String, dynamic> updateMap = <String, dynamic>{};

  addToMap(
    updateMap,
    _Param.heatMapsToInsert,
    heatMapToList(heatMapUpdates.insertSet),
  );
  addToMap(
    updateMap,
    _Param.heatMapsToUpdate,
    heatMapToList(heatMapUpdates.updateSet),
  );
  addToMap(
    updateMap,
    _Param.heatMapsToDelete,
    heatMapUpdates.deleteSet.map<dynamic>((HeatMapId h) => h.id).toList(),
  );

  return updateMap;
}
