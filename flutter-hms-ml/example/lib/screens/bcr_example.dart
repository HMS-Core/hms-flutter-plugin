/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';

class BcrExample extends StatefulWidget {
  @override
  _BcrExampleState createState() => _BcrExampleState();
}

class _BcrExampleState extends State<BcrExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLBankcardAnalyzer analyzer;
  MlBankcardSettings settings;

  dynamic _cardNumber = "Card Number";
  dynamic _cardExpire = "Card Expire";
  dynamic _cardImageSavedUri = "Card Image Saved Uri";

  @override
  void initState() {
    analyzer = new MLBankcardAnalyzer();
    settings = new MlBankcardSettings();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    List<MLPermission> list = [MLPermission.camera, MLPermission.storage];
    await MLPermissionClient().requestPermission(list).then((v) {
      if (!v) {
        _checkPermissions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Bankcard Recognition"),
          titleSpacing: 0,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            detectionResultBox("CARD NUMBER", _cardNumber),
            detectionResultBox("CARD EXPIRE", _cardExpire),
            detectionResultBox("CARD URI", _cardImageSavedUri),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Start Analyze"),
                  onPressed: _startRecognition,
                )),
          ],
        ),
      ),
    );
  }

  _startRecognition() async {
    try {
      final MLBankcard bankcard = await analyzer.captureBankcard();
      setState(() {
        _cardExpire = bankcard.expire;
        _cardNumber = bankcard.number;
        _cardImageSavedUri = bankcard.originalBitmap;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
