/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ar/ar_engine_library.dart';

class ARWorldScene extends StatefulWidget {
  @override
  _ARWorldSceneState createState() => _ARWorldSceneState();
}

class _ARWorldSceneState extends State<ARWorldScene> {
  ARSceneController arSceneController;

  _onARSceneCreated(ARSceneController controller) {
    arSceneController = controller;
    arSceneController.onDetectTrackable =
        (arPlane) => _onDetectARPlane(arPlane);
  }

  _onDetectARPlane(ARPlane arPlane) {
    print("ARPlane detected: " + arPlane?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.WORLD,
          ARSceneWorldConfig(
              objPath: "assets/bob.obj",
              texturePath: "assets/bob_texture.png",
              // Label customization (Optional)
              colorFloor: Colors.brown,
              colorOther: Colors.red,
              colorTable: Colors.amber,
              colorSeat: Colors.blue,
              colorWall: Colors.green,
              textFloor: "Floor",
              textOther: "Other",
              textSeat: "Seat",
              textTable: "Table",
              textWall: "Wall",
              imageCeiling: "assets/blue_texture.png",
              drawLabel: true),
          onArSceneCreated: _onARSceneCreated,
        ),
      ),
    );
  }
}
