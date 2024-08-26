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
import 'package:huawei_ml_language_example/utils/demo_utils.dart';

class LocalTranslateDemo extends StatefulWidget {
  const LocalTranslateDemo({Key? key}) : super(key: key);

  @override
  State<LocalTranslateDemo> createState() => _LocalTranslateDemoState();
}

class _LocalTranslateDemoState extends State<LocalTranslateDemo> {
  final MLLocalTranslator localTranslator = MLLocalTranslator();
  String? _res;
  String? _downloadProgress;
  String _btnText = 'Download and Translate';
  String _selectedLanguage = 'lv';
  final List<String> _languages = <String>[
    'de',
    'no',
    'hi',
    'ru',
    'fi',
    'pt',
    'lv',
    'fr',
    'hu',
  ];

  @override
  void initState() {
    super.initState();
    localTranslator.setDownloadListener(downloadListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Translate Demo'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Select a target language (en to => )'),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (String? s) {
                      setState(() => _selectedLanguage = s!);
                    },
                    items: _languages.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            resultBox(
              'Download progress',
              _downloadProgress,
            ),
            resultBox(
              'Hey, how are you? ==> ',
              _res,
            ),
            recognitionButton(
              prepare,
              text: _btnText,
            ),
            recognitionButton(
              stop,
              text: 'Stop Translation',
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  // Methods
  void prepare() async {
    setState(() => _btnText = 'Wait Please...');
    final LanguageModelDownloadStrategy strategy =
        LanguageModelDownloadStrategy();
    strategy.needWifi();

    final MLTranslateSetting setting = MLTranslateSetting.local(
      sourceLangCode: 'en',
      targetLangCode: _selectedLanguage,
    );
    try {
      final bool prepared = await localTranslator.prepareModel(
        setting,
        strategy,
      );
      if (prepared) {
        final String? res =
            await localTranslator.asyncTranslate('Hey, how are you?');
        setState(() {
          _res = res;
          _btnText = 'Download and Translate';
        });
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void stop() {
    try {
      localTranslator.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  // Listener
  void downloadListener({dynamic all, dynamic downloaded}) {
    setState(() => _downloadProgress = '%${(downloaded! * 100) / all!}');
  }
}
