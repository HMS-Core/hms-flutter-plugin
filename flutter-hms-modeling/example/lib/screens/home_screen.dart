/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_modeling3d_example/screens/image_picking_screen.dart';
import 'package:huawei_modeling3d_example/screens/modeling3d_capture_screen.dart';
import 'package:huawei_modeling3d_example/screens/motion_capture_screen.dart';
import 'package:huawei_modeling3d_example/screens/reconstruction3d_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HMS 3D Modeling Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const ImagePickingScreen();
                  },
                ),
              );
            },
            child: const Text('Material Generation'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const Reconstruction3dScreen();
                  },
                ),
              );
            },
            child: const Text('3D Reconstruction'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const MotionCaptureScreen();
                  },
                ),
              );
            },
            child: const Text('Motion Capture'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const Modeling3dCaptureScreen();
                  },
                ),
              );
            },
            child: const Text('Modeling3D Capture'),
          ),
        ],
      ),
    );
  }
}
