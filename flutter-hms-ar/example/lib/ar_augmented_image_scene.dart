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

class ArAugmentedImageScene extends StatefulWidget {
  const ArAugmentedImageScene({Key? key}) : super(key: key);

  @override
  State<ArAugmentedImageScene> createState() => _ArAugmentedImageSceneState();
}

class _ArAugmentedImageSceneState extends State<ArAugmentedImageScene> {
  late ARSceneController arSceneController;

  void _onARSceneCreated(ARSceneController controller) {
    debugPrint('ARScene created');
    arSceneController = controller;
    arSceneController.onDetectTrackable = (dynamic arAugmentedImage) {
      _augmentedImageDetectCallback(arAugmentedImage);
    };
    arSceneController.handleMessageData = (String text) {
      debugPrint('handleMessageData:$text');
    };
  }

  void _augmentedImageDetectCallback(ARAugmentdImage arAugmentedImage) {
    debugPrint('ARAugmentdImage detected: $arAugmentedImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AREngineScene(
          ARSceneType.AUGMENTED_IMAGE,
          ARSceneAugmentedImageConfig(
            augmentedImage: AugmentedImage(
              imgFileFromAsset: 'assets/image_default.png',
              widthInMeters: 0,
              imgName: 'Tech Park',
            ),
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
