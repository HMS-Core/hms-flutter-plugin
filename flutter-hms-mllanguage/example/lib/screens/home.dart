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
import 'package:huawei_ml_language_example/screens/aft_demo.dart';
import 'package:huawei_ml_language_example/screens/asr_demo.dart';
import 'package:huawei_ml_language_example/screens/lang_detecton_demo.dart';
import 'package:huawei_ml_language_example/screens/languages_demo.dart';
import 'package:huawei_ml_language_example/screens/local_translate_demo.dart';
import 'package:huawei_ml_language_example/screens/remote_translate_demo.dart';
import 'package:huawei_ml_language_example/screens/rtt_demo.dart';
import 'package:huawei_ml_language_example/screens/sound_detection_demo.dart';
import 'package:huawei_ml_language_example/screens/tts_demo.dart';
import 'package:huawei_ml_language_example/utils/demo_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Tooltip(
          message: 'Flutter Version: 3.12.0+300',
          child: Text('ML Language Demo'),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const <Widget>[
          CustomGridElement(
            name: 'Local\nTranslate',
            imagePath: 'trans',
            page: LocalTranslateDemo(),
          ),
          CustomGridElement(
            name: 'Remote\nTranslate',
            imagePath: 'trans',
            page: RemoteTranslateDemo(),
          ),
          CustomGridElement(
            name: 'Translate\nLanguages',
            imagePath: 'trans',
            page: LanguagesDemo(),
          ),
          CustomGridElement(
            name: 'Aft',
            imagePath: 'asr',
            page: AftDemo(),
          ),
          CustomGridElement(
            name: 'Asr',
            imagePath: 'asr',
            page: AsrDemo(),
          ),
          CustomGridElement(
            name: 'Rtt',
            imagePath: 'asr',
            page: RttDemo(),
          ),
          CustomGridElement(
            name: 'Tts',
            imagePath: 'tts',
            page: TtsDemo(),
          ),
          CustomGridElement(
            name: 'Lang\nDetection',
            imagePath: 'langdetect',
            page: LangDetectionDemo(),
          ),
          CustomGridElement(
            name: 'Sound Detection',
            imagePath: 'sounddetect',
            page: SoundDetectionDemo(),
          ),
        ],
      ),
    );
  }
}
