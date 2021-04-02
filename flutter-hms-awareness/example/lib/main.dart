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
import 'package:huawei_awareness/awarenessUtilsClient.dart';
import 'package:huawei_awareness_example/CustomWidgets/customAppBar.dart';

import 'CustomWidgets/customButton.dart';
import 'barrierClientDemo.dart';
import 'captureClientDemo.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hmsLoggerStatus = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          icon: true,
          size: 210,
          title: "Huawei Awareness",
          title2: "Flutter Plugin Demo",
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Make your app work smarter and better with user insights.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(30, 61, 89, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "The time, location, weather, behavior, headset status, beacons, ambient light intensity, and car Bluetooth status are valuable information for adapting to user environments.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(30, 61, 89, 1),
                  ),
                ),
              ),
              CustomButton(
                  text: "Capture Client Demo",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CaptureClientDemo()));
                  }),
              CustomButton(
                  text: "Barrier Client Demo",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BarrierClientDemo()));
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Divider(
                  color: Color.fromRGBO(30, 61, 89, 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "This method enables/disables the HMSLogger capability which is used for sending usage analytics of Awareness SDK's methods to improve the service quality.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(30, 61, 89, 1),
                  ),
                ),
              ),
              CustomButton(
                text: "Enable/Disable Hms Logger",
                onPressed: () {
                  if (hmsLoggerStatus) {
                    AwarenessUtilsClient.disableLogger();
                    setState(() {
                      hmsLoggerStatus = false;
                    });
                  } else {
                    AwarenessUtilsClient.enableLogger();
                    setState(() {
                      hmsLoggerStatus = true;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
