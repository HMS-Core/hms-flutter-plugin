/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class LandmarkExample extends StatefulWidget {
  @override
  _LandmarkExampleState createState() => _LandmarkExampleState();
}

class _LandmarkExampleState extends State<LandmarkExample> {
  final _key = GlobalKey<ScaffoldState>();

  late MLLandmarkAnalyzer _analyzer;
  List _names = [];
  List _possibilities = [];

  @override
  void initState() {
    _analyzer = MLLandmarkAnalyzer();
    _setApiKey();
    super.initState();
  }

  _setApiKey() {
    MLImageApplication().setApiKey(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Landmark Recognition Demo"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultBox(landmarkNames, _names, context),
            Container(
              color: kGrayColor,
              margin: context.paddingLow,
              width: context.highValue,
              height: context.highValue,
              child: Image.asset(landmarkImage),
            ),
            resultBox(possibility, _possibilities, context),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _startRecognition,
                  child: Text(startAsyncClassificationText),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: _stopRecognition,
                  child: Text(stopText),
                )),
          ],
        ),
      ),
    );
  }

  _startRecognition() async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting = MLLandmarkAnalyzerSetting.create(path: pickedImagePath);
      try {
        List<MLRemoteLandmark> list =
            await _analyzer.asyncAnalyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _names.add(element.landmark);
            _possibilities.add(element.possibility);
          });
        });
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  _stopRecognition() async {
    try {
      await _analyzer.stopLandmarkDetection();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
