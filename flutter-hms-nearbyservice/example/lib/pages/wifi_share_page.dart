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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice_example/utils/constants.dart';
import 'package:huawei_nearbyservice_example/widgets/custom_button.dart';

class WifiSharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Wifi Sharing',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: WifiSharePageContent(),
    );
  }
}

class WifiSharePageContent extends StatefulWidget {
  @override
  _WifiSharePageContentState createState() => _WifiSharePageContentState();
}

class _WifiSharePageContentState extends State<WifiSharePageContent> {
  String _sdkVersion = 'Unknown';
  String _endpointId;
  String _authCode = 'Unknown';
  int _statusCode = 234;
  String _logs = 'Double tap to clear the logs.\n';

  void _setListeners() {
    HMSWifiShareEngine.instance.wifiOnFound
        .listen((WifiOnFoundResponse response) {
      String res = jsonEncode(response.toMap());
      setState(() {
        _endpointId = response.endpointId;
        _logs += 'wifiOnFound\n $res \n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnFetchAuthCode
        .listen((WifiOnFetchAuthCodeResponse response) {
      setState(() {
        _authCode = response.authCode;
        _logs += 'wifiOnFetchAuthCode\n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnShareResult
        .listen((WifiShareResultResponse response) {
      setState(() {
        _statusCode = response.statusCode;
        _logs += 'wifiOnShareResult\n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnLost.listen((String endpointId) {
      setState(() {
        _logs += 'Endpoint lost! $_endpointId \n';
      });
    });
  }

  void _startWifiBroadcast(context) async {
    try {
      await HMSWifiShareEngine.instance.startWifiShare(WifiSharePolicy.set);
      Scaffold.of(context).showSnackBar(createSnack("Wifi broadcast started."));
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _startWifiScan(context) async {
    try {
      await HMSWifiShareEngine.instance.startWifiShare(WifiSharePolicy.share);
      Scaffold.of(context).showSnackBar(createSnack("Wifi scan started."));
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _shareWifiConfig(context) async {
    if (_endpointId == null) {
      Scaffold.of(context)
          .showSnackBar(createSnack("No endpoint found!", true));
      return;
    }
    try {
      Scaffold.of(context)
          .showSnackBar(createSnack("Attempting to share wifi config..."));
      await HMSWifiShareEngine.instance.shareWifiConfig(_endpointId);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopWifiSharing(context) async {
    try {
      await HMSWifiShareEngine.instance.stopWifiShare();
      Scaffold.of(context).showSnackBar(createSnack("Wifi share stopped."));
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _handleException(e, context) async {
    SnackBar snackBar = createSnack(e.message, true);
    setState(() {
      _logs += e.message + '\n';
    });
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    HMSWifiShareEngine.instance.stopWifiShare();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Running with: Nearby Service $_sdkVersion\n',
              style: Styles.textContentStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Endpoint id : $_endpointId'),
                Text('Auth code : $_authCode'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Share Result: ' + NearbyStatus.getStatus(_statusCode).message,
              style: Styles.textContentStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onDoubleTap: () => setState(() => _logs = ""),
                  child: SingleChildScrollView(
                    child: Text(_logs),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          text: 'Start Wifi Broadcast',
                          onPressed: () async {
                            _startWifiBroadcast(context);
                          },
                        ),
                        CustomButton(
                          text: 'Start Wifi Scan',
                          onPressed: () async {
                            _startWifiScan(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          text: 'Share Wifi Config',
                          onPressed: () async {
                            _shareWifiConfig(context);
                          },
                        ),
                        CustomButton(
                          text: 'Stop Wifi Share',
                          onPressed: () async {
                            _stopWifiSharing(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> initPlatformState() async {
    _setListeners();
    String sdkVersion;
    try {
      sdkVersion = await HMSNearby.getVersion();
    } on PlatformException {
      sdkVersion = 'Failed to get sdk version.';
    }

    if (!mounted) return;

    setState(() {
      _sdkVersion = sdkVersion;
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
}
