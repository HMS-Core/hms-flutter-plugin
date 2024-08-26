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
import 'package:huawei_ml_body/huawei_ml_body.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';

class LensExample extends StatefulWidget {
  const LensExample({Key? key}) : super(key: key);

  @override
  State<LensExample> createState() => _LensExampleState();
}

class _LensExampleState extends State<LensExample> {
  final MLBodyLensController _controller = MLBodyLensController(
    transaction: BodyTransaction.face,
    lensType: MLBodyLensController.backLens,
  );
  late MLBodyLensEngine _lensEngine;
  int? _textureId;
  dynamic _smilingProb = 0;

  @override
  void initState() {
    super.initState();
    _lensEngine = MLBodyLensEngine(
      controller: _controller,
    );
    _lensEngine.setTransactor(_onTransaction);
    _initialize();
  }

  void _onTransaction({dynamic result}) {
    _updateResult(result);
  }

  void _updateResult(List<MLFace> faces) {
    setState(() => _smilingProb = faces.first.possibilityOfSmiling);
  }

  void _initialize() async {
    await _lensEngine.init().then((int value) {
      setState(() => _textureId = value);
    });
  }

  void _run() {
    try {
      _lensEngine.run();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _release() {
    _lensEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Lens Example'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MLBodyLens(
              textureId: _textureId,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(' Smiling probability: $_smilingProb'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                lensControllerButton(
                  _initialize,
                  const Color(0xff6e7c7c),
                  'init',
                ),
                lensControllerButton(
                  _run,
                  const Color(0xff6ddccf),
                  'start',
                ),
                lensControllerButton(
                  _release,
                  const Color(0xffec4646),
                  'release',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
