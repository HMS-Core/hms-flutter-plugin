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

class LiteModeDemo extends StatelessWidget {
  LiteModeDemo({Key? key}) : super(key: key);

  final LatLng _center = const LatLng(41.012959, 28.997438);

  final double _zoom = 12;

  final Set<Marker> markers = <Marker>{
    Marker(
      markerId: MarkerId("marker1"),
      position: LatLng(41.004529242683585, 28.964250133237044),
      infoWindow: InfoWindow(
        title: "Marker",
        onClick: () {
          log("InfoWindow clicked");
        },
      ),
      onClick: () {
        log("Marker clicked");
      },
    )
  };

  final Set<Circle> circles = <Circle>{
    Circle(
      circleId: CircleId("circle1"),
      center: LatLng(40.99300851276074, 29.049279736702175),
      radius: 4000,
      fillColor: Colors.black38,
      clickable: true,
      onClick: () {
        log("Circle clicked");
      },
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: kToolbarHeight + 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "In the lite mode, the Map SDK allows your app to show the static map image of a specified location at a specified zoom level to a user. The lite mode supports only static image–based functions.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "This is the basic Huawei Map that uses the lite mode.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 200,
                          child: HuaweiMap(
                            liteMode: true,
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 3,
                            ),
                            logoPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Lite Mode also supports onClick and onLongPress callbacks. Try clicking the map below and check your logs.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 200,
                          child: HuaweiMap(
                            liteMode: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(51.5160895, -0.1294527),
                              zoom: _zoom,
                            ),
                            onClick: (LatLng latLng) {
                              log("Map Clicked at ${latLng.lat} : ${latLng.lng}");
                            },
                            onLongPress: (LatLng latLng) {
                              log("Map LongClicked at ${latLng.lat} : ${latLng.lng}");
                            },
                            logoPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "While using the lite mode you may also add markers and shapes to your map and customize them to your preferences. Note that Ground and Tile Overlays are not supported.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 200,
                          child: HuaweiMap(
                            liteMode: true,
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: _zoom,
                            ),
                            markers: markers,
                            circles: circles,
                            logoPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        CustomAppBar(title: "Lite Mode"),
      ],
    ));
  }
}
