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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_fido/huawei_fido.dart';
import '../widgets/custom_button.dart';

class FaceManagerExample extends StatefulWidget {
  const FaceManagerExample({Key? key}) : super(key: key);

  @override
  State<FaceManagerExample> createState() => _FaceManagerExampleState();
}

class _FaceManagerExampleState extends State<FaceManagerExample> {
  late HmsFaceManager faceManager;
  final List<String> _results = <String>['Results will be here'];

  @override
  void initState() {
    faceManager = HmsFaceManager();
    faceManager.setCallback((
      BioAuthnEvent? event, {
      int? errCode,
      HmsBioAuthnResult? result,
    }) {
      _updateList('Auth event: ${describeEnum(event!)}');
    });
    _init();
    super.initState();
  }

  // This method is only necessary for authentication methods.
  void _init() async {
    await faceManager.init();
  }

  void _canAuth() async {
    final int? result = await faceManager.canAuth();
    _updateList('Can auth:$result');
  }

  void _isHardwareDetected() async {
    final bool? result = await faceManager.isHardwareDetected();
    _updateList('Hardware detected:$result');
  }

  void _hasEnrolledTemplates() async {
    final bool? result = await faceManager.hasEnrolledTemplates();
    _updateList('Has enrolled templates:$result');
  }

  void _authWithoutCryptoObject() async {
    await faceManager.authWithoutCryptoObject();
  }

  void _authWithCryptoObject() async {
    HmsCipherFactory factory = HmsCipherFactory();
    factory.storeKey = '<store_key>';
    factory.password = '<store_password>';

    await faceManager.authWithCryptoObject(factory);
  }

  void _getFaceModality() async {
    final int? result = await faceManager.getFaceModality();
    _updateList(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Manager Example')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          customButton('CAN AUTH', _canAuth),
          customButton('IS HARDWARE DETECTED', _isHardwareDetected),
          customButton('HAS ENROLLED TEMPLATES', _hasEnrolledTemplates),
          customButton('AUTH WITHOUT CRYPTO OBJECT', _authWithoutCryptoObject),
          customButton('AUTH WITH CRYPTO OBJECT', _authWithCryptoObject),
          customButton('GET FACE MODALITY', _getFaceModality),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              setState(() => _results.clear());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Text(_results[index]);
                },
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _updateList(String obj) {
    setState(() => _results.add(obj));
  }
}
