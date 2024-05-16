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

part of huawei_map;

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
    await _HuaweiMapMethodChannel.init(id);
    return HuaweiMapController._(
      initialCameraPosition,
      huaweiMapState,
      mapId: id,
    );
  }

  final _HuaweiMapState _huaweiMapState;

  void _connectStreams(int mapId) {
    _HuaweiMapMethodChannel.onMarkerClick(mapId: mapId).listen(
      (MarkerClickEvent e) => _huaweiMapState.onMarkerClick(e.value!),
    );
    _HuaweiMapMethodChannel.onMarkerDragEnd(mapId: mapId).listen(
      (MarkerDragEndEvent e) =>
          _huaweiMapState.onMarkerDragEnd(e.value!, e.position),
    );
    _HuaweiMapMethodChannel.onMarkerDragStart(mapId: mapId).listen(
      (MarkerDragStartEvent e) =>
          _huaweiMapState.onMarkerDragStart(e.value!, e.position),
    );
    _HuaweiMapMethodChannel.onMarkerDrag(mapId: mapId).listen(
      (MarkerDragEvent e) => _huaweiMapState.onMarkerDrag(e.value!, e.position),
    );
    _HuaweiMapMethodChannel.onInfoWindowClick(mapId: mapId).listen(
      (InfoWindowClickEvent e) => _huaweiMapState.onInfoWindowClick(e.value!),
    );
    _HuaweiMapMethodChannel.onInfoWindowLongClick(mapId: mapId).listen(
      (InfoWindowLongClickEvent e) =>
          _huaweiMapState.onInfoWindowLongClick(e.value!),
    );
    _HuaweiMapMethodChannel.onInfoWindowClose(mapId: mapId).listen(
      (InfoWindowCloseEvent e) => _huaweiMapState.onInfoWindowClose(e.value!),
    );
    _HuaweiMapMethodChannel.onPolylineClick(mapId: mapId).listen(
      (PolylineClickEvent e) => _huaweiMapState.onPolylineClick(e.value!),
    );
    _HuaweiMapMethodChannel.onPolygonClick(mapId: mapId).listen(
      (PolygonClickEvent e) => _huaweiMapState.onPolygonClick(e.value!),
    );
    _HuaweiMapMethodChannel.onCircleClick(mapId: mapId).listen(
      (CircleClickEvent e) => _huaweiMapState.onCircleClick(e.value!),
    );
    _HuaweiMapMethodChannel.onClick(mapId: mapId)
        .listen((MapClickEvent e) => _huaweiMapState.onClick(e.position));
    _HuaweiMapMethodChannel.onLongPress(mapId: mapId).listen(
      (MapLongPressEvent e) => _huaweiMapState.onLongPress(e.position),
    );
    _HuaweiMapMethodChannel.onPoiClick(mapId: mapId).listen(
      (PoiClickEvent e) => _huaweiMapState.onPoiClick(e.pointOfInterest),
    );
    _HuaweiMapMethodChannel.onMyLocationClick(mapId: mapId).listen(
      (LocationClickEvent e) => _huaweiMapState.onMyLocationClick(e.location),
    );
    _HuaweiMapMethodChannel.onMyLocationButtonClick(mapId: mapId).listen(
      (LocationButtonClickEvent e) =>
          _huaweiMapState.onMyLocationButtonClick(e.onMyLocationButtonClicked),
    );
    _HuaweiMapMethodChannel.onGroundOverlayClick(mapId: mapId).listen(
      (GroundOverlayClickEvent e) =>
          _huaweiMapState.onGroundOverlayClick(e.value!),
    );
    if (_huaweiMapState.widget.onCameraMoveStarted != null) {
      _HuaweiMapMethodChannel.onCameraMoveStarted(mapId: mapId).listen(
        (CameraMoveStartedEvent e) =>
            _huaweiMapState.widget.onCameraMoveStarted!(e.value!),
      );
    }
    if (_huaweiMapState.widget.onCameraMove != null) {
      _HuaweiMapMethodChannel.onCameraMove(mapId: mapId).listen(
        (CameraMoveEvent e) => _huaweiMapState.widget.onCameraMove!(e.value!),
      );
    }
    if (_huaweiMapState.widget.onCameraIdle != null) {
      _HuaweiMapMethodChannel.onCameraIdle(mapId: mapId)
          .listen((_) => _huaweiMapState.widget.onCameraIdle!());
    }
    if (_huaweiMapState.widget.onCameraMoveCanceled != null) {
      _HuaweiMapMethodChannel.onCameraMoveCanceled(mapId: mapId)
          .listen((_) => _huaweiMapState.widget.onCameraMoveCanceled!());
    }
  }

  Future<void> _updateMapOptions(Map<String, dynamic> optionsUpdate) {
    return _HuaweiMapMethodChannel.updateMapOptions(
      optionsUpdate,
      mapId: mapId,
    );
  }

  Future<void> _updateMarkers(MarkerUpdates markerUpdates) {
    return _HuaweiMapMethodChannel.updateMarkers(markerUpdates, mapId: mapId);
  }

  Future<void> _updatePolygons(PolygonUpdates polygonUpdates) {
    return _HuaweiMapMethodChannel.updatePolygons(polygonUpdates, mapId: mapId);
  }

  Future<void> _updatePolylines(PolylineUpdates polylineUpdates) {
    return _HuaweiMapMethodChannel.updatePolylines(
      polylineUpdates,
      mapId: mapId,
    );
  }

  Future<void> _updateCircles(CircleUpdates circleUpdates) {
    return _HuaweiMapMethodChannel.updateCircles(circleUpdates, mapId: mapId);
  }

  Future<void> _updateGroundOverlays(
    GroundOverlayUpdates groundOverlayUpdates,
  ) {
    return _HuaweiMapMethodChannel.updateGroundOverlays(
      groundOverlayUpdates,
      mapId: mapId,
    );
  }

  Future<void> _updateTileOverlays(TileOverlayUpdates tileOverlayUpdates) {
    return _HuaweiMapMethodChannel.updateTileOverlays(
      tileOverlayUpdates,
      mapId: mapId,
    );
  }

  Future<void> _updateHeatMaps(HeatMapUpdates heatMapUpdates) {
    return _HuaweiMapMethodChannel.updateHeatMaps(heatMapUpdates, mapId: mapId);
  }

  Future<void> clearTileCache(TileOverlay tileOverlay) {
    return _HuaweiMapMethodChannel.clearTileCache(
      tileOverlay.tileOverlayId,
      mapId: mapId,
    );
  }

  Future<void> startAnimationOnMarker(Marker marker) {
    return _HuaweiMapMethodChannel.startAnimationOnMarker(
      marker.markerId,
      mapId: mapId,
    );
  }

  Future<void> startAnimationOnCircle(Circle circle) {
    return _HuaweiMapMethodChannel.startAnimationOnCircle(
      circle.circleId,
      mapId: mapId,
    );
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    return _HuaweiMapMethodChannel.animateCamera(cameraUpdate, mapId: mapId);
  }

  Future<void> stopAnimation() {
    return _HuaweiMapMethodChannel.stopAnimation(mapId: mapId);
  }

  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return _HuaweiMapMethodChannel.moveCamera(cameraUpdate, mapId: mapId);
  }

  Future<void> setMapStyle(String mapStyle) {
    return _HuaweiMapMethodChannel.setMapStyle(mapStyle, mapId: mapId);
  }

  Future<void> setLocation(LatLng latLng) {
    return _HuaweiMapMethodChannel.setLocation(latLng, mapId: mapId);
  }

  Future<void> setLocationSource() {
    return _HuaweiMapMethodChannel.setLocationSource(mapId: mapId);
  }

  Future<void> deactivateLocationSource() {
    return _HuaweiMapMethodChannel.deactivateLocationSource(mapId: mapId);
  }

  Future<LatLngBounds> getVisibleRegion() {
    return _HuaweiMapMethodChannel.getVisibleRegion(mapId: mapId);
  }

  Future<ScreenCoordinate> getScreenCoordinate(LatLng latLng) {
    return _HuaweiMapMethodChannel.getScreenCoordinate(latLng, mapId: mapId);
  }

  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) {
    return _HuaweiMapMethodChannel.getLatLng(screenCoordinate, mapId: mapId);
  }

  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return _HuaweiMapMethodChannel.showMarkerInfoWindow(markerId, mapId: mapId);
  }

  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return _HuaweiMapMethodChannel.hideMarkerInfoWindow(markerId, mapId: mapId);
  }

  Future<bool?> isMarkerInfoWindowShown(MarkerId markerId) {
    return _HuaweiMapMethodChannel.isMarkerInfoWindowShown(
      markerId,
      mapId: mapId,
    );
  }

  Future<bool?> isMarkerClusterable(MarkerId markerId) {
    return _HuaweiMapMethodChannel.isMarkerClusterable(markerId, mapId: mapId);
  }

  Future<double?> getZoomLevel() {
    return _HuaweiMapMethodChannel.getZoomLevel(mapId: mapId);
  }

  Future<Uint8List?> takeSnapshot() {
    return _HuaweiMapMethodChannel.takeSnapshot(mapId: mapId);
  }

  Future<double?> getScalePerPixel() {
    return _HuaweiMapMethodChannel.getScalePerPixel(mapId: mapId);
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
  final bool isDark;
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
  final MyLocationStyle? myLocationStyle;

  final void Function(HuaweiMapController controller)? onMapCreated;
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
    this.isDark = false,
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
    this.myLocationStyle,
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
      MarkerUpdates.update(_markers.values.toSet(), widget.markers),
    );
    _markers = markerToMap(widget.markers);
  }

  void _updatePolylines() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updatePolylines(
      PolylineUpdates.update(_polylines.values.toSet(), widget.polylines),
    );
    _polylines = polylineToMap(widget.polylines);
  }

  void _updatePolygons() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updatePolygons(
      PolygonUpdates.update(_polygons.values.toSet(), widget.polygons),
    );
    _polygons = polygonToMap(widget.polygons);
  }

  void _updateCircles() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateCircles(
      CircleUpdates.update(_circles.values.toSet(), widget.circles),
    );
    _circles = circleToMap(widget.circles);
  }

  void _updateGroundOverlays() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateGroundOverlays(
      GroundOverlayUpdates.update(
        _groundOverlays.values.toSet(),
        widget.groundOverlays,
      ),
    );
    _groundOverlays = groundOverlayToMap(widget.groundOverlays);
  }

  void _updateTileOverlays() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateTileOverlays(
      TileOverlayUpdates.update(
        _tileOverlays.values.toSet(),
        widget.tileOverlays,
      ),
    );
    _tileOverlays = tileOverlayToMap(widget.tileOverlays);
  }

  void _updateHeatMaps() async {
    final HuaweiMapController controller = await _controller.future;
    controller._updateHeatMaps(
      HeatMapUpdates.update(_heatMaps.values.toSet(), widget.heatMaps),
    );
    _heatMaps = heatMapToMap(widget.heatMaps);
  }

  void onClick(LatLng position) {
    widget.onClick?.call(position);
  }

  void onLongPress(LatLng position) {
    widget.onLongPress?.call(position);
  }

  void onPoiClick(PointOfInterest pointOfInterest) {
    widget.onPoiClick?.call(pointOfInterest);
  }

  void onMyLocationClick(Location location) {
    widget.onMyLocationClick?.call(location);
  }

  void onMyLocationButtonClick(bool onMyLocationButtonClicked) {
    widget.onMyLocationButtonClick?.call(onMyLocationButtonClicked);
  }

  void onMarkerClick(MarkerId markerId) {
    _markers[markerId]?.onClick?.call();
  }

  void onMarkerDragEnd(MarkerId markerId, LatLng position) {
    _markers[markerId]?.onDragEnd?.call(position);
  }

  void onMarkerDragStart(MarkerId markerId, LatLng position) {
    _markers[markerId]?.onDragStart?.call(position);
  }

  void onMarkerDrag(MarkerId markerId, LatLng position) {
    _markers[markerId]?.onDrag?.call(position);
  }

  void onPolygonClick(PolygonId polygonId) {
    _polygons[polygonId]?.onClick?.call();
  }

  void onPolylineClick(PolylineId polylineId) {
    _polylines[polylineId]?.onClick?.call();
  }

  void onCircleClick(CircleId circleId) {
    _circles[circleId]!.onClick!();
  }

  void onInfoWindowClick(MarkerId markerId) {
    _markers[markerId]?.infoWindow.onClick?.call();
  }

  void onInfoWindowLongClick(MarkerId markerId) {
    _markers[markerId]?.infoWindow.onLongClick?.call();
  }

  void onInfoWindowClose(MarkerId markerId) {
    _markers[markerId]?.infoWindow.onClose?.call();
  }

  void onGroundOverlayClick(GroundOverlayId groundOverlayId) {
    _groundOverlays[groundOverlayId]?.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      _Param.initialCameraPosition: widget.initialCameraPosition.toMap(),
      _Param.options: _huaweiMapOptions.toMap(),
      _Param.markersToInsert: markerToList(widget.markers),
      _Param.polylinesToInsert: polylineToList(widget.polylines),
      _Param.polygonsToInsert: polygonToList(widget.polygons),
      _Param.circlesToInsert: circleToList(widget.circles),
      _Param.groundOverlaysToInsert: groundOverlayToList(widget.groundOverlays),
      _Param.tileOverlaysToInsert: tileOverlayToList(widget.tileOverlays),
      _Param.heatMapsToInsert: heatMapToList(widget.heatMaps),
    };
    return _HuaweiMapMethodChannel.buildView(
      creationParams,
      widget.gestureRecognizers,
      onPlatformViewCreated,
    );
  }
}
