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

class RemoteTranslateDemo extends StatefulWidget {
  const RemoteTranslateDemo({Key? key}) : super(key: key);

  @override
  State<RemoteTranslateDemo> createState() => _RemoteTranslateDemoState();
}

class _RemoteTranslateDemoState extends State<RemoteTranslateDemo> {
  final MLRemoteTranslator _translator = MLRemoteTranslator();
  String? _res;
  String _selectedLanguage = 'bg';
  final List<String> _languages = <String>[
    'ar',
    'bg',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'fa',
    'fi',
    'fr',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Translate Demo'),
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
              'How are you ==',
              _res,
            ),
            recognitionButton(
              _translate,
              text: 'Translate',
            ),
            recognitionButton(
              _stopTranslator,
              text: 'Stop Translation',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void _translate() async {
    final MLTranslateSetting setting = MLTranslateSetting.remote(
      sourceText: 'How are you',
      sourceLangCode: 'en',
      targetLangCode: _selectedLanguage,
    );
    try {
      final String? res = await _translator.syncTranslate(setting);
      if (res != null) {
        setState(() => _res = res);
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _stopTranslator() async {
    try {
      await _translator.stopTranslate();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
