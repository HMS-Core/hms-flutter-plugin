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

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_map/map.dart';
import '../customWidgets/customWidgets.dart';

class TileOverlayDemo extends StatefulWidget {
  @override
  _TileOverlayDemoState createState() => _TileOverlayDemoState();
}

class _TileOverlayDemoState extends State<TileOverlayDemo> {
  bool _fadeInChanged = false;

  static const LatLng _center = const LatLng(41.012959, 28.997438);
  static const double _zoom = 3;

  late HuaweiMapController mapController;
  Set<TileOverlay> _tileOverlays = Set<TileOverlay>();

  TileOverlay? tileOverlay;
  TileOverlay? urlTileOverlay;
  TileOverlay? repetitiveTileOverlay;

  late Uint8List imageData;

  @override
  void initState() {
    loadAsset("assets/huawei.png");
    super.initState();
  }

  void loadAsset(String path) async {
    await rootBundle.load(path).then((data) => setState(() {
          this.imageData = data.buffer.asUint8List();
        }));
  }

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _addTileOverlays() {
    tileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId("tile"),
      tileProvider: [
        Tile(
          x: 4,
          y: 2,
          zoom: 3,
          imageData: imageData,
        ),
        Tile(
          x: 4,
          y: 3,
          zoom: 3,
          imageData: imageData,
        ),
      ],
      fadeIn: true,
      transparency: 0.5,
      visible: true,
      zIndex: 2,
    );

    repetitiveTileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId("repetitiveTileOverlay"),
      tileProvider: RepetitiveTile(
        zoom: [4, 5],
        imageData: imageData,
      ),
      fadeIn: true,
      transparency: 0.5,
      visible: true,
      zIndex: 2,
    );

    urlTileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId("urlTileOverlay"),
      tileProvider:
          UrlTile(uri: "https://a.tile.openstreetmap.de/{z}/{x}/{y}.png"),
      fadeIn: true,
      transparency: 0,
      visible: true,
      zIndex: 1,
    );

    setState(() {
      _tileOverlays.add(tileOverlay!);
      _tileOverlays.add(repetitiveTileOverlay!);
      _tileOverlays.add(urlTileOverlay!);
    });
  }

  void _clearTileCaches() {
    if (_tileOverlays.isNotEmpty) {
      for (int i = 0; i <= _tileOverlays.length - 1; i++) {
        mapController.clearTileCache(_tileOverlays.elementAt(i));
      }
    }
  }

  void _changeFadeIn() {
    if (tileOverlay != null && _tileOverlays.isNotEmpty) {
      if (!_fadeInChanged) {
        setState(
          () {
            _tileOverlays.remove(tileOverlay);
            tileOverlay = tileOverlay!.updateCopy(fadeIn: false);
            _tileOverlays.add(tileOverlay!);
            _fadeInChanged = !_fadeInChanged;
          },
        );
      } else {
        setState(
          () {
            _tileOverlays.remove(tileOverlay);
            tileOverlay = tileOverlay!.updateCopy(fadeIn: true);
            _tileOverlays.add(tileOverlay!);
            _fadeInChanged = !_fadeInChanged;
          },
        );
      }
    }
  }

  void _clear() {
    setState(() {
      _tileOverlays.clear();
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
            tileOverlays: _tileOverlays,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          CustomAppBar(
            title: "Tile Overlays",
          ),
          CustomActionBar(
            children: [
              CustomIconButton(
                icon: Icons.view_module,
                tooltip: "Add Tile Overlays",
                onPressed: _addTileOverlays,
              ),
              CustomIconButton(
                icon: Icons.cached,
                tooltip: "Clear Tile Cache",
                onPressed: _clearTileCaches,
              ),
              CustomIconButton(
                icon: Icons.texture,
                tooltip: "Change fadeIn",
                onPressed: _changeFadeIn,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: "Clear Tile Overlays",
                onPressed: _clear,
              )
            ],
          )
        ],
      ),
    );
  }
}
