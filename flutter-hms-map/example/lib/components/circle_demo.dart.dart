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

class CircleDemo extends StatefulWidget {
  const CircleDemo({Key? key}) : super(key: key);

  @override
  State<CircleDemo> createState() => _CircleDemoState();
}

class _CircleDemoState extends State<CircleDemo> {
  bool _colorChanged = false;
  bool _strokeChanged = false;
  bool _radiusChanged = false;

  static const LatLng _center = LatLng(41.012959, 28.997438);
  static const double _zoom = 12;

  late HuaweiMapController mapController;
  final Set<Circle> _circles = <Circle>{};

  LatLng circleCenter1 = const LatLng(40.983208, 28.965971);
  LatLng circleCenter2 = const LatLng(41.028675, 29.025234);
  LatLng circleCenter3 = const LatLng(40.851750922225825, 29.31384346110201);

  Circle? circle0;
  Circle? circle1;
  Circle? circle2;

  HmsTranslateAnimation translateAnimation = HmsTranslateAnimation(
    animationId: 'translateAnimation',
    target: const LatLng(41.028675, 29.025234),
  );

  void _onMapCreated(HuaweiMapController controller) {
    mapController = controller;
  }

  void _clear() {
    setState(() {
      _circles.clear();
    });
  }

  void changeColor() {
    if (circle0 != null && _circles.isNotEmpty) {
      if (!_colorChanged) {
        setState(
          () {
            _circles.remove(circle0);
            circle0 = circle0!.updateCopy(
              fillColor: const Color.fromRGBO(100, 200, 0, 0.5),
            );
            _circles.add(circle0!);
            _colorChanged = !_colorChanged;
          },
        );
      } else {
        setState(
          () {
            _circles.remove(circle0);
            circle0 = circle0!.updateCopy(
              fillColor: const Color.fromRGBO(100, 100, 0, 0.3),
            );
            _circles.add(circle0!);
            _colorChanged = !_colorChanged;
          },
        );
      }
    }
  }

  void changeRadius() {
    if (circle0 != null && _circles.isNotEmpty) {
      if (!_radiusChanged) {
        setState(
          () {
            _circles.remove(circle0);
            circle0 = circle0!.updateCopy(radius: 5000);
            _circles.add(circle0!);
            _radiusChanged = !_radiusChanged;
          },
        );
      } else {
        setState(
          () {
            _circles.remove(circle0);
            circle0 = circle0!.updateCopy(radius: 3000);
            _circles.add(circle0!);
            _radiusChanged = !_radiusChanged;
          },
        );
      }
    }
  }

  void _changeStrokes() {
    if (circle1 != null && _circles.isNotEmpty) {
      if (!_strokeChanged) {
        setState(() {
          _circles.remove(circle1);
          circle1 = circle1!.updateCopy(
            strokeColor: Colors.cyan,
            strokeWidth: 6,
          );
          _circles.add(circle1!);
          _strokeChanged = !_strokeChanged;
        });
      } else {
        setState(() {
          _circles.remove(circle1);
          circle1 = circle1!.updateCopy(
            strokeColor: Colors.black,
            strokeWidth: 1,
          );
          _circles.add(circle1!);
          _strokeChanged = !_strokeChanged;
        });
      }
    }
  }

  void _addCircles() {
    circle0 = Circle(
      circleId: const CircleId('circle_id_0'),
      center: circleCenter1,
      radius: 3000,
      fillColor: const Color.fromRGBO(100, 100, 0, 0.3),
      strokeColor: Colors.red,
      strokeWidth: 5,
      zIndex: 2,
      clickable: true,
      onClick: () {
        log('Circle #0 clicked');
      },
    );

    circle1 = Circle(
      circleId: const CircleId('circle_id_1'),
      center: circleCenter2,
      radius: 7000,
      fillColor: const Color.fromARGB(50, 0, 0, 250),
      strokeColor: Colors.black,
      strokeWidth: 1,
      zIndex: 1,
      clickable: true,
      onClick: () {
        log('Circle #1 clicked');
      },
    );

    circle2 = Circle(
      circleId: const CircleId('circle_id_2'),
      center: circleCenter3,
      radius: 3000,
      strokeColor: Colors.black,
      strokeWidth: 1,
      zIndex: 1,
      visible: true,
      clickable: true,
      onClick: () {
        log('Circle #2 clicked');
      },
      animation: translateAnimation,
    );

    setState(() {
      _circles.add(circle0!);
      _circles.add(circle1!);
      _circles.add(circle2!);
    });
  }

  void startAnimation() {
    if (circle2 != null) {
      mapController.startAnimationOnCircle(circle2!);
    }
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
            circles: _circles,
            logoPosition: HuaweiMap.LOWER_LEFT,
            logoPadding: const EdgeInsets.only(
              left: 15,
              bottom: 75,
            ),
          ),
          const CustomAppBar(
            title: 'Circles',
          ),
          CustomActionBar(
            children: <Widget>[
              CustomIconButton(
                icon: Icons.control_point,
                tooltip: 'Add Circles',
                onPressed: _addCircles,
              ),
              CustomIconButton(
                icon: Icons.brush,
                tooltip: 'Change Color',
                onPressed: changeColor,
              ),
              CustomIconButton(
                icon: Icons.hdr_strong,
                tooltip: 'Change Radius',
                onPressed: changeRadius,
              ),
              CustomIconButton(
                icon: Icons.filter_tilt_shift,
                tooltip: 'Change Stroke',
                onPressed: _changeStrokes,
              ),
              CustomIconButton(
                icon: Icons.play_arrow,
                tooltip: 'Start Animation',
                onPressed: startAnimation,
              ),
              CustomIconButton(
                icon: Icons.delete,
                tooltip: 'Clear Circles',
                onPressed: _clear,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
