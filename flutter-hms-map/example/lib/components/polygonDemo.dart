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

class PolygonDemo extends StatefulWidget {
  @override
  _PolygonDemoState createState() => _PolygonDemoState();
}

class _PolygonDemoState extends State<PolygonDemo> {
  bool _zIndexChanged = false;

  static const LatLng _center = const LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  late HuaweiMapController mapController;
  final Set<Polygon> _polygons = Set<Polygon>();

  Polygon? polygon0;
  Polygon? polygon1;

  List<LatLng> dots1 = [
    LatLng(41.012959, 28.997438),
    LatLng(41.007243, 29.040482),
    LatLng(41.029763, 28.988469)
  ];
  List<LatLng> dots2 = [
    LatLng(40.990743, 29.029218),
    LatLng(41.041527, 29.007200),
    LatLng(41.032397, 29.030850)
  ];

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _addPolygons() {
    polygon0 = Polygon(
        polygonId: PolygonId('polygon_id_0'),
        points: dots1,
        fillColor: Colors.green[500]!,
        strokeColor: Colors.green[900]!,
        strokeWidth: 5,
        zIndex: 2,
        clickable: true,
        onClick: () {
          log("Polygon #0 clicked");
        });

    polygon1 = Polygon(
        polygonId: PolygonId('polygon_id_1'),
        points: dots2,
        fillColor: Colors.yellow[300]!,
        strokeColor: Colors.yellow[900]!,
        zIndex: 1,
        clickable: true,
        onClick: () {
          log("Polygon #1 clicked");
        });

    setState(() {
      _polygons.add(polygon0!);
      _polygons.add(polygon1!);
    });
  }

  void _changeZIndex() {
    if (polygon1 != null && _polygons.isNotEmpty) {
      if (!_zIndexChanged) {
        setState(
          () {
            _polygons.remove(polygon1);
            polygon1 = polygon1!.updateCopy(
              zIndex: 3,
            );
            _polygons.add(polygon1!);
            _zIndexChanged = !_zIndexChanged;
          },
        );
      } else {
        setState(
          () {
            _polygons.remove(polygon1);
            polygon1 = polygon1!.updateCopy(
              zIndex: 1,
            );
            _polygons.add(polygon1!);
            _zIndexChanged = !_zIndexChanged;
          },
        );
      }
    }
  }

  void _clear() {
    setState(() {
      _polygons.clear();
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
            polygons: _polygons,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          CustomAppBar(
            title: "Polygons",
          ),
          CustomActionBar(
            children: [
              CustomIconButton(
                icon: Icons.category,
                tooltip: "Add Polygons",
                onPressed: _addPolygons,
              ),
              CustomIconButton(
                icon: Icons.flip_to_front,
                tooltip: "Change zIndex",
                onPressed: _changeZIndex,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: "Remove Polygons",
                onPressed: _clear,
              ),
            ],
          )
        ],
      ),
    );
  }
}
