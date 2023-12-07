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

import 'package:huawei_scan_example/widgets/CustomButton.dart';
import 'package:huawei_scan_example/widgets/ResponseWidget.dart';

class MultiProcessorScreen extends StatefulWidget {
  const MultiProcessorScreen({Key? key}) : super(key: key);

  @override
  State<MultiProcessorScreen> createState() => _MultiProcessorScreenState();
}

class _MultiProcessorScreenState extends State<MultiProcessorScreen> {
  ScanResponseList? scanList;

  void decodeMultiSync() async {
    Uint8List data = (await rootBundle.load('assets/multipleBarcode2.png'))
        .buffer
        .asUint8List();

    try {
      ScanResponseList response = await HmsMultiProcessor.decodeMultiSync(
        DecodeRequest(data: data, scanType: HmsScanTypes.AllScanType),
      );

      setState(() {
        scanList = response;
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.decodeMultiSyncCouldntFind.errorCode) {
        debugPrint(HmsScanErrors.decodeMultiSyncCouldntFind.errorMessage);
      }
    }
  }

  void decodeMultiAsync() async {
    Uint8List data = (await rootBundle.load('assets/multipleBarcode2.png'))
        .buffer
        .asUint8List();

    try {
      ScanResponseList response = await HmsMultiProcessor.decodeMultiAsync(
        DecodeRequest(data: data, scanType: HmsScanTypes.AllScanType),
      );
      setState(() {
        scanList = response;
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.decodeMultiAsyncCouldntFind.errorCode) {
        debugPrint(HmsScanErrors.decodeMultiAsyncCouldntFind.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode with Multi Processor Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/multipleBarcode2.png'),
                )
              ],
            ),
            CustomButton(
              text: 'Multi Processor Sync Mode',
              onPressed: () {
                decodeMultiSync();
              },
            ),
            CustomButton(
              text: 'Multi Processor Async Mode',
              onPressed: () {
                decodeMultiAsync();
              },
            ),
            scanList != null && scanList!.scanResponseList != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: scanList!.scanResponseList!.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ResponseWidget(
                        isMulti: true,
                        codeFormat:
                            scanList?.scanResponseList?[index]?.scanType,
                        result:
                            scanList?.scanResponseList?[index]?.originalValue,
                        resultType:
                            scanList?.scanResponseList?[index]?.scanTypeForm,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
