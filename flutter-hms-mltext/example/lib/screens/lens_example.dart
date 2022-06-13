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
import 'package:flutter/services.dart';
import 'package:huawei_ml_text/huawei_ml_text.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';

import '../utils/utils.dart';

class LensExample extends StatefulWidget {
  const LensExample({Key? key}) : super(key: key);

  @override
  _LensExampleState createState() => _LensExampleState();
}

class _LensExampleState extends State<LensExample> {
  final _controller = MLTextLensController(
      lensType: MLTextLensController.backLens,
      transaction: TextTransaction.text);

  late MLTextLensEngine _lensEngine;
  int? _textureId;
  String? _text = '';

  @override
  void initState() {
    _lensEngine = MLTextLensEngine(controller: _controller);
    _lensEngine.setTransactor(_onTransaction);
    _reqPermission();
    _initialize();
    super.initState();
  }

  void _reqPermission() async {
    MLTextPermissions().requestPermission(
        [TextPermission.camera, TextPermission.storage]).then((value) {
      debugPrint('$permissionText: $value');
      if (!value) {
        _reqPermission();
      }
    });
  }

  void _onTransaction({dynamic result}) {
    _updateResult(result);
  }

  _updateResult(List<TextBlock> texts) {
    setState(() => _text = texts.first.stringValue);
  }

  // To use LensView after you call release method, call this method first.
  _initialize() async {
    await _lensEngine.init().then((value) {
      setState(() => _textureId = value);
    });
  }

  // Start live detection.
  _run() {
    try {
      _lensEngine.run();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  // Stop live detection and release resources.
  _release() {
    _lensEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar(lensAppbarText),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: MLTextLens(
              textureId: _textureId,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            )),
            Padding(
              padding: context.paddingLow,
              child: Text(" $lensText: $_text"),
            ),
            _lensControllerWidget()
          ],
        ),
      ),
    );
  }

  Widget _lensControllerButton(
      VoidCallback callback, Color color, String title) {
    return Expanded(
      child: Container(
        height: 60,
        child: ElevatedButton(
          onPressed: callback,
          child: Text(title),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: color,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        ),
      ),
    );
  }

  Widget _lensControllerWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          _lensControllerButton(_initialize, kGreenColor, lensInitButton),
          _lensControllerButton(_run, kPrimaryColor, lensStartButton),
          _lensControllerButton(_release, kDangerColor, lensRelaseButton)
        ],
      ),
    );
  }
}
