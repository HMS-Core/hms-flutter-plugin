/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

import 'package:huawei_scan/huawei_scan.dart';

import 'package:huawei_scan_example/screens/BuildBitmapScreen.dart';
import 'package:huawei_scan_example/screens/CustomizedViewScreen.dart';
import 'package:huawei_scan_example/screens/DecodeScreen.dart';
import 'package:huawei_scan_example/screens/DecodeWithBitmapScreen.dart';
import 'package:huawei_scan_example/screens/DefaultViewScreen.dart';
import 'package:huawei_scan_example/screens/MultiProcessorCameraScreen.dart';
import 'package:huawei_scan_example/screens/MultiProcessorScreen.dart';
import 'package:huawei_scan_example/widgets/CustomButton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  bool hmsLoggerStatus = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      permissionRequest();
    });
  }

  void permissionRequest() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'About Permissions',
          ),
          content: Text(
            'Huawei Scan needs some permissions to work properly.\n\n'
            'You are expected to handle these permissions to use Huawei'
            ' Scan Demo.',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('HMS Flutter Scan Kit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 8,
              ),
              child: Image.asset(
                'assets/scan_kit_logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const <Widget>[
                  Text(
                    'Huawei Scan Kit Flutter Plugin',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Huawei Scan Kit scans and parses all major 1D and 2D'
                    ' barcodes, helping you quickly build barcode scanning'
                    ' functions into your apps.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomButton(
              text: 'Enable/Disable Hms Logger',
              onPressed: () {
                if (hmsLoggerStatus) {
                  HmsScanUtils.disableLogger();
                  hmsLoggerStatus = false;
                } else {
                  HmsScanUtils.enableLogger();
                  hmsLoggerStatus = true;
                }
              },
            ),
            CustomButton(
              text: 'Default View Mode',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const DefaultViewScreen();
                    },
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Customized View Mode',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const CustomizedViewScreen();
                    },
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Build Bitmap',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const BuildBitmapScreen();
                    },
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Decode With Bitmap',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const DecodeWithBitmapScreen();
                    },
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Decode',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => const DecodeScreen(),
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Multi Processor Camera',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const MultiProcessorCameraScreen();
                    },
                  ),
                );
              },
            ),
            CustomButton(
              text: 'Decode with Multi Processor',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        const MultiProcessorScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
