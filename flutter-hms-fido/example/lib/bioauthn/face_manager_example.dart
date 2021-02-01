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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_fido/huawei_fido.dart';
import '../widgets/custom_button.dart';

class FaceManagerExample extends StatefulWidget {
  @override
  _FaceManagerExampleState createState() => _FaceManagerExampleState();
}

class _FaceManagerExampleState extends State<FaceManagerExample> {
  HmsFaceManager faceManager;
  List<String> _results = ["Results will be here"];

  @override
  void initState() {
    faceManager = new HmsFaceManager();
    faceManager.setCallback((event, {errCode, result}) {
      _updateList(describeEnum(event));
    });
    _init();
    super.initState();
  }

  // This method is only necessary for authentication methods.
  _init() async {
    await faceManager.init();
  }

  _canAuth() async {
    final int result = await faceManager.canAuth();
    _updateList(result.toString());
  }

  _isHardwareDetected() async {
    final bool result = await faceManager.isHardwareDetected();
    _updateList(result.toString());
  }

  _hasEnrolledTemplates() async {
    final bool result = await faceManager.hasEnrolledTemplates();
    _updateList(result.toString());
  }

  _authWithoutCryptoObject() async {
    await faceManager.authWithoutCryptoObject();
  }

  _authWithCryptoObject() async {
    HmsCipherFactory factory = new HmsCipherFactory();
    factory.storeKey = "hw_test_fingerprint";
    factory.password = "12psw456.";

    await faceManager.authWithCryptoObject(factory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Face Manager Example")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customButton("CAN AUTH", _canAuth),
          customButton("IS HARDWARE DETECTED", _isHardwareDetected),
          customButton("HAS ENROLLED TEMPLATES", _hasEnrolledTemplates),
          customButton("AUTH WITHOUT CRYPTO OBJECT", _authWithoutCryptoObject),
          customButton("AUTH WITH CRYPTO OBJECT", _authWithCryptoObject),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              setState(() => _results.clear());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (ctx, index) {
                  return Text(_results[index]);
                },
              ),
            ),
          ))
        ],
      ),
    );
  }

  _updateList(String obj) {
    setState(() => _results.add(obj));
  }
}
