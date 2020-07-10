/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huawei_map/map.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HuaweiMapController mapController;

  static const LatLng _center = const LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final Set<Polygon> _polygons = {};
  final Set<Circle> _circles = {};

  bool _cameraPosChanged = false;

  bool _trafficEnabled = true;
  MapType _currentMapType = MapType.normal;
  BitmapDescriptor _markerIcon;

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _mapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.none : MapType.normal;
    });
  }

  void _clear() {
    setState(() {
      _markers.clear();
      _polylines.clear();
      _polygons.clear();
      _circles.clear();
    });
  }

  void log(msg) {
    print(msg);
  }

  void _markersButtonPressed() {
    if (_markers.length > 0) {
      setState(() {
        _markers.clear();
      });
    } else {
      Marker marker1;
      marker1 = new Marker(
        markerId: MarkerId('marker_id_0'),
        position: LatLng(41.012959, 28.997438),
        infoWindow: InfoWindow(
          title: 'Marker Title #0',
          snippet: 'Marker Desc #0',
        ),
        clickable: false,
        onClick: () {
          log('marker #0 clicked');
        },
        icon: BitmapDescriptor.defaultMarker,
      );
      marker1 = marker1.updateCopy(
          infoWindow: InfoWindow(
            title: 'Marker #0 Title',
            snippet: 'Marker #0 Desc',
          ),
          rotation: 45);

      setState(() {
        _markers.add(marker1);
        _markers.add(Marker(
          markerId: MarkerId('marker_id_1'),
          position: LatLng(41.002919, 28.980701),
          infoWindow: InfoWindow(
              title: 'Marker Title #1',
              snippet: 'Marker Desc #1',
              onClick: () {
                log("infoWindow clicked");
              }),
          onClick: () {
            log('marker #1 clicked');
          },
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ));
        _markers.add(Marker(
          markerId: MarkerId('marker_id_2'),
          position: LatLng(41.070978, 29.037736),
          draggable: true,
          flat: true,
          rotation: 0.0,
          infoWindow: InfoWindow(
            title: 'Marker Title #2',
            snippet: 'Marker Desc #2',
          ),
          clickable: true,
          onClick: () {
            log('marker #2 clicked');
          },
          onDragEnd: (pos) {
            log("marker #2 dragEnd : ${pos.lat}:${pos.lng}");
          },
          icon: _markerIcon,
        ));
        _markers.add(Marker(
          markerId: MarkerId('marker_id_3'),
          position: LatLng(41.057000, 29.090822),
          infoWindow: InfoWindow(
              title: 'Marker Title #3',
              snippet: 'Marker Desc #3',
              onClick: () {
                log("infoWindow clicked");
              }),
          onClick: () {
            log('marker #3 clicked');
          },
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    }
  }

  void _polygonsButtonPressed() {
    if (_polygons.length > 0) {
      setState(() {
        _polygons.clear();
      });
    } else {
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

      setState(() {
        _polygons.add(Polygon(
            polygonId: PolygonId('polygon_id_0'),
            points: dots1,
            fillColor: Colors.green[500],
            strokeColor: Colors.green[900],
            strokeWidth: 5,
            zIndex: 2,
            clickable: true,
            onClick: () {
              log("Polygon #0 clicked");
            }));
        _polygons.add(Polygon(
            polygonId: PolygonId('polygon_id_1'),
            points: dots2,
            fillColor: Colors.yellow[300],
            strokeColor: Colors.yellow[900],
            zIndex: 1,
            clickable: true,
            onClick: () {
              log("Polygon #1 clicked");
            }));
      });
    }
  }

  void _polylinesButtonPressed() {
    if (_polylines.length > 0) {
      setState(() {
        _polylines.clear();
      });
    } else {
      List<LatLng> dots1 = [
        LatLng(41.003285, 28.954506),
        LatLng(40.998218, 29.031455),
      ];
      List<LatLng> dots2 = [
        LatLng(41.037612, 28.984190),
        LatLng(40.987348, 28.988519),
      ];

      setState(() {
        _polylines.add(Polyline(
            polylineId: PolylineId('polyline_id_0'),
            points: dots1,
            color: Colors.green[900],
            zIndex: 2,
            clickable: true,
            onClick: () {
              log("Polyline #0 clicked");
            }));
        _polylines.add(Polyline(
            polylineId: PolylineId('polyline_id_1'),
            points: dots2,
            width: 2,
            patterns: [PatternItem.dot, PatternItem.gap(10.0)],
            endCap: Cap.roundCap,
            startCap: Cap.squareCap,
            color: Colors.yellow[900],
            zIndex: 1,
            clickable: true,
            onClick: () {
              log("Polyline #1 clicked");
            }));
      });
    }
  }

  void _circlesButtonPressed() {
    if (_circles.length > 0) {
      setState(() {
        _circles.clear();
      });
    } else {
      LatLng dot1 = LatLng(41.008552, 29.058577);
      LatLng dot2 = LatLng(41.028682, 29.115737);

      setState(() {
        _circles.add(Circle(
            circleId: CircleId('circle_id_0'),
            center: dot1,
            radius: 3000,
            fillColor: Color.fromARGB(100, 100, 100, 0),
            strokeColor: Colors.red,
            strokeWidth: 5,
            zIndex: 2,
            clickable: true,
            onClick: () {
              log("Circle #0 clicked");
            }));
        _circles.add(Circle(
            circleId: CircleId('circle_id_1'),
            center: dot2,
            zIndex: 1,
            clickable: true,
            onClick: () {
              log("Circle #1 clicked");
            },
            radius: 7000,
            fillColor: Color.fromARGB(50, 0, 0, 250)));
      });
    }
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
    _createMarkerImageFromAsset(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter HMS Map Example'),
          backgroundColor: Colors.red[900],
        ),
        body: Stack(
          children: <Widget>[
            HuaweiMap(
                onMapCreated: _onMapCreated,
                onClick: (LatLng latLng) {
                  log("Map Clicked at $latLng");
                },
                onLongPress: (LatLng latlng) {
                  log("Map LongClicked at $latlng");
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: _zoom,
                ),
                mapType: _currentMapType,
                tiltGesturesEnabled: true,
                buildingsEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: false,
                rotateGesturesEnabled: true,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                trafficEnabled: _trafficEnabled,
                markers: _markers,
                polylines: _polylines,
                polygons: _polygons,
                circles: _circles,
                onCameraMove: (CameraPosition pos) => {
                      print(
                          "onCameraMove: ${pos.target.lat} : ${pos.target.lng}")
                    },
                onCameraIdle: () {
                  print("onCameraIdle");
                },
                onCameraMoveStarted: () {
                  print("onCameraMoveStarted");
                }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: _mapTypeButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Map Type",
                        child: const Icon(Icons.map, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: _markersButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Markers",
                        child: const Icon(Icons.add_location, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: _circlesButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Circles",
                        child: const Icon(Icons.adjust, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: _polylinesButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Polylines",
                        child: const Icon(Icons.border_style, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: _polygonsButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Polygons",
                        child: const Icon(Icons.crop_square, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () => _clear(),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Clear",
                        child: const Icon(Icons.delete_outline, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () => _moveCameraButtonPressed(),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "CameraMove",
                        child:
                            const Icon(Icons.airplanemode_active, size: 36.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () => _trafficButtonPressed(),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red[800],
                        tooltip: "Traffic",
                        child: const Icon(Icons.traffic, size: 36.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/huawei.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }
}
