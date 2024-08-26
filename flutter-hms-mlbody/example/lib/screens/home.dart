/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_body_example/screens/face_3d_example.dart';
import 'package:huawei_ml_body_example/screens/face_example.dart';
import 'package:huawei_ml_body_example/screens/gesture_example.dart';
import 'package:huawei_ml_body_example/screens/hand_example.dart';
import 'package:huawei_ml_body_example/screens/interactive_liveness_example.dart';
import 'package:huawei_ml_body_example/screens/lens_example.dart';
import 'package:huawei_ml_body_example/screens/liveness_example.dart';
import 'package:huawei_ml_body_example/screens/skeleton_example.dart';
import 'package:huawei_ml_body_example/screens/verification_example.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('ML Body Demo'),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const <Widget>[
          CustomGridElement(
            name: 'Face\nDetection',
            imagePath: 'face',
            page: FaceExample(),
          ),
          CustomGridElement(
            name: 'Face 3D\nDetection',
            imagePath: 'face',
            page: Face3dExample(),
          ),
          CustomGridElement(
            name: 'Face\nVerification',
            imagePath: 'face',
            page: VerificationExample(),
          ),
          CustomGridElement(
            name: 'Skeleton\nDetection',
            imagePath: 'skeleton',
            page: SkeletonExample(),
          ),
          CustomGridElement(
            name: 'Liveness\nDetection',
            imagePath: 'liveness',
            page: LivenessExample(),
          ),
          CustomGridElement(
            name: 'Interactive Liveness\nDetection',
            imagePath: 'liveness',
            page: InteractiveLivenessExample(),
          ),
          CustomGridElement(
            name: 'Hand Keypoint\nDetection',
            imagePath: 'handkey',
            page: HandExample(),
          ),
          CustomGridElement(
            name: 'Hand Gesture\nDetection',
            imagePath: 'handkey',
            page: GestureExample(),
          ),
          CustomGridElement(
            name: 'Body Lens\nExample',
            imagePath: 'face',
            page: LensExample(),
          ),
        ],
      ),
    );
  }
}
