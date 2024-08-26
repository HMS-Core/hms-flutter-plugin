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

class GestureExample extends StatefulWidget {
  const GestureExample({Key? key}) : super(key: key);

  @override
  State<GestureExample> createState() => _GestureExampleState();
}

class _GestureExampleState extends State<GestureExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late MLGestureAnalyzer _analyzer;
  final List<double?> scores = <double?>[];
  final List<int?> categories = <int?>[];

  @override
  void initState() {
    super.initState();
    _analyzer = MLGestureAnalyzer();
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final List<MLGesture> gestures = await _analyzer.asyncAnalyseFrame(path);
    for (MLGesture element in gestures) {
      setState(() {
        categories.add(element.category);
        scores.add(element.score);
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
      key: _key,
      appBar: demoAppBar('Gesture Example'),
      body: Column(
        children: <Widget>[
          resultBox('Gesture categories', categories),
          resultBox('Gesture score', scores),
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
