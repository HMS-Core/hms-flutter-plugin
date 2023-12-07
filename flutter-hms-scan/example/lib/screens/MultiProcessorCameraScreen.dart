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
import 'package:huawei_scan_example/widgets/CustomSwitchButton.dart';
import 'package:huawei_scan_example/widgets/CustomTextFormField.dart';
import 'package:huawei_scan_example/widgets/ResponseWidget.dart';
import 'package:huawei_scan_example/Utils.dart';

class MultiProcessorCameraScreen extends StatefulWidget {
  const MultiProcessorCameraScreen({Key? key}) : super(key: key);

  @override
  State<MultiProcessorCameraScreen> createState() =>
      _MultiProcessorCameraScreenState();
}

class _MultiProcessorCameraScreenState
    extends State<MultiProcessorCameraScreen> {
  ScanResponseList? scanList;
  List<ScanResponse> responseListWidget = <ScanResponse>[];

  //Dropdown Values
  String? scanTypeValue = 'All Scan Types';
  int scanTypeValueFromDrowpDown = HmsScanTypes.AllScanType;
  String? color1 = 'Yellow';
  Color color1Value = Colors.yellow;
  String? color2 = 'Blue';
  Color color2Value = Colors.blue;
  String? color3 = 'Red';
  Color color3Value = Colors.red;
  String? color4 = 'Green';
  Color color4Value = Colors.green;
  String? textColor = 'White';
  Color textColorValue = Colors.white;
  String? textBackgroundColor = 'Black';
  Color textBackgroundColorValue = Colors.black;

  //Switch Button Values
  bool switchMode = true;
  bool switchGallery = true;
  bool showText = true;
  bool showTextOutBounds = false;
  bool autoSizeText = true;

  //Text Controllers
  final TextEditingController strokeWidthController =
      TextEditingController(text: '4.0');

  final TextEditingController textSizeController =
      TextEditingController(text: '35.0');

  final TextEditingController minTextSizeController =
      TextEditingController(text: '24');

  final TextEditingController granularityController =
      TextEditingController(text: '2');

  void multiCameraView() async {
    setState(() {
      responseListWidget = <ScanResponse>[];
      scanList = null;
    });
    try {
      ScanResponseList response =
          await HmsMultiProcessor.startMultiProcessorCamera(
        MultiCameraRequest(
          scanMode: switchMode == true
              ? HmsMultiProcessor.MPAsyncMode
              : HmsMultiProcessor.MPSyncMode,
          isGalleryAvailable: switchGallery,
          scanType: scanTypeValueFromDrowpDown,
          colorList: <Color>[
            color1Value,
            color2Value,
            color3Value,
            color4Value
          ],
          strokeWidth: double.parse(strokeWidthController.text),
          scanTextOptions: ScanTextOptions(
            textColor: textColorValue,
            textSize: double.parse(textSizeController.text),
            showText: showText,
            showTextOutBounds: showTextOutBounds,
            textBackgroundColor: textBackgroundColorValue,
            autoSizeText: autoSizeText,
            minTextSize: int.parse(minTextSizeController.text),
            granularity: int.parse(granularityController.text),
          ),
          multiCameraListener: (ScanResponse response) {
            setState(() {
              responseListWidget.add(response);
            });
          },
        ),
      );
      setState(() {
        scanList = response;
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.mpCameraScanModeError.errorCode) {
        debugPrint(HmsScanErrors.mpCameraScanModeError.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Processor Camera'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomDropdown(
                label: 'Scan Type: ',
                list: scanTypeStringList,
                onChanged: (String? newValue) {
                  setState(() {
                    scanTypeValue = newValue;
                    scanTypeValueFromDrowpDown =
                        dropdownController(scanTypeValue ?? '');
                  });
                },
                value: scanTypeValue,
              ),
              CustomDropdown(
                label: 'Color1: ',
                onChanged: (String? newValue) {
                  setState(() {
                    color1 = newValue;
                    color1Value = dropdownColorController(color1 ?? '');
                  });
                },
                list: colorStringList,
                value: color1,
              ),
              CustomDropdown(
                label: 'Color2: ',
                onChanged: (String? newValue) {
                  setState(() {
                    color2 = newValue;
                    color2Value = dropdownColorController(color2 ?? '');
                  });
                },
                list: colorStringList,
                value: color2,
              ),
              CustomDropdown(
                label: 'Color3: ',
                onChanged: (String? newValue) {
                  setState(() {
                    color3 = newValue;
                    color3Value = dropdownColorController(color3 ?? '');
                  });
                },
                list: colorStringList,
                value: color3,
              ),
              CustomDropdown(
                label: 'Color4: ',
                onChanged: (String? newValue) {
                  setState(() {
                    color4 = newValue;
                    color4Value = dropdownColorController(color4 ?? '');
                  });
                },
                list: colorStringList,
                value: color4,
              ),
              CustomDropdown(
                label: 'Text Color: ',
                onChanged: (String? newValue) {
                  setState(() {
                    textColor = newValue;
                    textColorValue = dropdownColorController(textColor ?? '');
                  });
                },
                list: colorStringList,
                value: textColor,
              ),
              CustomDropdown(
                label: 'Text Background Color: ',
                onChanged: (String? newValue) {
                  setState(() {
                    textBackgroundColor = newValue;
                    textBackgroundColorValue =
                        dropdownColorController(textBackgroundColor ?? '');
                  });
                },
                list: colorStringList,
                value: textBackgroundColor,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: CustomTextFormField(
                      text: 'Stroke Width',
                      controller: strokeWidthController,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: CustomTextFormField(
                      text: 'Text Size',
                      controller: textSizeController,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: CustomTextFormField(
                      text: 'Min Text Size',
                      controller: minTextSizeController,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: CustomTextFormField(
                      text: 'Granularity',
                      controller: granularityController,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomSwitchButton(
                    label: 'Scan Mode',
                    onChanged: (dynamic value) {
                      setState(() {
                        switchMode = value;
                      });
                    },
                    value: switchMode,
                    leftLabel: 'Sync',
                    rightLabel: 'Async',
                  ),
                  CustomSwitchButton(
                    label: 'Is Gallery Available',
                    onChanged: (dynamic value) {
                      setState(() {
                        switchGallery = value;
                      });
                    },
                    value: switchGallery,
                    leftLabel: 'False',
                    rightLabel: 'True',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomSwitchButton(
                    label: 'Show Text',
                    onChanged: (dynamic value) {
                      setState(() {
                        showText = value;
                      });
                    },
                    value: showText,
                    leftLabel: 'False',
                    rightLabel: 'True',
                  ),
                  CustomSwitchButton(
                    label: 'Show Text Out Bounds',
                    onChanged: (dynamic value) {
                      setState(() {
                        showTextOutBounds = value;
                      });
                    },
                    value: showTextOutBounds,
                    leftLabel: 'False',
                    rightLabel: 'True',
                  ),
                ],
              ),
              CustomSwitchButton(
                label: 'Auto Size Text',
                onChanged: (dynamic value) {
                  setState(() {
                    autoSizeText = value;
                  });
                },
                value: autoSizeText,
                leftLabel: 'False',
                rightLabel: 'True',
              ),
              CustomButton(
                text: 'Open Camera',
                onPressed: multiCameraView,
              ),
              CustomButton(
                text: 'Show Unique Elements',
                onPressed: () {
                  setState(() {
                    responseListWidget = getUniqueList(responseListWidget);
                  });
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
                              scanList?.scanResponseList![index]?.scanType,
                          result:
                              scanList?.scanResponseList![index]?.originalValue,
                          resultType:
                              scanList?.scanResponseList![index]?.scanTypeForm,
                        );
                      },
                    )
                  : const SizedBox.shrink(),
              responseListWidget.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: responseListWidget.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ResponseWidget(
                          isMulti: true,
                          codeFormat: responseListWidget[index].scanType,
                          result: responseListWidget[index].originalValue,
                          resultType: responseListWidget[index].scanTypeForm,
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
