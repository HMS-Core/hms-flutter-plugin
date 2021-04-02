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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:huawei_ads_example/utils/constants.dart';

class InstallReferrerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Huawei Ads - Referrer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: InstallReferrerPageContent(),
    );
  }
}

class InstallReferrerPageContent extends StatefulWidget {
  @override
  _InstallReferrerPageContentState createState() =>
      _InstallReferrerPageContentState();
}

class _InstallReferrerPageContentState
    extends State<InstallReferrerPageContent> {
  InstallReferrerClient sdkReferrer = new InstallReferrerClient();
  bool _referrerConnected = false;

  ReferrerDetails _referrerDetails;

  void getReferrerDetails() async {
    ReferrerDetails referrerDetails;
    referrerDetails = await sdkReferrer.getInstallReferrer;

    setState(() {
      _referrerDetails = referrerDetails;
    });
  }

  SnackBar createSnack(String message, [bool isWarning = false]) {
    if (!isWarning) {
      return SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
        ),
      );
    } else {
      return SnackBar(
        backgroundColor: Colors.redAccent,
        duration: Duration(milliseconds: 1500),
        content: Text(
          message,
          style: Styles.warningTextStyle,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sdkReferrer.stateListener == null) {
      sdkReferrer.stateListener =
          (InstallReferrerStateEvent event, {ReferrerResponse responseCode}) {
        print("Referrer State event : $event | Code : $responseCode");
        SnackBar snackBar;
        if (event == InstallReferrerStateEvent.setupFinished) {
          _referrerConnected = true;
          snackBar = createSnack(
              'Connection setup finished. \n Referrer Response : ${describeEnum(responseCode)}');
        } else if (event == InstallReferrerStateEvent.connectionClosed) {
          _referrerConnected = false;
          snackBar = createSnack('Connection closed successfully.');
        } else {
          _referrerConnected = false;
          snackBar = createSnack('Referrer disconnected.');
        }
        Scaffold.of(context).showSnackBar(snackBar);
      };
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50),
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Container(
                        child: Center(
                          child: Text(
                            'Connect',
                            style: Styles.adControlButtonStyle,
                          ),
                        ),
                        width: 90,
                        height: 40,
                      ),
                      onPressed: () {
                        if (_referrerConnected) {
                          SnackBar snackBar =
                              createSnack('Referrer already connected.');
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          sdkReferrer.startConnection(true); // Test mode
                        }
                      },
                    ),
                    RaisedButton(
                      child: Container(
                        child: Center(
                          child: Text(
                            'Disconnect',
                            style: Styles.adControlButtonStyle,
                          ),
                        ),
                        width: 90,
                        height: 40,
                      ),
                      onPressed: () {
                        if (!_referrerConnected) {
                          SnackBar snackBar =
                              createSnack('Referrer already disconnected.');
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          sdkReferrer.endConnection();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Container(
                  child: Center(
                    child: Text(
                      'Get Referrer Details',
                      style: Styles.adControlButtonStyle,
                    ),
                  ),
                  width: 150,
                  height: 40,
                ),
                onPressed: () {
                  if (!_referrerConnected) {
                    SnackBar snackBar = createSnack(
                        'Referrer connection must be established first!', true);
                    Scaffold.of(context).showSnackBar(snackBar);
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
                  Text('Install Referrer', style: Styles.headerTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_referrerDetails?.getInstallReferrer ?? " "}',
                    style: Styles.textContentStyle,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Referrer Click Timestamp Millisec',
                      style: Styles.headerTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_referrerDetails?.getReferrerClickTimestampMillisecond ?? " "}',
                    style: Styles.textContentStyle,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Install Begin Timestamp Millisec',
                      style: Styles.headerTextStyle),
                  SizedBox(
                    height: 10,
                  ),
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
