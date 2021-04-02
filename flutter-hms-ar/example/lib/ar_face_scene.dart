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

class ArFaceScreen extends StatefulWidget {
  ArFaceScreen({Key key}) : super(key: key);

  @override
  _ArFaceScreenState createState() => _ArFaceScreenState();
}

class _ArFaceScreenState extends State<ArFaceScreen> {
  ARSceneController arSceneController;

  _onSceneCreated(ARSceneController controller) {
    print("ARScene created");
    arSceneController = controller;
    arSceneController.onDetectTrackable =
        (arFace) => _faceDetectCallback(arFace);
  }

  void _faceDetectCallback(ARFace arFace) {
    print("ARFace detected: " + arFace?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.FACE,
          ARSceneFaceConfig(
              pointSize: 5.0,
              depthColor: Colors.amber,
              // Texture will override the color if specified
              // texturePath: "assets/blue_texture.png",
              drawFace: true),
          onArSceneCreated: _onSceneCreated,
        ),
      ),
    );
  }
}
