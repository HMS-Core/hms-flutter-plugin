/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:huawei_ml_text_example/utils/utils.dart';

class BcrExample extends StatefulWidget {
  const BcrExample({
    Key? key,
  }) : super(key: key);

  @override
  State<BcrExample> createState() => _BcrExampleState();
}

class _BcrExampleState extends State<BcrExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLBankcardAnalyzer _analyzer;
  late MLCustomViewAnalyzer _customViewAnalyzer;
  Image? _image;

  @override
  void initState() {
    super.initState();
    _analyzer = MLBankcardAnalyzer();
    _customViewAnalyzer = MLCustomViewAnalyzer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(bcrAppbarText),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              bcrImageContainer(context, _image),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _captureCard,
                  child: const Text(captureText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    pickerDialog(_key, context, analyze);
                  },
                  child: const Text(localImageText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _customView,
                  child: const Text(customViewText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _captureCard() async {
    final MlBankcardSettings setting = MlBankcardSettings.capture();
    try {
      final MLBankcard card = await _analyzer.asyncAnalyseFrame(setting);
      setState(() {
        _image = Image.memory(card.originalBitmap!);
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _customView() async {
    final MLCustomizedViewSetting setting = MLCustomizedViewSetting(
      resultType: MLCustomizedViewSetting.resultAll,
      rectMode: MLCustomizedViewSetting.weakMode,
    );
    try {
      final MLBankcard card =
          await _customViewAnalyzer.startCustomizedView(setting);
      setState(() {
        _image = Image.memory(card.originalBitmap!);
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final MlBankcardSettings setting = MlBankcardSettings.image(
      path: path,
    );
    try {
      final MLBankcard card = await _analyzer.analyseFrame(setting);
      setState(() {
        _image = Image.memory(card.originalBitmap!);
      });
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void destroy() {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      final bool res = await _analyzer.isAvailable();
      debugPrint('$res');
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void stop() {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}
