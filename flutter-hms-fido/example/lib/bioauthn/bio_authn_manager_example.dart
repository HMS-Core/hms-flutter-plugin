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
import 'package:huawei_fido/huawei_fido.dart';
import 'package:huawei_fido_example/widgets/custom_button.dart';

class BioAuthnManagerExample extends StatefulWidget {
  @override
  _BioAuthnManagerExampleState createState() => _BioAuthnManagerExampleState();
}

class _BioAuthnManagerExampleState extends State<BioAuthnManagerExample> {
  HmsBioAuthnManager manager;
  String _result = "Result will be here";

  @override
  void initState() {
    manager = new HmsBioAuthnManager();
    super.initState();
  }

  _canAuth() async {
    final int res = await manager.canAuth();
    setState(() => _result = res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BioAuthn Manager Example")),
      body: Column(
        children: [
          customButton("CHECK FINGERPRINT AUTH", _canAuth),
          SizedBox(height: 15),
          Text(_result)
        ],
      ),
    );
  }
}
