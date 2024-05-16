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

import 'package:huawei_map_example/custom_widgets/custom_app_bar.dart';

class LiteModeDemo extends StatelessWidget {
  LiteModeDemo({Key? key}) : super(key: key);

  final LatLng _center = const LatLng(41.012959, 28.997438);
  final double _zoom = 12;
  final Set<Marker> markers = <Marker>{
    Marker(
      markerId: const MarkerId('marker1'),
      position: const LatLng(41.004529242683585, 28.964250133237044),
      infoWindow: InfoWindow(
        title: 'Marker',
        onClick: () {
          log('InfoWindow clicked');
        },
      ),
      onClick: () {
        log('Marker clicked');
      },
    )
  };
  final Set<Circle> circles = <Circle>{
    Circle(
      circleId: const CircleId('circle1'),
      center: const LatLng(40.99300851276074, 29.049279736702175),
      radius: 4000,
      fillColor: Colors.black38,
      clickable: true,
      onClick: () {
        log('Circle clicked');
      },
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: kToolbarHeight + 8,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 32,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'In the lite mode, the Map SDK allows your app to show the static map image of a specified location at a specified zoom level to a user. The lite mode supports only static image–based functions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'This is the basic Huawei Map that uses the lite mode.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: 200,
                            child: HuaweiMap(
                              liteMode: true,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 3,
                              ),
                              logoPadding: const EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lite Mode also supports onClick and onLongPress callbacks. Try clicking the map below and check your logs.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: 200,
                            child: HuaweiMap(
                              liteMode: true,
                              isDark: true,
                              initialCameraPosition: CameraPosition(
                                target: const LatLng(51.5160895, -0.1294527),
                                zoom: _zoom,
                              ),
                              onClick: (LatLng latLng) {
                                log('Map Clicked at ${latLng.lat} : ${latLng.lng}');
                              },
                              onLongPress: (LatLng latLng) {
                                log('Map LongClicked at ${latLng.lat} : ${latLng.lng}');
                              },
                              logoPadding: const EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'While using the lite mode you may also add markers and shapes to your map and customize them to your preferences. Note that Ground and Tile Overlays are not supported.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: 200,
                            child: HuaweiMap(
                              liteMode: true,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: _zoom,
                              ),
                              markers: markers,
                              circles: circles,
                              logoPadding: const EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const CustomAppBar(title: 'Lite Mode'),
        ],
      ),
    );
  }
}
