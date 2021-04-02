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

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:huawei_map/map.dart';
import 'customWidgets/customWidgets.dart';

class HuaweiMapDemo extends StatefulWidget {
  @override
  _HuaweiMapDemoState createState() => _HuaweiMapDemoState();
}

class _HuaweiMapDemoState extends State<HuaweiMapDemo> {
  static const LatLng _center = const LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  HuaweiMapController mapController;

  bool _cameraPosChanged = false;
  MapType _currentMapType = MapType.normal;
  bool _trafficEnabled = false;

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _moveCameraButtonPressed() {
    if (!_cameraPosChanged) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            bearing: 270.0,
            target: LatLng(51.5160895, -0.1294527),
            tilt: 45.0,
            zoom: 17.0,
          ),
        ),
      );
      _cameraPosChanged = !_cameraPosChanged;
    } else {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            bearing: 0.0,
            target: _center,
            tilt: 0.0,
            zoom: 12.0,
          ),
        ),
      );
      _cameraPosChanged = !_cameraPosChanged;
    }
  }

  void _mapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.none : MapType.normal;
    });
  }

  void _trafficButtonPressed() {
    if (_trafficEnabled) {
      setState(() {
        _trafficEnabled = false;
      });
    } else {
      setState(() {
        _trafficEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        HuaweiMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: _zoom),
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            tiltGesturesEnabled: true,
            buildingsEnabled: true,
            compassEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            trafficEnabled: _trafficEnabled,
            onClick: (LatLng latLng) {
              log("Map Clicked at ${latLng.lat} : ${latLng.lng}");
            },
            onLongPress: (LatLng latLng) {
              log("Map LongClicked at ${latLng.lat} : ${latLng.lng}");
            },
            onCameraMove: (CameraPosition pos) {
              log("onCameraMove: ${pos.target.lat} : ${pos.target.lng}");
            },
            onCameraIdle: () {
              log("onCameraIdle");
            },
            onCameraMoveStarted: () {
              log("onCameraMoveStarted");
            }),
        CustomAppBar(
          title: "Huawei Map Options",
        ),
        CustomActionBar(children: [
          CustomIconButton(
              icon: Icons.map,
              tooltip: "Map Type",
              onPressed: _mapTypeButtonPressed),
          CustomIconButton(
              icon: Icons.traffic,
              tooltip: "Traffic",
              onPressed: _trafficButtonPressed),
          CustomIconButton(
            icon: Icons.adjust,
            tooltip: "Move Camera",
            onPressed: _moveCameraButtonPressed,
          ),
        ])
      ],
    ));
  }
}
