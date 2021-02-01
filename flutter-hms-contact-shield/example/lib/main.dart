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

  void _isContactShieldRunning(BuildContext context) async {
    try {
      final bool isRunning = await _engine.isContactShieldRunning();
      _showDialog(context, 'Is Contact Shield running: $isRunning');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _startContactShield(BuildContext context) async {
    try {
      await _engine.startContactShield();
      _showDialog(context, 'Contact Shield is started.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _startContactShieldCb(BuildContext context) async {
    try {
      await _engine.startContactShieldCb();
      _showDialog(context, 'Contact Shield is started (Old method).');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _startContactShieldNonPersistent(BuildContext context) async {
    try {
      await _engine.startContactShieldNonPersistent();
      _showDialog(context, 'Contact Shield is started in non persistent mode.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
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
        _showDialog(context, 'putSharedKeyFiles success (Deprecated method).');
      } else {
        _showDialog(context, 'You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _putSharedKeyFilesCb(BuildContext context) async {
    try {
      final DiagnosisConfiguration config = DiagnosisConfiguration();
      final files = await _pickFiles(context);
      if (files != null) {
        await _engine.putSharedKeyFilesCb(files, config, _TOKEN);
        _showDialog(context, 'putSharedKeyFilesCb success.');
      } else {
        _showDialog(context, 'You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _putSharedKeyFilesCbWithProvider(BuildContext context) async {
    try {
      final files = await _pickFiles(context);
      if (files != null) {
        await _engine.putSharedKeyFilesCbWithProvider(files);
        _showDialog(context, 'putSharedKeyFilesCbWithProvider success.');
      } else {
        _showDialog(context, 'You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _putSharedKeyFilesCbWithKeys(BuildContext context) async {
    try {
      final DiagnosisConfiguration config = DiagnosisConfiguration();
      final List<String> publicKeys = <String>["0", "1", "2"];
      final files = await _pickFiles(context);
      if (files != null) {
        await _engine.putSharedKeyFilesCbWithKeys(
            files, publicKeys, config, _TOKEN);
        _showDialog(context, 'putSharedKeyFilesCbWithKeys success.');
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

  void _setSharedKeysDataMapping(BuildContext context) async {
    try {
      final SharedKeysDataMapping sharedKeysDataMapping =
          SharedKeysDataMapping();
      await _engine.setSharedKeysDataMapping(sharedKeysDataMapping);
      _showDialog(context, 'setSharedKeysDataMapping success.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getSharedKeysDataMapping(BuildContext context) async {
    try {
      final SharedKeysDataMapping sharedKeysDataMapping =
          await _engine.getSharedKeysDataMapping();
      _showDialog(context, sharedKeysDataMapping.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getDailySketch(BuildContext context) async {
    try {
      final DailySketchConfiguration configuration = DailySketchConfiguration();
      final List<DailySketch> dailySketch =
          await _engine.getDailySketch(configuration);
      _showDialog(context, dailySketch.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getContactShieldVersion(BuildContext context) async {
    try {
      final int version = await _engine.getContactShieldVersion();
      _showDialog(context, 'Contact Shield version: $version');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getDeviceCalibrationConfidence(BuildContext context) async {
    try {
      final int confidence = await _engine.getDeviceCalibrationConfidence();
      _showDialog(context, 'Device calibration confidence: $confidence');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _isSupportScanningWithoutLocation(BuildContext context) async {
    try {
      final bool isSupported = await _engine.isSupportScanningWithoutLocation();
      _showDialog(
          context, 'Is support scanning without location: $isSupported');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _getStatus(BuildContext context) async {
    try {
      final Set<ContactShieldStatus> statusSet = await _engine.getStatus();

      _showDialog(context, statusSet.toString());
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _clearData(BuildContext context) async {
    try {
      await _engine.clearData();
      _showDialog(context, 'clearData success.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _stopContactShield(BuildContext context) async {
    try {
      await _engine.stopContactShield();
      _showDialog(context, 'Contact Shieled is stopped.');
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei Contact Shield Flutter Demo'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomButton('Is Contact Shield running?',
                          _isContactShieldRunning),
                      CustomButton('Start Contact Shield', _startContactShield),
                      CustomButton('Start Contact Shield Callback (Old method)',
                          _startContactShieldCb),
                      CustomButton('Start Contact Shield Non Persistent',
                          _startContactShieldNonPersistent),
                      Divider(
                        thickness: 0.1,
                        color: Colors.black,
                      ),
                      CustomButton('Report Periodic Keys (getPeriodicKey)',
                          _getPeriodicKey),
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
                      CustomButton('putSharedKeyFiles', _putSharedKeyFiles),
                      CustomButton('putSharedKeyFilesCb', _putSharedKeyFilesCb),
                      CustomButton('putSharedKeyFilesCbWithProvider',
                          _putSharedKeyFilesCbWithProvider),
                      CustomButton('putSharedKeyFilesCbWithKeys',
                          _putSharedKeyFilesCbWithKeys),
                      CustomButton('Get Contact Detail', _getContactDetail),
                      CustomButton('Get Contact Sketch', _getContactSketch),
                      CustomButton('Get Contact Window', _getContactWindow),
                      CustomButton('Set Shared Keys Data Mapping',
                          _setSharedKeysDataMapping),
                      CustomButton('Get Shared Keys Data Mapping',
                          _getSharedKeysDataMapping),
                      CustomButton('Get Daily Sketch', _getDailySketch),
                      CustomButton('Get Contact Shield Version',
                          _getContactShieldVersion),
                      CustomButton('Get Device Calibartion Confidence',
                          _getDeviceCalibrationConfidence),
                      CustomButton('Is Support Scanning w/o Location',
                          _isSupportScanningWithoutLocation),
                      CustomButton('Get Contact Shield Status', _getStatus),
                      CustomButton('Clear Data', _clearData),
                      CustomButton('Stop Contact Shield', _stopContactShield),
                    ],
                  ),
                )
                // remaining stuffs
              ]),
            ),
          );
        },
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
