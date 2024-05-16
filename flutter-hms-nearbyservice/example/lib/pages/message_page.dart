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

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messaging',
        ),
      ),
      body: const MessagingPageContent(),
    );
  }
}

class MessagingPageContent extends StatefulWidget {
  const MessagingPageContent({Key? key}) : super(key: key);

  @override
  State<MessagingPageContent> createState() => _MessagingPageContentState();
}

class _MessagingPageContentState extends State<MessagingPageContent> {
  String _sdkVersion = 'Unknown';
  String _logs = 'Double tap to clear the logs.\n';
  String _receivedMsg = 'Unknown';
  final Message _message = Message(
    content: Uint8List.fromList(
      utf8.encode('Hello there!'),
    ),
  );
  NearbyMessageHandler _handler = NearbyMessageHandler();
  MessageStatusCallback _statusCb = MessageStatusCallback();
  bool _isGetActive = false;
  bool _isPutActive = false;
  bool _isCallbackRegistered = false;

  void _get(BuildContext context) async {
    try {
      if (_isGetActive) {
        showSnackBar('Get already started.', true);
        return;
      }
      await HMSMessageEngine.instance.get(_handler);
      showSnackBar('Message get started.');
      setState(() {
        _isGetActive = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unget(BuildContext context) async {
    if (!_isGetActive) {
      showSnackBar('Get already stopped.', true);
      return;
    }
    try {
      await HMSMessageEngine.instance.unget(_handler);
      showSnackBar('Message unget successful.');
      setState(() {
        _isGetActive = false;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _put() async {
    if (_isPutActive) {
      showSnackBar('Put already started.', true);
      return;
    }
    try {
      await HMSMessageEngine.instance.put(_message);
      showSnackBar('Message put started.');
      setState(() {
        _isPutActive = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unput(BuildContext context) async {
    try {
      if (!_isPutActive) {
        showSnackBar('Put already stopped.', true);
        return;
      }
      HMSMessageEngine.instance.unput(_message);
      showSnackBar('Message unput successful.');
      setState(() {
        _isPutActive = false;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _registerStatusCallback(BuildContext context) async {
    try {
      if (_isCallbackRegistered) {
        showSnackBar('Status callback already registered.', true);
        return;
      }
      HMSMessageEngine.instance.registerStatusCallback(_statusCb);
      showSnackBar('Register callback successful.');
      setState(() {
        _isCallbackRegistered = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unregisterStatusCallback(BuildContext context) async {
    try {
      if (!_isCallbackRegistered) {
        showSnackBar('No callback registered.', true);
        return;
      }
      HMSMessageEngine.instance.unregisterStatusCallback(_statusCb);
      showSnackBar('Unregister callback successful.');
      setState(() {
        _isCallbackRegistered = false;
      });
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
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Text('Get active : $_isGetActive'),
              Text('Put active : $_isPutActive'),
            ],
          ),
        ),
        Text(
          'Message: $_receivedMsg\n',
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlexButton(
                        text: 'Put',
                        onPressed: () async {
                          _put();
                        },
                      ),
                      FlexButton(
                        text: 'Unput',
                        onPressed: () async {
                          _unput(context);
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
                        text: 'Get',
                        onPressed: () async {
                          _get(context);
                        },
                      ),
                      FlexButton(
                        text: 'Unget',
                        onPressed: () async {
                          _unget(context);
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
                        text: 'Register status callback',
                        onPressed: () async {
                          _registerStatusCallback(context);
                        },
                      ),
                      FlexButton(
                        text: 'Unregister status callback',
                        onPressed: () async {
                          _unregisterStatusCallback(context);
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
    );
  }

  @override
  void dispose() {
    HMSMessageEngine.instance.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String sdkVersion;
    _handler = NearbyMessageHandler(
      onBleSignalChanged: (Message message, BleSignal signal) {
        String msg = jsonEncode(message.toMap());
        String snl = jsonEncode(signal.toMap());
        setState(() {
          _logs += 'onBleSignalChanged\n $msg\n $snl\n';
        });
      },
      onDistanceChanged: (Message message, Distance distance) {
        String msg = jsonEncode(message.toMap());
        String dst = jsonEncode(distance.toMap());
        setState(() {
          _logs += 'onDistanceChanged\n $msg\n $dst\n';
        });
      },
      onFound: (Message message) {
        setState(() {
          _receivedMsg = utf8.decode(message.content!.toList());
          _logs += 'onFound\n';
        });
      },
      onLost: (Message message) {
        String msg = jsonEncode(message.toMap());
        setState(() {
          _logs += 'onLost\n $msg\n';
        });
      },
    );

    _statusCb = MessageStatusCallback(
      onPermissionChanged: (bool? granted) =>
          setState(() => _logs += 'onPermissionChanged\n Granted : $granted'),
    );

    try {
      sdkVersion = (await HMSNearby.getVersion())!;
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
