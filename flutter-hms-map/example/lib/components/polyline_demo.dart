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

class PolylineDemo extends StatefulWidget {
  const PolylineDemo({Key? key}) : super(key: key);

  @override
  State<PolylineDemo> createState() => _PolylineDemoState();
}

class _PolylineDemoState extends State<PolylineDemo> {
  bool _patternChanged = false;

  static const LatLng _center = LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  late HuaweiMapController mapController;
  final Set<Polyline> _polylines = <Polyline>{};

  List<LatLng> dots1 = <LatLng>[
    const LatLng(41.003285, 28.954506),
    const LatLng(40.998218, 29.031455),
  ];
  List<LatLng> dots2 = <LatLng>[
    const LatLng(41.037612, 28.984190),
    const LatLng(40.987348, 28.988519),
  ];

  Polyline? polyline0;
  Polyline? polyline1;

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _addPolylines() {
    polyline0 = Polyline(
      polylineId: const PolylineId('polyline_id_0'),
      points: dots1,
      patterns: <PatternItem>[
        PatternItem.dot,
        PatternItem.gap(10.0),
      ],
      color: Colors.green[900]!,
      zIndex: 2,
      clickable: true,
      onClick: () {
        log('Polyline #0 clicked');
      },
    );

    polyline1 = Polyline(
      polylineId: const PolylineId('polyline_id_1'),
      points: dots2,
      width: 2,
      endCap: Cap.roundCap,
      startCap: Cap.squareCap,
      color: Colors.yellow[900]!,
      zIndex: 1,
      clickable: true,
      onClick: () {
        log('Polyline #1 clicked');
      },
      gradient: true,
      colorValues: <Color>[
        Colors.red,
        Colors.green,
        Colors.black,
      ],
    );

    setState(() {
      _polylines.add(polyline0!);
      _polylines.add(polyline1!);
    });
  }

  void _changePattern() {
    if (polyline0 != null && _polylines.isNotEmpty) {
      if (!_patternChanged) {
        setState(() {
          _polylines.remove(polyline0);
          polyline0 = polyline0!.updateCopy(
            patterns: <PatternItem>[
              PatternItem.dash(100),
              PatternItem.gap(30.0)
            ],
          );
          _polylines.add(polyline0!);
          _patternChanged = !_patternChanged;
        });
      } else {
        setState(() {
          _polylines.remove(polyline0);
          polyline0 = polyline0!.updateCopy(
            patterns: <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
          );
          _polylines.add(polyline0!);
          _patternChanged = !_patternChanged;
        });
      }
    }
  }

  void _changeCaps() {
    if (polyline1 != null && _polylines.isNotEmpty) {
      if (!_patternChanged) {
        setState(() {
          _polylines.remove(polyline1);
          polyline1 = polyline1!.updateCopy(
            endCap: Cap.buttCap,
            startCap: Cap.roundCap,
          );
          _polylines.add(polyline1!);
          _patternChanged = !_patternChanged;
        });
      } else {
        setState(() {
          _polylines.remove(polyline1);
          polyline1 = polyline1!.updateCopy(
            endCap: Cap.roundCap,
            startCap: Cap.squareCap,
          );
          _polylines.add(polyline1!);
          _patternChanged = !_patternChanged;
        });
      }
    }
  }

  void _clear() {
    setState(() {
      _polylines.clear();
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
            polylines: _polylines,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: const EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          const CustomAppBar(
            title: 'Polylines',
          ),
          CustomActionBar(
            children: <Widget>[
              CustomIconButton(
                icon: Icons.timeline,
                tooltip: 'Add Polylines',
                onPressed: _addPolylines,
              ),
              CustomIconButton(
                icon: Icons.toll,
                tooltip: 'Change Pattern',
                onPressed: _changePattern,
              ),
              CustomIconButton(
                icon: Icons.fiber_smart_record,
                tooltip: 'Change Caps',
                onPressed: _changeCaps,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: 'Clear Polylines',
                onPressed: _clear,
              ),
            ],
          )
        ],
      ),
    );
  }
}
