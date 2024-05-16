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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_map/huawei_map.dart';

import 'package:huawei_map_example/custom_widgets/custom_action_bar.dart';
import 'package:huawei_map_example/custom_widgets/custom_app_bar.dart';
import 'package:huawei_map_example/custom_widgets/custom_icon_button.dart';

class HeatMapDemo extends StatefulWidget {
  const HeatMapDemo({Key? key}) : super(key: key);

  @override
  State<HeatMapDemo> createState() => _HeatMapDemoState();
}

class _HeatMapDemoState extends State<HeatMapDemo> {
  bool _opacityChanged = false;

  static const LatLng _center = LatLng(37.539251279546605, -137.10494751391218);
  static const double _zoom = 3;

  late HuaweiMapController mapController;

  late String _dataSet;
  final Set<HeatMap> _heatMaps = <HeatMap>{};

  HeatMap? heatMap0;
  HeatMap? heatMap1;

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  Future<void> readJson() async {
    await rootBundle
        .loadString('assets/earthquakes_with_usa.json')
        .then(_updateDataSet);
  }

  void _updateDataSet(String dataSet) {
    setState(() {
      _dataSet = dataSet;
    });
  }

  void _addHeatMaps() {
    heatMap0 = HeatMap(
      heatMapId: const HeatMapId('heat_map_id_0'),
      dataSet: _dataSet,
      visible: true,
      radiusUnit: RadiusUnit.pixel,
      color: <double, Color>{
        0: Colors.transparent,
        0.4: Colors.white,
        1.0: Colors.red,
      },
    );

    setState(() {
      _heatMaps.add(heatMap0!);
    });
  }

  void _changeOpacity() {
    if (heatMap0 != null && _heatMaps.isNotEmpty) {
      if (!_opacityChanged) {
        setState(() {
          _heatMaps.remove(heatMap0);
          heatMap0 = heatMap0!.updateCopy(
            dataSet: _dataSet,
            opacityMap: <double, double>{
              3: 0.6,
              4: 0.5,
              5: 0.0,
            },
          );
          _heatMaps.add(heatMap0!);
          _opacityChanged = !_opacityChanged;
        });
      } else {
        setState(() {
          _heatMaps.remove(heatMap0);
          heatMap0 = heatMap0!.updateCopy(
            opacityMap: <double, double>{
              3: 0,
            },
          );
          _heatMaps.add(heatMap0!);
          _opacityChanged = !_opacityChanged;
        });
      }
    }
  }

  void _clear() {
    setState(() {
      _heatMaps.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HuaweiMap(
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: _zoom,
            ),
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
            heatMaps: _heatMaps,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: const EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          const CustomAppBar(
            title: 'Heat Maps',
          ),
          CustomActionBar(
            children: <Widget>[
              CustomIconButton(
                icon: Icons.category,
                tooltip: 'Add Heat Maps',
                onPressed: () async {
                  if (_heatMaps.isEmpty) await readJson();
                  _addHeatMaps();
                },
              ),
              CustomIconButton(
                icon: Icons.flip_to_front,
                tooltip: 'Change Opacity',
                onPressed: _changeOpacity,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: 'Remove Heat Maps',
                onPressed: _clear,
              ),
            ],
          )
        ],
      ),
    );
  }
}
