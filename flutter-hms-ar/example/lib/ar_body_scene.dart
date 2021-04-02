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

class ArBodyScene extends StatefulWidget {
  ArBodyScene({Key key}) : super(key: key);

  @override
  _ArBodySceneState createState() => _ArBodySceneState();
}

class _ArBodySceneState extends State<ArBodyScene> {
  ARSceneController arSceneController;

  _onARSceneCreated(ARSceneController controller) {
    arSceneController = controller;
    arSceneController.onDetectTrackable =
        (arHand) => _bodyDetectCallback(arHand);
  }

  _bodyDetectCallback(ARBody arBody) {
    print("ARBody detected: " + arBody?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.BODY,
          ARSceneBodyConfig(
            drawLine: true,
            drawPoint: true,
            lineWidth: 10.0,
            pointSize: 20.0,
            lineColor: Colors.green,
            pointColor: Colors.amber,
          ),
          onArSceneCreated: _onARSceneCreated,
        ),
      ),
    );
  }
}
