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

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:huawei_map/huawei_map.dart';

import 'package:huawei_map_example/custom_widgets/custom_action_bar.dart';
import 'package:huawei_map_example/custom_widgets/custom_app_bar.dart';
import 'package:huawei_map_example/custom_widgets/custom_icon_button.dart';

class GroundOverlayDemo extends StatefulWidget {
  const GroundOverlayDemo({Key? key}) : super(key: key);

  @override
  State<GroundOverlayDemo> createState() => _GroundOverlayDemoState();
}

class _GroundOverlayDemoState extends State<GroundOverlayDemo> {
  bool _transparencyChanged = false;
  bool _sizeChanged = false;

  static const LatLng _center = LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  late HuaweiMapController mapController;
  final Set<GroundOverlay> _groundOverlays = <GroundOverlay>{};

  LatLng position = const LatLng(41.034721, 28.984627);
  LatLng position2 = const LatLng(40.993402, 29.021878);

  GroundOverlay? groundOverlay0;
  GroundOverlay? groundOverlay1;

  late BitmapDescriptor _grounOverlayIcon;

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _addGroundOverlays() {
    groundOverlay0 = GroundOverlay(
      groundOverlayId: const GroundOverlayId('go_1'),
      imageDescriptor: _grounOverlayIcon,
      position: position,
      onClick: () {
        log('Ground Overlay #1 pressed.');
      },
      width: 3000,
      height: 3000,
      anchor: const Offset(0.1, 0.2),
      zIndex: 10.0,
      transparency: 0.5,
      clickable: true,
    );

    groundOverlay1 = GroundOverlay(
      groundOverlayId: const GroundOverlayId('go_2'),
      imageDescriptor: _grounOverlayIcon,
      position: position2,
      width: 1500,
      height: 1500,
      clickable: true,
      onClick: () {
        log('Ground Overlay #2 pressed.');
      },
    );

    setState(() {
      _groundOverlays.add(groundOverlay0!);
      _groundOverlays.add(groundOverlay1!);
    });
  }

  void _changeTransparency() {
    if (groundOverlay0 != null && _groundOverlays.isNotEmpty) {
      if (!_transparencyChanged) {
        setState(
          () {
            _groundOverlays.remove(groundOverlay0);
            groundOverlay0 = groundOverlay0!.updateCopy(transparency: 0);
            _groundOverlays.add(groundOverlay0!);
            _transparencyChanged = !_transparencyChanged;
          },
        );
      } else {
        setState(
          () {
            _groundOverlays.remove(groundOverlay0);
            groundOverlay0 = groundOverlay0!.updateCopy(transparency: 0.5);
            _groundOverlays.add(groundOverlay0!);
            _transparencyChanged = !_transparencyChanged;
          },
        );
      }
    }
  }

  void _changeSize() {
    if (groundOverlay1 != null && _groundOverlays.isNotEmpty) {
      if (!_sizeChanged) {
        setState(
          () {
            _groundOverlays.remove(groundOverlay1);
            groundOverlay1 =
                groundOverlay1!.updateCopy(width: 5000, height: 5000);
            _groundOverlays.add(groundOverlay1!);
            _sizeChanged = !_sizeChanged;
          },
        );
      } else {
        setState(
          () {
            _groundOverlays.remove(groundOverlay1);
            groundOverlay1 =
                groundOverlay1!.updateCopy(width: 1500, height: 1500);
            _groundOverlays.add(groundOverlay1!);
            _sizeChanged = !_sizeChanged;
          },
        );
      }
    }
  }

  void _clear() {
    setState(() {
      _groundOverlays.clear();
    });
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/huawei.png')
        .then(_updateBitmap);
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _grounOverlayIcon = bitmap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HuaweiMap(
            initialCameraPosition:
                const CameraPosition(target: _center, zoom: _zoom),
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
            groundOverlays: _groundOverlays,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: const EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          const CustomAppBar(
            title: 'Ground Overlays',
          ),
          CustomActionBar(
            children: <Widget>[
              CustomIconButton(
                icon: Icons.album,
                tooltip: 'Add Ground Overlays',
                onPressed: () async {
                  if (_groundOverlays.isEmpty) {
                    await _createMarkerImageFromAsset(context);
                  }
                  _addGroundOverlays();
                },
              ),
              CustomIconButton(
                icon: Icons.settings_brightness,
                tooltip: 'Change Transparency',
                onPressed: _changeTransparency,
              ),
              CustomIconButton(
                icon: Icons.zoom_out_map,
                tooltip: 'Change Size',
                onPressed: _changeSize,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: 'Remove Ground Overlays',
                onPressed: _clear,
              )
            ],
          )
        ],
      ),
    );
  }
}
