/*
 * Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_scan/HmsScanLibrary.dart';

import 'package:huawei_scan_example/widgets/CustomButton.dart';
import 'package:huawei_scan_example/widgets/ResponseWidget.dart';
import 'package:huawei_scan_example/Utils.dart';

class CustomizedViewScreen extends StatefulWidget {
  @override
  _CustomizedViewScreenState createState() => _CustomizedViewScreenState();
}

class _CustomizedViewScreenState extends State<CustomizedViewScreen> {
  String resultScan;
  int codeFormatScan;
  int resultTypeScan;

  List<ScanResponse> responseList = [];

  @override
  void initState() {
    super.initState();
    customizedView();
  }

  void resume() async {
    try {
      await HmsCustomizedView.resumeScan();
    } on PlatformException catch (e) {
      if (e.code == HmsScanErrors.remoteViewError.errorCode) {
        debugPrint(HmsScanErrors.remoteViewError.errorMessage);
      }
    }
  }

  void pause() async {
    try {
      await HmsCustomizedView.pauseScan();
    } on PlatformException catch (e) {
      if (e.code == HmsScanErrors.remoteViewError.errorCode) {
        debugPrint(HmsScanErrors.remoteViewError.errorMessage);
      }
    }
  }

  void switchLight() async {
    try {
      await HmsCustomizedView.switchLight();
    } on PlatformException catch (e) {
      if (e.code == HmsScanErrors.remoteViewError.errorCode) {
        debugPrint(HmsScanErrors.remoteViewError.errorMessage);
      }
    }
  }

  void switchLightOnLightStatus() async {
    try {
      if (await HmsCustomizedView.getLightStatus() == false) {
        switchLight();
      }
    } on PlatformException catch (e) {
      if (e.code == HmsScanErrors.remoteViewError.errorCode) {
        debugPrint(HmsScanErrors.remoteViewError.errorMessage);
      }
    }
  }

  customizedView() async {
    responseList = [];
    ScanResponse response =
        await HmsCustomizedView.startCustomizedView(CustomizedViewRequest(
      scanType: HmsScanTypes.AllScanType,
      continuouslyScan: false,
      isFlashAvailable: true,
      flashOnLightChange: false,
      customizedCameraListener: (ScanResponse response) {
        pause();
        setState(() {
          responseList.add(response);
        });
        resume();
      },
      customizedLifeCycleListener: (CustomizedViewEvent lifecycleStatus) {
        debugPrint("Customized View LifeCycle Listener: " +
            lifecycleStatus.toString());
        if (lifecycleStatus == CustomizedViewEvent.onStart) {
          Future.delayed(const Duration(seconds: 5), () async {
            switchLightOnLightStatus();
          });
        }
      },
    ));
    setState(() {
      resultScan = response.originalValue;
      codeFormatScan = response.scanType;
      resultTypeScan = response.scanTypeForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Customized View Screen'),
        ),
        body: resultScan == null && responseList.isEmpty
            ? AlertDialog(
                content: Text("Please scan a valid barcode."),
                actions: [
                  RaisedButton(
                      child: Text("Back"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              )
            : resultScan == null
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      CustomButton(
                        text: "Show Unique Elements",
                        onPressed: () {
                          setState(() {
                            responseList = getUniqueList(responseList);
                          });
                        },
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: responseList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return ResponseWidget(
                              isMulti: true,
                              codeFormat: responseList[index].scanType,
                              result: responseList[index].originalValue,
                              resultType: responseList[index].scanTypeForm,
                            );
                          })
                    ],
                  ))
                : SingleChildScrollView(
                    child: ResponseWidget(
                    isMulti: false,
                    codeFormat: codeFormatScan,
                    result: resultScan,
                    resultType: resultTypeScan,
                  )));
  }
}
