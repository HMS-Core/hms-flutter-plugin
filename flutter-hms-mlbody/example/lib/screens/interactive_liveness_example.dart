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
import 'package:huawei_ml_body/huawei_ml_body.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';

class InteractiveLivenessExample extends StatefulWidget {
  const InteractiveLivenessExample({Key? key}) : super(key: key);

  @override
  State<InteractiveLivenessExample> createState() =>
      _InteractiveLivenessExampleState();
}

class _InteractiveLivenessExampleState
    extends State<InteractiveLivenessExample> {
  late MLInteractiveLivenessCapture _capture;
  late MLCustomInteractiveLivenessDetectionAnalyzer _customInteractive;
  final List<MLInteractiveLivenessCaptureResult> _events =
      <MLInteractiveLivenessCaptureResult>[];

  @override
  void initState() {
    super.initState();
    _capture = MLInteractiveLivenessCapture();
    _customInteractive = MLCustomInteractiveLivenessDetectionAnalyzer();
  }

  void _startRecognition() async {
    try {
      _events.clear();
      final Stream<MLInteractiveLivenessCaptureResult> listener =
          await _capture.startDetect();
      listener.listen((MLInteractiveLivenessCaptureResult result) {
        setState(() {
          _events.add(result);
        });
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _customView() async {
    try {
      MLCustomInteractiveLivenessDetectionSetting setting =
          MLCustomInteractiveLivenessDetectionSetting(
              showStatusCodes: true,
              statusCodes: {
                1001:
                    "The face orientation is inconsistent with that of the phone.",
                1002: "No face is detected.",
                1003: "Multiple faces are detected.",
                1004: "The face deviates from the center of the face frame.",
                1005: "The face is too large.",
                1006: "The face is too small.",
                1007: "The face is blocked by the sunglasses.",
                1008: "The face is blocked by the mask.",
                1009: "The detected action is not the required one.",
                1014: "The continuity detection fails.",
                1018: "The light is dark.",
                1019: "The image is blurry.",
                1020: "The face is backlit.",
                1021: "The light is bright.",
                2000: "In progress",
                2002: "The face does not belong to a real person. ",
                2003:
                    "Verification is performed: and the detected action is correct.",
                2004: "Verification succeeded.",
                2007:
                    "The position of the face frame is not set before the algorithm is called.",
                5020: "The previous detection ended when it was not complete."
              },
              title: "Title",
              action: MlBodyActions(
                actionArray: {
                  3: "Blink.",
                },
                num: 1,
                isRandom: false,
              ),
              detectionTimeOut: 100000,
              cameraFrame: Rect(
                bottom: 1440,
                left: 0,
                right: 1080,
                top: 0,
              ),
              faceFrame: Rect(
                bottom: 518,
                left: 14,
                right: 396,
                top: 122,
              ),
              textMargin: 1300,
              textOptions: TextOptions(
                textColor: Colors.red,
                textSize: 23,
                minTextSize: 13,
                maxTextSize: 34,
                autoSizeText: false,
                granularity: 1,
              ));

      MLInteractiveLivenessCaptureResult result =
          await _customInteractive.startCustomizedView(
        setting: setting,
      );
      setState(() {
        _events.add(result);
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Interactive Liveness Detection Demo'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                return Text('$index: ${_events[index]}');
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: _startRecognition,
              child: const Text('Capture'),
            ),
          ),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: _customView,
              child: const Text('Custom View'),
            ),
          ),
        ],
      ),
    );
  }
}
