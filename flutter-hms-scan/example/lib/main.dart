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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

import 'package:huawei_scan/HmsScanLibrary.dart';

import 'package:huawei_scan_example/screens/BuildBitmapScreen.dart';
import 'package:huawei_scan_example/screens/CustomizedViewScreen.dart';
import 'package:huawei_scan_example/screens/DecodeWithBitmapScreen.dart';
import 'package:huawei_scan_example/screens/DefaultViewScreen.dart';
import 'package:huawei_scan_example/screens/MultiProcessorCameraScreen.dart';
import 'package:huawei_scan_example/screens/MultiProcessorScreen.dart';
import 'package:huawei_scan_example/widgets/CustomButton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String permissionState = "Permissions Are Not Granted.";
  bool hmsLoggerStatus = true;

  @override
  void initState() {
    permissionRequest();
    super.initState();
  }

  permissionRequest() async {
    bool permissionResult =
        await HmsScanPermissions.hasCameraAndStoragePermission();
    if (permissionResult == false) {
      await HmsScanPermissions.requestCameraAndStoragePermissions();
    } else {
      setState(() {
        permissionState = "All Permissions Are Granted";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("HMS Flutter Scan Kit"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 12.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 8,
              ),
              child: Image.asset(
                "assets/scan_kit_logo.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Huawei Scan Kit Flutter Plugin",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "HUAWEI Scan Kit scans and parses all major 1D and 2D barcodes, helping you quickly build barcode scanning functions into your apps.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Permission State",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(permissionState),
                    ],
                  )
                ],
              ),
            ),
            CustomButton(
              text: "Enable/Disable Hms Logger",
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
              text: "Request Permissions",
              onPressed: () {
                permissionRequest();
              },
            ),
            CustomButton(
              text: "Default View Mode",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefaultViewScreen()),
                );
              },
            ),
            CustomButton(
              text: "Customized View Mode",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomizedViewScreen()),
                );
              },
            ),
            CustomButton(
              text: "Build Bitmap",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuildBitmapScreen()),
                );
              },
            ),
            CustomButton(
              text: "Decode With Bitmap",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DecodeWithBitmapScreen()),
                );
              },
            ),
            CustomButton(
              text: "Multi Processor Camera",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProcessorCameraScreen()),
                );
              },
            ),
            CustomButton(
              text: "Decode with Multi Processor",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProcessorScreen()),
                );
              },
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
