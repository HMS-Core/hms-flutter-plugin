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

import 'package:flutter/material.dart';
import 'package:huawei_ml_body/huawei_ml_body.dart';
import 'package:huawei_ml_body_example/utils/demo_util.dart';

class Face3dExample extends StatefulWidget {
  const Face3dExample({Key? key}) : super(key: key);

  @override
  State<Face3dExample> createState() => _Face3dExampleState();
}

class _Face3dExampleState extends State<Face3dExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late ML3DFaceAnalyzer _analyzer;
  final List<double> eulerXs = <double>[];
  final List<double> eulerYs = <double>[];
  final List<double> eulerZs = <double>[];

  @override
  void initState() {
    super.initState();
    _analyzer = ML3DFaceAnalyzer();
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final ML3DFaceAnalyzerSetting setting = ML3DFaceAnalyzerSetting(
      path: path,
    );
    final List<ML3DFace> faces = await _analyzer.asyncAnalyseFrame(setting);
    for (ML3DFace element in faces) {
      setState(() {
        eulerXs.add(element.eulerX);
        eulerYs.add(element.eulerY);
        eulerZs.add(element.eulerZ);
      });
    }
  }

  @override
  void destroy() async {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      final bool res = await _analyzer.isAvailable();
      debugPrint(res.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void stop() async {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Face 3d Example'),
      key: _key,
      body: Column(
        children: <Widget>[
          resultBox('Euler Xs', eulerXs),
          resultBox('Euler Ys', eulerYs),
          resultBox('Euler Zs', eulerZs),
          Container(
            width: double.infinity - 20,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: buttonStyle(),
              onPressed: () => pickerDialog(_key, context, analyze),
              child: const Text('Start Recognition'),
            ),
          ),
        ],
      ),
    );
  }
}
