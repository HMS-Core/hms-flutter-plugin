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
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:huawei_ml_text_example/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class GcrExample extends StatefulWidget {
  const GcrExample({
    Key? key,
  }) : super(key: key);

  @override
  State<GcrExample> createState() => _GcrExampleState();
}

class _GcrExampleState extends State<GcrExample> {
  late MLGeneralCardAnalyzer _analyzer;
  String? _res;
  Image? _image;

  @override
  void initState() {
    super.initState();
    _analyzer = MLGeneralCardAnalyzer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar(gcrAppbarText),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              bcrImageContainer(context, _image),
              resultBox(resultBoxCardText, _res, context),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _capture,
                  child: const Text(captureText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _takePicture,
                  child: const Text(takePictureText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _localImage,
                  child: const Text(localImageText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _capture() async {
    final MLGeneralCardAnalyzerSetting setting =
        MLGeneralCardAnalyzerSetting.capture(
      tipText: captureTipTextText,
      tipTextColor: Colors.red,
      scanBoxCornerColor: Colors.white,
    );
    try {
      final MLGeneralCard card = await _analyzer.capturePreview(setting);
      _update(card);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _takePicture() async {
    final MLGeneralCardAnalyzerSetting setting =
        MLGeneralCardAnalyzerSetting.capture(
      tipText: takePictureText,
      tipTextColor: Colors.red,
      scanBoxCornerColor: Colors.white,
    );
    try {
      final MLGeneralCard card = await _analyzer.capturePhoto(setting);
      _update(card);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _localImage() async {
    final String? path = await getImage(
      ImageSource.gallery,
    );
    if (path != null) {
      try {
        final MLGeneralCardAnalyzerSetting setting =
            MLGeneralCardAnalyzerSetting.image(
          path: path,
        );
        final MLGeneralCard card = await _analyzer.captureImage(setting);
        _update(card);
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  void _update(MLGeneralCard card) {
    setState(() {
      _res = card.text?.stringValue;
      _image = Image.memory(card.bytes!);
    });
  }
}
