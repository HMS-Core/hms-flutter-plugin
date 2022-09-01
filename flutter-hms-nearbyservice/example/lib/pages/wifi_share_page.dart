/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice_example/utils/constants.dart';
import 'package:huawei_nearbyservice_example/widgets/custom_button.dart';

class WifiSharePage extends StatelessWidget {
  const WifiSharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Wifi Sharing',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const WifiSharePageContent(),
    );
  }
}

class WifiSharePageContent extends StatefulWidget {
  const WifiSharePageContent({Key? key}) : super(key: key);

  @override
  State<WifiSharePageContent> createState() => _WifiSharePageContentState();
}

class _WifiSharePageContentState extends State<WifiSharePageContent> {
  String _sdkVersion = 'Unknown';
  String? _endpointId;
  String _authCode = 'Unknown';
  int _statusCode = 234;
  String _logs = 'Double tap to clear the logs.\n';

  void _setListeners() {
    HMSWifiShareEngine.instance.wifiOnFound!
        .listen((WifiOnFoundResponse? response) {
      String res = jsonEncode(response!.toMap());
      setState(() {
        _endpointId = response.endpointId!;
        _logs += 'wifiOnFound\n $res \n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnFetchAuthCode!
        .listen((WifiOnFetchAuthCodeResponse? response) {
      setState(() {
        _authCode = response!.authCode!;
        _logs += 'wifiOnFetchAuthCode\n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnShareResult!
        .listen((WifiShareResultResponse? response) {
      setState(() {
        _statusCode = response!.statusCode!;
        _logs += 'wifiOnShareResult\n';
      });
    });

    HMSWifiShareEngine.instance.wifiOnLost!.listen((String? endpointId) {
      setState(() {
        _logs += 'Endpoint lost! $_endpointId \n';
      });
    });
  }

  void _startWifiBroadcast(BuildContext context) async {
    try {
      await HMSWifiShareEngine.instance.startWifiShare(WifiSharePolicy.set);
      showSnackBar('Wifi broadcast started.');
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _startWifiScan(BuildContext context) async {
    try {
      await HMSWifiShareEngine.instance.startWifiShare(WifiSharePolicy.share);
      showSnackBar('Wifi scan started.');
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _shareWifiConfig(BuildContext context) async {
    if (_endpointId == null) {
      showSnackBar('No endpoint found!', true);
      return;
    }
    try {
      showSnackBar('Attempting to share wifi config...');
      await HMSWifiShareEngine.instance.shareWifiConfig(_endpointId!);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopWifiSharing(BuildContext context) async {
    try {
      await HMSWifiShareEngine.instance.stopWifiShare();
      showSnackBar('Wifi share stopped.');
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _handleException(dynamic e, BuildContext context) async {
    setState(() {
      _logs += e.message + '\n';
    });
    showSnackBar(e.message, true);
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
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Running with: Nearby Service $_sdkVersion\n',
              style: Styles.textContentStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Endpoint id : $_endpointId'),
                Text('Auth code : $_authCode'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Share Result: ${NearbyStatus.getStatus(_statusCode).message}',
              style: Styles.textContentStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onDoubleTap: () => setState(() => _logs = ''),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                    const SizedBox(
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
                    const SizedBox(
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
      sdkVersion = (await HMSNearby.getVersion())!;
    } on PlatformException {
      sdkVersion = 'Failed to get sdk version.';
    }

    if (!mounted) return;

    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  void showSnackBar(String message, [bool isWarning = false]) {
    ScaffoldMessenger.of(context).showSnackBar(
      isWarning
          ? SnackBar(
              backgroundColor: Colors.redAccent,
              duration: const Duration(milliseconds: 1500),
              content: Text(
                message,
                style: Styles.warningTextStyle,
              ),
            )
          : SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(
                message,
              ),
            ),
    );
  }
}
