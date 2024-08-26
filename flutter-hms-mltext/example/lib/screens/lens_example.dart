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
import 'package:flutter/services.dart';
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:huawei_ml_text_example/utils/utils.dart';

class LensExample extends StatefulWidget {
  const LensExample({
    Key? key,
  }) : super(key: key);

  @override
  State<LensExample> createState() => _LensExampleState();
}

class _LensExampleState extends State<LensExample> {
  final MLTextLensController _controller = MLTextLensController(
    lensType: MLTextLensController.backLens,
    transaction: TextTransaction.text,
  );
  late MLTextLensEngine _lensEngine;
  int? _textureId;
  String? _text = '';

  @override
  void initState() {
    super.initState();
    _lensEngine = MLTextLensEngine(controller: _controller);
    _lensEngine.setTransactor(_onTransaction);
    _initialize();
  }

  void _onTransaction({dynamic result}) {
    _updateResult(result);
  }

  void _updateResult(List<TextBlock> texts) {
    setState(() => _text = texts.first.stringValue);
  }

  // To use LensView after you call release method, call this method first.
  void _initialize() async {
    await _lensEngine.init().then((int value) {
      setState(() => _textureId = value);
    });
  }

  // Start live detection.
  void _run() {
    try {
      _lensEngine.run();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  // Stop live detection and release resources.
  void _release() {
    _lensEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar(lensAppbarText),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: MLTextLens(
                textureId: _textureId,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: context.paddingLow,
              child: Text(' $lensText: $_text'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  _lensControllerButton(
                    _initialize,
                    kGreenColor,
                    lensInitButton,
                  ),
                  _lensControllerButton(
                    _run,
                    kPrimaryColor,
                    lensStartButton,
                  ),
                  _lensControllerButton(
                    _release,
                    kDangerColor,
                    lensRelaseButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lensControllerButton(
    VoidCallback callback,
    Color color,
    String title,
  ) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
