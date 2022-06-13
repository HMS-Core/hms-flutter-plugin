/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';

import '../utils/utils.dart';

class IcrExample extends StatefulWidget {
  @override
  _IcrExampleState createState() => _IcrExampleState();
}

class _IcrExampleState extends State<IcrExample> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLVnIcrCapture _capture;

  Image? _image;
  String? _name;

  @override
  void initState() {
    _capture = MLVnIcrCapture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(icrAppbarText),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bcrImageContainer(context, _image),
            resultBox(resultBoxText, _name, context),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, _captureCard()),
                child: Text(captureText),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () =>
                    pickerDialog(_key, context, _analyzeLocalImage),
                child: Text(localImageText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _captureCard() async {
    try {
      MLVnIcrCaptureResult result = await _capture.capture();
      _update(result);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _analyzeLocalImage(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }

    try {
      MLVnIcrCaptureResult result = await _capture.captureImage(path);
      _update(result);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _update(MLVnIcrCaptureResult result) {
    setState(() {
      _name = result.name;
      _image = Image.memory(result.bytes!);
    });
  }
}
