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
import 'package:huawei_map/huawei_map.dart';

import 'package:huawei_map_example/components/circle_demo.dart.dart';
import 'package:huawei_map_example/components/ground_overlay_demo.dart';
import 'package:huawei_map_example/components/marker_demo.dart';
import 'package:huawei_map_example/components/polygon_demo.dart';
import 'package:huawei_map_example/components/polyline_demo.dart';
import 'package:huawei_map_example/components/tile_overlay_demo.dart';
import 'package:huawei_map_example/components/heat_map_demo.dart';
import 'package:huawei_map_example/components/lite_mode_demo.dart';
import 'package:huawei_map_example/custom_widgets/custom_card.dart';
import 'package:huawei_map_example/huawei_map_demo.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Hms Map Flutter Plugin Demo',
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double top = 0.0;
  double distance = 0.0;
  LatLng? convertedLatLng;
  bool hmsLoggerStatus = true;

  @override
  void initState() {
    HuaweiMapInitializer.initializeMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 220.0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/banner2.png',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    background: AnimatedOpacity(
                      opacity: top >= 220 ? 1.0 : 0.2,
                      duration: const Duration(milliseconds: 300),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Huawei Map Kit, provides standard maps as well as UI elements such as markers, shapes, and layers for you to customize maps that better meet service scenarios.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'Huawei Map Flutter Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    collapseMode: CollapseMode.pin,
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    CustomCard(
                      imagePath: 'assets/map.jpg',
                      text: 'Map Options',
                      subText:
                          'Map Listeners, Traffic, Map Type, Camera Animation and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const HuaweiMapDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/marker.jpg',
                      text: 'Markers',
                      subText:
                          'Listeners, Animations, Marker Clustering, Info Windows and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const MarkerDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/circle.jpg',
                      text: 'Circles',
                      subText:
                          'Listeners, Color Settings, Stroke Settings and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const CircleDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/polyline.jpg',
                      text: 'Polylines',
                      subText: 'Listeners, Patterns, Caps and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const PolylineDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/polygon.jpg',
                      text: 'Polygons',
                      subText: 'Listeners, zIndex and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const PolygonDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/groundOverlay.jpg',
                      text: 'Ground Overlays',
                      subText: 'Listeners, Size, Transparency and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const GroundOverlayDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/tileOverlay.jpg',
                      text: 'Tile Overlays',
                      subText: 'Tiles, URL Tiles, Tile Caches and more',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const TileOverlayDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      imagePath: 'assets/heatMap.png',
                      text: 'Heat Maps',
                      subText:
                          'Display the density and distribution of crowd or cars',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const HeatMapDemo(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      text: 'Lite Mode',
                      imagePath: 'assets/liteMode.jpg',
                      textColor: Colors.white,
                      subText: 'Create static map images easily',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => LiteModeDemo(),
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Distance Calculator',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Calculate distance between to coordinate points.',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () async {
                          double? result =
                              await HuaweiMapUtils.distanceCalculator(
                            start: const LatLng(41.048641, 28.977033),
                            end: const LatLng(41.063984, 29.033135),
                          );

                          setState(() {
                            if (result != null) distance = result;
                          });
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        color: const Color.fromRGBO(18, 26, 55, 1),
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        padding: const EdgeInsets.all(12.0),
                        child: const Text('Calculate'),
                      ),
                    ),
                    distance == 0.0
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(distance.toString()),
                          ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Coordinate Converter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        'It converts only WGS84 coordinates in China territory to GCJ02 coordinates.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () async {
                          LatLng result =
                              await HuaweiMapUtils.convertCoordinate(
                            const LatLng(39.902722, 116.391441),
                          );
                          setState(() {
                            convertedLatLng = result;
                          });
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        color: const Color.fromRGBO(18, 26, 55, 1),
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        padding: const EdgeInsets.all(12.0),
                        child: const Text('Convert'),
                      ),
                    ),
                    convertedLatLng == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${convertedLatLng!.lat} : ${convertedLatLng!.lng}',
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      child: Divider(color: Colors.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 18.0,
                      ),
                      child: Text(
                        "This method enables/disables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          if (hmsLoggerStatus) {
                            HuaweiMapUtils.disableLogger();
                            hmsLoggerStatus = false;
                          } else {
                            HuaweiMapUtils.enableLogger();
                            hmsLoggerStatus = true;
                          }
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        color: const Color.fromRGBO(18, 26, 55, 1),
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          'Enable/Disable Logger',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
