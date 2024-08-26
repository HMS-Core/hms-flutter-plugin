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

abstract class _Method {
  static const String CameraMoveStart = '[Camera]onMoveStarted';

  static const String CameraOnMove = '[Camera]onMove';

  static const String CameraOnIdle = '[Camera]onIdle';

  static const String CameraMoveCanceled = '[Camera]onMoveCancelled';

  static const String MarkerClick = '[Marker]click';

  static const String MarkerDragEnd = '[Marker]onDragEnd';

  static const String MarkerDragStart = '[Marker]onDragStart';

  static const String MarkerDrag = '[Marker]onDrag';

  static const String InfoWindowClick = '[InfoWindow]click';

  static const String InfoWindowLongClick = '[InfoWindow]longClick';

  static const String InfoWindowClose = '[InfoWindow]close';

  static const String PolylineClick = '[Polyline]click';

  static const String PolygonClick = '[Polygon]click';

  static const String CircleClick = '[Circle]click';

  static const String MapClick = '[Map]click';

  static const String MapLongClick = '[Map]onLongPress';

  static const String MapPoiClick = '[Map]onPoiClick';

  static const String MapOnMyLocationClick = '[Map]onMyLocationClick';

  static const String MapOnMyLocationButtonClick =
      '[Map]onMyLocationButtonClick';

  static const String MapWaitForMap = '[Map]waitForMap';

  static const String MapUpdate = '[Map]update';

  static const String MapGetVisibleRegion = '[Map]getVisibleRegion';

  static const String MapGetScreenCoordinate = '[Map]getScreenCoordinate';

  static const String MapGetLatLng = '[Map]getLatLng';

  static const String MapTakeSnapshot = '[Map]takeSnapshot';

  static const String CameraMove = '[Camera]move';

  static const String CameraAnimate = '[Camera]animate';

  static const String StopAnimation = '[Map]stopAnimation';

  static const String MarkersUpdate = '[Markers]update';

  static const String MarkersShowInfoWindow = '[Markers]showInfoWindow';

  static const String MarkersHideInfoWindow = '[Markers]hideInfoWindow';

  static const String MarkersIsInfoWindowShown = '[Markers]isInfoWindowShown';

  static const String PolygonsUpdate = '[Polygons]update';

  static const String PolylinesUpdate = '[Polylines]update';

  static const String CirclesUpdate = '[Circles]update';

  static const String MapGetZoomLevel = '[Map]getZoomLevel';

  static const String MapSetStyle = '[Map]setStyle';

  static const String InitializeMap = '[MapUtil]initializeMap';

  static const String SetApiKey = '[MapUtil]setApiKey';

  static const String SetAccessToken = '[MapUtil]setAccessToken';

  static const String MapGetScalePerPixel = '[Map]getScalePerPixel';

  //Location Source
  static const String SetLocationSource = '[Map]setLocationSource';

  static const String SetLocation = '[Map]setLocation';

  static const String DeactivateLocationSource =
      '[Map]deactivateLocationSource';

  //Ground Overlays
  static const String GroundOverlayClick = '[GroundOverlay]click';

  static const String GroundOverlaysUpdate = '[GroundOverlays]update';

  //Map Utils
  static const String MapDistanceCalculator = '[MapUtil]distanceCalculator';

  static const String MapConvertCoordinate = '[MapUtil]convertCoordinate';

  static const String MapConvertCoordinates = '[MapUtil]convertCoordinates';

  //HMS Logger
  static const String EnableLogger = '[MapUtil]enableLogger';

  static const String DisableLogger = '[MapUtil]disableLogger';

  //Tile Overlay
  static const String TileOverlaysUpdate = '[TileOverlays]update';

  static const String ClearTileCache = 'clearTileCache';

  //Marker
  static const String MarkerStartAnimation = 'MarkerStartAnimation';

  static const String MarkerIsClusterable = '[Markers]isMarkerClusterable';

  //Heat Map
  static const String HeatMapUpdate = '[HeatMap]update';

  //Circle
  static const String CircleStartAnimation = 'CircleStartAnimation';
}
