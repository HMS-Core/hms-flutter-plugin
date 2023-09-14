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

class SceneExample extends StatefulWidget {
  const SceneExample({Key? key}) : super(key: key);

  @override
  State<SceneExample> createState() => _SceneExampleState();
}

class _SceneExampleState extends State<SceneExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final MLSceneDetectionAnalyzer _analyzer = MLSceneDetectionAnalyzer();
  final List<String?> _results = <String?>[];
  final List<dynamic> _confidences = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Scene Detection Demo'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            resultBox(sceneDetectionResults, _results, context),
            Container(
              color: kGrayColor,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: context.width * 0.3,
              height: context.width * 0.3,
              child: Image.asset(
                sceneImage,
              ),
            ),
            resultBox(
              confidences,
              _confidences,
              context,
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  pickerDialog(
                    _key,
                    context,
                    analyseFrame,
                  );
                },
                child: const Text(startSceneDetection),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  pickerDialog(
                    _key,
                    context,
                    asyncAnalyseFrame,
                  );
                },
                child: const Text(startAsyncSceneDetection),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: dangerbuttonStyle,
                onPressed: stop,
                child: const Text(stopText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> analyseFrame(String? path) async {
    try {
      if (path != null) {
        final MLSceneDetectionAnalyzerSetting setting =
            MLSceneDetectionAnalyzerSetting.create(
          path: path,
        );
        final List<MLSceneDetection> list =
            await _analyzer.analyseFrame(setting);
        for (MLSceneDetection element in list) {
          setState(() {
            _results.add(element.result);
            _confidences.add(element.confidence);
          });
        }
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  @override
  Future<void> asyncAnalyseFrame(String? path) async {
    try {
      if (path != null) {
        final MLSceneDetectionAnalyzerSetting setting =
            MLSceneDetectionAnalyzerSetting.create(
          path: path,
        );
        final List<MLSceneDetection> list =
            await _analyzer.asyncAnalyseFrame(setting);
        for (MLSceneDetection element in list) {
          setState(() {
            _results.add(element.result);
            _confidences.add(element.confidence);
          });
        }
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _analyzer.stop();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}
