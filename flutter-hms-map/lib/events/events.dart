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

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/events/mapEvent.dart';
import 'package:huawei_map/events/mapEventCoord.dart';
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

class InfoWindowClickEvent extends MapEvent<MarkerId> {
  InfoWindowClickEvent(int mapId, MarkerId markerId) : super(mapId, markerId);
}

class CameraMoveStartedEvent extends MapEvent<void> {
  CameraMoveStartedEvent(int mapId) : super(mapId, null);
}

class CameraMoveEvent extends MapEvent<CameraPosition> {
  CameraMoveEvent(int mapId, CameraPosition position) : super(mapId, position);
}

class CameraIdleEvent extends MapEvent<void> {
  CameraIdleEvent(int mapId) : super(mapId, null);
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
