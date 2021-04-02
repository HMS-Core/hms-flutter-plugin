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
import '../widgets/detection_result_box.dart';

class SoundDetectionExample extends StatefulWidget {
  @override
  _SoundDetectionExampleState createState() => _SoundDetectionExampleState();
}

class _SoundDetectionExampleState extends State<SoundDetectionExample> {
  MLSoundDetector detector;
  int _result;

  @override
  void initState() {
    detector = new MLSoundDetector();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    await MLPermissionClient()
        .requestPermission([MLPermission.audio]).then((v) {
      if (!v) {
        _checkPermissions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sound Detection")),
      body: Column(
        children: [
          SizedBox(height: 20),
          detectionResultBox("result code", _result),
          SizedBox(height: 20),
          detectionButton(
              onPressed: _startRecognition, label: "START RECOGNITION")
        ],
      ),
    );
  }

  _startRecognition() async {
    try {
      final int res = await detector.startSoundDetector();
      setState(() => _result = res);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
