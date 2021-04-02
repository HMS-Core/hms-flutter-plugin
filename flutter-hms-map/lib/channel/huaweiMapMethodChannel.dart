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

import 'dart:async' show StreamController;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show OneSequenceGestureRecognizer;

import 'package:stream_transform/stream_transform.dart';

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/constants/channel.dart' as Channel;
import 'package:huawei_map/constants/method.dart';
import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/events/events.dart';
import 'package:huawei_map/utils/toJson.dart';

class HuaweiMapMethodChannel {
  final Map<int, MethodChannel> _channels = {};

  MethodChannel setChannel(int mapId) {
    return _channels[mapId];
  }

  static HuaweiMapMethodChannel instance = HuaweiMapMethodChannel();

  Future<void> init(int mapId) {
    MethodChannel channel;
    if (!_channels.containsKey(mapId)) {
      channel = MethodChannel('${Channel.channel}_$mapId');
      channel.setMethodCallHandler(
          (MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
    return channel.invokeMethod<void>(Method.MapWaitForMap);
  }

  final StreamController<MapEvent> _streamController =
      StreamController<MapEvent>.broadcast();

  Stream<MapEvent> _events(int mapId) =>
      _streamController.stream.where((event) => event.mapId == mapId);

  // MAP

  Stream<MapClickEvent> onClick({@required int mapId}) =>
      _events(mapId).whereType<MapClickEvent>();

  Stream<MapLongPressEvent> onLongPress({@required int mapId}) =>
      _events(mapId).whereType<MapLongPressEvent>();

  // CAMERA

  Stream<CameraMoveStartedEvent> onCameraMoveStarted({@required int mapId}) =>
      _events(mapId).whereType<CameraMoveStartedEvent>();

  Stream<CameraMoveEvent> onCameraMove({@required int mapId}) =>
      _events(mapId).whereType<CameraMoveEvent>();

  Stream<CameraIdleEvent> onCameraIdle({@required int mapId}) =>
      _events(mapId).whereType<CameraIdleEvent>();

  // MARKER

  Stream<MarkerClickEvent> onMarkerClick({@required int mapId}) =>
      _events(mapId).whereType<MarkerClickEvent>();

  Stream<InfoWindowClickEvent> onInfoWindowClick({@required int mapId}) =>
      _events(mapId).whereType<InfoWindowClickEvent>();

  Stream<MarkerDragEndEvent> onMarkerDragEnd({@required int mapId}) =>
      _events(mapId).whereType<MarkerDragEndEvent>();

  // GROUND OVERLAY

  Stream<GroundOverlayClickEvent> onGroundOverlayClick({@required int mapId}) =>
      _events(mapId).whereType<GroundOverlayClickEvent>();

  // POLYLINE

  Stream<PolylineClickEvent> onPolylineClick({@required int mapId}) =>
      _events(mapId).whereType<PolylineClickEvent>();

  // POLYGON

  Stream<PolygonClickEvent> onPolygonClick({@required int mapId}) =>
      _events(mapId).whereType<PolygonClickEvent>();

  // CIRCLE

  Stream<CircleClickEvent> onCircleClick({@required int mapId}) =>
      _events(mapId).whereType<CircleClickEvent>();

  Future<dynamic> _handleMethodCall(MethodCall call, int mapId) async {
    switch (call.method) {
      case Method.CameraMoveStart:
        _streamController.add(CameraMoveStartedEvent(mapId));
        break;
      case Method.CameraOnMove:
        _streamController.add(CameraMoveEvent(
          mapId,
          CameraPosition.fromMap(call.arguments[Param.position]),
        ));
        break;
      case Method.CameraMoveEnd:
        _streamController.add(CameraIdleEvent(mapId));
        break;
      case Method.MarkerClick:
        _streamController.add(MarkerClickEvent(
          mapId,
          MarkerId(call.arguments[Param.markerId]),
        ));
        break;
      case Method.MarkerDragEnd:
        _streamController.add(MarkerDragEndEvent(
          mapId,
          LatLng.fromJson(call.arguments[Param.position]),
          MarkerId(call.arguments[Param.markerId]),
        ));
        break;
      case Method.InfoWindowClick:
        _streamController.add(InfoWindowClickEvent(
          mapId,
          MarkerId(call.arguments[Param.markerId]),
        ));
        break;
      case Method.PolylineClick:
        _streamController.add(PolylineClickEvent(
          mapId,
          PolylineId(call.arguments[Param.polylineId]),
        ));
        break;
      case Method.PolygonClick:
        _streamController.add(PolygonClickEvent(
          mapId,
          PolygonId(call.arguments[Param.polygonId]),
        ));
        break;
      case Method.CircleClick:
        _streamController.add(CircleClickEvent(
          mapId,
          CircleId(call.arguments[Param.circleId]),
        ));
        break;
      case Method.MapClick:
        _streamController.add(MapClickEvent(
          mapId,
          LatLng.fromJson(call.arguments[Param.position]),
        ));
        break;
      case Method.MapLongClick:
        _streamController.add(MapLongPressEvent(
          mapId,
          LatLng.fromJson(call.arguments[Param.position]),
        ));
        break;
      case Method.GroundOverlayClick:
        _streamController.add(GroundOverlayClickEvent(
          mapId,
          GroundOverlayId(call.arguments[Param.groundOverlayId]),
        ));
        break;
      default:
        throw MissingPluginException();
    }
  }

  Future<void> updateMapOptions(
    Map<String, dynamic> optionsUpdate, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      Method.MapUpdate,
      <String, dynamic>{
        Param.options: optionsUpdate,
      },
    );
  }

  Future<void> updateMarkers(
    MarkerUpdates markerUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      Method.MarkersUpdate,
      markerUpdatesToJson(markerUpdates),
    );
  }

  Future<void> updateGroundOverlays(
    GroundOverlayUpdates groundOverlayUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(Method.GroundOverlaysUpdate,
        groundOverlayUpdatesToJson(groundOverlayUpdates));
  }

  Future<void> updateTileOverlays(
    TileOverlayUpdates tileOverlayUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(Method.TileOverlaysUpdate,
        tileOverlayUpdatesToJson(tileOverlayUpdates));
  }

  Future<void> clearTileCache(TileOverlayId tileOverlayId,
      {@required int mapId}) {
    return setChannel(mapId).invokeMethod<void>(Method.ClearTileCache,
        <String, String>{Param.tileOverlayId: tileOverlayId.id});
  }

  Future<void> startAnimationOnMarker(MarkerId markerId,
      {@required int mapId}) {
    return setChannel(mapId).invokeMethod<void>(Method.MarkerStartAnimation,
        <String, String>{Param.markerId: markerId.id});
  }

  Future<void> updatePolygons(
    PolygonUpdates polygonUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      Method.PolygonsUpdate,
      polygonUpdatesToJson(polygonUpdates),
    );
  }

  Future<void> updatePolylines(
    PolylineUpdates polylineUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      Method.PolylinesUpdate,
      polylineUpdatesToJson(polylineUpdates),
    );
  }

  Future<void> updateCircles(
    CircleUpdates circleUpdates, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      Method.CirclesUpdate,
      circleUpdatesToJson(circleUpdates),
    );
  }

  Future<void> animateCamera(
    CameraUpdate cameraUpdate, {
    @required int mapId,
  }) {
    return setChannel(mapId)
        .invokeMethod<void>(Method.CameraAnimate, <String, dynamic>{
      Param.cameraUpdate: cameraUpdate.toJson(),
    });
  }

  Future<void> moveCamera(
    CameraUpdate cameraUpdate, {
    @required int mapId,
  }) {
    return setChannel(mapId)
        .invokeMethod<void>(Method.CameraMove, <String, dynamic>{
      Param.cameraUpdate: cameraUpdate.toJson(),
    });
  }

  Future<void> setMapStyle(
    String mapStyle, {
    @required int mapId,
  }) async {
    final List<dynamic> successAndError = await setChannel(mapId)
        .invokeMethod<List<dynamic>>(Method.MapSetStyle, mapStyle);
    final bool success = successAndError[0];
    return success;
  }

  Future<LatLngBounds> getVisibleRegion({
    @required int mapId,
  }) async {
    final Map<String, dynamic> latLngBounds = await setChannel(mapId)
        .invokeMapMethod<String, dynamic>(Method.MapGetVisibleRegion);
    final LatLng southwest = LatLng.fromJson(latLngBounds[Param.southwest]);
    final LatLng northeast = LatLng.fromJson(latLngBounds[Param.northeast]);

    return LatLngBounds(northeast: northeast, southwest: southwest);
  }

  Future<ScreenCoordinate> getScreenCoordinate(
    LatLng latLng, {
    @required int mapId,
  }) async {
    final Map<String, int> point = await setChannel(mapId)
        .invokeMapMethod<String, int>(
            Method.MapGetScreenCoordinate, latLngToJson(latLng));

    return ScreenCoordinate(x: point[Param.x], y: point[Param.y]);
  }

  Future<LatLng> getLatLng(
    ScreenCoordinate screenCoordinate, {
    @required int mapId,
  }) async {
    final List<dynamic> latLng = await setChannel(mapId)
        .invokeMethod<List<dynamic>>(
            Method.MapGetLatLng, screenCoordinateToJson(screenCoordinate));
    return LatLng(latLng[0], latLng[1]);
  }

  Future<void> showMarkerInfoWindow(
    MarkerId markerId, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(Method.MarkersShowInfoWindow,
        <String, String>{Param.markerId: markerId.id});
  }

  Future<void> hideMarkerInfoWindow(
    MarkerId markerId, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(Method.MarkersHideInfoWindow,
        <String, String>{Param.markerId: markerId.id});
  }

  Future<bool> isMarkerInfoWindowShown(
    MarkerId markerId, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<bool>(Method.MarkersIsInfoWindowShown,
        <String, String>{Param.markerId: markerId.id});
  }

  Future<bool> isMarkerClusterable(
    MarkerId markerId, {
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<bool>(Method.MarkerIsClusterable,
        <String, String>{Param.markerId: markerId.id});
  }

  Future<double> getZoomLevel({
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<double>(Method.MapGetZoomLevel);
  }

  Future<Uint8List> takeSnapshot({
    @required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<Uint8List>(Method.MapTakeSnapshot);
  }

  Widget buildView(
      Map<String, dynamic> creationParams,
      Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
      PlatformViewCreatedCallback onPlatformViewCreated) {
    return AndroidView(
      viewType: Channel.channel,
      onPlatformViewCreated: onPlatformViewCreated,
      gestureRecognizers: gestureRecognizers,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
