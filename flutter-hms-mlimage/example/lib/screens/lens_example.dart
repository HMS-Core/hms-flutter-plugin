/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';

class LensExample extends StatefulWidget {
  const LensExample({Key? key}) : super(key: key);

  @override
  State<LensExample> createState() => _LensExampleState();
}

class _LensExampleState extends State<LensExample> {
  final MLImageLensEngine _lensEngine = MLImageLensEngine(
    controller: MLImageLensController(
      transaction: ImageTransaction.classification,
      lensType: MLImageLensController.backLens,
    ),
  );
  int? _textureId;
  String? _objType = unknownText;

  @override
  void initState() {
    super.initState();
    _lensEngine.setTransactor(({dynamic result}) {
      setState(() {
        _objType = (result as List<MLImageClassification>).first.name;
      });
    });
    _initialize();
  }

  void _initialize() async {
    await _lensEngine.init().then((int value) {
      setState(() {
        _textureId = value;
      });
    });
  }

  void _run() {
    try {
      _lensEngine.run();
    } catch (e) {
      exceptionDialog(context, '$e');
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
            child: MLImageLens(
              textureId: _textureId,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Object type: $_objType'),
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
