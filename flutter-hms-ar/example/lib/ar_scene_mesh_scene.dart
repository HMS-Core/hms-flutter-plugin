/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ar/huawei_ar.dart';

class ArSceneMeshScene extends StatefulWidget {
  const ArSceneMeshScene({Key? key}) : super(key: key);

  @override
  State<ArSceneMeshScene> createState() => _ArSceneMeshSceneState();
}

class _ArSceneMeshSceneState extends State<ArSceneMeshScene> {
  late ARSceneController arSceneController;

  void _onARSceneCreated(ARSceneController controller) {
    debugPrint('ARScene created');
    arSceneController = controller;
    arSceneController.handleMessageData = (String text) {
      debugPrint('handleMessageData:$text');
    };
    arSceneController.sceneMeshDrawFrame = (ARSceneMesh arSceneMesh) {
      debugPrint('sceneMeshDrawFrame: $arSceneMesh');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.SCENE_MESH,
          ARSceneMeshConfig(
            objPath: 'assets/blub.obj',
            texturePath: 'assets/blub_texture.png',
          ),
          onArSceneCreated: _onARSceneCreated,
        ),
      ),
    );
  }
}
