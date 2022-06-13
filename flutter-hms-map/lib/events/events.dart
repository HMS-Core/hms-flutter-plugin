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

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/events/mapEvent.dart';
import 'package:huawei_map/events/mapEventCoord.dart';
import 'package:huawei_map/events/mapEventLocation.dart';
import 'package:huawei_map/events/mapEventLocationButton.dart';
import 'package:huawei_map/events/mapEventPoi.dart';
export 'package:huawei_map/events/mapEvent.dart';

class MapClickEvent extends MapEventCoord<void> {
  MapClickEvent(int mapId, LatLng position) : super(mapId, position, null);
}

class MapLongPressEvent extends MapEventCoord<void> {
  MapLongPressEvent(int mapId, LatLng position) : super(mapId, position, null);
}

class MarkerClickEvent extends MapEvent<MarkerId> {
  MarkerClickEvent(int mapId, MarkerId markerId) : super(mapId, markerId);
}

class GroundOverlayClickEvent extends MapEvent<GroundOverlayId> {
  GroundOverlayClickEvent(int mapId, GroundOverlayId groundOverlayId)
      : super(mapId, groundOverlayId);
}

class MarkerDragEndEvent extends MapEventCoord<MarkerId> {
  MarkerDragEndEvent(int mapId, LatLng position, MarkerId markerId)
      : super(mapId, position, markerId);
}

class MarkerDragStartEvent extends MapEventCoord<MarkerId> {
  MarkerDragStartEvent(int mapId, LatLng position, MarkerId markerId)
      : super(mapId, position, markerId);
}

class MarkerDragEvent extends MapEventCoord<MarkerId> {
  MarkerDragEvent(int mapId, LatLng position, MarkerId markerId)
      : super(mapId, position, markerId);
}

class InfoWindowClickEvent extends MapEvent<MarkerId> {
  InfoWindowClickEvent(int mapId, MarkerId markerId) : super(mapId, markerId);
}

class InfoWindowLongClickEvent extends MapEvent<MarkerId> {
  InfoWindowLongClickEvent(int mapId, MarkerId markerId)
      : super(mapId, markerId);
}

class InfoWindowCloseEvent extends MapEvent<MarkerId> {
  InfoWindowCloseEvent(int mapId, MarkerId markerId) : super(mapId, markerId);
}

class CameraMoveStartedEvent extends MapEvent<int> {
  CameraMoveStartedEvent(int mapId, int reason) : super(mapId, reason);
}

class CameraMoveEvent extends MapEvent<CameraPosition> {
  CameraMoveEvent(int mapId, CameraPosition position) : super(mapId, position);
}

class CameraIdleEvent extends MapEvent<void> {
  CameraIdleEvent(int mapId) : super(mapId, null);
}

class CameraMoveCanceledEvent extends MapEvent<void> {
  CameraMoveCanceledEvent(int mapId) : super(mapId, null);
}

class PolylineClickEvent extends MapEvent<PolylineId> {
  PolylineClickEvent(int mapId, PolylineId polylineId)
      : super(mapId, polylineId);
}

class PolygonClickEvent extends MapEvent<PolygonId> {
  PolygonClickEvent(int mapId, PolygonId polygonId) : super(mapId, polygonId);
}

class CircleClickEvent extends MapEvent<CircleId> {
  CircleClickEvent(int mapId, CircleId circleId) : super(mapId, circleId);
}

class PoiClickEvent extends MapEventPoi<void> {
  PoiClickEvent(int mapId, PointOfInterest pointOfInterest)
      : super(mapId, pointOfInterest, null);
}

class LocationClickEvent extends MapEventLocation<void> {
  LocationClickEvent(int mapId, Location location)
      : super(mapId, location, null);
}

class LocationButtonClickEvent extends MapEventLocationButton<void> {
  LocationButtonClickEvent(int mapId, bool onMyLocationButtonClicked)
      : super(mapId, onMyLocationButtonClicked, null);
}
