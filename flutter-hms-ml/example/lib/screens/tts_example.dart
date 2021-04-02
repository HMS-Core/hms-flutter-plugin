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

class TtsExample extends StatefulWidget {
  @override
  _TtsExampleState createState() => _TtsExampleState();
}

class _TtsExampleState extends State<TtsExample> {
  MLTtsEngine engine;
  MLTtsConfig config;

  @override
  void initState() {
    _setApiKey();
    _init();
    super.initState();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  _init() {
    engine = new MLTtsEngine();
    config = new MLTtsConfig();
    engine.setTtsCallback((event, details, {errorCode}) {
      print("TTS Event: $event");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Text To Speech"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
                "Press the buttons and speech will start. Control the speech with buttons below.",
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            _customTextWidget("Hi, how are you"),
            _customTextWidget(
                "Dave watched as the forest burned up on the hill, only a few miles from her house."),
            _customTextWidget(
                "The computer wouldn't start. She banged on the side and tried again. Nothing. She lifted it up and dropped it to the table. Still nothing.")
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.pause),
                onPressed: () async {
                  try {
                    print(await engine.pauseSpeech());
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
            IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  try {
                    print(await engine.resumeSpeech());
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
            IconButton(
                icon: Icon(Icons.stop),
                onPressed: () async {
                  try {
                    print(await engine.stopTextToSpeech());
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  try {
                    print(await engine.shutdownTextToSpeech());
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                })
          ],
        ),
      ),
    ));
  }

  _startRecognition(String text) async {
    config.text = text;
    config.queuingMode = MLTtsEngine.QUEUE_APPEND;
    config.person = MLTtsConfig.TTS_SPEAKER_FEMALE_EN;
    config.language = MLTtsConfig.TTS_EN_US;
    config.synthesizeMode = MLTtsConfig.TTS_ONLINE_MODE;
    try {
      await engine.speakOnCloud(config);
    } on Exception catch (e) {
      print(e);
    }
  }

  Widget _customTextWidget(String text) {
    return InkWell(
      onTap: () {
        _startRecognition(text);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: .5,
                color: Colors.blueAccent.withOpacity(.5),
                style: BorderStyle.solid)),
        child: Text(text),
      ),
    );
  }
}
