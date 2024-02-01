/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HmsAvailabilityDemo(),
    );
  }
}

class HmsAvailabilityDemo extends StatefulWidget {
  const HmsAvailabilityDemo({Key? key}) : super(key: key);

  @override
  State<HmsAvailabilityDemo> createState() => _HmsAvailabilityDemoState();
}

class _HmsAvailabilityDemoState extends State<HmsAvailabilityDemo> {
  late HmsApiAvailability hmsApiAvailability;
  String _result = 'HMS availability result code: unknown';
  final List<String> _eventList = <String>[
    'Availability result events will be listed'
  ];

  @override
  void initState() {
    super.initState();
    hmsApiAvailability = HmsApiAvailability();
  }

  @override
  void dispose() {
    hmsApiAvailability.destroyStreams();
    super.dispose();
  }

  void _getAvailability() async {
    try {
      final int resultCode =
          await hmsApiAvailability.isHMSAvailableWithApkVersion(28);
      setState(() {
        _result = 'Availability result code: $resultCode';
      });

      if (resultCode != 0) {
        hmsApiAvailability.setResultListener = (AvailabilityEvent? event) {
          if (event != null) {
            setState(() {
              _eventList.add('Availability event: ${describeEnum(event)}');
            });
          }
        };
        hmsApiAvailability.getErrorDialog(resultCode, 1000, true);
      }
    } catch (e) {
      setState(() {
        _eventList.add('$e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hms Availability Demo'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            Text(_result),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff394867),
                  foregroundColor: Colors.white,
                ),
                onPressed: _getAvailability,
                child: const Text('Check Hms Core Availability'),
              ),
            ),
            const Divider(color: Colors.black),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  itemCount: _eventList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          _eventList[index],
                          style: TextStyle(
                            fontWeight: index == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
