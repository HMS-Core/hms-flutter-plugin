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

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_contactshield/huawei_contactshield.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _token = 'TOKEN_TEST';
  late ContactShieldEngine _engine;
  String _exposureText = 'Click the following buttons '
      'if you want to check the exposures in the past 14 days';

  @override
  void initState() {
    super.initState();
    _engine = ContactShieldEngine();
    _engine.contactShieldCallback = ContactShieldCallback(
      onHasContact: (String? token) {
        setState(() {
          _exposureText = 'Contact Status: Has contact\nToken: $token';
        });
      },
      onNoContact: (String? token) {
        setState(() {
          _exposureText = 'Contact Status: No contact\nToken: $token';
        });
      },
    );
  }

  Future<List<String>?> _pickFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['zip'],
    );
    return result?.files.map((PlatformFile e) => e.path!).toList();
  }

  void _isContactShieldRunning() async {
    try {
      final bool? isRunning = await _engine.isContactShieldRunning();
      _showDialog('Is Contact Shield running: $isRunning');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _startContactShield() async {
    try {
      await _engine.startContactShield();
      _showDialog('Contact Shield is started.');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _startContactShieldCb() async {
    try {
      await _engine.startContactShieldCb();
      _showDialog('Contact Shield is started (Old method).');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _startContactShieldNonPersistent() async {
    try {
      await _engine.startContactShieldNonPersistent();
      _showDialog('Contact Shield is started in non persistent mode.');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getPeriodicKey() async {
    try {
      final List<PeriodicKey> result = await _engine.getPeriodicKey();
      _showDialog('$result');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _putSharedKeyFiles() async {
    try {
      final List<String>? files = await _pickFiles();
      if (files != null) {
        await _engine.putSharedKeyFiles(
          files,
          DiagnosisConfiguration(),
          _token,
        );
        _showDialog('putSharedKeyFiles success (Deprecated method).');
      } else {
        _showDialog('You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _putSharedKeyFilesCb() async {
    try {
      final List<String>? files = await _pickFiles();
      if (files != null) {
        await _engine.putSharedKeyFilesCb(
          files,
          DiagnosisConfiguration(),
          _token,
        );
        _showDialog('putSharedKeyFilesCb success.');
      } else {
        _showDialog('You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _putSharedKeyFilesCbWithProvider() async {
    try {
      final List<String>? files = await _pickFiles();
      if (files != null) {
        await _engine.putSharedKeyFilesCbWithProvider(files);
        _showDialog('putSharedKeyFilesCbWithProvider success.');
      } else {
        _showDialog('You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _putSharedKeyFilesCbWithKeys() async {
    try {
      final List<String>? files = await _pickFiles();
      if (files != null) {
        await _engine.putSharedKeyFilesCbWithKeys(
          files,
          <String>['0', '1', '2'],
          DiagnosisConfiguration(),
          _token,
        );
        _showDialog('putSharedKeyFilesCbWithKeys success.');
      } else {
        _showDialog('You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _putSharedKeyFilesCbProviderKeys() async {
    try {
      final List<String>? files = await _pickFiles();
      if (files != null) {
        await _engine.putSharedKeyFilesCbProviderKeys(
          files,
          <String>['0', '1', '2'],
        );
        _showDialog('putSharedKeyFilesCbProviderKeys success.');
      } else {
        _showDialog('You have not selected any file(s).');
      }
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getContactDetail() async {
    try {
      final List<ContactDetail> contactDetails = await _engine.getContactDetail(
        _token,
      );
      _showDialog('$contactDetails');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getContactSketch() async {
    try {
      final ContactSketch contactSketch = await _engine.getContactSketch(
        _token,
      );
      _showDialog('$contactSketch');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getContactWindow() async {
    try {
      final List<ContactWindow> contactWindows =
          await _engine.getContactWindow();
      _showDialog('$contactWindows');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _setSharedKeysDataMapping() async {
    try {
      await _engine.setSharedKeysDataMapping(
        SharedKeysDataMapping(null, null, null),
      );
      _showDialog('setSharedKeysDataMapping success.');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getSharedKeysDataMapping() async {
    try {
      final SharedKeysDataMapping sharedKeysDataMapping =
          await _engine.getSharedKeysDataMapping();
      _showDialog('$sharedKeysDataMapping');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getDailySketch() async {
    try {
      final List<DailySketch> dailySketch = await _engine.getDailySketch(
        DailySketchConfiguration(),
      );
      _showDialog('$dailySketch');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getContactShieldVersion() async {
    try {
      final int? version = await _engine.getContactShieldVersion();
      _showDialog('Contact Shield version: $version');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getDeviceCalibrationConfidence() async {
    try {
      final int? confidence = await _engine.getDeviceCalibrationConfidence();
      _showDialog('Device calibration confidence: $confidence');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _isSupportScanningWithoutLocation() async {
    try {
      final bool? isSupported =
          await _engine.isSupportScanningWithoutLocation();
      _showDialog('Is support scanning without location: $isSupported');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _getStatus() async {
    try {
      final Set<ContactShieldStatus> statusSet = await _engine.getStatus();
      _showDialog('$statusSet');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _clearData() async {
    try {
      await _engine.clearData();
      _showDialog('clearData success.');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _stopContactShield() async {
    try {
      await _engine.stopContactShield();
      _showDialog('Contact Shieled is stopped.');
    } on PlatformException catch (e) {
      _showDialog('$e');
    }
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Shield Demo'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildButton(
                          'Is Contact Shield running?',
                          _isContactShieldRunning,
                        ),
                        _buildButton(
                          'Start Contact Shield',
                          _startContactShield,
                        ),
                        _buildButton(
                          'Start Contact Shield Callback (Old method)',
                          _startContactShieldCb,
                        ),
                        _buildButton(
                          'Start Contact Shield Non Persistent',
                          _startContactShieldNonPersistent,
                        ),
                        const Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        _buildButton(
                          'Report Periodic Keys (getPeriodicKey)',
                          _getPeriodicKey,
                        ),
                        const Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 32,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(_exposureText),
                          ),
                        ),
                        const Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        _buildButton(
                          'putSharedKeyFiles',
                          _putSharedKeyFiles,
                        ),
                        _buildButton(
                          'putSharedKeyFilesCb',
                          _putSharedKeyFilesCb,
                        ),
                        _buildButton(
                          'putSharedKeyFilesCbWithProvider',
                          _putSharedKeyFilesCbWithProvider,
                        ),
                        _buildButton(
                          'putSharedKeyFilesCbWithKeys',
                          _putSharedKeyFilesCbWithKeys,
                        ),
                        _buildButton(
                          'putSharedKeyFilesCbProviderKeys',
                          _putSharedKeyFilesCbProviderKeys,
                        ),
                        _buildButton(
                          'Get Contact Detail',
                          _getContactDetail,
                        ),
                        _buildButton(
                          'Get Contact Sketch',
                          _getContactSketch,
                        ),
                        _buildButton(
                          'Get Contact Window',
                          _getContactWindow,
                        ),
                        _buildButton(
                          'Set Shared Keys Data Mapping',
                          _setSharedKeysDataMapping,
                        ),
                        _buildButton(
                          'Get Shared Keys Data Mapping',
                          _getSharedKeysDataMapping,
                        ),
                        _buildButton(
                          'Get Daily Sketch',
                          _getDailySketch,
                        ),
                        _buildButton(
                          'Get Contact Shield Version',
                          _getContactShieldVersion,
                        ),
                        _buildButton(
                          'Get Device Calibartion Confidence',
                          _getDeviceCalibrationConfidence,
                        ),
                        _buildButton(
                          'Is Support Scanning w/o Location',
                          _isSupportScanningWithoutLocation,
                        ),
                        _buildButton(
                          'Get Contact Shield Status',
                          _getStatus,
                        ),
                        _buildButton(
                          'Clear Data',
                          _clearData,
                        ),
                        _buildButton(
                          'Stop Contact Shield',
                          _stopContactShield,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
