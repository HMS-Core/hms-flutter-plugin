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

class ArWorldBodyScene extends StatefulWidget {
  const ArWorldBodyScene({Key? key}) : super(key: key);

  @override
  State<ArWorldBodyScene> createState() => _ArWorldBodySceneState();
}

class _ArWorldBodySceneState extends State<ArWorldBodyScene> {
  late ARSceneController arSceneController;

  void _onARSceneCreated(ARSceneController controller) {
    debugPrint('ARScene created');
    arSceneController = controller;
    arSceneController.onDetectTrackable = (dynamic arBody) {
      _onDetectARWorldBody(arBody);
    };
    arSceneController.handleMessageData = (String text) {
      debugPrint('handleMessageData:$text');
    };
  }

  void _onDetectARWorldBody(ARBody arBody) {
    debugPrint('ARWorldBody detected: $arBody');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.WORLD_BODY,
          ARSceneWorldBodyConfig(
            objPath: 'assets/bob.obj',
            texturePath: 'assets/bob_texture.png',
            // Label customization (Optional)
            colorFloor: Colors.brown,
            colorOther: Colors.red,
            colorTable: Colors.amber,
            colorSeat: Colors.blue,
            colorWall: Colors.green,
            colorBed: Colors.cyan,
            colorDoor: Colors.purple,
            colorWindow: Colors.orange,
            textFloor: 'Floor',
            textOther: 'Other',
            textSeat: 'Seat',
            textTable: 'Table',
            textWall: 'Wall',
            textBed: 'Bed',
            textDoor: 'Door',
            textWindow: 'Window',
            imageCeiling: 'assets/blue_texture.png',
            drawLabel: true,
          ),
          onArSceneCreated: _onARSceneCreated,
        ),
      ),
    );
  }
}
