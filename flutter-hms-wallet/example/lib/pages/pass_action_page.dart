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
import 'package:huawei_wallet/huawei_wallet.dart';

import 'package:huawei_wallet_example/constants.dart';

class PassActionPage extends StatefulWidget {
  final PassObject passObject;
  final int environment;

  const PassActionPage({
    required this.passObject,
    required this.environment,
    Key? key,
  }) : super(key: key);

  @override
  State<PassActionPage> createState() => _PassActionPageState();
}

class _PassActionPageState extends State<PassActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Huawei Wallet App'),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each card type must be posted to Huawei server before used. Further information can be found in README.md',
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              saveToHuaweiWallet();
            },
            child: const Text(
              'Save to Huawei Wallet App - with sdk',
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              clickLinkToPay(context);
            },
            child: const Text(
              'Save to Huawei Wallet App - with uri intent',
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              clickAppOrUriToPay(context);
            },
            child: const Text(
              'Click App or Uri to Pay',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveToHuaweiWallet() async {
    try {
      final String jweStr = await generateJwe();
      final CreateWalletPassResult result =
          await HuaweiWallet.createWalletPassWithSdk(
        content: jweStr,
      );
      showSnackbar('$result');
    } catch (e) {
      showSnackbar('$e');
    }
  }

  Future<void> clickLinkToPay(BuildContext context) async {
    try {
      final String jweStr = await generateJwe();
      final CreateWalletPassResult result =
          await HuaweiWallet.createWalletPassWithIntent(
        content: jweStr,
      );
      showSnackbar('$result');
    } catch (e) {
      showSnackbar('$e');
    }
  }

  // add by wallet app or browser
  void clickAppOrUriToPay(BuildContext context) async {
    try {
      final String jweStr = await generateJwe();
      final String uri =
          '${Constants.getBrowserUrl(widget.environment)}/pass/save?jwt=${Uri.encodeComponent(jweStr)}';
      HuaweiWallet.startActivityWithUriIntent(uri: uri);
    } catch (e) {
      showSnackbar('$e');
    }
  }

  Future<String> generateJwe() async {
    return await HuaweiWallet.generateJwe(
      appId: Constants.issuerId,
      passObject: widget.passObject,
      jwePrivateKey: Constants.getPrivateKey(widget.environment),
      sessionKeyPublicKey: Constants.getPublicKey(),
    );
  }

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
