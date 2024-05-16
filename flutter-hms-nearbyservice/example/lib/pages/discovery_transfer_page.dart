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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice_example/widgets/custom_buttons.dart';

class DiscoveryTransferPage extends StatelessWidget {
  const DiscoveryTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover & Transfer',
        ),
      ),
      body: const DiscoveryTransferPageContent(),
    );
  }
}

class DiscoveryTransferPageContent extends StatefulWidget {
  const DiscoveryTransferPageContent({Key? key}) : super(key: key);

  @override
  State<DiscoveryTransferPageContent> createState() =>
      _DiscoveryTransferPageContentState();
}

class _DiscoveryTransferPageContentState
    extends State<DiscoveryTransferPageContent> {
  String _sdkVersion = 'Unknown';
  String _endpointId = 'Unknown';
  String _endpointName = 'Unknown';
  String _msg = 'Unknown';
  String _logs = 'Double tap to clear the logs.\n';
  late bool _isEstablished;
  bool _isConnected = false;
  ScrollController _scrollController = ScrollController();

  void _setListeners() {
    HMSDiscoveryEngine.instance.scanOnFound!
        .listen((ScanOnFoundResponse response) {
      setState(() {
        _endpointId = response.endpointId!;
        _endpointName = response.scanEndpointInfo!.name;
        _logs += 'scanOnFound\n';
      });
    });

    HMSDiscoveryEngine.instance.scanOnLost!.listen((String endpointId) {
      setState(() {
        _endpointId = 'Unknown';
        _endpointName = 'Unknown';
        _logs += 'Endpoint lost $endpointId';
      });
    });

    HMSDiscoveryEngine.instance.connectOnEstablish!
        .listen((ConnectOnEstablishResponse response) {
      setState(() {
        _isEstablished = true;
        _endpointId = response.endpointId!;
        _endpointName = response.connectInfo!.endpointName!;
        _logs += 'connectOnEstablish\n';
      });
    });

    HMSDiscoveryEngine.instance.connectOnResult!
        .listen((ConnectOnResultResponse response) {
      String res = jsonEncode(response.toMap());
      setState(() {
        _logs += 'connectOnResult\n$res\n';
        if (response.connectResult!.statusCode == NearbyStatus.success.code) {
          _isConnected = true;
        }
      });
    });

    HMSTransferEngine.instance.dataOnTransferUpdate!
        .listen((DataOnTransferUpdateResponse response) {
      String res = jsonEncode(response.toMap());
      setState(() {
        _logs += 'dataOnTransferUpdate\n$res\n';
      });
    });

    HMSTransferEngine.instance.dataOnReceived!
        .listen((DataOnReceivedResponse response) {
      String msg;
      if (response.data?.type == DataTypes.bytes) {
        msg = utf8.decode(response.data!.bytes!.toList());
      } else if (response.data?.type == DataTypes.stream) {
        msg = utf8.decode(response.data!.stream!.content!.toList());
      } else if (response.data?.type == DataTypes.file) {
        msg = response.data!.file!.filePath!;
      } else {
        msg = 'Unsupported data type';
      }
      setState(() {
        _msg = msg;
      });
    });
  }

  void _startBroadcast(BuildContext context) async {
    try {
      await HMSDiscoveryEngine.instance.startBroadcasting(
        name: 'SERVICE-1',
        serviceId: 'SERVICE-1',
        broadcastOption: const BroadcastOption(DiscoveryPolicy.p2p),
      );
      showSnackBar('Broadcast started.');
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopBroadcast(BuildContext context) async {
    HMSDiscoveryEngine.instance.stopBroadcasting();
    showSnackBar('Broadcast stopped.');
  }

  void _startScan(BuildContext context) async {
    try {
      await HMSDiscoveryEngine.instance.startScan(
        serviceId: 'SERVICE-1',
        scanOption: ScanOption(DiscoveryPolicy.p2p),
      );
      showSnackBar('Scan started.');
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _stopScan(BuildContext context) async {
    HMSDiscoveryEngine.instance.stopScan();
    showSnackBar('Scan stopped.');
  }

  void _requestConnectEx(BuildContext context) async {
    if (_endpointName == 'Unknown') {
      showSnackBar('No endpoint found!', true);
      return;
    }
    try {
      await HMSDiscoveryEngine.instance.requestConnectEx(
        name: _endpointName,
        endpointId: _endpointId,
        channelPolicy: ConnectOption(ChannelPolicy.highThroughput),
      );
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _acceptConnect(BuildContext context) async {
    if (_endpointId == 'Unknown') {
      showSnackBar('No endpoint found!', true);
      return;
    }
    try {
      await HMSDiscoveryEngine.instance.acceptConnect(_endpointId);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _rejectConnect(BuildContext context) async {
    if (!_isEstablished) {
      showSnackBar('There is no established connection!', true);
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

  void _disconnect(BuildContext context) async {
    if (!_isConnected) {
      showSnackBar('You are not connected to an endpoint!', true);
      return;
    }
    await HMSDiscoveryEngine.instance.disconnect(_endpointId);
    setState(() {
      _isConnected = false;
    });
  }

  void _sendByteData(BuildContext context) async {
    if (!_isConnected) {
      showSnackBar('You are not connected to an endpoint!', true);
      return;
    }
    try {
      String msg = 'Hello there  $_endpointId!';
      TransferData data =
          TransferData.fromBytes((Uint8List.fromList(utf8.encode(msg))));
      await HMSTransferEngine.instance.sendData(_endpointId, data);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _sendStreamData(BuildContext context) async {
    if (!_isConnected) {
      showSnackBar('You are not connected to an endpoint!', true);
      return;
    }
    try {
      String msg = 'Hello there  $_endpointId, with streams!';
      TransferData data = TransferData.fromStream(
        content: (Uint8List.fromList(utf8.encode(msg))),
      );
      await HMSTransferEngine.instance.sendData(_endpointId, data);
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _handleException(PlatformException e, BuildContext context) async {
    setState(() {
      _logs += '${e.message}\n';
    });
    showSnackBar('${e.message}', true);
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
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Endpoint id : $_endpointId'),
                Text('Endpoint name : $_endpointName'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Connected: $_isConnected\n',
            ),
          ),
          Text(
            'Message: $_msg\n',
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
              padding: const EdgeInsets.only(top: 20.0),
              child: Scrollbar(
                controller: _scrollController,
                trackVisibility: true,
                thumbVisibility: true,
                thickness: 5,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlexButton(
                            text: 'Start Broadcast',
                            onPressed: () async {
                              _startBroadcast(context);
                            },
                          ),
                          FlexButton(
                            text: 'Stop Broadcast',
                            onPressed: () async {
                              _stopBroadcast(context);
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
                          FlexButton(
                            text: 'Start Scan',
                            onPressed: () async {
                              _startScan(context);
                            },
                          ),
                          FlexButton(
                            text: 'Stop Scan',
                            onPressed: () async {
                              _stopScan(context);
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
                          FlexButton(
                            text: 'Request Connect',
                            onPressed: () async {
                              _requestConnectEx(context);
                            },
                          ),
                          FlexButton(
                            text: 'Accept Connect',
                            onPressed: () async {
                              _acceptConnect(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlexButton(
                            text: 'Reject Connect',
                            onPressed: () async {
                              _rejectConnect(context);
                            },
                          ),
                          FlexButton(
                            text: 'Disconnect',
                            onPressed: () async {
                              _disconnect(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlexButton(
                            text: 'Send Bytes',
                            onPressed: () async {
                              _sendByteData(context);
                            },
                          ),
                          FlexButton(
                            text: 'Send Stream',
                            onPressed: () async {
                              _sendStreamData(context);
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
    late String sdkVersion;
    try {
      if (await HMSNearby.getVersion() != null) {
        sdkVersion = (await HMSNearby.getVersion())!;
      } else {
        throw ArgumentError('SDK version is null');
      }
    } on PlatformException {
      sdkVersion = 'Failed to get SDK version.';
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
