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

class DiscoveryTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Discover & Transfer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DiscoveryTransferPageContent(),
    );
  }
}

class DiscoveryTransferPageContent extends StatefulWidget {
  @override
  _DiscoveryTransferPageContentState createState() =>
      _DiscoveryTransferPageContentState();
}

class _DiscoveryTransferPageContentState
    extends State<DiscoveryTransferPageContent> {
  String _sdkVersion = 'Unknown';
  String _endpointId;
  String _endpointName;
  String _msg = 'Unknown';
  String _logs = 'Double tap to clear the logs.\n';
  bool _isEstablished;
  bool _isConnected = false;

  void _setListeners() {
    HMSDiscoveryEngine.instance.scanOnFound
        .listen((ScanOnFoundResponse response) {
      setState(() {
        _endpointId = response.endpointId;
        _endpointName = response.scanEndpointInfo.name;
        _logs += 'scanOnFound\n';
      });
    });

    HMSDiscoveryEngine.instance.scanOnLost.listen((String endpointId) {
      setState(() {
        _endpointId = 'Unknown';
        _endpointName = 'Unknown';
        _logs += 'Endpoint lost $endpointId';
      });
    });

    HMSDiscoveryEngine.instance.connectOnEstablish
        .listen((ConnectOnEstablishResponse response) {
      setState(() {
        _isEstablished = true;
        _endpointId = response.endpointId;
        _endpointName = response.connectInfo.endpointName;
        _logs += 'connectOnEstablish\n';
      });
    });

    HMSDiscoveryEngine.instance.connectOnResult
        .listen((ConnectOnResultResponse response) {
      String res = jsonEncode(response.toMap());
      setState(() {
        _logs += 'connectOnResult\n' + res + '\n';
        if (response.connectResult.statusCode == NearbyStatus.success.code)
          _isConnected = true;
      });
    });

    HMSTransferEngine.instance.dataOnTransferUpdate
        .listen((DataOnTransferUpdateResponse response) {
      String res = jsonEncode(response.toMap());
      setState(() {
        _logs += 'dataOnTransferUpdate\n' + res + '\n';
      });
    });

    HMSTransferEngine.instance.dataOnReceived
        .listen((DataOnReceivedResponse response) {
      String msg;
      if (response.data?.type == DataTypes.bytes) {
        msg = utf8.decode(response.data.bytes);
      } else if (response.data?.type == DataTypes.stream) {
        msg = utf8.decode(response.data.stream.content);
      } else if (response?.data?.type == DataTypes.file) {
        msg = response.data.file.filePath;
      } else {
        msg = 'Unsupported data type';
      }
      setState(() {
        _msg = msg;
      });
    });
  }

  void _startBroadcast(context) async {
    try {
      await HMSDiscoveryEngine.instance.startBroadcasting(
        name: "SERVICE-1",
        serviceId: "SERVICE-1",
        broadcastOption: BroadcastOption(DiscoveryPolicy.p2p),
      );
      Scaffold.of(context).showSnackBar(createSnack("Broadcast started."));
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopBroadcast(context) async {
    HMSDiscoveryEngine.instance.stopBroadcasting();
    Scaffold.of(context).showSnackBar(createSnack("Broadcast stopped."));
  }

  void _startScan(context) async {
    try {
      await HMSDiscoveryEngine.instance.startScan(
          serviceId: "SERVICE-1", scanOption: ScanOption(DiscoveryPolicy.p2p));
      Scaffold.of(context).showSnackBar(createSnack("Scan started."));
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopScan(context) async {
    HMSDiscoveryEngine.instance.stopScan();
    Scaffold.of(context).showSnackBar(createSnack("Scan stopped."));
  }

  void _requestConnect(context) async {
    if (_endpointId == null || _endpointName == null) {
      Scaffold.of(context)
          .showSnackBar(createSnack("No endpoint found!", true));
      return;
    }
    try {
      await HMSDiscoveryEngine.instance
          .requestConnect(name: _endpointName, endpointId: _endpointId);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _acceptConnect(context) async {
    if (_endpointId == null) {
      Scaffold.of(context)
          .showSnackBar(createSnack("No endpoint found!", true));
      return;
    }
    try {
      await HMSDiscoveryEngine.instance.acceptConnect(_endpointId);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _rejectConnect(context) async {
    if (_endpointName == null || !_isEstablished) {
      Scaffold.of(context)
          .showSnackBar(createSnack('There no established connection!', true));
      return;
    }
    try {
      await HMSDiscoveryEngine.instance.rejectConnect(_endpointId);
      setState(() {
        _isEstablished = false;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _disconnect(context) async {
    if (_endpointName == null || !_isConnected) {
      Scaffold.of(context).showSnackBar(
          createSnack('You are not connected to an endpoint!', true));
      return;
    }
    await HMSDiscoveryEngine.instance.disconnect(_endpointId);
    setState(() {
      _isConnected = false;
    });
  }

  void _sendByteData(context) async {
    if (_endpointName == null || !_isConnected) {
      Scaffold.of(context).showSnackBar(
          createSnack('You are not connected to an endpoint!', true));
      return;
    }
    try {
      String msg = "Hello there  $_endpointId!";
      TransferData data = TransferData.fromBytes(utf8.encode(msg));
      await HMSTransferEngine.instance.sendData(_endpointId, data);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _sendStreamData(context) async {
    if (_endpointName == null || !_isConnected) {
      Scaffold.of(context).showSnackBar(
          createSnack('You are not connected to an endpoint!', true));
      return;
    }
    try {
      String msg = "Hello there  $_endpointId, with streams!";
      TransferData data = TransferData.fromStream(content: utf8.encode(msg));
      await HMSTransferEngine.instance.sendData(_endpointId, data);
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
                Text('Endpoint name : $_endpointName'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Connected: $_isConnected\n',
              style: Styles.textContentStyle,
            ),
          ),
          Container(
            child: Text(
              'Message: $_msg\n',
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
                          text: 'Start Broadcast',
                          onPressed: () async {
                            _startBroadcast(context);
                          },
                        ),
                        CustomButton(
                          text: 'Stop Broadcast',
                          onPressed: () async {
                            _stopBroadcast(context);
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
                          text: 'Start Scan',
                          onPressed: () async {
                            _startScan(context);
                          },
                        ),
                        CustomButton(
                          text: 'Stop Scan',
                          onPressed: () async {
                            _stopScan(context);
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
                          text: 'Request Connect',
                          onPressed: () async {
                            _requestConnect(context);
                          },
                        ),
                        CustomButton(
                          text: 'Accept Connect',
                          onPressed: () async {
                            _acceptConnect(context);
                          },
                        )
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
                          text: 'Reject Connect',
                          onPressed: () async {
                            _rejectConnect(context);
                          },
                        ),
                        CustomButton(
                          text: 'Disconnect',
                          onPressed: () async {
                            _disconnect(context);
                          },
                        )
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
                          text: 'Send Bytes',
                          width: 100,
                          onPressed: () async {
                            _sendByteData(context);
                          },
                        ),
                        CustomButton(
                          text: 'Send Stream',
                          width: 100,
                          onPressed: () async {
                            _sendStreamData(context);
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

  @override
  void dispose() {
    HMSDiscoveryEngine.instance.disconnectAll();
    super.dispose();
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
