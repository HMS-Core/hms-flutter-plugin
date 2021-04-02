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
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';

class LivenessExample extends StatefulWidget {
  @override
  _LivenessExampleState createState() => _LivenessExampleState();
}

class _LivenessExampleState extends State<LivenessExample> {
  MLLivenessCapture livenessCapture;

  String _resultBitmap = "";
  bool _isLive = false;
  double _score = 0;

  @override
  void initState() {
    livenessCapture = new MLLivenessCapture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liveness Detection"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            detectionResultBox("Bitmap", _resultBitmap),
            detectionResultBox("Score", _score),
            detectionResultBox("Is live", _isLive),
            SizedBox(height: 15),
            detectionButton(
                onPressed: _startLivenessDetection, label: "DETECT LIVENESS")
          ],
        ),
      ),
    );
  }

  _startLivenessDetection() async {
    try {
      final MLLivenessCaptureResult result =
          await livenessCapture.startLivenessDetection();
      setState(() {
        _resultBitmap = result.bitmap;
        _isLive = result.isLive;
        _score = result.score;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
