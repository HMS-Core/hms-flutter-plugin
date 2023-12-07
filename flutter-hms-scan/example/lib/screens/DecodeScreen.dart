/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:flutter/services.dart';

import 'package:huawei_scan/huawei_scan.dart';

import 'package:huawei_scan_example/widgets/DecodeWidget.dart';

class DecodeScreen extends StatefulWidget {
  const DecodeScreen({Key? key}) : super(key: key);

  @override
  State<DecodeScreen> createState() => _DecodeScreenState();
}

class _DecodeScreenState extends State<DecodeScreen> {
  List<ScanResponse?>? responseList;
  bool photoMode = false;

  void decode() async {
    Uint8List data =
        (await rootBundle.load('assets/aztecBarcode.png')).buffer.asUint8List();
    try {
      ScanResponseList response = await HmsScanUtils.decode(
        DecodeRequest(
          data: data,
          scanType: HmsScanTypes.AllScanType,
          photoMode: photoMode,
          parseResult: true,
          multiMode: false,
        ),
      );
      setState(() {
        responseList = response.scanResponseList;
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
      body: DecodeBodyWidget(
        imageUrl: 'assets/aztecBarcode.png',
        customButtonName: 'Decode',
        onPressed: () {
          decode();
        },
        responseList: responseList,
        photoMode: photoMode,
      ),
    );
  }
}
