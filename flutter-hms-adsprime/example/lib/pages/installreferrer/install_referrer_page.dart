/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_adsprime/huawei_adsprime.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class InstallReferrerPage extends StatelessWidget {
  const InstallReferrerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Referrer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const InstallReferrerPageContent(),
    );
  }
}

class InstallReferrerPageContent extends StatefulWidget {
  const InstallReferrerPageContent({Key? key}) : super(key: key);

  @override
  State<InstallReferrerPageContent> createState() =>
      _InstallReferrerPageContentState();
}

class _InstallReferrerPageContentState
    extends State<InstallReferrerPageContent> {
  InstallReferrerClient? sdkReferrer = InstallReferrerClient();
  bool _referrerConnected = false;

  ReferrerDetails? _referrerDetails;

  void getReferrerDetails() async {
    ReferrerDetails? referrerDetails;
    referrerDetails = await sdkReferrer!.getInstallReferrer;

    setState(() {
      _referrerDetails = referrerDetails;
    });
  }

  SnackBar createSnack(String message, [bool isWarning = false]) {
    if (!isWarning) {
      return SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          message,
        ),
      );
    } else {
      return SnackBar(
        backgroundColor: Colors.redAccent,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: Styles.warningTextStyle,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sdkReferrer!.stateListener == null) {
      sdkReferrer!.stateListener =
          (InstallReferrerStateEvent? event, {ReferrerResponse? responseCode}) {
        debugPrint('Referrer State event : $event | Code : $responseCode');
        SnackBar snackBar;
        if (event == InstallReferrerStateEvent.setupFinished) {
          _referrerConnected = true;
          snackBar = createSnack(
            'Connection setup finished. \n Referrer Response : ${describeEnum(responseCode!)}',
          );
        } else if (event == InstallReferrerStateEvent.connectionClosed) {
          _referrerConnected = false;
          snackBar = createSnack('Connection closed successfully.');
        } else {
          _referrerConnected = false;
          snackBar = createSnack('Referrer disconnected.');
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      };
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 50),
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: const SizedBox(
                        width: 90,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Connect',
                            style: Styles.adControlButtonStyle,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_referrerConnected) {
                          SnackBar snackBar = createSnack(
                            'Referrer already connected.',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          sdkReferrer!.startConnection(true); // Test mode
                        }
                      },
                    ),
                    ElevatedButton(
                      child: const SizedBox(
                        width: 90,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Disconnect',
                            style: Styles.adControlButtonStyle,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (!_referrerConnected) {
                          SnackBar snackBar = createSnack(
                            'Referrer already disconnected.',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          sdkReferrer!.endConnection();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const SizedBox(
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Get Referrer Details',
                      style: Styles.adControlButtonStyle,
                    ),
                  ),
                ),
                onPressed: () {
                  if (!_referrerConnected) {
                    SnackBar snackBar = createSnack(
                      'Referrer connection must be established first!',
                      true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    getReferrerDetails();
                  }
                },
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Install Referrer', style: Styles.headerTextStyle),
                  const SizedBox(height: 10),
                  Text(
                    _referrerDetails?.getInstallReferrer ?? ' ',
                    style: Styles.textContentStyle,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Referrer Click Timestamp Millisec',
                    style: Styles.headerTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_referrerDetails?.getReferrerClickTimestampMillisecond ?? " "}',
                    style: Styles.textContentStyle,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Install Begin Timestamp Millisec',
                    style: Styles.headerTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_referrerDetails?.getReferrerBeginTimeStampMillisecond ?? " "}',
                    style: Styles.textContentStyle,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_referrerConnected) {
      sdkReferrer?.endConnection();
    }
    _referrerConnected = false;
    sdkReferrer = null;
  }
}
