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

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Messaging',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: MessagingPageContent(),
    );
  }
}

class MessagingPageContent extends StatefulWidget {
  @override
  _MessagingPageContentState createState() => _MessagingPageContentState();
}

class _MessagingPageContentState extends State<MessagingPageContent> {
  String _sdkVersion = 'Unknown';
  String _logs = 'Double tap to clear the logs.\n';
  String _receivedMsg = 'Unknown';
  Message _message = Message(content: utf8.encode("Hello there!"));
  NearbyMessageHandler _handler;
  MessageStatusCallback _statusCb;
  bool _isGetActive = false;
  bool _isPutActive = false;
  bool _isCallbackRegistered = false;

  void _get(context) async {
    try {
      if (_isGetActive) {
        Scaffold.of(context)
            .showSnackBar(createSnack("Get already started.", true));
        return;
      }
      await HMSMessageEngine.instance.get(_handler);
      Scaffold.of(context).showSnackBar(createSnack("Message get started."));
      setState(() {
        _isGetActive = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unget(context) async {
    if (!_isGetActive) {
      Scaffold.of(context)
          .showSnackBar(createSnack("Get already stopped.", true));
      return;
    }
    try {
      await HMSMessageEngine.instance.unget(_handler);
      Scaffold.of(context)
          .showSnackBar(createSnack("Message unget successful."));
      setState(() {
        _isGetActive = false;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _put(context) async {
    if (_isPutActive) {
      Scaffold.of(context)
          .showSnackBar(createSnack("Put already started.", true));
      return;
    }
    try {
      await HMSMessageEngine.instance.put(_message);
      Scaffold.of(context).showSnackBar(createSnack("Message put started."));
      setState(() {
        _isPutActive = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unput(context) async {
    try {
      if (!_isPutActive) {
        Scaffold.of(context)
            .showSnackBar(createSnack("Put already stopped.", true));
        return;
      }
      HMSMessageEngine.instance.unput(_message);
      Scaffold.of(context)
          .showSnackBar(createSnack("Message unput successful."));
      setState(() {
        _isPutActive = false;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _registerStatusCallback(context) async {
    try {
      if (_isCallbackRegistered) {
        Scaffold.of(context).showSnackBar(
            createSnack("Status callback already registered.", true));
        return;
      }
      HMSMessageEngine.instance.registerStatusCallback(_statusCb);
      Scaffold.of(context)
          .showSnackBar(createSnack("Register callback successful."));
      setState(() {
        _isCallbackRegistered = true;
      });
    } on PlatformException catch (e) {
      _handleException(e, context);
    }
  }

  void _unregisterStatusCallback(context) async {
    try {
      if (!_isCallbackRegistered) {
        Scaffold.of(context)
            .showSnackBar(createSnack("No callback registered.", true));
        return;
      }
      HMSMessageEngine.instance.unregisterStatusCallback(_statusCb);
      Scaffold.of(context)
          .showSnackBar(createSnack("Unregister callback successful."));
      setState(() {
        _isCallbackRegistered = false;
      });
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
    return Container(
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
                Text('Get active : $_isGetActive'),
                Text('Put active : $_isPutActive'),
              ],
            ),
          ),
          Container(
            child: Text(
              'Message: $_receivedMsg\n',
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
                          text: 'Put',
                          onPressed: () async {
                            _put(context);
                          },
                        ),
                        CustomButton(
                          text: 'Unput',
                          onPressed: () async {
                            _unput(context);
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
                          text: 'Get',
                          onPressed: () async {
                            _get(context);
                          },
                        ),
                        CustomButton(
                          text: 'Unget',
                          onPressed: () async {
                            _unget(context);
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
                          text: 'Register status callback',
                          width: 100,
                          height: 60,
                          onPressed: () async {
                            _registerStatusCallback(context);
                          },
                        ),
                        CustomButton(
                          text: 'Unregister status callback',
                          width: 100,
                          height: 60,
                          onPressed: () async {
                            _unregisterStatusCallback(context);
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
    HMSMessageEngine.instance.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String sdkVersion;
    _handler = NearbyMessageHandler(onBleSignalChanged: (message, signal) {
      String msg = jsonEncode(message?.toMap());
      String snl = jsonEncode(signal?.toMap());
      setState(() {
        _logs += 'onBleSignalChanged\n $msg\n $snl\n';
      });
    }, onDistanceChanged: (message, distance) {
      String msg = jsonEncode(message?.toMap());
      String dst = jsonEncode(distance?.toMap());
      setState(() {
        _logs += 'onDistanceChanged\n $msg\n $dst\n';
      });
    }, onFound: (message) {
      setState(() {
        _receivedMsg = utf8.decode(message.content);
        _logs += 'onFound\n';
      });
    }, onLost: (message) {
      String msg = jsonEncode(message?.toMap());
      setState(() {
        _logs += 'onLost\n $msg\n';
      });
    });

    _statusCb = MessageStatusCallback(
      onPermissionChanged: (bool granted) =>
          setState(() => _logs += 'onPermissionChanged\n Granted : $granted'),
    );

    try {
      sdkVersion = await HMSNearby.getVersion();
    } on PlatformException {
      sdkVersion = 'Failed to get SDK version.';
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
