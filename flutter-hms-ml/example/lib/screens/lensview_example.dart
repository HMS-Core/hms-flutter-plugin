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
import 'package:huawei_ml/huawei_ml.dart';

class LensViewExample extends StatefulWidget {
  @override
  _LensViewExampleState createState() => _LensViewExampleState();
}

class _LensViewExampleState extends State<LensViewExample> {
  LensEngine lensEngine;

  final LensViewController controller = new LensViewController(
      lensType: LensViewController.BACK_LENS,
      analyzerType: LensEngineAnalyzerOptions.FACE);

  dynamic _smilingPossibility = 0;

  @override
  void initState() {
    lensEngine = new LensEngine(controller: controller);
    lensEngine.setTransactor(({isAnalyzerAvailable, result}) {
      if (result != null) {
        _updateEmotions(result);
      }
    });
    _createLensFrame();
    super.initState();
  }

  _createLensFrame() async {
    await lensEngine.initLens();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: LensView(
          controller: controller,
          width: MediaQuery.of(context).size.width,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text("SMILING POSSIBILITY",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(_smilingPossibility.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 30,
                color: Colors.green,
                onPressed: () async {
                  try {
                    lensEngine.run();
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
            IconButton(
                icon: Icon(Icons.stop),
                iconSize: 30,
                color: Colors.redAccent,
                onPressed: () async {
                  try {
                    await lensEngine.release().then((value) {
                      if (value) {
                        _createLensFrame();
                      }
                    });
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
            IconButton(
                icon: Icon(Icons.switch_camera),
                iconSize: 30,
                color: Colors.blueGrey,
                onPressed: () async {
                  try {
                    lensEngine.switchCamera();
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                }),
          ],
        )
      ],
    ));
  }

  _updateEmotions(MLFace face) {
    setState(() {
      _smilingPossibility = face.emotions.smilingProbability;
    });
  }
}
