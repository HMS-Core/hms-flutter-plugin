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

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:huawei_map/map.dart';
import '../customWidgets/customWidgets.dart';

class MarkerDemo extends StatefulWidget {
  @override
  _MarkerDemoState createState() => _MarkerDemoState();
}

class _MarkerDemoState extends State<MarkerDemo> {
  bool _colorChanged = false;

  static const LatLng _center = const LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  late HuaweiMapController mapController;
  final Set<Marker> _markers = Set<Marker>();
  bool _markersClustering = false;
  late BitmapDescriptor _markerIcon;

  Marker? marker0;
  Marker? marker1;
  Marker? marker2;
  Marker? marker3;
  Marker? markerWithColor;
  Marker? markerWithImage;

  HmsMarkerAlphaAnimation alphaAnimation = HmsMarkerAlphaAnimation(
      animationId: "alphaAnimation", fromAlpha: 0.1, toAlpha: 1.0);

  HmsMarkerRotateAnimation rotateAnimation = HmsMarkerRotateAnimation(
      animationId: "rotateAnimation", fromDegree: 0, toDegree: 360);

  HmsMarkerScaleAnimation scaleAnimation = HmsMarkerScaleAnimation(
      animationId: "scaleAnimation", fromX: 2, toX: 0, fromY: 2, toY: 0);

  HmsMarkerTranslateAnimation translateAnimation = HmsMarkerTranslateAnimation(
      animationId: "translateAnimation", target: LatLng(41.063984, 29.033135));

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _clear() {
    setState(() {
      _markers.clear();
    });
  }

  void _markersClusteringButton() {
    if (_markersClustering) {
      setState(() {
        _markersClustering = false;
      });
    } else {
      setState(() {
        _markersClustering = true;
      });
    }
  }

  void changeMarkerColor() {
    if (markerWithColor != null && _markers.isNotEmpty) {
      if (!_colorChanged) {
        setState(
          () {
            _markers.remove(markerWithColor);
            markerWithColor = markerWithColor!.updateCopy(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange));
            _markers.add(markerWithColor!);
            _colorChanged = !_colorChanged;
          },
        );
      } else {
        setState(
          () {
            _markers.remove(markerWithColor);
            markerWithColor = markerWithColor!.updateCopy(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta));
            _markers.add(markerWithColor!);
            _colorChanged = !_colorChanged;
          },
        );
      }
    }
  }

  void _addMarkers() {
    marker0 = Marker(
        markerId: MarkerId("marker_id_0"),
        position: LatLng(41.048641, 28.977033),
        clusterable: true,
        animationSet: [alphaAnimation]);

    marker1 = Marker(
        markerId: MarkerId('marker_id_1'),
        position: LatLng(41.059814, 28.979799),
        clusterable: true,
        animationSet: [rotateAnimation]);

    marker2 = Marker(
        markerId: MarkerId('marker_id_2'),
        position: LatLng(41.060261, 28.996985),
        clusterable: true,
        animationSet: [scaleAnimation]);

    marker3 = Marker(
        markerId: MarkerId('marker_id_3'),
        position: LatLng(41.049982, 28.994812),
        clusterable: true,
        animationSet: [translateAnimation]);

    markerWithColor = Marker(
      markerId: MarkerId('markerWithColor'),
      position: LatLng(40.962923, 28.958859),
      clusterable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(
        title: 'Custom Marker Title',
        snippet: 'Custom Marker Description',
        onClick: () {
          log("infoWindow Clicked!");
        },
        onLongClick: () {
          log("infoWindow Long Clicked!");
        },
        onClose: () {
          log("infoWindow Closed!");
        },
      ),
      onClick: () {
        log('Marker Clicked!');
      },
    );

    markerWithImage = Marker(
      markerId: MarkerId("markerWithImage"),
      position: LatLng(40.97408883857841, 29.016435192716216),
      clusterable: true,
      icon: _markerIcon,
      draggable: true,
      onDragEnd: (pos) {
        log("Marker onDragEnd : ${pos.lat} : ${pos.lng}");
      },
      onDragStart: (pos) {
        log("Marker onDragStart : ${pos.lat} : ${pos.lng}");
      },
      onDrag: (pos) {
        log("Marker onDrag : ${pos.lat} : ${pos.lng}");
      },
    );

    setState(() {
      _markers.add(marker0!);
      _markers.add(marker1!);
      _markers.add(marker2!);
      _markers.add(marker3!);
      _markers.add(markerWithColor!);
      _markers.add(markerWithImage!);
    });
  }

  void _addClusterMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("cluster1"),
        position: LatLng(41.001919, 28.980701),
        clusterable: true,
      ));
      _markers.add(Marker(
        markerId: MarkerId("cluster2"),
        position: LatLng(41.002919, 28.980701),
        clusterable: true,
      ));
      _markers.add(Marker(
        markerId: MarkerId("cluster3"),
        position: LatLng(41.003919, 28.980701),
        clusterable: true,
      ));
      _markers.add(Marker(
        markerId: MarkerId("cluster4"),
        position: LatLng(41.004919, 28.980701),
        clusterable: true,
      ));
      _markers.add(Marker(
        markerId: MarkerId("cluster5"),
        position: LatLng(41.005919, 28.980701),
        clusterable: true,
      ));
      _markers.add(Marker(
        markerId: MarkerId("cluster6"),
        position: LatLng(41.006919, 28.980701),
        clusterable: true,
      ));
    });
  }

  void startAnimation() {
    if (marker0 != null) {
      mapController.startAnimationOnMarker(marker0!);
    }
  }

  void startAllAnimations() {
    for (int i = 0; i <= _markers.length - 1; i++) {
      mapController.startAnimationOnMarker(_markers.elementAt(i));
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/huawei.png')
        .then(_updateBitmap);
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HuaweiMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: _zoom),
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            tiltGesturesEnabled: true,
            buildingsEnabled: true,
            compassEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            trafficEnabled: false,
            markersClusteringEnabled: _markersClustering,
            markers: _markers,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          CustomAppBar(
            title: "Markers",
          ),
          CustomActionBar(
            children: [
              CustomIconButton(
                icon: Icons.add_location,
                tooltip: "Add Markers",
                onPressed: () async {
                  if (_markers.isEmpty)
                    await _createMarkerImageFromAsset(context);
                  _addMarkers();
                },
              ),
              CustomIconButton(
                icon: Icons.brush,
                tooltip: "Change Marker Color",
                onPressed: changeMarkerColor,
              ),
              CustomIconButton(
                icon: Icons.play_arrow,
                tooltip: "Start Animation",
                onPressed: startAnimation,
              ),
              CustomIconButton(
                icon: Icons.fast_forward,
                tooltip: "Start All Animations",
                onPressed: startAllAnimations,
              ),
              CustomIconButton(
                icon: Icons.add_circle_outline,
                tooltip: "Add Cluster Markers",
                onPressed: _addClusterMarkers,
              ),
              CustomIconButton(
                icon: Icons.all_out,
                tooltip: "Cluster",
                onPressed: _markersClusteringButton,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: "Clear Markers",
                onPressed: _clear,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
