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
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:huawei_scan/HmsScanLibrary.dart';

import 'package:huawei_scan_example/widgets/CustomButton.dart';
import 'package:huawei_scan_example/widgets/ResponseWidget.dart';

class DecodeWithBitmapScreen extends StatefulWidget {
  @override
  _DecodeWithBitmapScreenState createState() => _DecodeWithBitmapScreenState();
}

class _DecodeWithBitmapScreenState extends State<DecodeWithBitmapScreen> {
  String resultScan;
  int codeFormatScan;
  int resultTypeScan;

  decodeWithBitmap() async {
    Uint8List data =
        (await rootBundle.load('assets/aztecBarcode.png')).buffer.asUint8List();

    try {
      ScanResponse response = await HmsScanUtils.decodeWithBitmap(
          DecodeRequest(data: data, scanType: HmsScanTypes.Aztec));
      setState(() {
        resultScan = response.originalValue;
        codeFormatScan = response.scanType;
        resultTypeScan = response.scanTypeForm;
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.decodeWithBitmapError.errorCode) {
        debugPrint(HmsScanErrors.decodeWithBitmapError.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode View Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/aztecBarcode.png"),
              ],
            ),
            CustomButton(
              text: "Decode With Bitmap",
              onPressed: () {
                decodeWithBitmap();
              },
            ),
            resultScan != null
                ? ResponseWidget(
                    isMulti: false,
                    codeFormat: codeFormatScan,
                    result: resultScan,
                    resultType: resultTypeScan,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
