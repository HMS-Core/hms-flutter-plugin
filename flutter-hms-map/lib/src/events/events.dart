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

class MapClickEvent extends MapEventCoord<void> {
  const MapClickEvent(
    int mapId,
    LatLng position,
  ) : super(mapId, position, null);
}

class MapLongPressEvent extends MapEventCoord<void> {
  const MapLongPressEvent(
    int mapId,
    LatLng position,
  ) : super(mapId, position, null);
}

class MarkerClickEvent extends MapEvent<MarkerId> {
  const MarkerClickEvent(
    int mapId,
    MarkerId markerId,
  ) : super(mapId, markerId);
}

class GroundOverlayClickEvent extends MapEvent<GroundOverlayId> {
  const GroundOverlayClickEvent(
    int mapId,
    GroundOverlayId groundOverlayId,
  ) : super(mapId, groundOverlayId);
}

class MarkerDragEndEvent extends MapEventCoord<MarkerId> {
  const MarkerDragEndEvent(
    int mapId,
    LatLng position,
    MarkerId markerId,
  ) : super(mapId, position, markerId);
}

class MarkerDragStartEvent extends MapEventCoord<MarkerId> {
  const MarkerDragStartEvent(
    int mapId,
    LatLng position,
    MarkerId markerId,
  ) : super(mapId, position, markerId);
}

class MarkerDragEvent extends MapEventCoord<MarkerId> {
  const MarkerDragEvent(
    int mapId,
    LatLng position,
    MarkerId markerId,
  ) : super(mapId, position, markerId);
}

class InfoWindowClickEvent extends MapEvent<MarkerId> {
  const InfoWindowClickEvent(
    int mapId,
    MarkerId markerId,
  ) : super(mapId, markerId);
}

class InfoWindowLongClickEvent extends MapEvent<MarkerId> {
  const InfoWindowLongClickEvent(
    int mapId,
    MarkerId markerId,
  ) : super(mapId, markerId);
}

class InfoWindowCloseEvent extends MapEvent<MarkerId> {
  const InfoWindowCloseEvent(
    int mapId,
    MarkerId markerId,
  ) : super(mapId, markerId);
}

class CameraMoveStartedEvent extends MapEvent<int> {
  const CameraMoveStartedEvent(
    int mapId,
    int reason,
  ) : super(mapId, reason);
}

class CameraMoveEvent extends MapEvent<CameraPosition> {
  const CameraMoveEvent(
    int mapId,
    CameraPosition position,
  ) : super(mapId, position);
}

class CameraIdleEvent extends MapEvent<void> {
  const CameraIdleEvent(
    int mapId,
  ) : super(mapId, null);
}

class CameraMoveCanceledEvent extends MapEvent<void> {
  const CameraMoveCanceledEvent(
    int mapId,
  ) : super(mapId, null);
}

class PolylineClickEvent extends MapEvent<PolylineId> {
  const PolylineClickEvent(
    int mapId,
    PolylineId polylineId,
  ) : super(mapId, polylineId);
}

class PolygonClickEvent extends MapEvent<PolygonId> {
  const PolygonClickEvent(
    int mapId,
    PolygonId polygonId,
  ) : super(mapId, polygonId);
}

class CircleClickEvent extends MapEvent<CircleId> {
  const CircleClickEvent(
    int mapId,
    CircleId circleId,
  ) : super(mapId, circleId);
}

class PoiClickEvent extends MapEventPoi<void> {
  const PoiClickEvent(
    int mapId,
    PointOfInterest pointOfInterest,
  ) : super(mapId, pointOfInterest, null);
}

class LocationClickEvent extends MapEventLocation<void> {
  const LocationClickEvent(
    int mapId,
    Location location,
  ) : super(mapId, location, null);
}

class LocationButtonClickEvent extends MapEventLocationButton<void> {
  const LocationButtonClickEvent(
    int mapId,
    bool onMyLocationButtonClicked,
  ) : super(mapId, onMyLocationButtonClicked, null);
}
