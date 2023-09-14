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
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class LandmarkExample extends StatefulWidget {
  const LandmarkExample({Key? key}) : super(key: key);

  @override
  State<LandmarkExample> createState() => _LandmarkExampleState();
}

class _LandmarkExampleState extends State<LandmarkExample> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final MLLandmarkAnalyzer _analyzer = MLLandmarkAnalyzer();
  final List<String?> _names = <String?>[];
  final List<dynamic> _possibilities = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Landmark Recognition Demo'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            resultBox(
              landmarkNames,
              _names,
              context,
            ),
            Container(
              color: kGrayColor,
              margin: context.paddingLow,
              width: context.highValue,
              height: context.highValue,
              child: Image.asset(landmarkImage),
            ),
            resultBox(
              possibility,
              _possibilities,
              context,
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: _startRecognition,
                child: const Text(startAsyncClassificationText),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: dangerbuttonStyle,
                onPressed: _stopRecognition,
                child: const Text(stopText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startRecognition() async {
    try {
      final String? pickedImagePath = await getImage(ImageSource.gallery);

      if (pickedImagePath != null) {
        final MLLandmarkAnalyzerSetting setting =
            MLLandmarkAnalyzerSetting.create(
          path: pickedImagePath,
        );
        final List<MLRemoteLandmark> list =
            await _analyzer.asyncAnalyseFrame(setting);
        for (MLRemoteLandmark element in list) {
          setState(() {
            _names.add(element.landmark);
            _possibilities.add(element.possibility);
          });
        }
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  Future<void> _stopRecognition() async {
    try {
      await _analyzer.stopLandmarkDetection();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}
