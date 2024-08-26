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
import 'package:huawei_ml_language/huawei_ml_language.dart';

class AsrDemo extends StatefulWidget {
  const AsrDemo({Key? key}) : super(key: key);

  @override
  State<AsrDemo> createState() => _AsrDemoState();
}

class _AsrDemoState extends State<AsrDemo> {
  late MLAsrRecognizer recognizer;
  String res = 'No result';
  final List<String> _events = <String>[
    'Initial event',
  ];

  @override
  void initState() {
    super.initState();
    recognizer = MLAsrRecognizer();
    recognizer.setAsrListener(
      MLAsrListener(
        onRecognizingResults: onRecognizingResults,
        onResults: onResults,
        onError: onError,
        onState: onState,
      ),
    );
  }

  void onResults(String s) {
    setState(() => _events.add('onResults: $s'));
  }

  void onRecognizingResults(String result) {
    setState(() => _events.add('onRecognizingResults: $result'));
  }

  void onError(int error, String errorMessage) {
    setState(() => _events.add('onError: $error: $errorMessage'));
  }

  void onState(int state) {
    setState(() => _events.add('onState: $state'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asr Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (_, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_events[index]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: startWithoutUi,
                        child: const Text('start asr'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: startWithUi,
                        child: const Text('start asr with ui'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: destroy,
                        child: const Text('destroy'),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void startWithoutUi() {
    final MLAsrSetting setting = MLAsrSetting(
      language: MLAsrConstants.LAN_EN_US,
      feature: MLAsrConstants.FEATURE_WORDFLUX,
    );
    recognizer.startRecognizing(setting);
  }

  void startWithUi() async {
    final MLAsrSetting setting = MLAsrSetting(
      language: MLAsrConstants.LAN_EN_US,
      feature: MLAsrConstants.FEATURE_WORDFLUX,
    );
    final String? res = await recognizer.startRecognizingWithUi(setting);
    setState(() => _events.add('ui picker result: $res'));
  }

  void destroy() {
    try {
      recognizer.destroy();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
