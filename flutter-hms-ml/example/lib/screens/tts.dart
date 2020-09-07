/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ml/helpers/tts_helpers.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:huawei_ml/tts/ml_text_to_speech_client.dart';
import 'package:huawei_ml/tts/ml_text_to_speech_settings.dart';

class TextToSpeechRecognitionPage extends StatefulWidget {
  @override
  _TextToSpeechRecognitionPageState createState() =>
      _TextToSpeechRecognitionPageState();
}

class _TextToSpeechRecognitionPageState
    extends State<TextToSpeechRecognitionPage> {
  MlTextToSpeechSettings settings;

  @override
  void initState() {
    settings = new MlTextToSpeechSettings();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    if (await MlPermissionClient.checkRecordAudioPermission()) {
      print("Permissions are granted");
    } else {
      await MlPermissionClient.requestRecordAudioPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Text To Speech"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _customTextWidget("Hi, how are you"),
            _customTextWidget(
                "Dave watched as the forest burned up on the hill, only a few miles from her house."),
            _customTextWidget(
                "The computer wouldn't start. She banged on the side and tried again. Nothing. She lifted it up and dropped it to the table. Still nothing.")
          ],
        ),
      ),
    ));
  }

  _startRecognition(String text) async {
    settings.text = text;
    settings.queuingMode = MlTtsQueuingMode.QUEUE_FLUSH;
    settings.person = MlTtsPerson.TTS_SPEAKER_FEMALE_EN;
    settings.language = MlTtsLanguage.TTS_EN_US;
    try {
      await MlTextToSpeechClient.getSpeechFromText(settings);
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
