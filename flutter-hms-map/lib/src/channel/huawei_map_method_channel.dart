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

abstract class _HuaweiMapMethodChannel {
  static final Map<int, MethodChannel> _channels = <int, MethodChannel>{};
  static final StreamController<MapEvent<dynamic>> _streamController =
      StreamController<MapEvent<dynamic>>.broadcast();

  static MethodChannel setChannel(int mapId) {
    return _channels[mapId]!;
  }

  static Future<void> init(int mapId) async {
    if (!_channels.containsKey(mapId)) {
      final MethodChannel channel = MethodChannel('${_mapChannel}_$mapId');

      channel.setMethodCallHandler((MethodCall call) {
        return _handleMethodCall(call, mapId);
      });
      _channels[mapId] = channel;
      return channel.invokeMethod<void>(
        _Method.MapWaitForMap,
      );
    }
  }

  static Stream<MapEvent<dynamic>> _events(int mapId) {
    return _streamController.stream.where((MapEvent<dynamic> event) {
      return event.mapId == mapId;
    });
  }

  // MAP

  static Stream<MapClickEvent> onClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MapClickEvent)
        .cast<MapClickEvent>();
  }

  static Stream<MapLongPressEvent> onLongPress({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MapLongPressEvent)
        .cast<MapLongPressEvent>();
  }

  // POINT OF INTEREST

  static Stream<PoiClickEvent> onPoiClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is PoiClickEvent)
        .cast<PoiClickEvent>();
  }

  // MY LOCATION

  static Stream<LocationClickEvent> onMyLocationClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is LocationClickEvent)
        .cast<LocationClickEvent>();
  }

  static Stream<LocationButtonClickEvent> onMyLocationButtonClick({
    required int mapId,
  }) {
    return _events(mapId)
        .where((_) => _ is LocationButtonClickEvent)
        .cast<LocationButtonClickEvent>();
  }

  // CAMERA

  static Stream<CameraMoveStartedEvent> onCameraMoveStarted({
    required int mapId,
  }) {
    return _events(mapId)
        .where((_) => _ is CameraMoveStartedEvent)
        .cast<CameraMoveStartedEvent>();
  }

  static Stream<CameraMoveEvent> onCameraMove({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is CameraMoveEvent)
        .cast<CameraMoveEvent>();
  }

  static Stream<CameraIdleEvent> onCameraIdle({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is CameraIdleEvent)
        .cast<CameraIdleEvent>();
  }

  static Stream<CameraMoveCanceledEvent> onCameraMoveCanceled({
    required int mapId,
  }) {
    return _events(mapId)
        .where((_) => _ is CameraMoveCanceledEvent)
        .cast<CameraMoveCanceledEvent>();
  }

  // MARKER

  static Stream<MarkerClickEvent> onMarkerClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MarkerClickEvent)
        .cast<MarkerClickEvent>();
  }

  static Stream<InfoWindowClickEvent> onInfoWindowClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is InfoWindowClickEvent)
        .cast<InfoWindowClickEvent>();
  }

  static Stream<InfoWindowLongClickEvent> onInfoWindowLongClick({
    required int mapId,
  }) {
    return _events(mapId)
        .where((_) => _ is InfoWindowLongClickEvent)
        .cast<InfoWindowLongClickEvent>();
  }

  static Stream<InfoWindowCloseEvent> onInfoWindowClose({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is InfoWindowCloseEvent)
        .cast<InfoWindowCloseEvent>();
  }

  static Stream<MarkerDragEndEvent> onMarkerDragEnd({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MarkerDragEndEvent)
        .cast<MarkerDragEndEvent>();
  }

  static Stream<MarkerDragStartEvent> onMarkerDragStart({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MarkerDragStartEvent)
        .cast<MarkerDragStartEvent>();
  }

  static Stream<MarkerDragEvent> onMarkerDrag({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is MarkerDragEvent)
        .cast<MarkerDragEvent>();
  }

  // GROUND OVERLAY

  static Stream<GroundOverlayClickEvent> onGroundOverlayClick({
    required int mapId,
  }) {
    return _events(mapId)
        .where((_) => _ is GroundOverlayClickEvent)
        .cast<GroundOverlayClickEvent>();
  }

  // POLYLINE

  static Stream<PolylineClickEvent> onPolylineClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is PolylineClickEvent)
        .cast<PolylineClickEvent>();
  }

  // POLYGON

  static Stream<PolygonClickEvent> onPolygonClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is PolygonClickEvent)
        .cast<PolygonClickEvent>();
  }

  // CIRCLE

  static Stream<CircleClickEvent> onCircleClick({required int mapId}) {
    return _events(mapId)
        .where((_) => _ is CircleClickEvent)
        .cast<CircleClickEvent>();
  }

  static Future<dynamic> _handleMethodCall(MethodCall call, int mapId) async {
    switch (call.method) {
      case _Method.CameraMoveStart:
        _streamController.add(
          CameraMoveStartedEvent(mapId, call.arguments[_Param.reason]),
        );
        break;
      case _Method.CameraOnMove:
        _streamController.add(
          CameraMoveEvent(
            mapId,
            CameraPosition.fromMap(call.arguments[_Param.position]),
          ),
        );
        break;
      case _Method.CameraOnIdle:
        _streamController.add(
          CameraIdleEvent(mapId),
        );
        break;
      case _Method.CameraMoveCanceled:
        _streamController.add(
          CameraMoveCanceledEvent(mapId),
        );
        break;
      case _Method.MarkerClick:
        _streamController.add(
          MarkerClickEvent(
            mapId,
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.MarkerDragEnd:
        _streamController.add(
          MarkerDragEndEvent(
            mapId,
            LatLng.fromJson(call.arguments[_Param.position]),
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.MarkerDragStart:
        _streamController.add(
          MarkerDragStartEvent(
            mapId,
            LatLng.fromJson(call.arguments[_Param.position]),
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.MarkerDrag:
        _streamController.add(
          MarkerDragEvent(
            mapId,
            LatLng.fromJson(call.arguments[_Param.position]),
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.InfoWindowClick:
        _streamController.add(
          InfoWindowClickEvent(
            mapId,
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.InfoWindowLongClick:
        _streamController.add(
          InfoWindowLongClickEvent(
            mapId,
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.InfoWindowClose:
        _streamController.add(
          InfoWindowCloseEvent(
            mapId,
            MarkerId(call.arguments[_Param.markerId]),
          ),
        );
        break;
      case _Method.PolylineClick:
        _streamController.add(
          PolylineClickEvent(
            mapId,
            PolylineId(call.arguments[_Param.polylineId]),
          ),
        );
        break;
      case _Method.PolygonClick:
        _streamController.add(
          PolygonClickEvent(
            mapId,
            PolygonId(call.arguments[_Param.polygonId]),
          ),
        );
        break;
      case _Method.CircleClick:
        _streamController.add(
          CircleClickEvent(
            mapId,
            CircleId(call.arguments[_Param.circleId]),
          ),
        );
        break;
      case _Method.MapClick:
        _streamController.add(
          MapClickEvent(
            mapId,
            LatLng.fromJson(call.arguments[_Param.position]),
          ),
        );
        break;
      case _Method.MapLongClick:
        _streamController.add(
          MapLongPressEvent(
            mapId,
            LatLng.fromJson(call.arguments[_Param.position]),
          ),
        );
        break;
      case _Method.GroundOverlayClick:
        _streamController.add(
          GroundOverlayClickEvent(
            mapId,
            GroundOverlayId(call.arguments[_Param.groundOverlayId]),
          ),
        );
        break;
      case _Method.MapPoiClick:
        _streamController.add(
          PoiClickEvent(
            mapId,
            PointOfInterest.fromMap(
              Map<String, dynamic>.from(call.arguments[_Param.poi]),
            ),
          ),
        );
        break;
      case _Method.MapOnMyLocationClick:
        _streamController.add(
          LocationClickEvent(
            mapId,
            Location.fromMap(
              Map<String, dynamic>.from(call.arguments[_Param.location]),
            ),
          ),
        );
        break;
      case _Method.MapOnMyLocationButtonClick:
        _streamController.add(
          LocationButtonClickEvent(mapId, call.arguments),
        );
        break;
      default:
        throw MissingPluginException();
    }
  }

  static Future<void> updateMapOptions(
    Map<String, dynamic> optionsUpdate, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.MapUpdate,
      <String, dynamic>{
        _Param.options: optionsUpdate,
      },
    );
  }

  static Future<void> updateMarkers(
    MarkerUpdates markerUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.MarkersUpdate,
      markerUpdatesToJson(markerUpdates),
    );
  }

  static Future<void> updateGroundOverlays(
    GroundOverlayUpdates groundOverlayUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.GroundOverlaysUpdate,
      groundOverlayUpdatesToJson(groundOverlayUpdates),
    );
  }

  static Future<void> updateTileOverlays(
    TileOverlayUpdates tileOverlayUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.TileOverlaysUpdate,
      tileOverlayUpdatesToJson(tileOverlayUpdates),
    );
  }

  static Future<void> updateHeatMaps(
    HeatMapUpdates heatMapUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.HeatMapUpdate,
      heatMapUpdatesToJson(heatMapUpdates),
    );
  }

  static Future<void> clearTileCache(
    TileOverlayId tileOverlayId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.ClearTileCache,
      <String, String>{
        _Param.tileOverlayId: tileOverlayId.id,
      },
    );
  }

  static Future<void> startAnimationOnMarker(
    MarkerId markerId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.MarkerStartAnimation,
      <String, String>{
        _Param.markerId: markerId.id,
      },
    );
  }

  static Future<void> startAnimationOnCircle(
    CircleId circleId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.CircleStartAnimation,
      <String, String>{
        _Param.circleId: circleId.id,
      },
    );
  }

  static Future<void> updatePolygons(
    PolygonUpdates polygonUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.PolygonsUpdate,
      polygonUpdatesToJson(polygonUpdates),
    );
  }

  static Future<void> updatePolylines(
    PolylineUpdates polylineUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.PolylinesUpdate,
      polylineUpdatesToJson(polylineUpdates),
    );
  }

  static Future<void> updateCircles(
    CircleUpdates circleUpdates, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.CirclesUpdate,
      circleUpdatesToJson(circleUpdates),
    );
  }

  static Future<void> animateCamera(
    CameraUpdate cameraUpdate, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.CameraAnimate,
      <String, dynamic>{
        _Param.cameraUpdate: cameraUpdate.toJson(),
      },
    );
  }

  static Future<void> stopAnimation({required int mapId}) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.StopAnimation,
    );
  }

  static Future<void> moveCamera(
    CameraUpdate cameraUpdate, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.CameraMove,
      <String, dynamic>{
        _Param.cameraUpdate: cameraUpdate.toJson(),
      },
    );
  }

  static Future<void> setMapStyle(
    String mapStyle, {
    required int mapId,
  }) async {
    await setChannel(mapId).invokeMethod<List<dynamic>>(
      _Method.MapSetStyle,
      mapStyle,
    );
  }

  static Future<void> setLocation(
    LatLng latLng, {
    required int mapId,
  }) async {
    await setChannel(mapId).invokeMethod(
      _Method.SetLocation,
      latLngToJson(latLng),
    );
  }

  static Future<void> setLocationSource({required int mapId}) async {
    await setChannel(mapId).invokeMethod(
      _Method.SetLocationSource,
    );
  }

  static Future<void> deactivateLocationSource({required int mapId}) async {
    await setChannel(mapId).invokeMethod(
      _Method.DeactivateLocationSource,
    );
  }

  static Future<LatLngBounds> getVisibleRegion({required int mapId}) async {
    final Map<String, dynamic> latLngBounds =
        await setChannel(mapId).invokeMapMethod<String, dynamic>(
      _Method.MapGetVisibleRegion,
    ) as Map<String, dynamic>;

    return LatLngBounds(
      northeast: LatLng.fromJson(latLngBounds[_Param.northeast]),
      southwest: LatLng.fromJson(latLngBounds[_Param.southwest]),
    );
  }

  static Future<ScreenCoordinate> getScreenCoordinate(
    LatLng latLng, {
    required int mapId,
  }) async {
    final Map<String, int> point =
        await setChannel(mapId).invokeMapMethod<String, int>(
      _Method.MapGetScreenCoordinate,
      latLngToJson(latLng),
    ) as Map<String, int>;

    return ScreenCoordinate(
      x: point[_Param.x]!,
      y: point[_Param.y]!,
    );
  }

  static Future<LatLng> getLatLng(
    ScreenCoordinate screenCoordinate, {
    required int mapId,
  }) async {
    final List<dynamic> latLng =
        await setChannel(mapId).invokeMethod<List<dynamic>>(
      _Method.MapGetLatLng,
      screenCoordinateToJson(screenCoordinate),
    ) as List<dynamic>;

    return LatLng(
      latLng[0],
      latLng[1],
    );
  }

  static Future<double?> getScalePerPixel({required int mapId}) {
    return setChannel(mapId).invokeMethod<double>(
      _Method.MapGetScalePerPixel,
    );
  }

  static Future<void> showMarkerInfoWindow(
    MarkerId markerId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.MarkersShowInfoWindow,
      <String, String>{
        _Param.markerId: markerId.id,
      },
    );
  }

  static Future<void> hideMarkerInfoWindow(
    MarkerId markerId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<void>(
      _Method.MarkersHideInfoWindow,
      <String, String>{
        _Param.markerId: markerId.id,
      },
    );
  }

  static Future<bool?> isMarkerInfoWindowShown(
    MarkerId markerId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<bool>(
      _Method.MarkersIsInfoWindowShown,
      <String, String>{
        _Param.markerId: markerId.id,
      },
    );
  }

  static Future<bool?> isMarkerClusterable(
    MarkerId markerId, {
    required int mapId,
  }) {
    return setChannel(mapId).invokeMethod<bool>(
      _Method.MarkerIsClusterable,
      <String, String>{
        _Param.markerId: markerId.id,
      },
    );
  }

  static Future<double?> getZoomLevel({required int mapId}) {
    return setChannel(mapId).invokeMethod<double>(
      _Method.MapGetZoomLevel,
    );
  }

  static Future<Uint8List?> takeSnapshot({required int mapId}) {
    return setChannel(mapId).invokeMethod<Uint8List>(
      _Method.MapTakeSnapshot,
    );
  }

  static Widget buildView(
    Map<String, dynamic> creationParams,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  ) {
    return PlatformViewLink(
      viewType: _mapChannel,
      surfaceFactory: (
        BuildContext context,
        PlatformViewController controller,
      ) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: gestureRecognizers ??
              const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        final AndroidViewController controller =
            PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: _mapChannel,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () => params.onFocusChanged(true),
        );
        controller.addOnPlatformViewCreatedListener(
          params.onPlatformViewCreated,
        );
        controller.addOnPlatformViewCreatedListener(
          onPlatformViewCreated,
        );
        controller.create();
        return controller;
      },
    );
  }
}
