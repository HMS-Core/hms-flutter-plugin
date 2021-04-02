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

class RttExample extends StatefulWidget {
  @override
  _RttExampleState createState() => _RttExampleState();
}

class _RttExampleState extends State<RttExample> {
  MLSpeechRealTimeTranscription client;
  MLSpeechRealTimeTranscriptionConfig config;

  String _result = "result";

  @override
  void initState() {
    _init();
    _setApiKey();
    super.initState();
  }

  _init() {
    client = new MLSpeechRealTimeTranscription();
    client.setListener((partialResult, {recognizedResult}) {
      if (recognizedResult != null) {
        setState(() => _result = recognizedResult);
      }
    });
    config = new MLSpeechRealTimeTranscriptionConfig();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  _startTranscription() async {
    try {
      await client.startRecognizing(config: config);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RTT Example")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Press the button and start talking.",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.grey)),
              child: Text(_result)),
          SizedBox(height: 10),
          detectionButton(
              onPressed: _startTranscription, label: "START RECOGNITION")
        ],
      ),
    );
  }
}
