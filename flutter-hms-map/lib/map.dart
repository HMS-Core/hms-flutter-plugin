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

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/channel/huaweiMapMethodChannel.dart';

import 'package:huawei_map/events/events.dart';
export 'package:huawei_map/events/events.dart';

import 'package:huawei_map/components/components.dart';
export 'package:huawei_map/components/components.dart';

final HuaweiMapMethodChannel mChannel = HuaweiMapMethodChannel.instance;

typedef void MapCreatedCallback(HuaweiMapController controller);

class HuaweiMapController {
  final int mapId;

  HuaweiMapController._(
    CameraPosition initialCameraPosition,
    this._huaweiMapState, {
    required this.mapId,
  }) {
    _connectStreams(mapId);
  }

  static Future<HuaweiMapController> init(
    int id,
    CameraPosition initialCameraPosition,
    _HuaweiMapState huaweiMapState,
  ) async {
    await mChannel.init(id);
    return HuaweiMapController._(
      initialCameraPosition,
      huaweiMapState,
      mapId: id,
    );
  }

  final _HuaweiMapState _huaweiMapState;

  void _connectStreams(int mapId) {
    mChannel.onMarkerClick(mapId: mapId).listen(
        (MarkerClickEvent e) => _huaweiMapState.onMarkerClick(e.value!));
    mChannel.onMarkerDragEnd(mapId: mapId).listen((MarkerDragEndEvent e) =>
        _huaweiMapState.onMarkerDragEnd(e.value!, e.position));
    mChannel.onMarkerDragStart(mapId: mapId).listen((MarkerDragStartEvent e) =>
        _huaweiMapState.onMarkerDragStart(e.value!, e.position));
    mChannel.onMarkerDrag(mapId: mapId).listen((MarkerDragEvent e) =>
        _huaweiMapState.onMarkerDrag(e.value!, e.position));
    mChannel.onInfoWindowClick(mapId: mapId).listen((InfoWindowClickEvent e) =>
        _huaweiMapState.onInfoWindowClick(e.value!));
    mChannel.onInfoWindowLongClick(mapId: mapId).listen(
        (InfoWindowLongClickEvent e) =>
            _huaweiMapState.onInfoWindowLongClick(e.value!));
    mChannel.onInfoWindowClose(mapId: mapId).listen((InfoWindowCloseEvent e) =>
        _huaweiMapState.onInfoWindowClose(e.value!));
    mChannel.onPolylineClick(mapId: mapId).listen(
        (PolylineClickEvent e) => _huaweiMapState.onPolylineClick(e.value!));
    mChannel.onPolygonClick(mapId: mapId).listen(
        (PolygonClickEvent e) => _huaweiMapState.onPolygonClick(e.value!));
    mChannel.onCircleClick(mapId: mapId).listen(
        (CircleClickEvent e) => _huaweiMapState.onCircleClick(e.value!));
    mChannel
        .onClick(mapId: mapId)
        .listen((MapClickEvent e) => _huaweiMapState.onClick(e.position));
    mChannel.onLongPress(mapId: mapId).listen(
        (MapLongPressEvent e) => _huaweiMapState.onLongPress(e.position));
    mChannel.onPoiClick(mapId: mapId).listen(
        (PoiClickEvent e) => _huaweiMapState.onPoiClick(e.pointOfInterest));
    mChannel.onMyLocationClick(mapId: mapId).listen((LocationClickEvent e) =>
        _huaweiMapState.onMyLocationClick(e.location));
    mChannel.onMyLocationButtonClick(mapId: mapId).listen(
        (LocationButtonClickEvent e) => _huaweiMapState
            .onMyLocationButtonClick(e.onMyLocationButtonClicked));
    mChannel.onGroundOverlayClick(mapId: mapId).listen(
        (GroundOverlayClickEvent e) =>
            _huaweiMapState.onGroundOverlayClick(e.value!));
    if (_huaweiMapState.widget.onCameraMoveStarted != null) {
      mChannel.onCameraMoveStarted(mapId: mapId).listen(
          (CameraMoveStartedEvent e) =>
              _huaweiMapState.widget.onCameraMoveStarted!(e.value!));
    }
    if (_huaweiMapState.widget.onCameraMove != null) {
      mChannel.onCameraMove(mapId: mapId).listen((CameraMoveEvent e) =>
          _huaweiMapState.widget.onCameraMove!(e.value!));
    }
    if (_huaweiMapState.widget.onCameraIdle != null) {
      mChannel
          .onCameraIdle(mapId: mapId)
          .listen((_) => _huaweiMapState.widget.onCameraIdle!());
    }
    if (_huaweiMapState.widget.onCameraMoveCanceled != null) {
      mChannel
          .onCameraMoveCanceled(mapId: mapId)
          .listen((_) => _huaweiMapState.widget.onCameraMoveCanceled!());
    }
  }

  Future<void> _updateMapOptions(Map<String, dynamic> optionsUpdate) {
    return mChannel.updateMapOptions(optionsUpdate, mapId: mapId);
  }

  Future<void> _updateMarkers(MarkerUpdates markerUpdates) {
    return mChannel.updateMarkers(markerUpdates, mapId: mapId);
  }

  Future<void> _updatePolygons(PolygonUpdates polygonUpdates) {
    return mChannel.updatePolygons(polygonUpdates, mapId: mapId);
  }

  Future<void> _updatePolylines(PolylineUpdates polylineUpdates) {
    return mChannel.updatePolylines(polylineUpdates, mapId: mapId);
  }

  Future<void> _updateCircles(CircleUpdates circleUpdates) {
    return mChannel.updateCircles(circleUpdates, mapId: mapId);
  }

  Future<void> _updateGroundOverlays(
      GroundOverlayUpdates groundOverlayUpdates) {
    return mChannel.updateGroundOverlays(groundOverlayUpdates, mapId: mapId);
  }

  Future<void> _updateTileOverlays(TileOverlayUpdates tileOverlayUpdates) {
    return mChannel.updateTileOverlays(tileOverlayUpdates, mapId: mapId);
  }

  Future<void> _updateHeatMaps(HeatMapUpdates heatMapUpdates) {
    return mChannel.updateHeatMaps(heatMapUpdates, mapId: mapId);
  }

  Future<void> clearTileCache(TileOverlay tileOverlay) {
    return mChannel.clearTileCache(tileOverlay.tileOverlayId, mapId: mapId);
  }

  Future<void> startAnimationOnMarker(Marker marker) {
    return mChannel.startAnimationOnMarker(marker.markerId, mapId: mapId);
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    return mChannel.animateCamera(cameraUpdate, mapId: mapId);
  }

  Future<void> stopAnimation() {
    return mChannel.stopAnimation(mapId: mapId);
  }

  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return mChannel.moveCamera(cameraUpdate, mapId: mapId);
  }

  Future<void> setMapStyle(String mapStyle) {
    return mChannel.setMapStyle(mapStyle, mapId: mapId);
  }

  Future<void> setLocation(LatLng latLng) {
    return mChannel.setLocation(latLng, mapId: mapId);
  }

  Future<void> setLocationSource() {
    return mChannel.setLocationSource(mapId: mapId);
  }

  Future<void> deactivateLocationSource() {
    return mChannel.deactivateLocationSource(mapId: mapId);
  }

  Future<LatLngBounds> getVisibleRegion() {
    return mChannel.getVisibleRegion(mapId: mapId);
  }

  Future<ScreenCoordinate> getScreenCoordinate(LatLng latLng) {
    return mChannel.getScreenCoordinate(latLng, mapId: mapId);
  }

  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) {
    return mChannel.getLatLng(screenCoordinate, mapId: mapId);
  }

  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return mChannel.showMarkerInfoWindow(markerId, mapId: mapId);
  }

  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return mChannel.hideMarkerInfoWindow(markerId, mapId: mapId);
  }

  Future<bool?> isMarkerInfoWindowShown(MarkerId markerId) {
    return mChannel.isMarkerInfoWindowShown(markerId, mapId: mapId);
  }

  Future<bool?> isMarkerClusterable(MarkerId markerId) {
    return mChannel.isMarkerClusterable(markerId, mapId: mapId);
  }

  Future<double?> getZoomLevel() {
    return mChannel.getZoomLevel(mapId: mapId);
  }

  Future<Uint8List?> takeSnapshot() {
    return mChannel.takeSnapshot(mapId: mapId);
  }
}

class HuaweiMap extends StatefulWidget {
  static const int REASON_API_ANIMATON = 2;
  static const int REASON_DEVELOPER_ANIMATION = 3;
  static const int REASON_GESTURE = 1;

  static const int LOWER_LEFT = 8388691;
  static const int LOWER_RIGHT = 8388693;
  static const int UPPER_LEFT = 8388659;
  static const int UPPER_RIGHT = 8388661;

  final CameraPosition initialCameraPosition;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MapType mapType;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool tiltGesturesEnabled;
  final EdgeInsets padding;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<GroundOverlay> groundOverlays;
  final Set<TileOverlay> tileOverlays;
  final Set<HeatMap> heatMaps;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool trafficEnabled;
  final bool buildingsEnabled;
  final bool markersClusteringEnabled;
  final bool? allGesturesEnabled;
  final bool isScrollGesturesEnabledDuringRotateOrZoom;
  final bool gestureScaleByMapCenter;
  final ScreenCoordinate? pointToCenter;
  final Color? clusterMarkerColor;
  final Color? clusterMarkerTextColor;
  final BitmapDescriptor? clusterIconDescriptor;
  final int logoPosition;
  final EdgeInsets logoPadding;
  final String? styleId;
  final String? previewId;
  final bool liteMode;

  final MapCreatedCallback? onMapCreated;
  final ArgumentCallback<int>? onCameraMoveStarted;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final VoidCallback? onCameraMoveCanceled;
  final ArgumentCallback<LatLng>? onClick;
  final ArgumentCallback<LatLng>? onLongPress;
  final ArgumentCallback<PointOfInterest>? onPoiClick;
  final ArgumentCallback<Location>? onMyLocationClick;
  final ArgumentCallback<bool>? onMyLocationButtonClick;

  const HuaweiMap({
    Key? key,
    required this.initialCameraPosition,
    this.mapType = MapType.normal,
    this.gestureRecognizers,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.padding = EdgeInsets.zero,
    this.trafficEnabled = false,
    this.markersClusteringEnabled = false,
    this.buildingsEnabled = true,
    this.allGesturesEnabled,
    this.isScrollGesturesEnabledDuringRotateOrZoom = true,
    this.gestureScaleByMapCenter = false,
    this.pointToCenter,
    this.markers = const <Marker>{},
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.circles = const <Circle>{},
    this.groundOverlays = const <GroundOverlay>{},
    this.tileOverlays = const <TileOverlay>{},
    this.heatMaps = const <HeatMap>{},
    this.onMapCreated,
    this.onCameraMoveStarted,
    this.onCameraMove,
    this.onCameraIdle,
    this.onCameraMoveCanceled,
    this.onClick,
    this.onLongPress,
    this.onPoiClick,
    this.onMyLocationClick,
    this.onMyLocationButtonClick,
    this.clusterMarkerColor,
    this.clusterMarkerTextColor,
    this.clusterIconDescriptor,
    this.logoPosition = LOWER_LEFT,
    this.logoPadding = EdgeInsets.zero,
    this.styleId,
    this.previewId,
    this.liteMode = false,
  }) : super(key: key);

  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  @override
  State createState() => _HuaweiMapState();
}

class _HuaweiMapState extends State<HuaweiMap> {
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Map<PolygonId, Polygon> _polygons = <PolygonId, Polygon>{};
  Map<CircleId, Circle> _circles = <CircleId, Circle>{};

  Map<GroundOverlayId, GroundOverlay> _groundOverlays =
      <GroundOverlayId, GroundOverlay>{};

  Map<TileOverlayId, TileOverlay> _tileOverlays =
      <TileOverlayId, TileOverlay>{};

  Map<HeatMapId, HeatMap> _heatMaps = <HeatMapId, HeatMap>{};

  late HuaweiMapOptions _huaweiMapOptions;

  final Completer<HuaweiMapController> _controller =
      Completer<HuaweiMapController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      Param.initialCameraPosition: widget.initialCameraPosition.toMap(),
      Param.options: _huaweiMapOptions.toMap(),
      Param.markersToInsert: markerToList(widget.markers),
      Param.polylinesToInsert: polylineToList(widget.polylines),
      Param.polygonsToInsert: polygonToList(widget.polygons),
      Param.circlesToInsert: circleToList(widget.circles),
      Param.groundOverlaysToInsert: groundOverlayToList(widget.groundOverlays),
      Param.tileOverlaysToInsert: tileOverlayToList(widget.tileOverlays),
      Param.heatMapsToInsert: heatMapToList(widget.heatMaps)
    };
    return mChannel.buildView(
      creationParams,
      widget.gestureRecognizers,
      onPlatformViewCreated,
    );
  }

  @override
  void initState() {
    super.initState();
    _huaweiMapOptions = HuaweiMapOptions.fromWidget(widget);
    _markers = markerToMap(widget.markers);
    _polylines = polylineToMap(widget.polylines);
    _polygons = polygonToMap(widget.polygons);
    _circles = circleToMap(widget.circles);
    _groundOverlays = groundOverlayToMap(widget.groundOverlays);
    _tileOverlays = tileOverlayToMap(widget.tileOverlays);
    _heatMaps = heatMapToMap(widget.heatMaps);
  }

  Future<void> onPlatformViewCreated(int id) async {
    final HuaweiMapController controller = await HuaweiMapController.init(
      id,
      widget.initialCameraPosition,
      this,
    );
    _controller.complete(controller);
    if (widget.onMapCreated != null) {
      widget.onMapCreated!(controller);
    }
  }

  void _updateOptions() async {
    final HuaweiMapOptions newOptions = HuaweiMapOptions.fromWidget(widget);
    final Map<String, dynamic> updates =
        _huaweiMapOptions.updatesMap(newOptions);
    if (updates.isEmpty) {
      return;
    }
    final HuaweiMapController controller = await _controller.future;
    controller._updateMapOptions(updates);
    _huaweiMapOptions = newOptions;
  }

  @override
  void didUpdateWidget(HuaweiMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOptions();
    _updateMarkers();
    _updatePolylines();
    _updatePolygons();
    _updateCircles();
    _updateGroundOverlays();
    _updateTileOverlays();
    _updateHeatMaps();
  }

  void _updateMarkers() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateMarkers(
        MarkerUpdates.update(_markers.values.toSet(), widget.markers));
    _markers = markerToMap(widget.markers);
  }

  void _updatePolylines() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updatePolylines(
        PolylineUpdates.update(_polylines.values.toSet(), widget.polylines));
    _polylines = polylineToMap(widget.polylines);
  }

  void _updatePolygons() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updatePolygons(
        PolygonUpdates.update(_polygons.values.toSet(), widget.polygons));
    _polygons = polygonToMap(widget.polygons);
  }

  void _updateCircles() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateCircles(
        CircleUpdates.update(_circles.values.toSet(), widget.circles));
    _circles = circleToMap(widget.circles);
  }

  void _updateGroundOverlays() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateGroundOverlays(GroundOverlayUpdates.update(
        _groundOverlays.values.toSet(), widget.groundOverlays));
    _groundOverlays = groundOverlayToMap(widget.groundOverlays);
  }

  void _updateTileOverlays() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateTileOverlays(TileOverlayUpdates.update(
        _tileOverlays.values.toSet(), widget.tileOverlays));
    _tileOverlays = tileOverlayToMap(widget.tileOverlays);
  }

  void _updateHeatMaps() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateHeatMaps(
        HeatMapUpdates.update(_heatMaps.values.toSet(), widget.heatMaps));
    _heatMaps = heatMapToMap(widget.heatMaps);
  }

  void onClick(LatLng position) {
    if (widget.onClick != null) widget.onClick!(position);
  }

  void onLongPress(LatLng position) {
    if (widget.onLongPress != null) widget.onLongPress!(position);
  }

  void onPoiClick(PointOfInterest pointOfInterest) {
    if (widget.onPoiClick != null) widget.onPoiClick!(pointOfInterest);
  }

  void onMyLocationClick(Location location) {
    if (widget.onMyLocationClick != null) widget.onMyLocationClick!(location);
  }

  void onMyLocationButtonClick(bool onMyLocationButtonClicked) {
    if (widget.onMyLocationButtonClick != null)
      widget.onMyLocationButtonClick!(onMyLocationButtonClicked);
  }

  void onMarkerClick(MarkerId markerId) {
    if (_markers[markerId]?.onClick != null) _markers[markerId]!.onClick!();
  }

  void onMarkerDragEnd(MarkerId markerId, LatLng position) {
    if (_markers[markerId]?.onDragEnd != null)
      _markers[markerId]!.onDragEnd!(position);
  }

  void onMarkerDragStart(MarkerId markerId, LatLng position) {
    if (_markers[markerId]?.onDragStart != null)
      _markers[markerId]!.onDragStart!(position);
  }

  void onMarkerDrag(MarkerId markerId, LatLng position) {
    if (_markers[markerId]?.onDrag != null)
      _markers[markerId]!.onDrag!(position);
  }

  void onPolygonClick(PolygonId polygonId) {
    _polygons[polygonId]!.onClick!();
  }

  void onPolylineClick(PolylineId polylineId) {
    if (_polylines[polylineId]?.onClick != null)
      _polylines[polylineId]!.onClick!();
  }

  void onCircleClick(CircleId circleId) {
    _circles[circleId]!.onClick!();
  }

  void onInfoWindowClick(MarkerId markerId) {
    if (_markers[markerId]?.infoWindow.onClick != null)
      _markers[markerId]!.infoWindow.onClick!();
  }

  void onInfoWindowLongClick(MarkerId markerId) {
    if (_markers[markerId]?.infoWindow.onLongClick != null)
      _markers[markerId]!.infoWindow.onLongClick!();
  }

  void onInfoWindowClose(MarkerId markerId) {
    if (_markers[markerId]?.infoWindow.onClose != null)
      _markers[markerId]!.infoWindow.onClose!();
  }

  void onGroundOverlayClick(GroundOverlayId groundOverlayId) {
    if (_groundOverlays[groundOverlayId]?.onClick != null)
      _groundOverlays[groundOverlayId]!.onClick!();
  }
}
