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
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';

class GcrExample extends StatefulWidget {
  @override
  _GcrExampleState createState() => _GcrExampleState();
}

class _GcrExampleState extends State<GcrExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLGeneralCardAnalyzer analyzer;
  MLGeneralCardAnalyzerSetting setting;

  String _cardText = "Card text will be here";
  String _bitmapUri = "Card bitmap uri will be here";

  @override
  void initState() {
    analyzer = new MLGeneralCardAnalyzer();
    setting = new MLGeneralCardAnalyzerSetting();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    await MLPermissionClient().requestPermission(
        [MLPermission.camera, MLPermission.storage]).then((v) {
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
              title: Text("General Card Recognition"),
              titleSpacing: 0,
            ),
            body: Column(
              children: [
                SizedBox(height: 20),
                detectionResultBox("TEXT", _cardText),
                detectionResultBox("BITMAP URI", _bitmapUri),
                SizedBox(height: 15),
                detectionButton(
                    onPressed: _startRecognition, label: "START ANALYZING")
              ],
            )));
  }

  _startRecognition() async {
    setting.scanBoxCornerColor = Colors.greenAccent;
    setting.tipTextColor = Colors.black;
    setting.tipText = "Hold still...";
    try {
      final MLGeneralCard card = await analyzer.capturePreview(setting);
      setState(() {
        _cardText = card.text.stringValue;
        _bitmapUri = card.bitmap;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
