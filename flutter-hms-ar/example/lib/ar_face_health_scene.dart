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

class ArFaceHealthScreen extends StatefulWidget {
  const ArFaceHealthScreen({Key? key}) : super(key: key);

  @override
  State<ArFaceHealthScreen> createState() => _ArFaceHealthScreenState();
}

class _ArFaceHealthScreenState extends State<ArFaceHealthScreen> {
  late ARSceneController arSceneController;
  String detectionResult = '';
  bool _showResult = false;

  void _onSceneCreated(ARSceneController controller) {
    debugPrint('ARScene created');
    arSceneController = controller;
    arSceneController.onDetectTrackable = (dynamic arFace) {
      _faceDetectCallback(arFace);
    };
    arSceneController.handleMessageData = (String text) {
      debugPrint('handleMessageData: $text');
    };
    arSceneController.handleResult = (String healthResult) {
      setState(() {
        detectionResult = healthResult;
      });
      debugPrint('handleFaceHealthResult: $healthResult');
    };
  }

  void _faceDetectCallback(ARFace arFace) {
    debugPrint('ARFace detected: $arFace');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AREngineScene(
              ARSceneType.FACE,
              ARSceneFaceConfig(
                enableHealthDevice: true,
              ),
              onArSceneCreated: _onSceneCreated,
            ),
            Align(
              alignment: Alignment(0.01, 0.5),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showResult = !_showResult;
                  });
                },
                child: Text("${_showResult ? "Hide" : "Show"} Result"),
              ),
            ),
            _showResult
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        detectionResult,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
