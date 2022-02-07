/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import '../utils/constants.dart';
import '../utils/utils.dart';

class LensExample extends StatefulWidget {
  const LensExample({Key? key}) : super(key: key);

  @override
  _LensExampleState createState() => _LensExampleState();
}

class _LensExampleState extends State<LensExample> {
  final _permissions = MLImagePermissions();

  final _controller = MLImageLensController(
    transaction: ImageTransaction.classification,
    lensType: MLImageLensController.backLens,
  );

  late MLImageLensEngine _lensEngine;
  int? _textureId;
  dynamic _objType = unknownText;

  @override
  void initState() {
    _lensEngine = MLImageLensEngine(controller: _controller);
    _lensEngine.setTransactor(_onTransaction);
    _reqPermission();
    _initialize();
    super.initState();
  }

  void _reqPermission() async {
    _permissions.requestPermission([
      ImagePermission.camera,
      ImagePermission.storage,
    ]).then((value) {
      debugPrint('permissions granted: $value');
      if (!value) {
        _reqPermission();
      }
    });
  }

  void _onTransaction({dynamic result}) {
    _updateResult(result);
  }

  _updateResult(List<MLImageClassification> objects) {
    setState(() => _objType = objects.first.name);
  }

  _initialize() async {
    await _lensEngine.init().then((value) {
      setState(() => _textureId = value);
    });
  }

  _run() {
    try {
      _lensEngine.run();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _release() {
    _lensEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Lens Example'),
      body: Column(
        children: [
          Expanded(
            child: MLImageLens(
              textureId: _textureId,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(" Object type: $_objType"),
          ),
          _lensControllerWidget()
        ],
      ),
    );
  }

  Widget _lensControllerWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          lensControllerButton(_initialize, const Color(0xff6e7c7c), "init"),
          lensControllerButton(_run, const Color(0xff6ddccf), "start"),
          lensControllerButton(_release, const Color(0xffec4646), "release"),
        ],
      ),
    );
  }
}
