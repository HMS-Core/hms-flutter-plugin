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

abstract class _Param {
  static const String options = 'options';

  static const String initialCameraPosition = 'initialCameraPosition';

  static const String cameraUpdate = 'cameraUpdate';

  static const String markersToInsert = 'markersToAdd';

  static const String markersToUpdate = 'markersToChange';

  static const String markersToDelete = 'markerIdsToRemove';

  static const String polylinesToInsert = 'polylinesToAdd';

  static const String polylinesToUpdate = 'polylinesToChange';

  static const String polylinesToDelete = 'polylineIdsToRemove';

  static const String polygonsToInsert = 'polygonsToAdd';

  static const String polygonsToUpdate = 'polygonsToChange';

  static const String polygonsToDelete = 'polygonIdsToRemove';

  static const String circlesToInsert = 'circlesToAdd';

  static const String circlesToUpdate = 'circlesToChange';

  static const String circlesToDelete = 'circleIdsToRemove';

  static const String newCameraPosition = 'newCameraPosition';

  static const String newLatLng = 'newLatLng';

  static const String newLatLngBounds = 'newLatLngBounds';

  static const String newLatLngZoom = 'newLatLngZoom';

  static const String scrollBy = 'scrollBy';

  static const String zoomBy = 'zoomBy';

  static const String zoomIn = 'zoomIn';

  static const String zoomOut = 'zoomOut';

  static const String zoomTo = 'zoomTo';

  static const String position = 'position';

  static const String reason = 'reason';

  static const String markerId = 'markerId';

  static const String compassEnabled = 'compassEnabled';

  static const String isDark = 'isDark';

  static const String mapToolbarEnabled = 'mapToolbarEnabled';

  static const String cameraTargetBounds = 'cameraTargetBounds';

  static const String mapType = 'mapType';

  static const String minMaxZoomPreference = 'minMaxZoomPreference';

  static const String rotateGesturesEnabled = 'rotateGesturesEnabled';

  static const String scrollGesturesEnabled = 'scrollGesturesEnabled';

  static const String tiltGesturesEnabled = 'tiltGesturesEnabled';

  static const String zoomControlsEnabled = 'zoomControlsEnabled';

  static const String zoomGesturesEnabled = 'zoomGesturesEnabled';

  static const String allGesturesEnabled = 'allGesturesEnabled';

  static const String isScrollGesturesEnabledDuringRotateOrZoom =
      'isScrollGesturesEnabledDuringRotateOrZoom';

  static const String gestureScaleByMapCenter = 'gestureScaleByMapCenter';

  static const String trackCameraPosition = 'trackCameraPosition';

  static const String myLocationEnabled = 'myLocationEnabled';

  static const String myLocationButtonEnabled = 'myLocationButtonEnabled';

  static const String padding = 'padding';

  static const String trafficEnabled = 'trafficEnabled';

  static const String buildingsEnabled = 'buildingsEnabled';

  static const String alpha = 'alpha';

  static const String anchor = 'anchor';

  static const String clickable = 'clickable';

  static const String draggable = 'draggable';

  static const String flat = 'flat';

  static const String icon = 'icon';

  static const String infoWindow = 'infoWindow';

  static const String rotation = 'rotation';

  static const String visible = 'visible';

  static const String zIndex = 'zIndex';

  static const String polygonId = 'polygonId';

  static const String polylineId = 'polylineId';

  static const String fillColor = 'fillColor';

  static const String geodesic = 'geodesic';

  static const String strokeColor = 'strokeColor';

  static const String strokeWidth = 'strokeWidth';

  static const String color = 'color';

  static const String endCap = 'endCap';

  static const String points = 'points';

  static const String startCap = 'startCap';

  static const String jointType = 'jointType';

  static const String width = 'width';

  static const String pattern = 'pattern';

  static const String title = 'title';

  static const String snippet = 'snippet';

  static const String circleId = 'circleId';

  static const String center = 'center';

  static const String radius = 'radius';

  static const String northeast = 'northeast';

  static const String southwest = 'southwest';

  static const String fromAsset = 'fromAsset';

  static const String defaultMarker = 'defaultMarker';

  static const String fromBytes = 'fromBytes';

  static const String fromAssetImage = 'fromAssetImage';

  static const String x = 'x';

  static const String y = 'y';

  static const String bearing = 'bearing';

  static const String target = 'target';

  static const String tilt = 'tilt';

  static const String zoom = 'zoom';

  static const String dot = 'dot';

  static const String dash = 'dash';

  static const String gap = 'gap';

  static const String latLng = 'latLng';

  static const String holes = 'holes';

  static const String strokeJointType = 'strokeJointType';

  static const String strokePattern = 'strokePattern';

  static const String pointToCenter = 'pointToCenter';

  static const String clusterMarkerColor = 'clusterMarkerColor';

  static const String clusterMarkerTextColor = 'clusterMarkerTextColor';

  static const String clusterMarkerIcon = 'clusterMarkerIcon';

  static const String logoPosition = 'logoPosition';

  static const String logoPadding = 'logoPadding';

  static const String styleId = 'styleId';

  static const String previewId = 'previewId';

  static const String liteMode = 'liteMode';

  static const String gradient = 'gradient';

  static const String colorValues = 'colorValues';

  // Point of Interest

  static const String poi = 'pointOfInterest';

  static const String name = 'name';

  static const String placeId = 'placeId';

  // Ground Overlays

  static const String groundOverlaysToInsert = 'groundOverlaysToAdd';

  static const String groundOverlaysToUpdate = 'groundOverlaysToChange';

  static const String groundOverlaysToDelete = 'groundOverlayIdsToRemove';

  static const String groundOverlayId = 'groundOverlayId';

  static const String height = 'height';

  static const String imageDescriptor = 'imageDescriptor';

  static const String bounds = 'bounds';

  static const String transparency = 'transparency';

  // Marker Clustering

  static const String markersClusteringEnabled = 'markersClusteringEnabled';

  static const String clusterable = 'clusterable';

  // Tile Overlay

  static const String tileOverlaysToInsert = 'tileOverlaysToAdd';

  static const String tileOverlaysToUpdate = 'tileOverlaysToChange';

  static const String tileOverlaysToDelete = 'tileOverlayIdsToRemove';

  static const String tileOverlayId = 'tileOverlayId';

  static const String fadeIn = 'fadeIn';

  static const String tileProvider = 'tileProvider';

  static const String uri = 'uri';

  static const String imageData = 'imageData';

  // Animation

  static const String animationId = 'animationId';

  static const String animation = 'animation';

  static const String duration = 'duration';

  static const String fillMode = 'fillMode';

  static const String repeatCount = 'repeatCount';

  static const String repeatMode = 'repeatMode';

  static const String interpolator = 'interpolator';

  static const String animationType = 'animationType';

  static const String fromAlpha = 'fromAlpha';

  static const String toAlpha = 'toAlpha';

  static const String fromDegree = 'fromDegree';

  static const String toDegree = 'toDegree';

  static const String fromX = 'fromX';

  static const String fromY = 'fromY';

  static const String toX = 'toX';

  static const String toY = 'toY';

  // Location

  static const String location = 'location';

  static const String latitude = 'latitude';

  static const String longitude = 'longitude';

  static const String altitude = 'altitude';

  static const String speed = 'speed';

  static const String accuracy = 'accuracy';

  static const String verticalAccuracyMeters = 'verticalAccuracyMeters';

  static const String bearingAccuracyDegrees = 'bearingAccuracyDegrees';

  static const String speedAccuracyMetersPerSecond =
      'speedAccuracyMetersPerSecond';

  static const String time = 'time';

  static const String fromMockProvider = 'fromMockProvider';

  static const String myLocationStyle = 'myLocationStyle';

  static const String radiusFillColor = 'radiusFillColor';

  // HeatMap

  static const String heatMapsToInsert = 'heatMapsToAdd';

  static const String heatMapsToUpdate = 'heatMapsToChange';

  static const String heatMapsToDelete = 'heatMapIdsToRemove';

  static const String heatMapId = 'heatMapId';

  static const String resourceId = 'resourceId';

  static const String jsonData = 'jsonData';

  static const String intensity = 'intensity';

  static const String intensityMap = 'intensityMap';

  static const String opacity = 'opacity';

  static const String opacityMap = 'opacityMap';

  static const String radiusMap = 'radiusMap';

  static const String radiusUnit = 'radiusUnit';
}
