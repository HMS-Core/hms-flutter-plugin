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
import 'package:huawei_scan_example/widgets/CustomDropdown.dart';
import 'package:huawei_scan_example/widgets/CustomTextFormField.dart';
import 'package:huawei_scan_example/Utils.dart';

class BuildBitmapScreen extends StatefulWidget {
  const BuildBitmapScreen({Key? key}) : super(key: key);

  @override
  State<BuildBitmapScreen> createState() => _BuildBitmapScreenState();
}

class _BuildBitmapScreenState extends State<BuildBitmapScreen> {
  Image? _qrImg;
  String? scanTypeValue = 'QRCode';
  String? bitmapColor = 'Black';
  String? backgroundColor = 'White';
  int scanTypeValueFromDrowpDown = HmsScanTypes.QRCode;
  Color bitmapColorValue = Colors.black;
  Color backgroundColorValue = Colors.white;

  final TextEditingController barcodeContentController =
      TextEditingController(text: 'Huawei Scan Kit');
  final TextEditingController barcodeWidthController =
      TextEditingController(text: '200');
  final TextEditingController barcodeHeightController =
      TextEditingController(text: '200');
  final TextEditingController barcodeMarginController =
      TextEditingController(text: '1');

  void buildBitmap() async {
    Uint8List data = (await rootBundle.load('assets/scan_kit_logo.png'))
        .buffer
        .asUint8List();
    BuildBitmapRequest request = BuildBitmapRequest(
      content: barcodeContentController.text,
      qrLogo: data,
    );

    request.width = int.parse(barcodeWidthController.text);
    request.height = int.parse(barcodeHeightController.text);
    request.type = scanTypeValueFromDrowpDown;
    request.margin = int.parse(barcodeMarginController.text);
    request.bitmapColor = bitmapColorValue;
    request.backgroundColor = backgroundColorValue;

    Image? image;

    try {
      image = await HmsScanUtils.buildBitmap(request);
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.buildBitmap.errorCode) {
        debugPrint(HmsScanErrors.buildBitmap.errorMessage);
        debugPrint(err.details);
      }
    }

    setState(() {
      _qrImg = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Bitmap Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTextFormField(
                      text: 'Barcode Content',
                      controller: barcodeContentController,
                    ),
                    CustomTextFormField(
                      text: 'Barcode Width',
                      controller: barcodeWidthController,
                    ),
                    CustomTextFormField(
                      text: 'Barcode Height',
                      controller: barcodeHeightController,
                    ),
                    CustomTextFormField(
                      text: 'Barcode Margin',
                      controller: barcodeMarginController,
                    ),
                    CustomDropdown(
                      label: 'Scan Type: ',
                      onChanged: (String? newValue) {
                        setState(() {
                          scanTypeValue = newValue;
                          scanTypeValueFromDrowpDown =
                              dropdownControllerBitmap(scanTypeValue ?? '');
                        });
                      },
                      list: scanTypeStringListBitmap,
                      value: scanTypeValue,
                    ),
                    CustomDropdown(
                      label: 'Bitmap Color: ',
                      onChanged: (String? newValue) {
                        setState(() {
                          bitmapColor = newValue;
                          bitmapColorValue =
                              dropdownColorController(bitmapColor ?? '');
                        });
                      },
                      list: colorStringList,
                      value: bitmapColor,
                    ),
                    CustomDropdown(
                      label: 'Background Color: ',
                      onChanged: (String? newValue) {
                        setState(() {
                          backgroundColor = newValue;
                          backgroundColorValue =
                              dropdownColorController(backgroundColor ?? '');
                        });
                      },
                      list: colorStringList,
                      value: backgroundColor,
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Build Bitmap',
                onPressed: buildBitmap,
              ),
              _qrImg ?? const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
