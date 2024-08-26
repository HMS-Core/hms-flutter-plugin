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

class LivenessExample extends StatefulWidget {
  const LivenessExample({Key? key}) : super(key: key);

  @override
  State<LivenessExample> createState() => _LivenessExampleState();
}

class _LivenessExampleState extends State<LivenessExample> {
  late MLLivenessCapture _capture;
  Image? image;
  bool? isLive;
  dynamic score;

  @override
  void initState() {
    super.initState();
    _capture = MLLivenessCapture();
  }

  void _startRecognition() async {
    try {
      final MLLivenessCaptureResult result = await _capture.startDetect();
      setState(() {
        isLive = result.isLive;
        score = result.score;
        image = Image.memory(
          result.bitmap!,
          fit: BoxFit.cover,
        );
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Liveness Detection Demo'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.grey,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: image ?? Image.asset('assets/user.png'),
          ),
          resultBox('Is live', isLive),
          resultBox('Score', score),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: _startRecognition,
              child: const Text('Capture'),
            ),
          ),
        ],
      ),
    );
  }
}
