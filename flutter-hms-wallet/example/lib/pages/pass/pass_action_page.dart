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
import 'package:huawei_wallet/huawei_wallet.dart';
import 'package:huawei_wallet_example/utils/utils.dart';

class PassActionPage extends StatelessWidget {
  final PassObject passObject;
  final int environment;

  const PassActionPage({
    Key key,
    this.passObject,
    this.environment,
  })  : assert(environment != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Huawei Wallet App'),
      ),
      body: PassActionBody(
        passObject: passObject,
        environment: environment,
      ),
    );
  }
}

class PassActionBody extends StatelessWidget {
  final PassObject passObject;
  final int environment;

  const PassActionBody({
    Key key,
    this.passObject,
    this.environment,
  })  : assert(environment != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Each card type must be posted to Huawei server before used. Further information can be found in README.md",
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Save to Huawei Wallet App - with sdk'),
          color: Colors.grey,
          onPressed: () {
            saveToHuaweiWallet(context);
          },
        ),
        MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Save to Huawei Wallet App - with uri intent'),
          color: Colors.grey,
          onPressed: () {
            clickLinkToPay(context);
          },
        ),
        MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Click App or Uri to Pay'),
          color: Colors.grey,
          onPressed: () {
            clickAppOrUriToPay(context);
          },
        ),
      ],
    );
  }

  Future<void> saveToHuaweiWallet(BuildContext context) async {
    String jweStr = await generateJwe();
    try {
      CreateWalletPassResult result =
          await HuaweiWallet.createWalletPassWithSdk(
        content: jweStr,
      );
      showSnackbar(context, result.toString());
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<void> clickLinkToPay(BuildContext context) async {
    String jweStr = await generateJwe();
    try {
      CreateWalletPassResult result =
          await HuaweiWallet.createWalletPassWithIntent(
        content: jweStr,
      );
      showSnackbar(context, result.toString());
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //add by wallet app or browser
  void clickAppOrUriToPay(BuildContext context) async {
    String jweStr = await generateJwe();
    String uri = getBrowserUrl(environment) +
        "/pass/save?jwt=" +
        Uri.encodeComponent(jweStr);
    try {
      HuaweiWallet.startActivityWithUriIntent(uri: uri);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<String> generateJwe() async {
    return await HuaweiWallet.generateJwe(
      dataJson: passObject.toJson(),
      appId: Constants.appId,
      jwePrivateKey: Constants.jwePrivateKey,
      sessionKeyPublicKey: Constants.sessionPublicKey,
    );
  }

  void showSnackbar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text ?? '')));
  }

  String getBrowserUrl(int environment) {
    String browserUrl = "";
    switch (environment) {
      case Constants.enviromentRussiaDebug:
        browserUrl =
            "https://walletkit-cstr.hwcloudtest.cn:8080/walletkit/consumer";
        break;
      case Constants.enviromentRussiaRelease:
        browserUrl =
            "https://walletpass-drru.cloud.huawei.com/walletkit/consumer";
        break;
      case Constants.enviromentEuropeDebug:
        browserUrl =
            "https://walletkit-cstr.hwcloudtest.cn:8080/walletkit/consumer";
        break;
      case Constants.enviromentEuropeRelease:
        browserUrl =
            "https://walletpass-dre.cloud.huawei.com/walletkit/consumer";
        break;
      case Constants.enviromentAfricaDebug:
        browserUrl =
            "https://walletkit-cstr.hwcloudtest.cn:8080/walletkit/consumer";
        break;
      case Constants.enviromentAfricaRelease:
        browserUrl =
            "https://walletpass-dra.cloud.huawei.com/walletkit/consumer";
        break;
      default:
        break;
    }
    return browserUrl;
  }
}
