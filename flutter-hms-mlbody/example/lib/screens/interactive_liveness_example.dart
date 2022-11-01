/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
  final List<MLInteractiveLivenessCaptureResult> _events =
      <MLInteractiveLivenessCaptureResult>[];

  @override
  void initState() {
    super.initState();
    _capture = MLInteractiveLivenessCapture();
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
        ],
      ),
    );
  }
}
