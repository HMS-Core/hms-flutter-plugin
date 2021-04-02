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
import 'package:huawei_ar/ar_engine_library.dart';

import 'ar_body_scene.dart';
import 'ar_face_scene.dart';
import 'ar_hand_scene.dart';
import 'ar_world_scene.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAREngineAPKReady = false;
  Color _serviceAppCheckColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _checkServiceApk();
  }

  _checkServiceApk() async {
    if (!mounted) return;
    bool result = await AREngine.isArEngineServiceApkReady();
    setState(() {
      _isAREngineAPKReady = result;
      _serviceAppCheckColor = result ? Colors.green : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Huawei AREngine Flutter Demo'),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _customContainer(
                        _serviceAppCheckColor,
                        "AREngine Service APK "
                        "Ready",
                        5,
                        false),
                    _customContainer(_serviceAppCheckColor,
                        _isAREngineAPKReady ? "Yes" : "No", 1, true)
                  ],
                ),
                _expandedButton(() => AREngine.navigateToAppMarketPage(),
                    "Navigate To AppGallery Page", Icons.store,
                    color: Colors.black),
                _expandedButton(
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ArFaceScreen())),
                    "ARFace Scene",
                    Icons.face),
                _expandedButton(
                    () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ArHandScene())),
                    "ARHand Scene",
                    Icons.pan_tool),
                _expandedButton(
                    () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ArBodyScene())),
                    "ARBody Scene",
                    Icons.accessibility),
                _expandedButton(
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ARWorldScene())),
                    "ARWorld "
                    "Scene",
                    Icons.public)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _expandedButton(
      Function onPressed, String buttonText, IconData iconData,
      {Color color}) {
    return Flexible(
      flex: 2,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: MaterialButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  buttonText,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            color: color ?? Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _customContainer(
      Color borderColor, String text, int flex, bool reverseBorder) {
    if (reverseBorder) {
      return Flexible(
        flex: flex,
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0)),
            border: Border.all(color: _serviceAppCheckColor, width: 2.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }
    return Flexible(
      flex: flex,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
          border: Border.all(color: _serviceAppCheckColor, width: 2.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
