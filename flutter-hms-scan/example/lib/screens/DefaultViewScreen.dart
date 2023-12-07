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

import 'package:huawei_scan_example/widgets/ResponseWidget.dart';

class DefaultViewScreen extends StatefulWidget {
  const DefaultViewScreen({Key? key}) : super(key: key);

  @override
  State<DefaultViewScreen> createState() => _DefaultViewScreenState();
}

class _DefaultViewScreenState extends State<DefaultViewScreen> {
  String? resultScan;
  int? codeFormatScan;
  int? resultTypeScan;

  @override
  void initState() {
    super.initState();
    defaultView();
  }

  void defaultView() async {
    try {
      DefaultViewRequest request = DefaultViewRequest(
        scanType: HmsScanTypes.AllScanType,
      );
      ScanResponse response = await HmsScanUtils.startDefaultView(request);
      setState(() {
        resultScan = response.originalValue;
        codeFormatScan = response.scanType;
        resultTypeScan = response.scanTypeForm;
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.scanUtilNoCameraPermission.errorCode) {
        debugPrint(HmsScanErrors.scanUtilNoCameraPermission.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default View Screen'),
      ),
      body: resultScan == null
          ? AlertDialog(
              content: const Text('Please scan a valid barcode.'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          : SingleChildScrollView(
              child: ResponseWidget(
                isMulti: false,
                codeFormat: codeFormatScan,
                result: resultScan,
                resultType: resultTypeScan,
              ),
            ),
    );
  }
}
