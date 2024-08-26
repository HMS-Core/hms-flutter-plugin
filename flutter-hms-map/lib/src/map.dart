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

part of '../huawei_map.dart';

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

  /// Clears the cache of a tile overlay.
  Future<void> clearTileCache(TileOverlay tileOverlay) {
    return _HuaweiMapMethodChannel.clearTileCache(
      tileOverlay.tileOverlayId,
      mapId: mapId,
    );
  }

  /// Starts the animation of a marker.
  Future<void> startAnimationOnMarker(Marker marker) {
    return _HuaweiMapMethodChannel.startAnimationOnMarker(
      marker.markerId,
      mapId: mapId,
    );
  }

  /// Starts the animation of a circle.
  Future<void> startAnimationOnCircle(Circle circle) {
    return _HuaweiMapMethodChannel.startAnimationOnCircle(
      circle.circleId,
      mapId: mapId,
    );
  }

  /// Updates the camera position in animation mode.
  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    return _HuaweiMapMethodChannel.animateCamera(cameraUpdate, mapId: mapId);
  }

  /// Stops the current animation of the camera.
  ///
  /// When this method is called, the camera stops moving immediately and remains in that position.
  Future<void> stopAnimation() {
    return _HuaweiMapMethodChannel.stopAnimation(mapId: mapId);
  }

  /// Updates the camera position.
  ///
  /// The movement is instantaneous.
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return _HuaweiMapMethodChannel.moveCamera(cameraUpdate, mapId: mapId);
  }

  /// Sets the map style.
  Future<void> setMapStyle(String mapStyle) {
    return _HuaweiMapMethodChannel.setMapStyle(mapStyle, mapId: mapId);
  }

  /// Sets location for location source.
  Future<void> setLocation(LatLng latLng) {
    return _HuaweiMapMethodChannel.setLocation(latLng, mapId: mapId);
  }

  /// Sets the location source for the my-location layer.
  Future<void> setLocationSource() {
    return _HuaweiMapMethodChannel.setLocationSource(mapId: mapId);
  }

  /// Deactivates location source.
  Future<void> deactivateLocationSource() {
    return _HuaweiMapMethodChannel.deactivateLocationSource(mapId: mapId);
  }

  /// Obtains the visible region after conversion between the screen coordinates and longitude/latitude coordinates.
  Future<LatLngBounds> getVisibleRegion() {
    return _HuaweiMapMethodChannel.getVisibleRegion(mapId: mapId);
  }

  /// Obtains a location on the screen corresponding to the specified longitude/latitude coordinates.
  ///
  /// The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen).
  Future<ScreenCoordinate> getScreenCoordinate(LatLng latLng) {
    return _HuaweiMapMethodChannel.getScreenCoordinate(latLng, mapId: mapId);
  }

  /// Obtains the longitude and latitude of a location on the screen.
  ///
  /// The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen).
  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) {
    return _HuaweiMapMethodChannel.getLatLng(screenCoordinate, mapId: mapId);
  }

  /// Displays an information window for a marker.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return _HuaweiMapMethodChannel.showMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Hides the information window that is displayed for a marker.
  ///
  /// This method is invalid for invisible markers.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return _HuaweiMapMethodChannel.hideMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Checks whether an information window is currently displayed for a marker.
  ///
  /// This method will not consider whether the information window is actually visible on the screen.
  Future<bool?> isMarkerInfoWindowShown(MarkerId markerId) {
    return _HuaweiMapMethodChannel.isMarkerInfoWindowShown(
      markerId,
      mapId: mapId,
    );
  }

  /// Checks whether a marker can be clustered.
  Future<bool?> isMarkerClusterable(MarkerId markerId) {
    return _HuaweiMapMethodChannel.isMarkerClusterable(markerId, mapId: mapId);
  }

  /// Obtains zoom level of a map.
  Future<double?> getZoomLevel() {
    return _HuaweiMapMethodChannel.getZoomLevel(mapId: mapId);
  }

  /// Takes a snapshot of a map.
  Future<Uint8List?> takeSnapshot() {
    return _HuaweiMapMethodChannel.takeSnapshot(mapId: mapId);
  }

  /// Obtains the length of one pixel point on the map at the current zoom level, in meters.
  Future<double?> getScalePerPixel() {
    return _HuaweiMapMethodChannel.getScalePerPixel(mapId: mapId);
  }
}

class HuaweiMap extends StatefulWidget {
  /// Non-gesture animation started in response to a user operation.
  static const int REASON_API_ANIMATON = 2;

  /// An animation started by the developer.
  static const int REASON_DEVELOPER_ANIMATION = 3;

  /// An animation started in response to user gestures on a map.
  static const int REASON_GESTURE = 1;

  /// Lower left logo and copyright position.
  static const int LOWER_LEFT = 8388691;

  /// Lower right logo and copyright position.
  static const int LOWER_RIGHT = 8388693;

  /// Upper left logo and copyright position.
  static const int UPPER_LEFT = 8388659;

  /// Lower right logo and copyright position.
  static const int UPPER_RIGHT = 8388661;

  /// Initial camera position for a map.
  final CameraPosition initialCameraPosition;

  /// Indicates whether to the compass is enabled for a map.
  final bool compassEnabled;

  /// Indicates whether to enable the dark mode.
  ///
  /// After the dark mode is enabled, popups displayed after the map logo is tapped, indoor map controls, and privacy agreement popups will be displayed in dark mode.
  final bool isDark;

  /// Indicates whether the toolbar is enabled for a map.
  final bool mapToolbarEnabled;

  /// [LatLngBounds] object to constrain the camera target so that the camera target does not move outside the bounds when a user scrolls the map.
  final CameraTargetBounds cameraTargetBounds;

  /// Map type.
  final MapType mapType;

  /// Preferred minimum and maximum zoom levels of the camera.
  final MinMaxZoomPreference minMaxZoomPreference;

  /// Indicates whether rotate gestures are enabled for a map.
  final bool rotateGesturesEnabled;

  /// Indicates whether scroll gestures are enabled for a map.
  final bool scrollGesturesEnabled;

  /// Indicates whether the zoom function is enabled for the camera.
  final bool zoomControlsEnabled;

  /// Indicates whether zoom gestures are enabled for a map.
  final bool zoomGesturesEnabled;

  /// Indicates whether tilt gestures are enabled for a map.
  final bool tiltGesturesEnabled;

  /// Padding on a map.
  final EdgeInsets padding;

  /// Markers on a map.
  ///
  /// Marker icons are displayed at specified positions on the map.
  final Set<Marker> markers;

  /// Polygons on a map.
  final Set<Polygon> polygons;

  /// Polylines on a map.
  final Set<Polyline> polylines;

  /// Circles on a map.
  ///
  /// The longitude and latitude of the center and the radius are specified for the circle to indicate the surrounding area of a location.
  final Set<Circle> circles;

  /// Images on a map.
  final Set<GroundOverlay> groundOverlays;

  /// Tile overlays to a map.
  final Set<TileOverlay> tileOverlays;

  /// Heatmaps on a map.
  final Set<HeatMap> heatMaps;

  /// Indicates whether the my-location layer is enabled.
  ///
  /// If the my-location layer is enabled and the location is available, the layer constantly draws the user's current location and bearing and displays the UI controls for the user to interact with their location.
  ///
  /// To use the my-location layer function, you must apply for the `ACCESS_COARSE_LOCATION` or `ACCESS_FINE_LOCATION` permissions.
  final bool myLocationEnabled;

  /// Indicates whether the my-location icon is enabled for a map.
  final bool myLocationButtonEnabled;

  /// Indicates whether the traffic status layer is enabled.
  final bool trafficEnabled;

  /// Indicates whether the 3D building layer is enabled.
  final bool buildingsEnabled;

  /// Indicates whether a marker can be clustered.
  final bool markersClusteringEnabled;

  /// Indicates whether to enable all gestures for a map.
  final bool? allGesturesEnabled;

  /// Indicates whether scroll gestures are enabled during rotation or zooming.
  final bool isScrollGesturesEnabledDuringRotateOrZoom;

  /// Sets whether a fixed screen center can be passed for zooming.
  ///
  /// - If so, the map will be zoomed based on the passed fixed screen center.
  /// - If not, the map will be zoomed based on the tap point on the screen. You can call the `pointToCenter` field to set the screen center coordinates.
  final bool gestureScaleByMapCenter;

  /// Sets a fixed screen center for zooming.
  final ScreenCoordinate? pointToCenter;

  /// Sets the color of the default cluster marker.
  final Color? clusterMarkerColor;

  /// Sets the text color of the custom cluster marker.
  final Color? clusterMarkerTextColor;

  /// Sets the icon of the custom cluster marker.
  final BitmapDescriptor? clusterIconDescriptor;

  /// Sets the position of the Petal Maps logo.
  final int logoPosition;

  /// Sets the padding between the map camera region edges and the logo.
  final EdgeInsets logoPadding;

  /// Sets a style ID.
  ///
  /// A style ID uniquely identifies a style. After creating a map, you can call this method to change the map style to a custom style.
  final String? styleId;

  /// Sets a preview ID.
  ///
  /// The preview ID is regenerated for a custom style when the style is edited. You can call this method to check the custom style effect after creating a map.
  final String? previewId;

  /// Indicates whether the lite mode is enabled for a map.
  final bool liteMode;

  /// Sets the my-location icon style.
  final MyLocationStyle? myLocationStyle;

  /// Function to be called when a map is created.
  final void Function(HuaweiMapController controller)? onMapCreated;

  /// Function to be called when a camera move started.
  final ArgumentCallback<int>? onCameraMoveStarted;

  /// Function to be called when a camera moved.
  final CameraPositionCallback? onCameraMove;

  /// Function to be called when a camera is idle.
  final VoidCallback? onCameraIdle;

  /// A listener to listen for the stop of camera movement or the interruption of camera movement due to a new animation.
  final VoidCallback? onCameraMoveCanceled;

  /// Function to be called when map is clicked.
  final ArgumentCallback<LatLng>? onClick;

  /// Function to be called when a map is long clicked.
  final ArgumentCallback<LatLng>? onLongPress;

  /// Function to be called when a POI is tapped.
  final ArgumentCallback<PointOfInterest>? onPoiClick;

  /// Function to be called when my-location dot is tapped.
  final ArgumentCallback<Location>? onMyLocationClick;

  /// Function to be called when my-location icon is tapped.
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
