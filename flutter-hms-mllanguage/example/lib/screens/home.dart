/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import '../screens/aft_demo.dart';
import '../screens/asr_demo.dart';
import '../screens/lang_detecton_demo.dart';
import '../screens/languages_demo.dart';
import '../screens/local_translate_demo.dart';
import '../screens/remote_translate_demo.dart';
import '../screens/rtt_demo.dart';
import '../screens/sound_detection_demo.dart';
import '../screens/tts_demo.dart';
import '../utils/demo_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    setApiKey();
    super.initState();
  }

  void setApiKey() {
    // Replace this with your api key.
    MLLanguageApp().setApiKey(
      "CgB6e3x9P33R+B2u+UHaEIK06gxzH883IZxpQc7BvJmmRgx8wl/sJ0bKGjlKNP46oiTtW6eWj4I73PXtjM2lcHhZ",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ML Language Demo')),
        body: GridView.count(
          padding: const EdgeInsets.all(10),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: const [
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
        ));
  }
}
