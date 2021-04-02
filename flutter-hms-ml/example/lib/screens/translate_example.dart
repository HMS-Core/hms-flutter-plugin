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

class TranslateExample extends StatefulWidget {
  @override
  _TranslateExampleState createState() => _TranslateExampleState();
}

class _TranslateExampleState extends State<TranslateExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  MLLocalTranslator translator;
  MLRemoteTranslator remoteTranslator;
  MLTranslateSetting setting;

  String _translateResult = "Translation result will be here";

  @override
  void initState() {
    translator = new MLLocalTranslator();
    remoteTranslator = new MLRemoteTranslator();
    setting = new MLTranslateSetting();
    _setApiKey();
    super.initState();
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  _prepareModel() async {
    setting.sourceLangCode = "es";
    setting.targetLangCode = "en";
    try {
      final bool res = await translator.prepareModel(setting: setting);
      if (res) {
        _localTranslate();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _localTranslate() async {
    try {
      final String s =
          await translator.syncTranslate(sourceText: "Cómo te sientes hoy");
      if (s != null) {
        setState(() => _translateResult = s);
        _stopLocalTranslate();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _stopLocalTranslate() async {
    try {
      await translator.stopTranslate();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _stopRemoteTranslate() async {
    try {
      await remoteTranslator.stopTranslate();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _remoteTranslate() async {
    setting.sourceLangCode = "en";
    setting.targetLangCode = "es";
    setting.sourceTextOnRemote = "how are you feeling today";

    try {
      final String s = await remoteTranslator.syncTranslate(setting: setting);
      if (s != null) {
        setState(() => _translateResult = s);
        _stopRemoteTranslate();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Translation Demo")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
                "This example demonstrates the translations between english and spanish",
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.6)),
                  color: Colors.white),
              child: Text(_translateResult),
            ),
            SizedBox(height: 20),
            detectionButton(onPressed: _prepareModel, label: "LOCAL TRANSLATE"),
            detectionButton(
                onPressed: _remoteTranslate, label: "REMOTE TRANSLATE")
          ],
        ),
      ),
    ));
  }
}
