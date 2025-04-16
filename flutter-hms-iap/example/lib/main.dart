/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_iap/huawei_iap.dart';

import 'package:huawei_iap_example/utils/CustomButton.dart';
import 'package:huawei_iap_example/HomePage.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? isEnvReadyStatus;
  String? sandboxReadyStatus;
  bool hmsLoggerStatus = true;

  @override
  void initState() {
    super.initState();
    enablePendingPurchase();
  }

  void enablePendingPurchase() async {
    String result = await IapClient.enablePendingPurchase();
    log(result);
  }

  void environmentCheck() async {
    isEnvReadyStatus = null;
    try {
      IsEnvReadyResult response = await IapClient.isEnvReady();
      setState(() {
        if (response.status != null)
          isEnvReadyStatus = response.status!.statusMessage;
      });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.LOG_IN_ERROR.resultCode) {
        log(HmsIapResults.LOG_IN_ERROR.resultMessage!);
      } else {
        log(e.toString());
      }
    }
  }

  void sandboxCheck() async {
    try {
      sandboxReadyStatus = null;
      IsSandboxActivatedResult response = await IapClient.isSandboxActivated();
      setState(() {
        sandboxReadyStatus = response.isSandboxUser.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        log(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei IAP Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/HUAWEI_IAP_icon.png'),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Huawei',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'In App Purchases',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Flutter Plugin Demo',
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Huawei's In-App Purchases (IAP) service allows you to offer in-app purchases and facilitates in-app payment. Users can purchase a variety of virtual products, including one-time virtual products and subscriptions, directly within your app.",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Before using HUAWEI IAP in your app, send an isEnvReady request from your app to HUAWEI IAP to check whether the currently signed-in HUAWEI ID is located in a location where HUAWEI IAP is available.',
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                onPressed: environmentCheck,
                text: 'Check Environment Status',
              ),
              isEnvReadyStatus == null
                  ? SizedBox.shrink()
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Environment Status: ' + isEnvReadyStatus!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => HomePage(),
                              ),
                            );
                          },
                          text: 'Products',
                        )
                      ],
                    ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sandbox testing allows you to complete end-to-end testing without real payments when you connect to HUAWEI IAP for joint commissioning. You can configure test accounts in AppGallery Connect and allow these testers to perform sandbox testing.',
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                onPressed: sandboxCheck,
                text: 'Check Sandbox Status',
              ),
              sandboxReadyStatus == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Is Sandbox User: ' + sandboxReadyStatus!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "This method enables/disables the HMSLogger capability which is used for sending usage analytics of Huawei IAP SDK's methods to improve the service quality.",
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                text: 'Enable/Disable Hms Logger',
                onPressed: () {
                  if (hmsLoggerStatus) {
                    IapClient.disableLogger();
                    hmsLoggerStatus = false;
                  } else {
                    IapClient.enableLogger();
                    hmsLoggerStatus = true;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
