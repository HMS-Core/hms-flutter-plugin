/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_contactshield/huawei_contactshield.dart';

import 'widgets/custom_button.dart';

void main() => runApp(MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _TOKEN = 'TOKEN_TEST';

  static const String _RUNNING_TEXT = 'ContactShield engine is RUNNING';
  static const String _NOT_RUNNING_TEXT = 'ContactShield engine is NOT RUNNING';

  bool _engineStatus = false;
  String _engineStatusText = '';
  String _exposureText = 'Click the following buttons ' +
      'if you want to check the exposures in the past 14 days';

  ContactShieldEngine _engine;
  ContactShieldCallback _callback;

  @override
  void initState() {
    super.initState();
    _engine = ContactShieldEngine();
    _callback = createCallback();
    _engine.contactShieldCallback = _callback;
    _isContactShieldRunning();
  }

  ContactShieldCallback createCallback() {
    return ContactShieldCallback(
      onHasContact: (token) {
        setState(() {
          _exposureText = 'Contact Status: Has contact\nToken: $token';
        });
      },
      onNoContact: (token) {
        setState(() {
          _exposureText = 'Contact Status: No contact\nToken: $token';
        });
      },
    );
  }

  Future<List<String>> _pickFiles(BuildContext context) async {
    List<File> files = await FilePicker.getMultiFile(
        type: FileType.custom, allowedExtensions: <String>['zip']);
    if (files == null) {
      return null;
    } else {
      List<String> paths = files.map((e) => e.path).toList();
      return paths;
    }
  }

  void _isContactShieldRunning() async {
    try {
      final bool status = await _engine.isContactShieldRunning();
      setState(() {
        _engineStatus = status;
        _engineStatusText = _engineStatus ? _RUNNING_TEXT : _NOT_RUNNING_TEXT;
      });
    } on PlatformException catch (e) {
      setState(() {
        _engineStatusText = e.toString();
      });
    }
  }

  void _startContactShield(BuildContext context) async {
    if (!_engineStatus) {
      try {
        await _engine.startContactShield();
        setState(() {
          _engineStatus = true;
          _engineStatusText = _RUNNING_TEXT;
        });
        _showDialog(context, 'Contact Shield is started.');
      } on PlatformException catch (e) {
        _showDialog(context, e.toString());
      }
    } else {
      _showDialog(context, 'Contact Shield is already running.');
    }
  }

  void _startContactShieldOld(BuildContext context) async {
    if (!_engineStatus) {
      try {
        await _engine.startContactShieldOld();
        setState(() {
          _engineStatus = true;
          _engineStatusText = _RUNNING_TEXT;
        });
        _showDialog(context, 'Contact Shield is started (Old method).');
      } on PlatformException catch (e) {
        _showDialog(context, e.toString());
      }
    } else {
      _showDialog(context, 'Contact Shield is already running.');
    }
  }

  void _startContactShieldNonPersistent(BuildContext context) async {
    if (!_engineStatus) {
      try {
        await _engine.startContactShieldNonPersistent();
        setState(() {
          _engineStatus = true;
          _engineStatusText = _RUNNING_TEXT;
        });
        _showDialog(
            context, 'Contact Shield is started in non persistent mode.');
      } on PlatformException catch (e) {
        _showDialog(context, e.toString());
      }
    } else {
      _showDialog(context, 'Contact Shield is already running.');
    }
  }

  void _getPeriodicKey(BuildContext context) async {
    try {
      final List<PeriodicKey> result = await _engine.getPeriodicKey();
      _showDialog(context, result.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _putSharedKeyFiles(BuildContext context) async {
    try {
      final DiagnosisConfiguration config = DiagnosisConfiguration();
      final files = await _pickFiles(context);
      if (files != null) {
        await _engine.putSharedKeyFiles(files, config, _TOKEN);
        _showDialog(context, 'putSharedKeyFiles Success.');
      } else {
        _showDialog(context, 'You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _putSharedKeyFilesOld(BuildContext context) async {
    try {
      final DiagnosisConfiguration config = DiagnosisConfiguration();
      final files = await _pickFiles(context);
      if (files != null) {
        await _engine.putSharedKeyFilesOld(files, config, _TOKEN);
        _showDialog(context, 'putSharedKeyFilesOld Success (Old method).');
      } else {
        _showDialog(context, 'You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getContactDetail(BuildContext context) async {
    try {
      final List<ContactDetail> contactDetails =
          await _engine.getContactDetail(_TOKEN);
      _showDialog(context, contactDetails.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getContactSketch(BuildContext context) async {
    try {
      final ContactSketch contactSketch =
          await _engine.getContactSketch(_TOKEN);
      _showDialog(context, contactSketch.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getContactWindow(BuildContext context) async {
    try {
      final List<ContactWindow> contactWindows =
          await _engine.getContactWindow();
      _showDialog(context, contactWindows.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _clearData(BuildContext context) async {
    try {
      await _engine.clearData();
      _showDialog(context, 'clearData Success.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _stopContactShield(BuildContext context) async {
    if (_engineStatus) {
      try {
        await _engine.stopContactShield();
        setState(() {
          _engineStatus = false;
          _engineStatusText = _NOT_RUNNING_TEXT;
        });
        _showDialog(context, 'Contact Shieled is stopped.');
      } on PlatformException catch (e) {
        _showDialog(context, e.toString());
      }
    } else {
      _showDialog(context, 'Contact Shield is not running. No action needed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei Contact Shield Flutter Demo'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 6,
              ),
              child: Container(
                child: Text(_engineStatusText),
                alignment: Alignment.center,
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CustomButton('Start Contact Shield', _startContactShield),
            CustomButton(
                'Start Contact Shield (Old method)', _startContactShieldOld),
            CustomButton('Start Contact Shield Non Persistent',
                _startContactShieldNonPersistent),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CustomButton(
                'Report Periodic Keys (getPeriodicKey)', _getPeriodicKey),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(),
              height: 32,
              child: Container(
                child: Text(_exposureText),
                alignment: Alignment.center,
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CustomButton('Check (putSharedKeyFiles)', _putSharedKeyFiles),
            CustomButton('Check (putSharedKeyFilesOld)', _putSharedKeyFilesOld),
            CustomButton('Get Contact Detail', _getContactDetail),
            CustomButton('Get Contact Sketch', _getContactSketch),
            CustomButton('Get Contact Window', _getContactWindow),
            CustomButton('Clear Data', _clearData),
            CustomButton('Stop Contact Shield', _stopContactShield),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Result'),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
